----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:05:08 11/16/2015 
-- Design Name: 
-- Module Name:    RAM - Behavioral 
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

entity RAM is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           addr : out  STD_LOGIC_VECTOR (18 downto 0);
           data_write : out  STD_LOGIC;
           data_in : out  STD_LOGIC_VECTOR (2 downto 0));
end RAM;

architecture Behavioral of RAM is
  TYPE     rom_type IS ARRAY (0 TO (ROM_MAX_ADDR-1)) OF SIGNED (ROM_DATA_BITS-1 DOWNTO 0);
  CONSTANT memory : rom_type := (

begin

PROCESS (CLOCK, RESET)
  BEGIN
  
	 IF (RESET='1') then DATA_IN <= "00000000000";
    ELSIF (CLOCK'event AND CLOCK = '1') THEN
		
      DATA_IN <= STD_LOGIC_VECTOR( memory(to_integer(UNSIGNED(ADDR))) );
    END IF;
  END PROCESS;

end Behavioral;

