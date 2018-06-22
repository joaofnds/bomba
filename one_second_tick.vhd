LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY one_second_tick IS
	PORT (
		clock: IN STD_LOGIC;
		q: OUT STD_LOGIC
	);
END one_second_tick;

ARCHITECTURE behavior OF one_second_tick IS
SIGNAL count: INTEGER RANGE 0 TO 50000000 := 0;
SIGNAL q_temp: STD_LOGIC := '0';
BEGIN
	PROCESS
	BEGIN
	WAIT UNTIL rising_edge(clock);
		IF count=50000000 THEN
			count <= 0;
			q_temp <= not q_temp;
		ELSE
			count <= count + 1;
		END IF;
		
		q <= q_temp;
	END PROCESS;
END behavior;