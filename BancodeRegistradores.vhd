LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY BancodeRegistradores IS 
PORT (RegWrite, CLOCK: IN STD_LOGIC;
		endereco : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
		R0, R1, R2, R3 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		R0out, R1out, R2out, R3out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END BancodeRegistradores;

ARCHITECTURE behaviorBanco OF BancodeRegistradores IS 
BEGIN
	PROCESS ( RegWrite , CLOCK, endereco)
	BEGIN
		IF RegWrite'EVENT AND RegWrite = '1' THEN
			CASE endereco IS 
				WHEN "00" => 
					R0out <= R0; 
				WHEN "01" => 
					R1out <= R1; 
				WHEN "10" => 
					R2out <= R2;   
				WHEN "11" => 
					R3out <= R3; 
			END CASE; 
		END IF;
	END PROCESS;
END behaviorBanco;