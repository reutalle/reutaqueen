library ieee;
use ieee.std_logic_1164.all;
entity disp_mux is
	port( ah,as,me:in integer range 0 to 15;
		run:in bit_vector(2 downto 0);
		y:out integer range 0 to 15 );
end disp_mux;
architecture behave of disp_mux is 
begin
	with run select
	y<=ah when "001",
		as when "010",
	me when others;
end behave;
 
