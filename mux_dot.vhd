library ieee;														-- use library ieee
use ieee.std_logic_1164.all;									-- use "std_logic"
	
entity mux_dot is													-- entity declaration
	port (DOT_IN : in  std_logic_vector(3 downto 0);	-- dot from channel select
			S      : in  std_logic;								-- switch	
			O      : out std_logic_vector(2 downto 0));	-- Output from Input
end mux_dot;

architecture behave of mux_dot is							-- architecture body
begin
	O(0) <= DOT_IN(0) when (S = '0') else DOT_IN(1);	-- choose DOT_IN(0) when s = 0, DOT_IN(1) when others
	O(1) <= DOT_IN(2);											-- choose DOT_IN(2)
	O(2) <= DOT_IN(3);											-- choose DOT_IN(3)
end behave;