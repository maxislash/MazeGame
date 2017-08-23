----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:17:27 11/28/2015 
-- Design Name: 
-- Module Name:    Pixel_Check - Behavioral 
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

entity Pixel_Check is
    Port ( addr_V : in  STD_LOGIC_VECTOR (18 downto 0);
           data_where_V : in  STD_LOGIC_VECTOR (1 downto 0);
           addr3 : in  STD_LOGIC_VECTOR (18 downto 0);
           data_in3 : in  STD_LOGIC_VECTOR (2 downto 0);
           data_write3 : in  STD_LOGIC;
           clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           addr : out  STD_LOGIC_VECTOR (18 downto 0);
           data_where : out  STD_LOGIC_VECTOR (1 downto 0);
           enable_movement : out  STD_LOGIC);
end Pixel_Check;

architecture Behavioral of Pixel_Check is

signal addr_Check : integer range 0 to 307200;
signal addr_int : integer range 0 to 307200;
signal data_where_Check : STD_LOGIC_VECTOR (1 downto 0);
signal cmpt : integer range 0 to 15;

begin


available : process(data_where_V, addr_V, data_write3, clock, reset)
begin


if(reset='0') then
	data_where_Check <= "00"; ------
	addr_Check <= 0 ; ------
	cmpt <= 0; --counter
	enable_movement <= '0';
	addr <= std_logic_vector(to_unsigned(0,19));
	data_where <= "00";
	
	
elsif(clock'event and clock='1') then

	if(data_write3='0') then
		enable_movement <= '0';
		cmpt <= 0;
		
		data_where_Check <= data_where_V;
		addr_Check <= to_integer(unsigned(addr_V));
	
	elsif(data_write3 = '1' and cmpt < 14) then 
		
		
		addr_int <= to_integer(unsigned(addr3));

		
		if(data_where_Check(1) = '0') then    -- horizontal row
		
			if(addr_int = addr_Check and data_in3 = "111") then
				addr_Check <= addr_Check + 1; 		--one pixel to the right
				cmpt <= cmpt+1;
			else      --wall or error, we don't move
				cmpt <= 0; --ATTENTION ICI GESTION DES ERREURS A FAIRE ICI, SI LA COMPARAISON N'EST PAS BONNE IL Y A ERREUR, IL FAUT LA GERER!
			end if;
			
		else		--vertical row
		
			if(addr_int = addr_Check and data_in3 = "111") then
				addr_Check <= addr_Check + 640; 	--one pixel to the bottom
				cmpt <= cmpt+1;
			else
			   cmpt <= 0; -- ATTENTION DE MEME !!
			end if;
			
		end if;
		
	else   --cmpt>=15
		cmpt <= 0;
		addr_Check <= addr_Check - 15;
		addr <= std_logic_vector(to_unsigned(addr_Check,19));
		data_where <= data_where_Check;
	
		enable_movement <= '1';
	end if;
		

				
end if;
	

end process available;

end Behavioral;

