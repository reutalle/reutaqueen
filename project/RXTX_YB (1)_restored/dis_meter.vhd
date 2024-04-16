library ieee;
use ieee.std_logic_1164.all;

entity dis_meter is
port( 
	clk, echo : in bit;
	dis : out integer range 0 to 255
);

end;

architecture behave of dis_meter is
type state_type is (wait4echo, scount, lock);
signal state : state_type;
signal cnt : integer range 0 to 255;

begin
process(clk, echo)
	begin
	if clk'event and clk='1' then
		case state is
			
			when wait4echo => cnt<=0;
				if echo='0' then state<=state;
				elsif echo='1' then state<=scount;
				end if;
				
			when scount =>
				if echo='1' then
					if cnt<255 then cnt<=cnt+1;
					else cnt<=255;
					end if;
					state<=state;
				elsif echo='0' then state<=lock;
				end if;
				
			when lock => 
				dis<=cnt;
				state<=wait4echo;
				
		end case;
	end if;
end process;
end behave;