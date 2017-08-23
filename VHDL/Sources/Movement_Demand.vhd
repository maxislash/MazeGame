----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:38:54 11/28/2015 
-- Design Name: 
-- Module Name:    Movement_Demand - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Movement_Demand is
    Port ( addr_D : in  STD_LOGIC_VECTOR (18 downto 0);
           data_where_D : in  STD_LOGIC_VECTOR (1 downto 0);
           addr : in  STD_LOGIC_VECTOR (18 downto 0);
           data_where 	: in  STD_LOGIC_VECTOR (1 downto 0);
           enable_movement : in  STD_LOGIC;
			  clock : in STD_LOGIC;
			  reset : in STD_LOGIC;          
			  position : out  STD_LOGIC_VECTOR (18 downto 0);
			  addr2 : out  STD_LOGIC_VECTOR (18 downto 0);
           data_rw : out  STD_LOGIC_VECTOR (1 downto 0);
           data_in2 : out  STD_LOGIC_VECTOR (2 downto 0));
end Movement_Demand;

architecture Behavioral of Movement_Demand is

signal count_put : integer range 0 to 15 := 0;
signal count_erase : integer range 0 to 15 := 0;
signal addr_center : integer range 0 to 307200 := 0;

signal addr_int : integer range 0 to 307200 := 0;

signal clock_enable : std_logic := '0';
signal prescaler : integer := 800000 ;
signal prescaler_counter : integer range 0 to 800001 := 0;
signal tempo_counter : integer range 0 to 30 := 0;
signal tempo : integer := 30;

signal data_in2_inter : std_logic_vector (2 downto 0);
signal data_rw_inter : std_logic_vector (1 downto 0);
signal position_inter : std_logic_vector (18 downto 0);

constant POSITION_START: STD_LOGIC_VECTOR(18 downto 0) := "0000110010000000000"; --31st column, 16th line


begin


prescaler_clock_8Hz : process(clock, reset)
begin

if(reset='0') then 
	clock_enable <= '0';
	prescaler_counter <= 0;
	prescaler <= 800000;
	tempo_counter <= 0;
	tempo <= 30;

elsif(clock'event and clock ='1') then

	if(prescaler_counter >= prescaler) then
		clock_enable <= '1';
		if(tempo_counter >= tempo) then  -- to wait 30 clock period
			prescaler_counter <= 0;
			tempo_counter <= 0;
		else
			tempo_counter <= tempo_counter + 1;
		end if;
	else 
		prescaler_counter <= prescaler_counter + 1;
		clock_enable <= '0';
	end if;
end if;

end process;



movement : process(addr, enable_movement, clock, reset, addr_int, data_in2_inter, data_rw_inter, position_inter)
begin

if(reset='0') then

	count_put <= 0;
	count_erase <= 0;
	addr_int <= 0;
	data_rw_inter <= "00";
	data_in2_inter <= "111";
	position_inter <= POSITION_START;
	
elsif(clock'event and clock='1') then

		if(enable_movement ='1') then
			if(clock_enable = '1') then 
				if(count_put < 15)	then
					
					if(count_put = 0) then
						addr_int <= to_integer(unsigned(addr));
						count_put <= count_put + 1;    -- to write the first pixel and to not switch on the second one directly
					else
						case data_where(1) is
							when '0' => addr_int <= addr_int + 1; -- horizontal movement
							when '1' => addr_int <= addr_int + 640; -- vertical
							when others => data_rw <= "00";
						end case;
						count_put <= count_put + 1;
					end if;
			
								
					data_in2_inter <= "001";
					data_rw_inter <= "01";
					
				elsif(count_erase < 15) then 
				
					data_in2_inter <= "111";
					data_rw_inter <= "01";
			
					if(count_erase = 0) then 
						case data_where is 
							when "00" => addr_int <= addr_int + 640*15;
							when "01" => addr_int <= addr_int - 640 * 15;
							when "10" => addr_int <= addr_int + 15;
							when "11" => addr_int <= addr_int -15;
							when others => addr_int <= addr_int;
						end case;
						count_erase <= count_erase + 1;
					else
						case data_where is
							when "00" => 	addr_int <= addr_int - 1;
							when "01" =>	addr_int <= addr_int - 1;
							when "10" =>	addr_int <= addr_int - 640;
							when "11" =>	addr_int <= addr_int - 640;
							when others => data_rw <= "00";
						end case;
						
						count_erase <= count_erase + 1;
					
					end if;
					
				else
					count_put <= 0;
					count_erase <= 0;
					case data_where is
						when "00" => 	addr_center <= addr_int + 8 + 7*640;
											
						when "01" =>	addr_center <= addr_int + 8 - 7*640;
						when "10" =>	addr_center <= addr_int + 7 + 8*640;
						when "11" =>	addr_center <= addr_int - 7 + 8*640;
						when others => addr_center <= addr_int;
					end case;
						
					
					position_inter <= std_logic_vector(to_unsigned(addr_center,19));
				
				end if;
			end if;
			
			
-- enable_movement = '0'
		else 
			addr_int <= to_integer(unsigned(addr_D));
			if(data_where_D ="10" or data_where_D = "11") then
				data_rw_inter <= "10";
			else 
			data_rw_inter <= "11";
			end if;
			data_in2_inter <= "010";
		end if;
		

end if;

addr2 <= std_logic_vector(to_unsigned(addr_int,19));
data_in2 <= data_in2_inter;
data_rw <= data_rw_inter; 
position <= position_inter;
		
end process movement;



end Behavioral;

