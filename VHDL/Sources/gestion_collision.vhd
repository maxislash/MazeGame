----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:10:32 11/17/2015 
-- Design Name: 
-- Module Name:    gestion_collision - Behavioral 
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity gestion_collision is 
	 port ( 
			  DBL : in  STD_LOGIC; --left debounced button
           DBR : in  STD_LOGIC; --right
           DBU : in  STD_LOGIC; --up
           DBD : in  STD_LOGIC; --down
           addr3: in  STD_LOGIC_VECTOR(18 downto 0); --pixel address
			  data_write3: in STD_LOGIC; 
			  data_in3: in STD_LOGIC_VECTOR(2 downto 0); --pixel color
			  clock: in  STD_LOGIC;
			  reset: in STD_LOGIC;
			  addr_3: out STD_LOGIC_VECTOR(18 downto 0);
			  data_rw: out STD_LOGIC_VECTOR(1 downto 0);
           addr_m : out  STD_LOGIC_VECTOR(18 downto 0)
			  );
end gestion_collision;

architecture Behavioral of gestion_collision is

signal addr_int : integer; 
constant POSITION_START: STD_LOGIC_VECTOR(18 downto 0) := "0000100110110101001"; --31st column, 16th line
signal current_position : integer;
signal type_row : integer; -- '0' for horizontal row, '1' for vertical

signal count : integer;

signal cmpt : integer;

signal enable_movement : std_logic;

begin





end Behavioral;

