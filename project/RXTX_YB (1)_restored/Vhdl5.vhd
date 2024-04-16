library ieee;
use ieee.std_logic_1164.all;
entity pump is
    port (
        my_rx: in bit_vector(7 downto 0);
        pump_out: out bit
		  
    );
end entity;

architecture behave of pump is 
begin
pump_out<='1' when my_rx="00000001" else '0';

end behave;