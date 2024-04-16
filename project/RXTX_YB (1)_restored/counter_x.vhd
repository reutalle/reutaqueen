library ieee;
use ieee.std_logic_1164.all;
entity counter_x is
port ( clk : in bit;
	   sw : in bit;
	   do:buffer integer range 0 to 255);
end;
architecture behave of counter_x is
begin
process ( clk)
begin
if clk'event and clk='1' then
	if sw='1' then
		if do<255 then do<=do+1; else do<=255; end if;
	elsif sw='0' then
		if do>0 then do<=do-1; else do<=0; end if;
	
	end if;
end if;
end process;
end behave;


