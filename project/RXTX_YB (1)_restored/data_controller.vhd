library ieee;
use ieee.std_logic_1164.all;
entity data_controller is
port( clk,rst : in std_logic;
		data_in : in std_logic_vector(7 downto 0);
		right_dis,left_dis,front_dis,back_dis : in integer range 0 to 255;
	   dc_motors_direction : buffer std_logic_vector(7 downto 0);
		dc_motors_speed : buffer std_logic_vector(1 downto 0);
		servo_engA,servo_engB,servo_engC,servo_engD,
		servo_engE,servo_engF,servo_engG : buffer std_logic_vector(2 downto 0));
end;
		
		
architecture behave of data_controller is
signal talking : std_logic_vector(1 downto 0);
signal din : std_logic_vector(7 downto 0);
begin
process (clk)
begin
if clk'event and clk='1' then
talking<=data_in(7 downto 6);
din<=data_in;
end if;
end process;

process (clk,talking)
begin
if rst='1' then
dc_motors_direction<= "00000000";  -- stop
servo_engA<= "111";
servo_engB<=  "000";
servo_engC<=  "000";
servo_engD<=  "011";
servo_engE<=  "000";
servo_engF<=  "000";
servo_engG<=  "000";
elsif clk'event and clk='1' then
case talking is
when "00" => if din(3 downto 0)="0000" or right_dis<10 or left_dis<10 or front_dis<10 or back_dis<10 	then 
															dc_motors_direction<= "00000000";  -- stop
			 elsif din(3 downto 0)="0001" then dc_motors_direction<= "10011001";  -- forward
			 elsif din(3 downto 0)="0010" then dc_motors_direction<= "01100110";  -- backward
			 elsif din(3 downto 0)="0011" then dc_motors_direction<= "01011010";  -- turn left 
			 elsif din(3 downto 0)="0100" then dc_motors_direction<= "10100101";  -- turn right
			 elsif din(3 downto 0)="0101" then dc_motors_direction<= "01010101";  -- slide left
			 elsif din(3 downto 0)="0110" then dc_motors_direction<= "10101010";  -- slide right
			 elsif din(3 downto 0)="0111" then dc_motors_direction<= "00010001";  -- diag fl 
			 elsif din(3 downto 0)="1000" then dc_motors_direction<= "10001000";  -- diag fr 
			 elsif din(3 downto 0)="1001" then dc_motors_direction<= "01000100";  -- diag bl 
			 elsif din(3 downto 0)="1010" then dc_motors_direction<= "00100010";  -- diag br 
					else dc_motors_direction<= dc_motors_direction;
			 end if;
			 dc_motors_speed<= din(5 downto 4);
			 
			 
	
when "01" => dc_motors_direction<= "00000000";  -- stop
			 if  din(5 downto 3)="000" then servo_engA<= din(2 downto 0);
			 elsif  din(5 downto 3)="001" then servo_engB<= din(2 downto 0);
			 elsif  din(5 downto 3)="010" then servo_engC<= din(2 downto 0);
			 elsif  din(5 downto 3)="011" then servo_engD<= din(2 downto 0);
			 elsif  din(5 downto 3)="100" then servo_engE<= din(2 downto 0);
			 elsif  din(5 downto 3)="101" then servo_engF<= din(2 downto 0);
			 elsif  din(5 downto 3)="110" then servo_engG<= din(2 downto 0);
			 end if;
when others =>null;-- dc_motors_speed<= dc_motors_speed;dc_motors_direction<= dc_motors_direction;


end case;
end if;
end process;

					
						
						
end behave;

