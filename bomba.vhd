LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY bomba IS
	PORT(
		fios: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		codigo: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		contagem_ativa: IN STD_LOGIC;
		codigo_desarme: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		clock: IN STD_LOGIC;
		control: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		reset: IN STD_LOGIC;
		
		display0,
		display1,
		display2,
		display3: OUT STD_LOGIC_VECTOR(6 downto 0);
		
		contagem_segundos, contagem_minutos: OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
		cout: OUT STD_LOGIC
	);
END bomba;

ARCHITECTURE behavior OF bomba IS

SIGNAL clock_segundos, clock_minutos, qwer: STD_LOGIC;
SIGNAL segundos_buffer, minutos_buffer: STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL segundos, minutos, entrada: INTEGER;

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
		reset: IN STD_LOGIC;
		
		q: OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
	);
END COMPONENT;

COMPONENT display
	PORT (
		entrada: IN INTEGER RANGE 0 TO 999999;

		display_unidade,
		display_dezena,
		display_centena,
		display_milhar: OUT STD_LOGIC_VECTOR(6 downto 0)
	);
END COMPONENT;

BEGIN
	gerador_de_sinal: signal_generator
		PORT MAP (clock => clock, controle => control, q => clock_segundos);

	segundos_counter: regressive_counter 
		PORT MAP (clock => (clock_segundos AND contagem_ativa), reset => reset, q => segundos_buffer); 
   
	clock_minutos <= segundos_buffer(5) AND 
						  segundos_buffer(4) AND 
						  segundos_buffer(3) AND 
						  NOT segundos_buffer(2) AND 
                    segundos_buffer(1) AND 
						  segundos_buffer(0); 

	minutos_counter: regressive_counter 
		PORT MAP (clock => clock_minutos, reset => reset, q => minutos_buffer);
		
	segundos <= to_integer(unsigned(segundos_buffer));
	minutos <=  to_integer(unsigned(minutos_buffer));
	entrada <= (minutos * 100) + segundos;
		
	display_segundos: display
		PORT MAP (
			entrada => entrada,
			display_unidade => display0,
			display_dezena => display1,
			display_centena => display2,
			display_milhar => display3
		);

  contagem_segundos <= segundos_buffer;
  contagem_minutos <= minutos_buffer;
END behavior;
