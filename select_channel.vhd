library IEEE;							-- use library ieee
use IEEE.STD_LOGIC_1164.ALL;		-- use "std_logic"

entity select_channel is			-- entity declaration
	port (inputs0, inputs1, inputs2, inputs3, inputs4, inputs5, inputs6 : in std_logic_vector(3 downto 0); -- from frequency counter
			sw : in std_logic_vector(1 downto 0);     -- switch select multiply
			dots : out std_logic_vector(3 downto 0);  -- dot display																			
			clk : in std_logic;								-- clock from oscillator
			outputs0, outputs1, outputs2, outputs3 : out std_logic_vector(3 downto 0));  -- output BCD value
end select_channel;

architecture behave of select_channel is	-- architecture body
begin
	process(clk)	-- process by clock 50 MHz 
		begin
			if(rising_edge(clk)) then	-- detect clock's rising edge
				if (sw = "00") then		-- detect switch is 00 ?
					if (inputs4 = "0000" and inputs5 = "0000" and inputs6 = "0000") then		-- no number in 3 MSB digit?
						outputs0 <= inputs0;		-- output 1st digit
						outputs1 <= inputs1;		-- output 2nd digit	
						outputs2 <= inputs2;		-- output 3rd digit
						outputs3 <= inputs3;		-- output 4th digit
						dots <= "0001";
					else						  -- it has number in 3 MSB digit.
						outputs0 <= "1011"; -- output = 11 => "r"
						outputs1 <= "1011"; -- output = 11 => "r"
						outputs2 <= "1010"; -- output = 10 => "E"
						outputs3 <= "1111"; -- output = 15 => blank
						dots <= "0000";	  -- not dot output
					end if;
				elsif (sw = "01") then	-- detect switch is 01 ?
					if (inputs5 = "0000" and inputs6 = "0000") then		-- it has number in 2 MSB digit.
						outputs0 <= inputs1;		-- output 2nd digit
						outputs1 <= inputs2;		-- output 3rd digit
						outputs2 <= inputs3;		-- output 4th digit
						outputs3 <= inputs4;		-- output 5th digit
						dots <= "0010";			-- dot output  => 2nd dot
					else						  -- it has number in 3 MSB digit.
						outputs0 <= "1011"; -- output = 11 => "r"
						outputs1 <= "1011"; -- output = 11 => "r"
						outputs2 <= "1010"; -- output = 10 => "E"
						outputs3 <= "1111"; -- output = 15 => blank
						dots <= "0000";	  -- not dot output
					end if;
				elsif (sw = "10") then	-- detect switch is 10 ?
					if (inputs6 = "0000") then	-- it has number in 1 MSB digit.
						outputs0 <= inputs2;		-- output 3rd digit
						outputs1 <= inputs3;		-- output 4th digit
						outputs2 <= inputs4;		-- output 5th digit
						outputs3 <= inputs5;		-- output 6th digit
						dots <= "0100";			-- dot output => 3rd dot
					else						  -- it has number in 3 MSB digit.
						outputs0 <= "1011"; -- output = 11 => "r"
						outputs1 <= "1011"; -- output = 11 => "r"
						outputs2 <= "1010"; -- output = 10 => "E"
						outputs3 <= "1111"; -- output = 15 => blank
						dots <= "0000";	  -- not dot output
					end if;
				elsif (sw = "11") then	-- detect switch is 11 ?
					outputs0 <= inputs3;		-- output 4th digit
					outputs1 <= inputs4;		-- output 5th digit
					outputs2 <= inputs5;		-- output 6th digit
					outputs3 <= inputs6;		-- output 7th digit
					dots <= "1000";			-- dot output 4th dot
				end if;
			end if;
	end process;
end behave;