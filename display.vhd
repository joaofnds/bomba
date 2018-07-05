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
CONSTANT sev_seg_off:  STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111111";

CONSTANT sev_seg_d: STD_LOGIC_VECTOR(6 DOWNTO 0) := "0100001";
CONSTANT sev_seg_e: STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000110";
CONSTANT sev_seg_n: STD_LOGIC_VECTOR(6 DOWNTO 0) := "0101011";
CONSTANT sev_seg_i: STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111001";
CONSTANT sev_seg_f: STD_LOGIC_VECTOR(6 DOWNTO 0) := "0001110";
CONSTANT sev_seg_u: STD_LOGIC_VECTOR(6 DOWNTO 0) := "1000001";
CONSTANT sev_seg_s: STD_LOGIC_VECTOR(6 DOWNTO 0) := "0010010";

CONSTANT sev_seg_b: STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000011";
CONSTANT sev_seg_o: STD_LOGIC_VECTOR(6 DOWNTO 0) := "0100011";

CONSTANT defuse_code: INTEGER := 62;
CONSTANT denied_code: INTEGER := 63;
CONSTANT boon_code:   INTEGER := 64;

SIGNAL display_0_buffer,
		   display_1_buffer,
		   display_2_buffer,
		   display_3_buffer,
		   display_4_buffer,
		   display_5_buffer: STD_LOGIC_VECTOR (6 DOWNTO 0);

BEGIN
	PROCESS(entrada)
	BEGIN
		IF entrada=defuse_code THEN
			display_5_buffer <= sev_seg_d;
			display_4_buffer <= sev_seg_e;
			display_3_buffer <= sev_seg_f;
			display_2_buffer <= sev_seg_u;
			display_1_buffer <= sev_seg_s;
			display_0_buffer <= sev_seg_e;
		ELSIF entrada=denied_code THEN
			display_5_buffer <= sev_seg_d;
			display_4_buffer <= sev_seg_e;
			display_3_buffer <= sev_seg_n;
			display_2_buffer <= sev_seg_i;
			display_1_buffer <= sev_seg_e;
			display_0_buffer <= sev_seg_d;
		ELSIF entrada=boon_code THEN
			display_5_buffer <= sev_seg_off;
			display_4_buffer <= sev_seg_off;
			display_3_buffer <= sev_seg_b;
			display_2_buffer <= sev_seg_o;
			display_1_buffer <= sev_seg_o;
			display_0_buffer <= sev_seg_n;
		ELSE
			CASE (entrada mod 10) IS
				WHEN 0 => display_0_buffer <= sev_seg_0;
				WHEN 1 => display_0_buffer <= sev_seg_1;
				WHEN 2 => display_0_buffer <= sev_seg_2;
				WHEN 3 => display_0_buffer <= sev_seg_3;
				WHEN 4 => display_0_buffer <= sev_seg_4;
				WHEN 5 => display_0_buffer <= sev_seg_5;
				WHEN 6 => display_0_buffer <= sev_seg_6;
				WHEN 7 => display_0_buffer <= sev_seg_7;
				WHEN 8 => display_0_buffer <= sev_seg_8;
				WHEN 9 => display_0_buffer <= sev_seg_9;
				WHEN OTHERS => display_0_buffer <= sev_seg_dash;
			END CASE;
					
			CASE ((entrada/10) mod 10) IS
				WHEN 0 => display_1_buffer <= sev_seg_0;
				WHEN 1 => display_1_buffer <= sev_seg_1;
				WHEN 2 => display_1_buffer <= sev_seg_2;
				WHEN 3 => display_1_buffer <= sev_seg_3;
				WHEN 4 => display_1_buffer <= sev_seg_4;
				WHEN 5 => display_1_buffer <= sev_seg_5;
				WHEN 6 => display_1_buffer <= sev_seg_6;
				WHEN 7 => display_1_buffer <= sev_seg_7;
				WHEN 8 => display_1_buffer <= sev_seg_8;
				WHEN 9 => display_1_buffer <= sev_seg_9;
				WHEN OTHERS => display_1_buffer <= sev_seg_dash;
			END CASE;
					
			CASE ((entrada/100) mod 10) IS
				WHEN 0 => display_2_buffer <= sev_seg_0;
				WHEN 1 => display_2_buffer <= sev_seg_1;
				WHEN 2 => display_2_buffer <= sev_seg_2;
				WHEN 3 => display_2_buffer <= sev_seg_3;
				WHEN 4 => display_2_buffer <= sev_seg_4;
				WHEN 5 => display_2_buffer <= sev_seg_5;
				WHEN 6 => display_2_buffer <= sev_seg_6;
				WHEN 7 => display_2_buffer <= sev_seg_7;
				WHEN 8 => display_2_buffer <= sev_seg_8;
				WHEN 9 => display_2_buffer <= sev_seg_9;
				WHEN OTHERS => display_2_buffer <= sev_seg_dash;
			END CASE;
					
			CASE ((entrada/1000) mod 10) IS
				WHEN 0 => display_3_buffer <= sev_seg_0;
				WHEN 1 => display_3_buffer <= sev_seg_1;
				WHEN 2 => display_3_buffer <= sev_seg_2;
				WHEN 3 => display_3_buffer <= sev_seg_3;
				WHEN 4 => display_3_buffer <= sev_seg_4;
				WHEN 5 => display_3_buffer <= sev_seg_5;
				WHEN 6 => display_3_buffer <= sev_seg_6;
				WHEN 7 => display_3_buffer <= sev_seg_7;
				WHEN 8 => display_3_buffer <= sev_seg_8;
				WHEN 9 => display_3_buffer <= sev_seg_9;
				WHEN OTHERS => display_3_buffer <= sev_seg_dash;
			END CASE;

			CASE ((entrada/10000) mod 10) IS
				WHEN 0 => display_4_buffer <= sev_seg_0;
				WHEN 1 => display_4_buffer <= sev_seg_1;
				WHEN 2 => display_4_buffer <= sev_seg_2;
				WHEN 3 => display_4_buffer <= sev_seg_3;
				WHEN 4 => display_4_buffer <= sev_seg_4;
				WHEN 5 => display_4_buffer <= sev_seg_5;
				WHEN 6 => display_4_buffer <= sev_seg_6;
				WHEN 7 => display_4_buffer <= sev_seg_7;
				WHEN 8 => display_4_buffer <= sev_seg_8;
				WHEN 9 => display_4_buffer <= sev_seg_9;
				WHEN OTHERS => display_4_buffer <= sev_seg_dash;
			END CASE;

			CASE ((entrada/100000) mod 10) IS
				WHEN 0 => display_5_buffer <= sev_seg_0;
				WHEN 1 => display_5_buffer <= sev_seg_1;
				WHEN 2 => display_5_buffer <= sev_seg_2;
				WHEN 3 => display_5_buffer <= sev_seg_3;
				WHEN 4 => display_5_buffer <= sev_seg_4;
				WHEN 5 => display_5_buffer <= sev_seg_5;
				WHEN 6 => display_5_buffer <= sev_seg_6;
				WHEN 7 => display_5_buffer <= sev_seg_7;
				WHEN 8 => display_5_buffer <= sev_seg_8;
				WHEN 9 => display_5_buffer <= sev_seg_9;
				WHEN OTHERS => display_5_buffer <= sev_seg_dash;
			END CASE;
		END IF;
	END PROCESS;

	display_0 <= display_0_buffer;
	display_1 <= display_1_buffer;
	display_2 <= display_2_buffer;
	display_3 <= display_3_buffer;
	display_4 <= display_4_buffer;
	display_5 <= display_5_buffer;
END behavior;
