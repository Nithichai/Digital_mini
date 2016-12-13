library ieee;										-- use library ieee
use ieee.std_logic_1164.all;					-- use "std_logic"
use ieee.std_logic_unsigned.all;				-- use integer

entity freq_div is								-- entity declaration
	port (CLK : in std_logic;					-- clock from oscillator
			SCLK : out std_logic);				-- clock that is divided
end freq_div;

architecture behave of freq_div is			-- architecture body
	signal temp : std_logic :='0';			-- output
	signal max_value : integer := 7500;  	-- max number = 75000
	signal counter : integer range 0 to max_value := 0;
begin
   process(CLK)									-- process clock
	   begin
		   if rising_edge(CLK) then			-- if find clk's rising edge
			   if (counter = max_value) then	-- counter is equal max number
				   temp <= NOT(temp);			-- change logic
					counter <= 0;					-- reset counter
				else 									-- if counter is not equal max number
				   counter <= counter +1;		-- add value 
				end if;
			end if;
	end process;
	SCLK <= temp;									-- set output
end behave;
