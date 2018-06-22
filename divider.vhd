LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY divider IS
	PORT (
		count_to: IN INTEGER;
		clock: IN STD_LOGIC;
		q: OUT STD_LOGIC
	);
END divider;

ARCHITECTURE behavior OF divider IS
constant RIGHT_BOUND: integer := count_to;
SIGNAL count: INTEGER RANGE 0 TO RIGHT_BOUND := 0;
SIGNAL q_temp: STD_LOGIC := '0';
BEGIN
	PROCESS
	BEGIN
	WAIT UNTIL rising_edge(clock);
		IF count=RIGHT_BOUND THEN
			count <= 0;
			q_temp <= not q_temp;
		ELSE
			count <= count + 1;
		END IF;
		
		q <= q_temp;
	END PROCESS;
END behavior;