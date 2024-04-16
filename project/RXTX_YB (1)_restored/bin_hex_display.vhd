
library ieee;
use ieee.std_logic_1164.all;
entity bin_hex_display is
	port( bin: in bit_vector (3 downto 0);
		seg_out: out bit_vector (6 downto 0));
end bin_hex_display;
architecture behave of bin_hex_display is 
begin 
	process(bin)
	begin
	case bin is 
	when"0000"=> seg_out<="1000000";
	when"0001"=> seg_out<="1111001";
	when"0010"=> seg_out<="0100100";
	when"0011"=> seg_out<="0110000";
	when"0100"=> seg_out<="0011001";
	when"0101"=> seg_out<="0010010";
	when"0110"=> seg_out<="0000010";
	when"0111"=> seg_out<="1111000";
	when"1000"=> seg_out<="0000000";
	when"1001"=> seg_out<="0010000";
	when"1010"=> seg_out<="0001000";
	when"1011"=> seg_out<="0000011";
	when"1100"=> seg_out<="1000110";
	when"1101"=> seg_out<="0100001";
	when"1110"=> seg_out<="0000110";
	when"1111"=> seg_out<="0001110";	
	end case;
	end process;
end behave;
