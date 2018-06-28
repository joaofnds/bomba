LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY display_mux IS
	PORT (
		data_0, data_1: IN INTEGER;
		sel: IN STD_LOGIC;
		
		q: OUT INTEGER
	);
END display_mux;

ARCHITECTURE behavior OF display_mux is
BEGIN
	WITH sel SELECT
		q <=
			data_0 WHEN '0',
			data_1 WHEN '1';
END behavior;