library ieee;
use ieee.std_logic_1164.all;
entity switch_SRF is
port (
	S : in bit_vector (1 downto 0);
	d0, d1, d2, d3 : in bit_vector (7 downto 0);
	Y : out bit_vector (7 downto 0)
	);
end;
architecture behave of switch_SRF is
begin
with S select 
	Y <= d0 when "00",
		  d1 when "01",
		  d2 when "10",
		  d3 when "11";
end behave;
