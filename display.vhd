LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;


ENTITY display IS
	PORT (
		entrada: IN INTEGER RANGE 0 TO 999999;

		display_0,
		display_1,
		display_2,
		display_3,
		display_4,
		display_5: OUT STD_LOGIC_VECTOR(6 downto 0)
	);
END display;

ARCHITECTURE behavior OF display IS

CONSTANT sev_seg_0:    STD_LOGIC_VECTOR(6 DOWNTO 0) := "1000000";
CONSTANT sev_seg_1:    STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111001";
CONSTANT sev_seg_2:    STD_LOGIC_VECTOR(6 DOWNTO 0) := "0100100";
CONSTANT sev_seg_3:    STD_LOGIC_VECTOR(6 DOWNTO 0) := "0110000";
CONSTANT sev_seg_4:    STD_LOGIC_VECTOR(6 DOWNTO 0) := "0011001";
CONSTANT sev_seg_5:    STD_LOGIC_VECTOR(6 DOWNTO 0) := "0010010";
CONSTANT sev_seg_6:    STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000010";
CONSTANT sev_seg_7:    STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111000";
CONSTANT sev_seg_8:    STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000000";
CONSTANT sev_seg_9:    STD_LOGIC_VECTOR(6 DOWNTO 0) := "0010000";
CONSTANT sev_seg_dash: STD_LOGIC_VECTOR(6 DOWNTO 0) := "0111111";

CONSTANT sev_seg_d: STD_LOGIC_VECTOR(6 DOWNTO 0) := "0100001";
CONSTANT sev_seg_e: STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000110";
CONSTANT sev_seg_n: STD_LOGIC_VECTOR(6 DOWNTO 0) := "0111010";
CONSTANT sev_seg_i: STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111001";
CONSTANT sev_seg_f: STD_LOGIC_VECTOR(6 DOWNTO 0) := "0001110";
CONSTANT sev_seg_u: STD_LOGIC_VECTOR(6 DOWNTO 0) := "1010000";
CONSTANT sev_seg_s: STD_LOGIC_VECTOR(6 DOWNTO 0) := "0100100";

SIGNAL display_0_buffer,
		   display_1_buffer,
		   display_2_buffer,
		   display_3_buffer,
		   display_4_buffer,
		   display_5_buffer: STD_LOGIC_VECTOR (6 DOWNTO 0);

BEGIN
	WITH (entrada mod 10) SELECT
		display_0_buffer <=
			sev_seg_0 WHEN 0,
			sev_seg_1 WHEN 1,
			sev_seg_2 WHEN 2,
			sev_seg_3 WHEN 3,
			sev_seg_4 WHEN 4,
			sev_seg_5 WHEN 5,
			sev_seg_6 WHEN 6,
			sev_seg_7 WHEN 7,
			sev_seg_8 WHEN 8,
			sev_seg_9 WHEN 9,
			sev_seg_dash WHEN OTHERS;
			
	WITH ((entrada/10) mod 10) SELECT
		display_1_buffer <=
			sev_seg_0 WHEN 0,
			sev_seg_1 WHEN 1,
			sev_seg_2 WHEN 2,
			sev_seg_3 WHEN 3,
			sev_seg_4 WHEN 4,
			sev_seg_5 WHEN 5,
			sev_seg_6 WHEN 6,
			sev_seg_7 WHEN 7,
			sev_seg_8 WHEN 8,
			sev_seg_9 WHEN 9,
			sev_seg_dash WHEN OTHERS;
			
	WITH ((entrada/100) mod 10) SELECT
		display_2_buffer <=
			sev_seg_0 WHEN 0,
			sev_seg_1 WHEN 1,
			sev_seg_2 WHEN 2,
			sev_seg_3 WHEN 3,
			sev_seg_4 WHEN 4,
			sev_seg_5 WHEN 5,
			sev_seg_6 WHEN 6,
			sev_seg_7 WHEN 7,
			sev_seg_8 WHEN 8,
			sev_seg_9 WHEN 9,
			sev_seg_dash WHEN OTHERS;
			
	WITH ((entrada/1000) mod 10) SELECT
		display_3_buffer <=
			sev_seg_0 WHEN 0,
			sev_seg_1 WHEN 1,
			sev_seg_2 WHEN 2,
			sev_seg_3 WHEN 3,
			sev_seg_4 WHEN 4,
			sev_seg_5 WHEN 5,
			sev_seg_6 WHEN 6,
			sev_seg_7 WHEN 7,
			sev_seg_8 WHEN 8,
			sev_seg_9 WHEN 9,
			sev_seg_dash WHEN OTHERS;

	WITH ((entrada/10000) mod 10) SELECT
		display_4_buffer <=
			sev_seg_0 WHEN 0,
			sev_seg_1 WHEN 1,
			sev_seg_2 WHEN 2,
			sev_seg_3 WHEN 3,
			sev_seg_4 WHEN 4,
			sev_seg_5 WHEN 5,
			sev_seg_6 WHEN 6,
			sev_seg_7 WHEN 7,
			sev_seg_8 WHEN 8,
			sev_seg_9 WHEN 9,
			sev_seg_dash WHEN OTHERS;

	WITH ((entrada/100000) mod 10) SELECT
		display_5_buffer <=
			sev_seg_0 WHEN 0,
			sev_seg_1 WHEN 1,
			sev_seg_2 WHEN 2,
			sev_seg_3 WHEN 3,
			sev_seg_4 WHEN 4,
			sev_seg_5 WHEN 5,
			sev_seg_6 WHEN 6,
			sev_seg_7 WHEN 7,
			sev_seg_8 WHEN 8,
			sev_seg_9 WHEN 9,
			sev_seg_dash WHEN OTHERS;

	display_0 <= display_0_buffer;
	display_1 <= display_1_buffer;
	display_2 <= display_2_buffer;
	display_3 <= display_3_buffer;
	display_4 <= display_4_buffer;
	display_5 <= display_5_buffer;
END behavior;
