library ieee;
use ieee.std_logic_1164.all;
entity piazo is
	port(clk: in bit;
		  di : in bit_vector(7 downto 0);
		f_out: buffer bit);
end  ;
architecture behave of piazo is 
	signal cnt,x: integer range 0 to 95785;
		signal y: integer range 0 to 25000000;

	signal en,clr,os:bit;
	signal temp: bit_vector(7 downto 0);
begin
process (clk,clr)
begin
if clr='1' then en<='0';
elsif clk'event and clk='1' then
if (di = temp) then null;
else temp<=di; en<='1'; end if;
end if;
end process;

process (clr,clk)
begin
if clr='1' then y<=0;os<='0';
elsif clk'event and clk='1' then
	if en='1' then
		if y<25000000 then y<=y+1; os<='1'; end if;
	end if;
end if;
end process;
clr<='1' when y=25000000 else '0';


x<= 95785 when di(3 downto 0)="0000" else
	 84745 when di(3 downto 0)="0001" else
	 75757 when di(3 downto 0)="0010" else
	 71633 when di(3 downto 0)="0011" else
	 63775 when di(3 downto 0)="0100" else
	 56818 when di(3 downto 0)="0101" else
	 50709 when di(3 downto 0)="0110" else
	 47801 when di(3 downto 0)="0111" else
	 42589 when di(3 downto 0)="1000" else
	 37936 when di(3 downto 0)="1001" else
	 20000;

	process(clk)
	begin
		if clk'event and clk='1' then
		if cnt<x then
			cnt<=cnt+1;
		else
			cnt<=0;
		f_out <= os and (not f_out);
		end if;
		end if;
	end process;
end behave;	