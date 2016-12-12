library ieee;														-- use library ieee
use ieee.std_logic_1164.all;									-- use "std_logic"
	
entity mux_8_to_4 is												-- entity declaration
	port (I0, I1	: in std_logic_vector(3 downto 0);  -- BCD from channel select
			S: in std_logic;										-- Switch channel
			O: out std_logic_vector(3 downto 0));			-- Output from Input
end mux_8_to_4;

architecture behave of mux_8_to_4 is						-- architecture body
begin
	O <= I0 when (S = '0') else I1;							-- select=0 => use input0, select=1 => use input1
end behave;