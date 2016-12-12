library ieee;							-- use library ieee
use ieee.std_logic_1164.all;		-- use "std_logic"

entity bcd_to_7_seg is				-- entity declaration
	port(
		BCD : in std_logic_vector(3 downto 0);				-- BCD 
		seven_seg : out std_logic_vector(6 downto 0));	-- 7 Segments
end bcd_to_7_seg;

architecture behave of bcd_to_7_Seg is						-- architecture body
begin
	with BCD select												-- case "BCD" port
		seven_seg <=												-- set seven_seg port
					"0000001" when "0000", --0
					"1001111" when "0001", --1
					"0010010" when "0010", --2
				   "0000110" when "0011", --3
					"1001100" when "0100", --4
					"0100100" when "0101", --5
					"0100000" when "0110", --6
					"0001111" when "0111", --7
					"0000000" when "1000", --8
					"0000100" when "1001", --9
					"0110000" when "1010", --10 = "E"
 					"1111010" when "1011", --11 = "r"
					"1111111" when others; --15 = blank
end behave; 