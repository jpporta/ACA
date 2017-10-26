LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY CondReg IS 
PORT (XchgCond: IN STD_LOGIC; 
		OpcodeCond: in STD_LOGIC_VECTOR (2 DOWNTO 0);
		RjCond : in STD_LOGIC_VECTOR (7 DOWNTO 0);
		ImediatoCond : in STD_LOGIC_VECTOR (7 DOWNTO 0);
		ResOut : out STD_LOGIC_VECTOR (7 DOWNTO 0));	
END CondReg;

ARCHITECTURE behaviorCondReg OF CondReg IS 
BEGIN
	PROCESS(OpcodeCond)
	BEGIN
	IF OpcodeCond /= "111" THEN
			IF OpcodeCond = "010" OR OpcodeCond = "011" OR OpcodeCond = "101" THEN
				ResOut <= ImediatoCond;
			ELSE IF OpcodeCond = "110" AND XchgCond = '1' THEN
				ResOut <= ImediatoCond;
				ELSE
					ResOut <= RjCond;
				END IF;
			END IF;
		END IF;
	END PROCESS;
END behaviorCondReg;