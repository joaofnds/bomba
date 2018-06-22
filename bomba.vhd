LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

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
		entrada: IN STD_LOGIC_VECTOR(5 downto 0);

		display_unidade,
		display_dezena: OUT STD_LOGIC_VECTOR(6 downto 0)
	);
END COMPONENT;

BEGIN
	gerador_de_sinal: signal_generator
		PORT MAP (clock => clock, controle => control, q => clock_segundos);

	segundos: regressive_counter 
		PORT MAP (clock => clock, reset => reset, q => segundos_buffer); 
   
	clock_minutos <= segundos_buffer(5) AND 
						  segundos_buffer(4) AND 
						  segundos_buffer(3) AND 
						  NOT segundos_buffer(2) AND 
                    segundos_buffer(1) AND 
						  segundos_buffer(0); 

	minutos: regressive_counter 
		PORT MAP (clock => clock_minutos, reset => reset, q => minutos_buffer);
		
	display_segundos: display
		PORT MAP (entrada => segundos_buffer, display_unidade => display0, display_dezena => display1);
	display_minutos: display
		PORT MAP (entrada => minutos_buffer, display_unidade => display2, display_dezena => display3);

  contagem_segundos <= segundos_buffer;
  contagem_minutos <= minutos_buffer;
END behavior;
