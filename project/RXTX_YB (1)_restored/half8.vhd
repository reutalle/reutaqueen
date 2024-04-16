library ieee;
use ieee.std_logic_1164.all;

entity half8 is
port (byte:in bit_vector (7 downto 0);
      high:out bit_vector (3 downto 0);
	  low :out bit_vector(3 downto 0));
end;

architecture behave of half8 is
begin
high<= byte(7 downto 4);
low<= byte(3 downto 0);
end behave;
