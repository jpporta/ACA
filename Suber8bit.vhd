LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;

ENTITY Suber8bit IS
	PORT( X,Y :IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			S :OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
	END Suber8bit;

ARCHITECTURE Behavior2 OF Suber8bit IS
	SIGNAL Sum : STD_LOGIC_VECTOR(8 DOWNTO 0);
BEGIN
		Sum <= ('0' & X) - ('0' & Y);
		S <= Sum( 7 DOWNTO 0);
END Behavior2 ;