----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:08:30 11/28/2015 
-- Design Name: 
-- Module Name:    Pixel_Demand - Behavioral 
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

entity Pixel_Demand is
    Port ( DBL : in  STD_LOGIC;
           DBR : in  STD_LOGIC;
           DBU : in  STD_LOGIC;
           DBD : in  STD_LOGIC;
           clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           position : in  STD_LOGIC_VECTOR (18 downto 0);
           addr_D : out  STD_LOGIC_VECTOR (18 downto 0);
           data_where_D : out  STD_LOGIC_VECTOR (1 downto 0);
           addr_V : out  STD_LOGIC_VECTOR (18 downto 0);
           data_where_V : out  STD_LOGIC_VECTOR (1 downto 0));
end Pixel_Demand;

architecture Behavioral of Pixel_Demand is

signal addr_int : integer; 
constant POSITION_START: STD_LOGIC_VECTOR(18 downto 0) := "0000110010000000000"; --31st column, 16th line
signal current_position : integer;
signal addr : STD_LOGIC_VECTOR(18 downto 0);
signal type_row : integer; -- '0' for horizontal row, '1' for vertical7
signal data_where: STD_LOGIC_VECTOR(1 downto 0);


begin

push : process(DBL, DBR, DBU, DBD, addr_int, addr, data_where, clock, reset)
begin

if(reset='0') then

	addr_int <= to_integer(unsigned(POSITION_START)); 
	data_where <= "00";
   current_position <= addr_int;
	
elsif(clock'event and clock='1') then

current_position <= to_integer(unsigned(position));
	
-- left button pushed	
	if(DBL='1' and DBR='0' and DBU = '0' and DBD = '0') then   
		addr_int <= current_position - 8 - 640*8; --top left corner
		data_where <= "10"; --vertical
		
-- right button pushed
	elsif(DBL='0' and DBR ='1' and DBU = '0' and DBD = '0') then   
		addr_int <= current_position + 8 - 640*8; --top right corner
		data_where <= "11"; --vertical
		
-- top button pushed	
	elsif(DBL='0' and DBR ='0' and DBU = '1' and DBD = '0') then   
		addr_int <= current_position - 8 - 640*8; --top left corner
		data_where <="00"; --horizontal
		
-- bottom button pushed	
	elsif(DBL='0' and DBR ='0' and DBU = '0' and DBD = '1') then   
		addr_int <= current_position - 8 + 640*8; --bottom left corner
		data_where <= "01"; --horizontal
	
	end if;
end if;

addr <= std_logic_vector(to_unsigned(addr_int,19));
addr_D <= addr;
addr_V <= addr;

data_where_D <= data_where;
data_where_V <= data_where;

end process push;



end Behavioral;

