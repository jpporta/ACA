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
	SIGNAL Ri, Rj : STD_LOGIC_VECTOR (1 DOWNTO 0);
	SIGNAL Imediato : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL Reg1, Reg2, RESULT1, RESULT2 : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL XCHG, SAVE : STD_LOGIC;
	
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

BEGIN
	OPCODE <= instruction (12 DOWNTO 10);
	Ri <= instruction (9 DOWNTO 8);
	Rj <= instruction (7 DOWNTO 6);
	Imediato <= instruction (7 DOWNTO 0);
	
	-- RECEBE RI
	stage0: BancodeRegistradores PORT MAP(
	RegWrite => '0',
	CLOCK => clock,
	endereco => Ri,
	R0 => "XXXXXXXX",
	R1 => "XXXXXXXX",
	R2 => "XXXXXXXX",
	R3 => "XXXXXXXX",
	Rout => Reg1);
	
	-- RECEBE RJ
	stage1: BancodeRegistradores PORT MAP(
	RegWrite => '0',
	CLOCK => clock,
	endereco => Rj,
	R0 => "XXXXXXXX",
	R1 => "XXXXXXXX",
	R2 => "XXXXXXXX",
	R3 => "XXXXXXXX",
	Rout => Reg2);
	
	stage2: ula PORT MAP (
		ClockUla => clock,
		opcode => OPCODE, 
		A => Reg1,
		B => Reg2,
		Ri => Reg1,
		Rj => RESULT1);
		
	stage3: ula PORT MAP (
	ClockUla => clock,
	opcode => OPCODE, 
	A => Reg1,
	B => Imediato,
	Ri => Reg1,
	Rj => RESULT2);
	
	XCHG <= '0';
	SAVE <= '1';
	decideResult: PROCESS (OPCODE)
	BEGIN
		IF OPCODE /= "111" THEN
			result <= "00000000";
			SAVE <= '0';
		ELSE
			IF OPCODE = "000" OR OPCODE = "001" OR OPCODE = "100" OR OPCODE = "110" THEN
				result <= RESULT1;
				IF OPCODE = "110" THEN
					XCHG <= '1';
				END IF;
			ELSE
				result <= RESULT2;
			END IF;
		END IF;
	END PROCESS decideResult;
		
	stage4: BancodeRegistradores PORT MAP(
	RegWrite => SAVE,
	CLOCK => clock,
	endereco => Ri,
	R0 => Reg1,
	R1 => Reg1,
	R2 => Reg1,
	R3 => Reg1,
	Rout => result);
	
	stage5: BancodeRegistradores PORT MAP(
	RegWrite => XCHG,
	CLOCK => clock,
	endereco => Rj,
	R0 => Reg2,
	R1 => Reg2,
	R2 => Reg2,
	R3 => Reg2,
	Rout => Reg2);
	
END behaviorControle;