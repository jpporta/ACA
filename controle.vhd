LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY Controle IS 
PORT (clock : IN STD_LOGIC;
		instruction : IN STD_LOGIC_VECTOR (12 DOWNTO 0);
		result : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));	
END Controle;

ARCHITECTURE behaviorControle OF Controle IS 
	SIGNAL OPCODE : STD_LOGIC_VECTOR (2 DOWNTO 0);
	SIGNAL Ric, Rjc : STD_LOGIC_VECTOR (1 DOWNTO 0);
	SIGNAL Imediato : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL Reg1, Reg2,Reg3, Reg4, Reg5, Reg6: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL ResU1, ResU2,ResU3, ResU4 : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL Main2 : STD_LOGIC_VECTOR (7 DOWNTO 0);
	
	COMPONENT BancodeRegistradores 
		PORT (RegWrite, CLOCK: IN STD_LOGIC;
		endereco : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
		R0, R1, R2, R3 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		Rout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT ula
	PORT ( ClockUla: IN STD_LOGIC; 
	opcode : IN STD_LOGIC_VECTOR(2 DOWNTO 0); 
	A, B : IN STD_LOGIC_VECTOR(7 DOWNTO 0); 
	Ri : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	Rj : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)); 
	END COMPONENT;
	
	COMPONENT Main  
	PORT (clock2 : IN STD_LOGIC;
		OPCODE2 : in STD_LOGIC_VECTOR (2 DOWNTO 0);
		Rj2 : in STD_LOGIC_VECTOR (7 DOWNTO 0);
		Imediato2 : in STD_LOGIC_VECTOR (7 DOWNTO 0);
		Reg22 : out STD_LOGIC_VECTOR (7 DOWNTO 0));
	END COMPONENT;

BEGIN
		OPCODE <= instruction (12 DOWNTO 10);
		Ric <= instruction (9 DOWNTO 8);
		Rjc <= instruction (7 DOWNTO 6);
		Imediato <= instruction (7 DOWNTO 0);
		
		-- RECEBE RI
		stage0: BancodeRegistradores PORT MAP(
		RegWrite => '0',
		CLOCK => clock,
		endereco => Ric,
		R0 => "00000100",
		R1 => "00000110",
		R2 => "00000100",
		R3 => "00000100",
		Rout => Reg1);
		
		-- RECEBE RJ
		stage1: BancodeRegistradores PORT MAP(
		RegWrite => '0',
		CLOCK => clock,
		endereco => Rjc,
		R0 => "00000100",
		R1 => "00000110",
		R2 => "00000100",
		R3 => "00000100",
		Rout => Reg2);
		
		reg3 <= Reg2;
		
		stage2: Main PORT MAP (
		clock2 => clock,
		OPCODE2 => OPCODE, 
		Rj2 => Reg3,
		Imediato2 => Imediato,
		Reg22 => Reg6);
		
		stage3: ula PORT MAP (
			ClockUla => clock,
			opcode => OPCODE, 
			A => Reg1,
			B => Reg6,
			Ri => Reg4,
			Rj => Reg5);
			
			ResU1  <= Reg4;
			ResU2 <= Reg4;
			ResU3  <= Reg4; 
			ResU4  <= Reg4;
			
		stage4: BancodeRegistradores PORT MAP(
			RegWrite => '1',
			CLOCK => clock,
			endereco => Ric,
			R0 => ResU1,
			R1 => ResU2,
			R2 => ResU3,
			R3 => ResU4,
			Rout => result);
--			
--			IF OPCODE = "110" THEN
--				stage4: BancodeRegistradores PORT MAP(
--				RegWrite => '1',
--				CLOCK => clock,
--				endereco => Rj,
--				R0 => Reg2,
--				R1 => Reg2,
--				R2 => Reg2,
--				R3 => Reg2,
--				Rout => Reg2);
--			END IF;
--		ELSE 
--			result <= "00000000";
--		END IF;
--END PROCESS;
END behaviorControle;