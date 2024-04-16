library ieee;
use ieee.std_logic_1164.all;
entity dis_meter_sm is
port ( clk , echo : in bit;
		dis : out integer range 0 to 255);
end;
architecture behave of dis_meter_sm is
type state_type is ( wait4echo,sofer,noel);
signal state : state_type;
signal cnt : integer range 0 to 255;
begin

process ( clk , echo  )
begin
if clk'event and clk='1' then
case state is
when wait4echo => cnt<=0;
				  if echo='0' then state<=state;
				  elsif echo='1' then state<=sofer;
					end if;
when sofer => if echo='1' then cnt<=cnt+1; state<=state;
				elsif echo='0' then state<=noel;
				end if;
when noel => dis<=cnt;
			 state<=wait4echo;
end case;
end if;
end process;
end behave;

