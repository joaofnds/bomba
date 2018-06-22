LIBRARY ieee;

USE ieee.std_logic_1164.all;

ENTITY ff_t IS
	PORT (
		t, reset, preset, clock: IN STD_LOGIC;
		
		q, q_not: OUT STD_LOGIC
	);
END ff_t;

ARCHITECTURE behavior OF ff_t IS
BEGIN
PROCESS
	VARIABLE  q_temp: STD_LOGIC;
	BEGIN
		WAIT UNTIL rising_edge(clock);
			IF reset='1' THEN
				q_temp := preset;
			ELSIF t='1' THEN
				q_temp := not q_temp;
			END IF;					
			q <= q_temp;
			q_not <= not q_temp;
	END PROCESS;
END behavior;