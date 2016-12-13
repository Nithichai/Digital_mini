library ieee;														-- use library ieee
use ieee.std_logic_1164.all;									-- use "std_logic"

entity ctrl_segment is											-- entity declaration
	port(SCLK : in std_logic;									-- clock from Frequency Counter
		  SEL  : out std_logic;									-- select channel of mux
		   dg   : out std_logic_vector(1 downto 0));		-- control bit of 7 segments
end ctrl_segment;

architecture behave of ctrl_segment is						-- architecture body
	begin
		SEL <= '1' when SCLK = '1' else '0';				-- control select channel of mux part
		dg <= "10" when SCLK = '1' else "01";				-- control bit of 7 segment part
end behave;