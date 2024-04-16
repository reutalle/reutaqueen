library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adc_hl is
port(L :in std_logic_vector(11 downto 0);
     y: out std_logic_vector(7 downto 0));
	  
end;

architecture behave of adc_hl is
begin
y(7 downto 4)<="0000";
y(3 downto 0)<=std_logic_vector("1101"-unsigned(L(9 downto 6)));

end behave;

