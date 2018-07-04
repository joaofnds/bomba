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

SIGNAL clock_segundos,
		 clock_minutos,
		 display_mux_sel,
		 contagem_ativa: STD_LOGIC;
SIGNAL signal_generator_control: STD_LOGIC_VECTOR(1 DOWNTO 0);
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
		data_0, data_1: IN INTEGER;
		sel: IN STD_LOGIC;
		
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
	gerador_de_sinal: signal_generator
		PORT MAP (clock => CLOCK_50, controle => signal_generator_control, q => clock_segundos);
		
	cd_setter: countdown_setter
		PORT MAP (keys => KEY, q_seg => cd_seg, q_min => cd_min);

	segundos_counter: regressive_counter 
		PORT MAP (
			clock => clock_segundos,
			load => SW(3) AND NOT contagem_ativa,
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
			load => SW(3) AND NOT contagem_ativa,
			preset => cd_min,
			reset => SW(2),
			q => minutos_buffer
		);
		
	segundos <= to_integer(unsigned(segundos_buffer));
	minutos <=  to_integer(unsigned(minutos_buffer));
	entrada <= (minutos * 100) + segundos;
	
	codigo_in <= to_integer(unsigned(SW(17 DOWNTO 14)));
	
	codigo_register: integer_register
		PORT MAP (d => codigo_in, load => SW(4), q => codigo);
	
	dp_mux: display_mux
		PORT MAP (
			data_0 => entrada,
			data_1 => codigo,
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
