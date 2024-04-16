library ieee;
use ieee.std_logic_1164.all;
entity moisture_control is
port(
m : in integer range 0 to 4095;
pump : out bit
);
end;
 architecture behave of moisture_control is
 begin
 process(m)
 begin
 if m >4 then pump <='1'; 
 else pump<='0';
 end if;
 end process;
 end behave;
 