LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;

ENTITY Exchenger8bit IS
	PORT( Ri,Rj :IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			S1:OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
			S2 :OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
	END Exchenger8bit;
	
ARCHITECTURE Behavior3 OF Exchenger8bit IS
	SIGNAL Sum : STD_LOGIC_VECTOR(8 DOWNTO 0);
BEGIN
		
		S1 <= Rj;
		S2 <= Ri;
END Behavior3 ;
