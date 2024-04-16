library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity divider12MHz is
    Port ( clk_in 	: IN	STD_LOGIC;
           clk_out 	: OUT	STD_LOGIC
	 );
end divider12MHz;

architecture Behavioral of divider12MHz is

SIGNAL count: INTEGER RANGE 0 to 99; -- citac

begin

	-- Proces pro deleni taktu 1/100
	process (clk_in)
	begin
		if (rising_edge(clk_in)) then
			count <= count + 1;				-- inkrementace citace
			if (count = 3) then				--	konec periody citace
				count <= 0;						-- reset citace
				clk_out <= '1';				-- nastaveni vystupniho signalu
			else
				clk_out <= '0';				-- zruseni vystupniho signalu
			end if;
		end if;
	end process;

end Behavioral;