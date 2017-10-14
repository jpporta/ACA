LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY Main IS 
PORT ( 
  Clock, WriteRegs: IN STD_LOGIC; 
  address : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
  --Opcode : IN STD_LOGIC_VECTOR(2 DOWNTO 0); 
  R1m, R2m : IN STD_LOGIC_VECTOR(7 DOWNTO 0); 
  RI : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
  RJ : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)); 
END Main;

ARCHITECTURE Behavior OF Main IS 
	SIGNAL AUX1, AUX2 : STD_LOGIC_VECTOR(7 DOWNTO 0);
	COMPONENT BancodeRegistradores
		PORT (RegWrite, CLOCK: IN STD_LOGIC;
		endereco : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
		R0, R1, R2, R3 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		R0out, R1out, R2out, R3out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
	END COMPONENT;	
 BEGIN
		stage0: BancodeRegistradores PORT MAP 
		(RegWrite => WriteRegs,
		CLOCK => Clock,
		endereco => address,
		R0 => R1m,
		R1 =>"00000000",
		R2 => R2m,
		R3 => "00000000",
		R0out =>  RI,
		R1out => AUX1,
		R2out => RJ,
		R3out => AUX2);
END Behavior;