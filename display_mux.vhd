LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY display_mux IS
	PORT (
		data_0,
		data_1,
		data_2,
		data_3,
		data_4: IN INTEGER;
		sel: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		
		q: OUT INTEGER
	);
END display_mux;

ARCHITECTURE behavior OF display_mux is
BEGIN
	WITH sel SELECT
		q <=
			data_0 WHEN "000",
			data_1 WHEN "001",
			data_2 WHEN "010",
			data_3 WHEN "011",
			data_4 WHEN "100",
			data_0 WHEN OTHERS;
END behavior;