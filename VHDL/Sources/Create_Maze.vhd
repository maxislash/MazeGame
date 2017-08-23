----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:38:26 11/28/2015 
-- Design Name: 
-- Module Name:    Create_Maze - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Create_Maze is
	 generic (number_cell : integer range 1 to 192 :=48);
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           config_cell : out  STD_LOGIC_VECTOR (3 downto 0));
end Create_Maze;

architecture Behavioral of Create_Maze is

   type ram_type1 is array (0 to number_cell -1) of std_logic;
   signal etat_cell : ram_type2;
	
	type ram_type2 is array (0 to number_cell -1) of std_logic_vector(3 downto 0);
   signal config_cell : ram_type2;
	
	type ram_type3 is array (0 to number_cell -1) of integer range 0 to number_cell;
   signal history : ram_type3;
	
	signal initialisation : integer range 0 to 2;
	signal count : integer range 0 to number_cell -1;

begin

process(clock,reset)
begin 

if (clock'event and clock='1') then

	if reset ='0' then
		initialisation <= 0;
			
	else 

		if initialisation=0 then
			count <= 0;
			initialisation <= 1 ;
			
		elsif initialisation=1 then
		
			if count = number_cell -1 then initialisation <= 2;
			else
				etat_cell(count)<= '0';
				config_cell(count) <= "0000";
				history(count) <= 0;
				count <= count+1;
				
			end if;
		
		else
			
			
		end if;
		
	end if;
end if;	

end process;
end Behavioral;

