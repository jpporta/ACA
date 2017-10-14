LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY Main IS 
PORT ( 
  Clock, Reset: IN STD_LOGIC; 
  Opcode : IN STD_LOGIC_VECTOR(2 DOWNTO 0); 
  R1, R2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0); 
  RI : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
  RJ : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)); 
END Main;

ARCHITECTURE Behavior OF Main IS 

	COMPONENT ula
	PORT (  ClockUla: IN STD_LOGIC;
	opcode : IN STD_LOGIC_VECTOR(2 DOWNTO 0); 
	A, B : IN STD_LOGIC_VECTOR(7 DOWNTO 0); 
	Ri : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	Rj : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)); 
	END COMPONENT ;
	
 BEGIN
 
	stage0: ula PORT MAP (ClockUla => Clock,opcode => Opcode, A => R1, B => R2, Ri => RI, Rj => RJ);

END Behavior;