library ieee;
use ieee.std_logic_1164.all;
entity pwm_motors is
port( motors : in bit_vector (7 downto 0);
		pwm : in bit;
	  ml0,ml1,mr0,mr1,mlb0,mlb1,mrb0,mrb1 : out bit);
end;

architecture behave of pwm_motors is
begin
ml0<=pwm and motors(0);
ml1<=pwm and motors(1);
mr0<=pwm and motors(2);
mr1<=pwm and motors(3);

mlb0<=pwm and motors(4);
mlb1<=pwm and motors(5);
mrb0<=pwm and motors(6);
mrb1<=pwm and motors(7);


end behave;
