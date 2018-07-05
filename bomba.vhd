LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.all;

ENTITY bomba IS
	PORT(
		fios: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		ativa_contagem: IN STD_LOGIC;
		codigo_desarme: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		CLOCK_50: IN STD_LOGIC;
		SW: IN STD_LOGIC_VECTOR(17 DOWNTO 0);
		KEY: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		
		LEDR: OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
		HEX0,
		HEX1,
		HEX2,
		HEX3,
		HEX4,
		HEX5: OUT STD_LOGIC_VECTOR(6 downto 0);
		
		contagem_segundos, contagem_minutos: OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
		cout: OUT STD_LOGIC
	);
END bomba;

ARCHITECTURE behavior OF bomba IS

TYPE STATES is (set_code, set_timer, countdown, boon);
SIGNAL current_state, next_state: STATES;
SIGNAL clock_segundos,
		 clock_minutos,
		 load_codigo,
		 load_countdown,
		 fsm_must_transition: STD_LOGIC;
SIGNAL signal_generator_control: STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL display_mux_sel: STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL segundos_buffer, minutos_buffer: STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL segundos,
		minutos,
		entrada,
		display_buffer,
		codigo_in,
		cd_seg,
		cd_min,
		codigo: INTEGER;

COMPONENT signal_generator
	PORT(
		clock: IN STD_LOGIC;
		controle: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		q: OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT regressive_counter
	PORT (
		clock: IN STD_LOGIC;
		load: IN STD_LOGIC;
		reset: IN STD_LOGIC;
		preset: IN INTEGER;
		
		q: OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
	);
END COMPONENT;

COMPONENT display
	PORT (
		entrada: IN INTEGER RANGE 0 TO 999999;

		display_0,
		display_1,
		display_2,
		display_3,
		display_4,
		display_5: OUT STD_LOGIC_VECTOR(6 downto 0)
	);
END COMPONENT;

COMPONENT display_mux
	PORT (
		data_0, data_1, data_2, data_3, data_4: IN INTEGER;
		sel: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		
		q: OUT INTEGER
	);
END COMPONENT;

COMPONENT integer_register
	PORT (
		d: IN INTEGER;
		load: IN STD_LOGIC;
		
		q: OUT INTEGER
	);
END COMPONENT;

COMPONENT countdown_setter
		PORT (
			keys: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			
			q_seg, q_min: OUT INTEGER
		);
END COMPONENT;

BEGIN
	fsm_must_transition <= SW(0);
	
	PROCESS(CLOCK_50)
	BEGIN
		IF SW(1)='1' THEN
			current_state <= set_code;
		ELSIF rising_edge(CLOCK_50) THEN
			current_state <= next_state;
		END IF;
	END PROCESS;
	
	PROCESS(current_state, fsm_must_transition)
		VARIABLE initial_state: STD_LOGIC := '1';
	BEGIN
		CASE current_state IS
			WHEN set_code =>
				LEDR(17 DOWNTO 13) <= "10000";
				display_mux_sel <= "001";
				load_codigo <= '1';
				load_countdown <= '0';
				signal_generator_control <= "00";
				
				IF fsm_must_transition='1' THEN
					next_state <= set_timer;
				ELSE
					next_state <= set_code;
				END IF;
			WHEN set_timer =>
				LEDR(17 DOWNTO 13) <= "01000";
				display_mux_sel <= "000";
				load_codigo <= '0';
				load_countdown <= '1';
				signal_generator_control <= "00";
				
				IF fsm_must_transition='0' THEN
					next_state <= countdown;
				ELSE
					next_state <= set_timer;
				END IF;
			WHEN countdown =>
				LEDR(17 DOWNTO 13) <= "00100";
				display_mux_sel <= "000";
				load_codigo <= '0';
				load_countdown <= '0';
				signal_generator_control <= "01";
				
				IF entrada=0 THEN
					next_state <= boon;
				ELSE
					next_state <= countdown;
				END IF;
			WHEN boon =>
				LEDR(17 DOWNTO 13) <= "00001";
				display_mux_sel <= "100";
				load_codigo <= '0';
				load_countdown <= '0';
				signal_generator_control <= "00";
				next_state <= boon;
		END CASE;
	END PROCESS;

	gerador_de_sinal: signal_generator
		PORT MAP (clock => CLOCK_50, controle => signal_generator_control, q => clock_segundos);
		
	cd_setter: countdown_setter
		PORT MAP (keys => KEY, q_seg => cd_seg, q_min => cd_min);

	segundos_counter: regressive_counter 
		PORT MAP (
			clock => clock_segundos,
			load => load_countdown,
			preset => cd_seg,
			reset => SW(2),
			q => segundos_buffer
		); 
   
	clock_minutos <= segundos_buffer(5) AND
						  segundos_buffer(4) AND 
				    	  segundos_buffer(3) AND 
						  NOT segundos_buffer(2) AND 
						  segundos_buffer(1) AND 
						  segundos_buffer(0); 

	minutos_counter: regressive_counter 
		PORT MAP (
			clock => clock_minutos,
			load => load_countdown,
			preset => cd_min,
			reset => SW(2),
			q => minutos_buffer
		);
		
	segundos <= to_integer(unsigned(segundos_buffer));
	minutos <=  to_integer(unsigned(minutos_buffer));
	entrada <= (minutos * 100) + segundos;
	
	codigo_in <= to_integer(unsigned(SW(17 DOWNTO 14)));
	
	codigo_register: integer_register
		PORT MAP (d => codigo_in, load => load_codigo, q => codigo);
	
	dp_mux: display_mux
		PORT MAP (
			data_0 => entrada,
			data_1 => codigo,
			data_2 => 62, -- defuse code
			data_3 => 63, -- denied code
			data_4 => 64, -- boon code
			sel => display_mux_sel,
			q => display_buffer
		);
		
	display_segundos: display
		PORT MAP (
			entrada => display_buffer,
			display_0 => HEX0,
			display_1 => HEX1,
			display_2 => HEX2,
			display_3 => HEX3,
			display_4 => HEX4,
			display_5 => HEX5
		);

  contagem_segundos <= segundos_buffer;
  contagem_minutos <= minutos_buffer;
END behavior;
