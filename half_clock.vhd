LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY half_clock IS
	PORT (
		clock: IN STD_LOGIC;
		
		q: OUT STD_LOGIC
	);
END half_clock;


ARCHITECTURE behavior OF half_clock is
BEGIN
	PROCESS
	VARIABLE  count: STD_LOGIC;
	BEGIN
		WAIT UNTIL rising_edge(clock);
			count := not count;

		q <= count;
	END PROCESS;
END behavior;