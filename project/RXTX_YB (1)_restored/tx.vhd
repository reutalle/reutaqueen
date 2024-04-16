library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity TX is 
port ( clk,rst,send: in bit;
	data_in: in bit_vector(7 downto 0);
	tx_ser_out: out bit;
	tx_busy:out bit);
end TX;
architecture behave of TX is
signal cnt: integer range 0 to 160;
signal clr,start: bit;
begin

process (clr,rst,send)
begin
if rst='1' or clr='1' then
start<='0';
elsif send'event and send='0' then
start<='1';
end if;
end process;

process(clk,clr,rst)
begin	
if rst='1' or clr='1' then
	cnt<=0;
	tx_ser_out<='1';
    tx_busy<='0';
	elsif clk'event and clk='1' then
	if start='1' then
		if cnt<160 then cnt<=cnt+1;
		else cnt<=0;
		end if;
		if cnt<16 then tx_ser_out<='0';
		tx_busy<='1';
		elsif cnt<32 then tx_ser_out<=data_in(0);
		tx_busy<='1';
		elsif cnt<48 then tx_ser_out<=data_in(1);
		tx_busy<='1';
		elsif cnt<64 then tx_ser_out<=data_in(2);
		tx_busy<='1';
		elsif cnt<80 then tx_ser_out<=data_in(3);
		tx_busy<='1';
		elsif cnt<96 then tx_ser_out<=data_in(4);
		tx_busy<='1';
		elsif cnt<112 then tx_ser_out<=data_in(5);
		tx_busy<='1';
		elsif cnt<128 then tx_ser_out<=data_in(6);
		tx_busy<='1';
		elsif cnt<144 then tx_ser_out<=data_in(7);
		tx_busy<='1';

		elsif cnt<160 then tx_ser_out<='1';
		tx_busy<='0';
		end if;
	end if;
end if;
end process;
clr<='1' when cnt=160 else '0';
end behave;
