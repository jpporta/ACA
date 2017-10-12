LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;

ENTITY registrador8bit IS
PORT ( RegWrite, Reset: IN STD_LOGIC ;
		RegEntrada: IN STD_LOGIC_VECTOR (7 DOWNTO 0); -- MAIS SIGNIFICATIVO 7
		RegSaida	: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)) ; -- MENOS SIGNIFICATIVO 0
END registrador8bit ;

ARCHITECTURE Behavior OF registrador8bit IS
BEGIN
	PROCESS ( Reset, RegWrite )
	BEGIN
		IF Reset = '1' THEN
			RegSaida <= (OTHERS => '0');
		ELSE 
			IF RegWrite'EVENT AND RegWrite = '1' THEN
			RegSaida <= RegEntrada;
			END IF;
		END IF;
	END PROCESS;
END Behavior ;