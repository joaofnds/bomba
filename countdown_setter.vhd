LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;

ENTITY countdown_setter IS
	PORT (
		keys: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		
		q_seg, q_min: OUT INTEGER
	);
END countdown_setter;

ARCHITECTURE behavior OF countdown_setter IS
BEGIN
	PROCESS(keys)
		VARIABLE q_0: INTEGER := 0;
		VARIABLE q_1: INTEGER := 0;
		VARIABLE q_2: INTEGER := 0;
		VARIABLE q_3: INTEGER := 0;
	BEGIN
		-- Unidade segundos
		IF keys(0)'EVENT AND keys(0)='0' THEN
			IF q_0=9 THEN
				q_0 := 0;
			ELSE
				q_0 := q_0 + 1;
			END IF;
		END IF;

		-- Dezena segundos
		IF keys(1)'EVENT AND keys(1)='0' THEN
			IF q_1=5 THEN
				q_1 := 0;
			ELSE
				q_1 := q_1 + 1;
			END IF;
		END IF;

		-- Unidade minutos
		IF keys(2)'EVENT AND keys(2)='0' THEN
			IF q_2=9 THEN
				q_2 := 0;
			ELSE
				q_2 := q_2 + 1;
			END IF;
		END IF;

		-- Dezena minutos
		IF keys(3)'EVENT AND keys(3)='0' THEN
			IF q_3=5 THEN
				q_3 := 0;
			ELSE
				q_3 := q_3 + 1;
			END IF;
		END IF;

		q_seg <= q_0 + (q_1 * 10);
		q_min <= q_2 + (q_3 * 10);
	END PROCESS;
END behavior;