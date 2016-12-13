library ieee;										-- use library ieee
use ieee.std_logic_1164.all;					-- use "std_logic"

entity frequency_divider is					-- entity declaration
	port(clk : in std_logic;					-- clock from oscillator
		  one_hz_clk : out std_logic);		-- 1 Hz clock
end frequency_divider;

architecture behavioral of frequency_divider is		-- architecture body
   signal temp : std_logic :='0';			-- output
	signal max_value : integer := 25000000;  	-- max number = 25000000
	signal counter : integer range 0 to max_value := 0;
begin
   process(clk)									-- process clock
	   begin
		   if rising_edge(clk) then			-- if find clk's rising edge
			   if (counter = max_value) then	-- counter is equal max number
				   temp <= NOT(temp);			-- change logic
					counter <= 0;					-- reset counter
				else 									-- if counter is not equal max number
				   counter <= counter +1;		-- add value 
				end if;
			end if;
	end process;
	one_hz_clk <= temp;							-- set output
end behavioral;
			
