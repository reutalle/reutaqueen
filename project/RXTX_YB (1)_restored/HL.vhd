library ieee;
use ieee.std_logic_1164.all;

entity adc_hl is
port(L :in bit_vector(11 downto 0);
     H :in bit_vector(11 downto 0);
     y: out bit_vector(7 downto 0));
	  
end;

architecture behave of adc_hl is
begin
y<=L(3 downto 0) & H(3 downto 0);

end behave;		