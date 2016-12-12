library ieee;
use ieee.std_logic_1164.all;

entity miniproject_digi is
   port (Clocks, Signals, Reset : in std_logic;	-- Clocks = 50 MHz
			SW : in std_logic_vector(1 downto 0);
			Seg0, Seg1, Seg2 : out std_logic_vector(6 downto 0);
			dgCtrl : out std_logic_vector(1 downto 0);
			DOTS 	 : out std_logic_vector(3 downto 0)
	);
end miniproject_digi;

architecture behavioral of miniproject_digi is

component frequency_divider is
	port(clk : in std_logic;
		  one_hz_clk : out std_logic);
end component;

component fixfreq is
   port (clk     : in std_logic;
	      clocks : in std_logic;
         signals : in std_logic;
	    	reset   : in std_logic;
		   C_out   : out std_logic;
	   	channel : out std_logic_vector(3 downto 0));
end component;

component select_channel is
	port (inputs0, inputs1, inputs2, inputs3, inputs4, inputs5, inputs6 : in std_logic_vector(3 downto 0);
			sw : in std_logic_vector(1 downto 0);
			dots : out std_logic_vector(3 downto 0);
			clk : in std_logic;
			outputs0, outputs1, outputs2, outputs3 : out std_logic_vector(3 downto 0));
end component;

component mux_8_to_4 is
	port (I0	: in std_logic_vector(3 downto 0);
			I1 : in std_logic_vector(3 downto 0);
			S: in std_logic;
			O: out std_logic_vector(3 downto 0));
end component;

component bcd_to_7_seg is
	port(
		BCD : in std_logic_vector(3 downto 0);
		seven_seg : out std_logic_vector(6 downto 0));
end component;

component freq_div is
	port (CLK : in std_logic;
			SCLK : out std_logic);
end component;

component ctrl_segment is
	port(SCLK : in std_logic;
		  SEL  : out std_logic;
		  dg   : out std_logic_vector(1 downto 0));
end component;


signal one_clk  : std_logic;
signal Channel0 : std_logic_vector(3 downto 0);
signal Channel1 : std_logic_vector(3 downto 0);
signal Channel2 : std_logic_vector(3 downto 0);
signal Channel3 : std_logic_vector(3 downto 0);
signal Channel4 : std_logic_vector(3 downto 0);
signal Channel5 : std_logic_vector(3 downto 0);
signal Channel6 : std_logic_vector(3 downto 0);
signal C_out1   : std_logic_vector(6 downto 0);

signal SelFromCtrl : std_logic;
signal fromMUX  : std_logic_vector(3 downto 0);
signal sclkFromFreqDiv : std_logic;

signal BCD0, BCD1, BCD2, BCD3 : std_logic_vector(3 downto 0);

begin
	U0 : frequency_divider
		port map(Clocks, one_clk);
   U1 : fixfreq
	   port map(one_clk, Clocks, Signals, Reset, C_out1(0), Channel0);
	U2 : fixfreq
	   port map(one_clk, Clocks, C_out1(0), Reset, C_out1(1), Channel1);
	U3 : fixfreq
	   port map(one_clk, Clocks, C_out1(1), Reset, C_out1(2), Channel2);
	U4 : fixfreq
	   port map(one_clk, Clocks, C_out1(2), Reset, C_out1(3), Channel3);
	U5 : fixfreq
	   port map(one_clk, Clocks, C_out1(3), Reset, C_out1(4), Channel4);
	U6 : fixfreq
	   port map(one_clk, Clocks, C_out1(4), Reset, C_out1(5), Channel5);
	U7 : fixfreq
	   port map(one_clk, Clocks, C_out1(5), Reset, C_out1(6), Channel6);
	U8 : select_channel
		port map(Channel0, Channel1, Channel2, Channel3, Channel4, Channel5, Channel6, SW, DOTS, Clocks, BCD0, BCD1, BCD2, BCD3);
	U9 : mux_8_to_4
		port map(BCD0, BCD1, SelFromCtrl, fromMUX);
	U10 : freq_div
		port map(Clocks, sclkFromFreqDiv);
	U11 : ctrl_segment
		port map(sclkFromFreqDiv, SelFromCtrl, dgCtrl);
	U12 : bcd_to_7_seg
		port map(fromMUX, Seg0);
	U13 : bcd_to_7_seg
		port map(BCD2, Seg1);
	U14 : bcd_to_7_seg
		port map(BCD3, Seg2);
		
end behavioral;