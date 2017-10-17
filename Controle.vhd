LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY Controle IS 
PORT (clock : IN STD_LOGIC;
		instruction : IN STD_LOGIC_VECTOR (12 DOWNTO 0);
		R1c, R2c, R3c, R4c: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		Riout, Rjout: OUT STD_LOGIC_VECTOR (7 DOWNTO 0));	
END Controle;

ARCHITECTURE behaviorControle OF Controle IS 
	SIGNAL XchgC : STD_LOGIC;
	SIGNAL OPCODE : STD_LOGIC_VECTOR (2 DOWNTO 0);
	SIGNAL Ric, Rjc : STD_LOGIC_VECTOR (1 DOWNTO 0);
	SIGNAL Imediato : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL Op1, Op2, RegAux, Res1, Res2, Res3, op3: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL ResU1, ResU2, ResU3, ResU4 : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL ResU5, ResU6, ResU7, ResU8 : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL Main2 : STD_LOGIC_VECTOR (7 DOWNTO 0);
	
	COMPONENT BancodeRegistradores 
		PORT (RegWrite, CLOCK: IN STD_LOGIC;
		endereco : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
		R0, R1, R2, R3 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		Rout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT ula
	PORT (ClockUla: IN STD_LOGIC; 
		Xchg: OUT STD_LOGIC; 
		opcode : IN STD_LOGIC_VECTOR(2 DOWNTO 0); 
		A, B : IN STD_LOGIC_VECTOR(7 DOWNTO 0); 
		Ri : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		Rj : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)); 
	END COMPONENT;
	
	COMPONENT CondReg
	PORT (XchgCond: IN STD_LOGIC; 
		OpcodeCond: in STD_LOGIC_VECTOR (2 DOWNTO 0);
		RjCond : in STD_LOGIC_VECTOR (7 DOWNTO 0);
		ImediatoCond : in STD_LOGIC_VECTOR (7 DOWNTO 0);
		ResOut : out STD_LOGIC_VECTOR (7 DOWNTO 0));	
	END COMPONENT;
	

BEGIN
		OPCODE <= instruction (12 DOWNTO 10);
		Ric <= instruction (9 DOWNTO 8);
		Rjc <= instruction (7 DOWNTO 6);
		Imediato <= instruction (7 DOWNTO 0);
		
		-- RECEBE RI
		stage0: BancodeRegistradores PORT MAP(
		RegWrite => '1',
		CLOCK => clock,
		endereco => Ric,
		R0 => R1c,  
		R1 => R2c,
		R2 => R3c,
		R3 => R4c,
		Rout => Op1);
		
		-- RECEBE RJ
		stage1: BancodeRegistradores PORT MAP(
		RegWrite => '1',
		CLOCK => clock,
		endereco => Rjc,
		R0 => R1c,
		R1 => R2c,
		R2 => R3c,
		R3 => R4c,
		Rout => Op2);
		
		regAux <= Op2;
		
		--Verifica se tem imediato
		stage2: CondReg PORT MAP (
		XchgCond=>'0',
		OpcodeCond => OPCODE, 
		RjCond => regAux,
		ImediatoCond => Imediato,
		ResOut => Op3);
		
		--Faz a operacao Ula
		stage3: ula PORT MAP (
			ClockUla => clock,
			opcode => OPCODE, 
			A => Op1,
			B => Op3,
			Ri => Res1,
			Rj => Res2,
			Xchg => XchgC);
			
			ResU1  <= Res1;
			ResU2  <= Res1;
			ResU3  <= Res1; 
			ResU4  <= Res1;
			
		stage4: BancodeRegistradores PORT MAP(
			RegWrite => '1',
			CLOCK => clock,
			endereco => Ric,
			R0 => ResU1,
			R1 => ResU2,
			R2 => ResU3,
			R3 => ResU4,
			Rout => Riout);
			
		stage5: CondReg PORT MAP (
			XchgCond=> XchgC,
			OpcodeCond => OPCODE, 
			RjCond => Op2,
			ImediatoCond => Res2,
			ResOut => Res3);	
			
			ResU5  <= Res3;
			ResU6  <= Res3;
			ResU7  <= Res3; 
			ResU8  <= Res3;
			
		stage6: BancodeRegistradores PORT MAP(
			RegWrite => '1',
			CLOCK => clock,
			endereco => Rjc,
			R0 => ResU5,
			R1 => ResU6,
			R2 => ResU7,
			R3 => ResU8,
			Rout => Rjout);
			

END behaviorControle;