LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY signal_generator IS
	PORT(
		clock: IN STD_LOGIC;
		controle: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		q: OUT STD_LOGIC
	);
END signal_generator;

ARCHITECTURE behavior OF signal_generator IS

SIGNAL clock_minutos, tick_one_sec, tick_half_sec, tick_quarter_sec: STD_LOGIC;

COMPONENT one_second_tick
	PORT (
		clock: IN STD_LOGIC;
		q: OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT half_second_tick
	PORT (
		clock: IN STD_LOGIC;
		q: OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT quarter_second_tick
	PORT (
		clock: IN STD_LOGIC;
		q: OUT STD_LOGIC
	);
END COMPONENT;
	
BEGIN
	one_sec_tick: one_second_tick
		PORT MAP (clock => clock, q => tick_one_sec);
	half_sec_tick: half_second_tick
		PORT MAP (clock => clock, q => tick_half_sec);
	quarter_sec_tick: quarter_second_tick
		PORT MAP (clock => clock, q => tick_quarter_sec);
		
		
	WITH controle SELECT
		q <=
			'0'              WHEN "00",
			tick_one_sec     WHEN "01",
			tick_half_sec    WHEN "10",
			tick_quarter_sec WHEN "11";
END behavior;
