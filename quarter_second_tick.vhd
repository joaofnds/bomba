LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY quarter_second_tick IS
	PORT (
		clock: IN STD_LOGIC;
		q: OUT STD_LOGIC
	);
END quarter_second_tick;

ARCHITECTURE behavior OF quarter_second_tick IS
constant QUARTER_SECOND_COUNT: INTEGER := 6250000;
SIGNAL count: INTEGER RANGE 0 TO QUARTER_SECOND_COUNT := 0;
SIGNAL q_temp: STD_LOGIC := '0';
BEGIN
	PROCESS
	BEGIN
	WAIT UNTIL rising_edge(clock);
		IF count=QUARTER_SECOND_COUNT THEN
			count <= 0;
			q_temp <= not q_temp;
		ELSE
			count <= count + 1;
		END IF;
		
		q <= q_temp;
	END PROCESS;
END behavior;