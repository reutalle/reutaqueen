


library ieee;
use ieee.std_logic_1164.all;
entity boud is
	port(clk: in bit;
		f_out: out bit);
end boud ;
architecture behave of boud is 
	signal f_out_tmp: bit;
	signal cnt: integer range 0 to 162;
begin
	process(clk)
	begin
		if clk'event and clk='1' then
		if cnt<162 then
			cnt<=cnt+1;
		else
			cnt<=0;
		f_out_tmp <= not f_out_tmp;
		end if;
		end if;
	end process;
	f_out<=f_out_tmp;
end behave;	
