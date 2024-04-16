library ieee;
use ieee.std_logic_1164.all;
entity pwm_motor  is
port (clk:in  bit;
		speed: in bit_vector(1 downto 0);
pwm_out : out bit);
end;
architecture b of pwm_motor  is
signal cnt , th : integer range 0 to 50000 ;  --1Khz
begin
th<=30000 when speed="00" else
	 35000 when speed="01" else
	 45000 when speed="10" else
	 49999;
	 
process (clk)
begin
if clk'event and clk='1' then
if cnt<50000 then cnt<=cnt+1; else cnt<=0;  end if;
if cnt<th then pwm_out<='1'; else pwm_out<='0'; end if;
end if;
end process;
end b;


