LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY Main IS 
PORT (clock2 : IN STD_LOGIC;
		OPCODE2 : in STD_LOGIC_VECTOR (2 DOWNTO 0);
		Rj2 : in STD_LOGIC_VECTOR (7 DOWNTO 0);
		Imediato2 : in STD_LOGIC_VECTOR (7 DOWNTO 0);
		Reg22 : out STD_LOGIC_VECTOR (7 DOWNTO 0));	
END Main;

ARCHITECTURE behaviorMain OF Main IS 
BEGIN
	PROCESS(clock2, Imediato2, Rj2)
	BEGIN
	
	IF OPCODE2 /= "111" THEN
			IF OPCODE2 = "010" OR OPCODE2 = "011" OR OPCODE2 = "101" THEN
				Reg22 <= Imediato2;
			ELSE
				Reg22 <= Rj2;
			END IF;
		END IF;
	END PROCESS;
END behaviorMain;