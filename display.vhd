LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;


ENTITY display IS
	PORT (
		entrada: IN INTEGER RANGE 0 TO 999999;

		display_unidade,
		display_dezena,
		display_centena,
		display_milhar: OUT STD_LOGIC_VECTOR(6 downto 0)
	);
END display;

ARCHITECTURE behavior OF display IS

SIGNAL display1_buffer,
		 display2_buffer,
		 display3_buffer,
		 display4_buffer: STD_LOGIC_VECTOR (6 DOWNTO 0);

BEGIN
	WITH (entrada mod 10) SELECT
		display1_buffer <=
			"1000000" WHEN 0,
			"1111001" WHEN 1,
			"0100100" WHEN 2,
			"0110000" WHEN 3,
			"0011001" WHEN 4,
			"0010010" WHEN 5,
			"0000010" WHEN 6,
			"1111000" WHEN 7,
			"0000000" WHEN 8,
			"0010000" WHEN 9,
			"0111111" WHEN OTHERS;
			
	WITH ((entrada/10) mod 10) SELECT
		display2_buffer <=
			"1000000" WHEN 0,
			"1111001" WHEN 1,
			"0100100" WHEN 2,
			"0110000" WHEN 3,
			"0011001" WHEN 4,
			"0010010" WHEN 5,
			"0000010" WHEN 6,
			"1111000" WHEN 7,
			"0000000" WHEN 8,
			"0010000" WHEN 9,
			"0111111" WHEN OTHERS;
			
	WITH ((entrada/100) mod 10) SELECT
		display3_buffer <=
			"1000000" WHEN 0,
			"1111001" WHEN 1,
			"0100100" WHEN 2,
			"0110000" WHEN 3,
			"0011001" WHEN 4,
			"0010010" WHEN 5,
			"0000010" WHEN 6,
			"1111000" WHEN 7,
			"0000000" WHEN 8,
			"0010000" WHEN 9,
			"0111111" WHEN OTHERS;
			
	WITH ((entrada/1000) mod 10) SELECT
		display4_buffer <=
			"1000000" WHEN 0,
			"1111001" WHEN 1,
			"0100100" WHEN 2,
			"0110000" WHEN 3,
			"0011001" WHEN 4,
			"0010010" WHEN 5,
			"0000010" WHEN 6,
			"1111000" WHEN 7,
			"0000000" WHEN 8,
			"0010000" WHEN 9,
			"0111111" WHEN OTHERS;

	display_unidade <= display1_buffer;
	display_dezena  <= display2_buffer;
	display_centena <= display3_buffer;
	display_milhar  <= display4_buffer;
END behavior;
