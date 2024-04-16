library ieee;
use ieee.std_logic_1164.all;
entity uln_1 is
port(
	water : in bit_vector(7 downto 0);
	 piezo : out bit_vector(7 downto 0)
);
end;

architecture behave of uln_1 is
begin
piezo<="00001001" when water(3 downto 0) = "0000" else "00000000";
end behave;