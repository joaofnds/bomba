LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY register_4b IS
	PORT (
		d: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		load: IN STD_LOGIC;
		
		q: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END register_4b;

ARCHITECTURE behavior OF register_4b is
BEGIN
	PROCESS(load)
	BEGIN
		IF load='1' THEN
			q <= d;
		END IF;
	END PROCESS;
END behavior;