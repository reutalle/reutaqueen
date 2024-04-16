library ieee;
use ieee.std_logic_1164.all;
entity clkdiv is
port (clk:in  bit;
y : buffer bit);
end;
architecture b of clkdiv is
signal cnt  : integer range 0 to 50000000 ;
begin
process (clk)
begin
if clk'event and clk='1' then
if cnt<12000000 then cnt<=cnt+1; else cnt<=0; y<=not y; end if;
end if;
end process;
end b;


