library ieee;
use ieee.std_logic_1164.all;
entity lpf is
	port (i,clk:in bit;
			y:out bit);
end lpf;
architecture behave of lpf is 
signal buf:bit_vector(29 downto 0);
signal ones,zeros:bit_vector (29 downto 0);
begin
	ones<=(others=>'1');
	zeros<=(others=>'0');
	process(clk,i)
	begin
			if clk'event and clk='1' then
			buf<=i & buf(29 downto 1);
			if buf=ones then y<='1';
			elsif buf<=zeros then y<='0';
			end if;
			end if;
	end process;
end behave; 
