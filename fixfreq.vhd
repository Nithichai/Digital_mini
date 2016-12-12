library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity fixfreq is
   port( clk: in std_logic;
	 clocks: in std_logic;
 	 signals: in std_logic;
 	 reset: in std_logic;
	 C_out: out std_logic;
 	 channel: out std_logic_vector(3 downto 0));
end fixfreq;
 
architecture Behavioral of fixfreq is
	signal carry : std_logic := '0';
	signal check : std_logic := '0';
   signal temp1: std_logic_vector(3 downto 0);
	signal temp2: std_logic_vector(3 downto 0);
	signal overflow : std_logic := '0';
	type state_type is(s0,s1,s2);
	signal state : state_type:=s0;
begin     
	overflow <= '1' when (temp1 = "1010") else '0'; 
	process(signals, reset, overflow, clk, check)
   begin	   
      if (reset = '0') then
         temp1 <= "0000";
			carry <= '0';
		elsif (check = '1') then
			temp1 <= "0000";
			carry <= '0';
      elsif(rising_edge(signals)) then	
	      if (check = '0') then	
					if overflow = '1' then
				      temp1 <= "0001";
				      carry <= '0'; 
			      elsif(overflow = '0' and temp1 = "1001") then
				      temp1 <= "0000";
				      carry <= '1';
			      else
    			      temp1 <= temp1+1;
				      carry<='0';
			      end if;
			end if;
		end if;
   end process;
	temp2 <= temp1;
	C_out <= carry;
	process(temp2,clocks,clk)
	begin
	   if rising_edge(clocks) then
		   case state is
			when s0 =>
			   if(clk = '1') then
				   channel <= "0000";
				   check <='1';
				   state <= s1;
				else
				   state <= s0;
			   end if;
		   when s1 =>
			   if(clk = '0') then
				   state <= s2;
					check <='0';
				else 
				   check <='0';
				   state <= s1;
				end if;
			when s2 =>
			   if(clk = '1') then
				   channel <= temp2;
				   check <='1';
					state <= s1;
				else
				   check <='0';
				   state <= s2;
					
				end if;				   
			end case;
		end if;
	end process;
end Behavioral;