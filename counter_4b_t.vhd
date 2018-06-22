LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY counter_4b_t IS
	PORT (
		clock: IN STD_LOGIC;
		
		q: OUT INTEGER RANGE 0 TO 59
	);
END counter_4b_t;

ARCHITECTURE behavior OF counter_4b_t IS
SIGNAL count: INTEGER RANGE 0 TO 59 := 59;
BEGIN
	PROCESS
	BEGIN
	WAIT UNTIL rising_edge(clock);
		IF count=0 THEN
			count <= 59;
		ELSE
			count <= count - 1;
		END IF;
			
		q <= count;
	END PROCESS;
END behavior;