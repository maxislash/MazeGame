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

entity Movement_Management is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           btnU : in STD_LOGIC;
			  btnD : in STD_LOGIC;
			  btnL : in STD_LOGIC;
			  btnR : in STD_LOGIC;
           VGA_hs : out  STD_LOGIC;
           VGA_vs : out  STD_LOGIC;
           VGA_red : out  STD_LOGIC_VECTOR (3 downto 0);
           VGA_green : out  STD_LOGIC_VECTOR (3 downto 0);
           VGA_blue : out  STD_LOGIC_VECTOR (3 downto 0);
           data_out : out  STD_LOGIC_VECTOR (2 downto 0));
			  
end Movement_Management;

architecture Behavioral of Movement_Management is

	COMPONENT Debounce is
		generic(
			counter_size  :  INTEGER := 19); --counter size (19 bits gives 10.5ms with 50MHz clock)
		Port(
			clock     : IN  STD_LOGIC;  --input clock
			button  : IN  STD_LOGIC;  --input signal to be debounced
			result  : OUT STD_LOGIC); --debounced signal
		end COMPONENT;
	 
	COMPONENT Movement_Demand is
    Port ( addr_D : in  STD_LOGIC_VECTOR (18 downto 0);
           data_where_D : in  STD_LOGIC_VECTOR (1 downto 0);
           addr : in  STD_LOGIC_VECTOR (18 downto 0);
           data_where : in  STD_LOGIC_VECTOR (1 downto 0);
           enable_movement : in  STD_LOGIC;
			  clock : in STD_LOGIC;
			  reset : in STD_LOGIC;
           position : out  STD_LOGIC_VECTOR (18 downto 0);			  
           addr2 : out  STD_LOGIC_VECTOR (18 downto 0);
           data_rw : out  STD_LOGIC_VECTOR (1 downto 0);
           data_in2 : out  STD_LOGIC_VECTOR (2 downto 0));
	end COMPONENT;
	 
--	 COMPONENT Pixel_Check is
--    Port ( addr_V : in  STD_LOGIC_VECTOR (18 downto 0);
--           data_where_V : in  STD_LOGIC_VECTOR (1 downto 0);
--           addr3 : in  STD_LOGIC_VECTOR (18 downto 0);
--           data_in3 : in  STD_LOGIC_VECTOR (2 downto 0);
--           data_write3 : in  STD_LOGIC;
--           clock : in  STD_LOGIC;
--           reset : in  STD_LOGIC;
--           addr : out  STD_LOGIC_VECTOR (18 downto 0);
--           data_where : out  STD_LOGIC_VECTOR (1 downto 0);
--           enable_movement : out  STD_LOGIC);
--	  end COMPONENT;
 
	 COMPONENT Pixel_Demand is
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
	end COMPONENT;

		
COMPONENT vga_bitmap_640x480
	  generic(bit_per_pixel : integer range 1 to 12:=3;    -- number of bits per pixel
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
	 
	 signal data_write0 : std_logic;
	 signal addr0 : std_logic_vector(18 downto 0);
	 signal data_in0 : std_logic_vector(2 downto 0);
	 
	 signal addr_D :   STD_LOGIC_VECTOR (18 downto 0);
    signal data_where_D :   STD_LOGIC_VECTOR (1 downto 0);
    signal addr :  STD_LOGIC_VECTOR (18 downto 0);
    signal data_where :  STD_LOGIC_VECTOR (1 downto 0);
    signal enable_movement :  STD_LOGIC;
    signal position : STD_LOGIC_VECTOR (18 downto 0);
	 
	 signal addr_V :  STD_LOGIC_VECTOR (18 downto 0);
    signal data_where_V :  STD_LOGIC_VECTOR (1 downto 0);
	 
    signal DBL :  STD_LOGIC;
    signal DBR :  STD_LOGIC;
    signal DBU :  STD_LOGIC;
    signal DBD :  STD_LOGIC;


	 signal data_rw : std_logic_vector(1 downto 0);
	 signal addr2 : std_logic_vector(18 downto 0);
	 signal data_in2 : std_logic_vector(2 downto 0);
	 
	 signal data_write3 : std_logic;
	 signal addr3 : std_logic_vector(18 downto 0);
	 signal data_in3 : std_logic_vector(2 downto 0);
	 
begin


debounce_U :  Debounce generic map(counter_size => 19) port map(clock, btnU, DBU); 
debounce_D : Debounce generic map(counter_size => 19) port map(clock, btnD, DBD); 
debounce_L : Debounce generic map(counter_size => 19) port map(clock, btnL, DBL); 
debounce_R : Debounce generic map(counter_size => 19) port map(clock, btnR, DBR); 

mvmt_demand : Movement_Demand port map(addr_D, data_where_D, addr, data_where, enable_movement, clock, reset, position, addr2, data_rw, data_in2);

--pxl_check : Pixel_Check port map(addr_V, data_where_V, addr3, data_in3, data_write3, clock, reset, addr, data_where, enable_movement);

pxl_demand : Pixel_Demand port map(DBL, DBR, DBU, DBD, clock, reset, position, addr_D, data_where_D, addr_V, data_where_V);

gene_maze : Generate_Maze port map(clock, reset,addr1,data_write1,data_in1); 

vga : vga_bitmap_640x480 generic map(bit_per_pixel => 3, grayscale => false) port map(clock,reset,VGA_hs,VGA_vs,VGA_red,VGA_green,VGA_blue,addr0,data_in0,data_write0,data_out);

ram : RAM_Maze port map(clock,reset,addr1, data_write1, data_in1, addr2, data_rw, data_in2, addr3, data_write3, data_in3, addr0, data_write0, data_in0);


end Behavioral;

