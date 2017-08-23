--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:49:07 12/15/2015
-- Design Name:   
-- Module Name:   C:/Users/Wilfried/Desktop/Projets/MazeGame/NewMazeGame/MazeGame/Maze_Movement_Display/test_pixel_demand.vhd
-- Project Name:  Maze_Movement_Display
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Pixel_Demand
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_pixel_demand IS
END test_pixel_demand;
 
ARCHITECTURE behavior OF test_pixel_demand IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Pixel_Demand
    PORT(
         DBL : IN  std_logic;
         DBR : IN  std_logic;
         DBU : IN  std_logic;
         DBD : IN  std_logic;
         clock : IN  std_logic;
         reset : IN  std_logic;
         position : IN  std_logic_vector(18 downto 0);
         addr_D : OUT  std_logic_vector(18 downto 0);
         data_where_D : OUT  std_logic_vector(1 downto 0);
         addr_V : OUT  std_logic_vector(18 downto 0);
         data_where_V : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal DBL : std_logic := '0';
   signal DBR : std_logic := '0';
   signal DBU : std_logic := '0';
   signal DBD : std_logic := '0';
   signal clock : std_logic := '0';
   signal reset : std_logic := '0';
   signal position : std_logic_vector(18 downto 0) := (others => '0');

 	--Outputs
   signal addr_D : std_logic_vector(18 downto 0);
   signal data_where_D : std_logic_vector(1 downto 0);
   signal addr_V : std_logic_vector(18 downto 0);
   signal data_where_V : std_logic_vector(1 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Pixel_Demand PORT MAP (
          DBL => DBL,
          DBR => DBR,
          DBU => DBU,
          DBD => DBD,
          clock => clock,
          reset => reset,
          position => position,
          addr_D => addr_D,
          data_where_D => data_where_D,
          addr_V => addr_V,
          data_where_V => data_where_V
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		
		reset <= '0';
		
      wait for 100 ns;	
		reset <= '1';
		
		position <= "0000110010100101100";

      wait for clock_period*10;

      DBL <= '1';
		
		wait for 200ns;
		
		DBU <= '1';
		
		wait for 1ms;
		
	
		
		

      wait;
   end process;

END;
