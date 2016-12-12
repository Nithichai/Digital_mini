library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity frequency_counter is
port (clk     : in std_logic;
      signals : in std_logic;
		reset   : in std_logic;
		C_out   : out std_logic := '0';
		channel : out std_logic_vector(3 downto 0));
end frequency_counter;

architecture Behavioral of frequency_counter is
   signal temp : std_logic_vector(3 downto 0);
	signal overflow : std_logic := '0';
	signal check : std_logic := '0';
	signal get : std_logic_vector(3 downto 0);
	signal c : std_logic := '0';
	type state_type is(s0,s1);
	signal state : state_type:=s0;
begin
   overflow <= '1' when (temp = "1001") else '0';	
   process(clk,signals,reset,overflow)
	begin		
	   if (reset = '1') then
		   channel <= "0000";			
		elsif (rising_edge(signals)) then
         if (overflow = '1') then
		      temp <= "0000";
			   c <= '1';
			elsif (check = '1') then
		      channel <= get;
			   check <= '0'; 	
			else 
		      c <= '0';	
			   case state is
			      when s0 =>				   
				      if(clk = '1') then				
					      state <= s1;	
	                  temp <= temp +1;					
					   else						  
					     state <= s0;
						  temp <= temp+1;
					   end if;
				   when s1 =>
				      if(clk = '1') then						
					      temp <= temp +1;
					      state <= s1;
					   else
						   get <= temp;
							check <= '1';
						   temp <= "0001";
							state <= s0;							
					   end if;
			   end case;
			end if;
		end if;	
	end process;
	C_out <= c;	
end Behavioral;
					
		