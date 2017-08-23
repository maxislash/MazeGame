----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:13:21 11/24/2015 
-- Design Name: 
-- Module Name:    test_affichage - Behavioral 
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

entity test_affichage is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           VGA_hs : out  STD_LOGIC;
           VGA_vs : out  STD_LOGIC;
           VGA_red : out  STD_LOGIC_VECTOR (3 downto 0);
           VGA_green : out  STD_LOGIC_VECTOR (3 downto 0);
           VGA_blue : out  STD_LOGIC_VECTOR (3 downto 0);
           data_out : out  STD_LOGIC_VECTOR (2 downto 0));
end test_affichage;

architecture Behavioral of test_affichage is

COMPONENT vga_bitmap_640x480
	  generic(bit_per_pixel : integer range 1 to 12:=1;    -- number of bits per pixel
          grayscale     : boolean := false);
  port(clk          : in  std_logic;
       reset        : in  std_logic;
       VGA_hs       : out std_logic;   -- horisontal vga syncr.
       VGA_vs       : out std_logic;   -- vertical vga syncr.
       VGA_red      : out std_logic_vector(3 downto 0);   -- red output
       VGA_green    : out std_logic_vector(3 downto 0);   -- green output
       VGA_blue     : out std_logic_vector(3 downto 0);   -- blue output

       ADDR         : in  std_logic_vector(18 downto 0);
       data_in      : in  std_logic_vector(bit_per_pixel - 1 downto 0);
       data_write   : in  std_logic;
       data_out     : out std_logic_vector(bit_per_pixel - 1 downto 0));

    END COMPONENT;
	 
	COMPONENT Generate_Maze 
		Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           addr1 : out  STD_LOGIC_VECTOR (18 downto 0);
           data_write1 : out  STD_LOGIC;
           data_in1 : out  STD_LOGIC_VECTOR (2 downto 0));
	end COMPONENT;
	 
	 COMPONENT RAM_Maze is
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
	 end COMPONENT;
	 
	 signal data_write1 : std_logic;
	 signal addr1 : std_logic_vector(18 downto 0);
	 signal data_in1 : std_logic_vector(2 downto 0);
	 
	 signal data_rw : std_logic_vector(1 downto 0);
	 signal addr2 : std_logic_vector(18 downto 0);
	 signal data_in2 : std_logic_vector(2 downto 0);
	 
	 signal data_write3 : std_logic;
	 signal addr3 : std_logic_vector(18 downto 0);
	 signal data_in3 : std_logic_vector(2 downto 0);
	 
	 signal data_write0 : std_logic;
	 signal addr0 : std_logic_vector(18 downto 0);
	 signal data_in0 : std_logic_vector(2 downto 0);
	 
begin

gene_maze : Generate_Maze port map(clock, reset,addr1,data_write1,data_in1); 

vga : vga_bitmap_640x480 generic map(bit_per_pixel => 3, grayscale => false) port map(clock,reset,VGA_hs,VGA_vs,VGA_red,VGA_green,VGA_blue,addr0,data_in0,data_write0,data_out);

ram : RAM_Maze port map(clock,reset,addr1, data_write1, data_in1, addr2, data_rw, data_in2, addr3, data_write3, data_in3, addr0, data_write0, data_in0);

end Behavioral;

