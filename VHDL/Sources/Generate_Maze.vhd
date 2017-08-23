----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:36:36 11/17/2015 
-- Design Name: 
-- Module Name:    Generate_Maze - Behavioral 
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
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Generate_Maze is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           addr1 : out  STD_LOGIC_VECTOR (18 downto 0);
           data_write1 : out  STD_LOGIC;
           data_in1 : out  STD_LOGIC_VECTOR (2 downto 0));
end Generate_Maze;

architecture Behavioral of Generate_Maze is

signal initialisation : boolean:= false;

signal ADDR : integer range 0 to 307199:=0;
signal MOD_ADDR : integer range 0 to 640:=0;
signal DATA : std_logic_vector(2 downto 0):="111";

begin

process(clock) --synchronous block
begin
   if clock'event and clock='1' then

--Reset	
		if(reset='0') then 
			DATA <= "111";
			ADDR <= 0;
			data_write1<='0';
			initialisation <= false;
			
		else
--If initialisation not happened		
		if(initialisation=false) then

			data_write1<='1';
			MOD_ADDR <= ADDR MOD 640;
		
--Frame	
			if(ADDR<6400) then DATA <= "000"; --up
			elsif(MOD_ADDR >= 0 and  MOD_ADDR < 5) then DATA <= "000"; -- left
			elsif(MOD_ADDR >= 635 and  MOD_ADDR < 640) then DATA <= "000"; --right
			elsif(ADDR>=306560) then DATA <= "000"; --down

--Walls in columns
			elsif(MOD_ADDR >= 75 and MOD_ADDR < 85 and ADDR <= 208000) then DATA <= "000"; -- column 1
			elsif(MOD_ADDR >= 155 and MOD_ADDR < 165 and ADDR >= 99355 and ADDR <= 259365) then DATA <= "000"; --column 2
			elsif(MOD_ADDR >= 235 and MOD_ADDR < 245 and ADDR >= 150635 and ADDR <= 259445) then DATA <= "000"; --column 3 
			elsif(MOD_ADDR >= 315 and MOD_ADDR < 325 and ((ADDR >= 48315 and ADDR <= 105925) or (ADDR >= 201915))) then DATA <= "000"; --column 4
			elsif(MOD_ADDR >= 395 and MOD_ADDR < 405 and (ADDR >= 99595 and ADDR <= 208405)) then DATA <= "000"; --column 5
			elsif(MOD_ADDR >= 475 and MOD_ADDR < 485 and ((ADDR >= 99675 and ADDR <= 157285) or (ADDR >= 202075 and ADDR <= 259685))) then DATA <= "000"; --column 6
			elsif(MOD_ADDR >= 555 and MOD_ADDR < 565 and ((ADDR >= 48555 and ADDR <= 106165) or (ADDR >= 150955 and ADDR <= 208565))) then DATA <= "000"; --column 7

--Walls in lines
			elsif( (MOD_ADDR >= 75 and MOD_ADDR < 245 and ADDR >= 48075 and ADDR <= 54645 ) or (MOD_ADDR >= 315 and MOD_ADDR < 565 and ADDR >= 48315 and ADDR < 54965 )) then DATA <= "000";	--line 1
			elsif( (MOD_ADDR >= 155 and MOD_ADDR < 325 and ADDR >= 99355 and ADDR <= 105925 ) or (MOD_ADDR >= 395 and MOD_ADDR < 565 and ADDR >= 99595 and ADDR < 106165 )) then DATA <= "000";	--line 2  
			elsif( (MOD_ADDR >= 235 and MOD_ADDR < 405 and ADDR >= 150635 and ADDR <= 157205 ) or (MOD_ADDR >= 475 and MOD_ADDR < 640 and ADDR >= 150875 and ADDR < 157440 )) then DATA <= "000"; --line 3
			elsif( (MOD_ADDR >= 75 and MOD_ADDR < 165 and ADDR >= 252875 and ADDR <= 259365 ) or (MOD_ADDR >= 395 and MOD_ADDR < 640 and ADDR >= 253195 and ADDR < 259840 )) then DATA <= "000"; --line 5

--Cursor

			elsif(MOD_ADDR >= 32 and MOD_ADDR < 47 and ADDR >= 21120 and ADDR <= 30080) then DATA <= "001"; --center is at (x,y)=(40,40), i.e. ADDR=25000
--			elsif(ADDR = 25000) then DATA <= "001";

--White background			
			else DATA <= "111";
			
			end if;
--ADDR incrementation and initialisation true
			if(ADDR<307199) then ADDR <= ADDR+1;
			else initialisation<=true;
			end if;
			
		else data_write1<='0';
		
      end if;
		end if;
   end if;
end process;

--Output writing
data_in1 <= DATA;
addr1 <= std_logic_vector(to_signed(ADDR,19));

end Behavioral;

