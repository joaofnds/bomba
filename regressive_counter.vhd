LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.numeric_std.all;

ENTITY regressive_counter IS
	PORT (
		clock: IN STD_LOGIC;
		reset: IN STD_LOGIC;
		
		q: OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
	);
END regressive_counter;

ARCHITECTURE behavior OF regressive_counter IS
SIGNAL count: INTEGER RANGE 0 TO 59 := 59;
BEGIN
	PROCESS(clock, reset)
	BEGIN
		IF reset='1' THEN
			count <= 0;
		ELSIF rising_edge(clock) THEN
			IF count=0 THEN
				count <= 59;
			ELSE
				count <= count - 1;
			END IF;
		END IF;
		
		q <= std_logic_vector(to_signed(count, q'length));
	END PROCESS;
END behavior;