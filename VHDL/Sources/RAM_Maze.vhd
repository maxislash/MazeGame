----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:37:48 11/18/2015 
-- Design Name: 
-- Module Name:    RAM_Maze - Behavioral 
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
use IEEE.Numeric_Std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RAM_Maze is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  
           addr1 : in  STD_LOGIC_VECTOR (18 downto 0);
           data_write1 : in  STD_LOGIC;
           data_in1 : in  STD_LOGIC_VECTOR (2 downto 0);
			  
           addr2 : in  STD_LOGIC_VECTOR (18 downto 0);
           data_rw : in  STD_LOGIC_VECTOR (1 downto 0);
           data_in2 : in  STD_LOGIC_VECTOR (2 downto 0);
			  
			  addr3 : out STD_LOGIC_VECTOR (18 downto 0);
			  data_write3 : out STD_LOGIC;
           data_in3 : out  STD_LOGIC_VECTOR (2 downto 0);
			  
           addr0 : out  STD_LOGIC_VECTOR (18 downto 0);
           data_write0 : out  STD_LOGIC;
           data_in0 : out  STD_LOGIC_VECTOR (2 downto 0));
end RAM_Maze;

architecture Behavioral of RAM_Maze is

   type ram_type is array (0 to 307199) of std_logic_vector(2 downto 0);
   signal ram : ram_type;
	
	signal integer_addr2 : integer range 0 to 307199:=0;
	signal pixel_asked : integer range 0 to 307199:=0;
	signal count : integer range 0 to 30 :=0;

begin

  RamProc: process(clock) is

  begin
    if rising_edge(clock) then
	 
		if reset = '0' then
			data_write0 <= '0';
			data_write3 <= '0';
			
		else
			
			if data_write1 = '1' then --initialisation from Generate_Maze activate
				ram(to_integer(unsigned(addr1))) <= data_in1; --writing in the RAM
			
				data_write0 <= '1'; --writing in the VGA memory
				addr0 <= addr1;
				data_in0 <= data_in1;
				
				data_write3 <= '0'; --writing nothing for the movement management
				
			else --if not initialisation
			
				integer_addr2 <= to_integer(unsigned(addr2));
				
				if data_rw = "01" then --if movement management wants to display 
					ram(integer_addr2) <= data_in2; --writing in the RAM 
					
					data_write0 <= '1'; --writing in the VGA memory
					addr0 <= addr2; 
					data_in0 <= data_in2;
					
					data_write3 <= '0'; --writing nothnig for the movement management
					
				elsif data_rw = "10" then --if movement management wants to know what there are on the 15 pixels in line
					
					if integer_addr2 /= pixel_asked then 
						pixel_asked <= integer_addr2;
						count <= 0;
					
					elsif count = 1 then
						data_write3 <= '0';

					else 
						  data_in3 <= ram(pixel_asked + count);
						  count <= count +1;
						  data_write3 <= '1'; --writing the pixel asked + count for the movement management
					     addr3 <= addr2;
						  

					end if;
										
					data_write0 <= '0'; --writing nothing for the VGA
				
				elsif data_rw = "11" then --if movement management wants to know what there are on the 30 pixels in column
					
					if integer_addr2 /= pixel_asked then 
						pixel_asked <= integer_addr2;
						count <= 0;
					
					elsif count = 1 then
						data_write3 <= '0';

					else 
						  data_in3 <= ram(pixel_asked + (count*640));
						  count <= count +1 ;
						  data_write3 <= '1'; --writing the pixel asked + count for the movement management
					     addr3 <= addr2;
					     
					end if;
										
					data_write0 <= '0'; --writing nothing for the VGA
					
				else -- if movement management do nothing, RAM_Maze do nothing too
					data_write0 <= '0';
					data_write3 <= '0';
					
				end if;
			
			end if;

		end if;
	end if;
  end process RamProc;

end Behavioral;

