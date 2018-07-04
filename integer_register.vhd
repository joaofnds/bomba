LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY integer_register IS
	PORT (
		d: IN INTEGER;
		load: IN STD_LOGIC;
		
		q: OUT INTEGER
	);
END integer_register;

ARCHITECTURE behavior OF integer_register is
BEGIN
	PROCESS(d, load)
	BEGIN
		IF load='1' THEN
			q <= d;
		END IF;
	END PROCESS;
END behavior;