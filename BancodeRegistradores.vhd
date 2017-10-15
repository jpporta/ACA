LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY BancodeRegistradores IS 
PORT (RegWrite, CLOCK: IN STD_LOGIC;
		endereco : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
		R0, R1, R2, R3 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		Rout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END BancodeRegistradores;

ARCHITECTURE behaviorBanco OF BancodeRegistradores IS 
BEGIN
	PROCESS ( RegWrite , CLOCK, endereco)
	BEGIN
		IF CLOCK'EVENT AND CLOCK = '1' THEN
			IF RegWrite'EVENT AND RegWrite = '1' THEN
				CASE endereco IS 
					WHEN "00" => 
						Rout <= R0; 
					WHEN "01" => 
						Rout <= R1; 
					WHEN "10" => 
						Rout <= R2;   
					WHEN "11" => 
						Rout <= R3; 
				END CASE; 
			END IF;
		END IF;
	END PROCESS;
END behaviorBanco;