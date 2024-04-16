library ieee;
use ieee.std_logic_1164.all;
entity servo_degree  is
port (clk:in  bit;
		degree: in integer range 0 to 7;
pwm_servo : out bit);
end;
architecture b of servo_degree  is
signal cnt , th : integer range 0 to 1000000 ;  --50hz
begin
th<=60000 when degree=0 else -- 0 degrees
	 65000 when degree=1 else -- _ degrees
	 70000 when degree=2 else --  degrees
	 75000 when degree=3 else --  90 degrees
	 80000 when degree=4 else --  degrees
	 85000 when degree=5 else --  degrees
	 90000 when degree=6 else --  degrees
	 95000 when degree=7 ; -- 180 degrees

	 
process (clk)
begin
if clk'event and clk='1' then
if cnt<1000000 then cnt<=cnt+1; else cnt<=0;  end if;
if cnt<th then pwm_servo<='1'; else pwm_servo<='0'; end if;
end if;
end process;
end b;


