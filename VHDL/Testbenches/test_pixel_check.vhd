--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:18:16 12/15/2015
-- Design Name:   
-- Module Name:   C:/Users/Wilfried/Desktop/Projets/MazeGame/NewMazeGame/MazeGame/Maze_Movement_Display/test_pixel_check.vhd
-- Project Name:  Maze_Movement_Display
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Pixel_Check
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
 
ENTITY test_pixel_check IS
END test_pixel_check;
 
ARCHITECTURE behavior OF test_pixel_check IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Pixel_Check
    PORT(
         addr_V : IN  std_logic_vector(18 downto 0);
         data_where_V : IN  std_logic_vector(1 downto 0);
         addr3 : IN  std_logic_vector(18 downto 0);
         data_in3 : IN  std_logic_vector(2 downto 0);
         data_write3 : IN  std_logic;
         clock : IN  std_logic;
         reset : IN  std_logic;
         addr : OUT  std_logic_vector(18 downto 0);
         data_where : OUT  std_logic_vector(1 downto 0);
         enable_movement : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal addr_V : std_logic_vector(18 downto 0) := (others => '0');
   signal data_where_V : std_logic_vector(1 downto 0) := (others => '0');
   signal addr3 : std_logic_vector(18 downto 0) := (others => '0');
   signal data_in3 : std_logic_vector(2 downto 0) := (others => '0');
   signal data_write3 : std_logic := '0';
   signal clock : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal addr : std_logic_vector(18 downto 0);
   signal data_where : std_logic_vector(1 downto 0);
   signal enable_movement : std_logic;

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Pixel_Check PORT MAP (
          addr_V => addr_V,
          data_where_V => data_where_V,
          addr3 => addr3,
          data_in3 => data_in3,
          data_write3 => data_write3,
          clock => clock,
          reset => reset,
          addr => addr,
          data_where => data_where,
          enable_movement => enable_movement
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
      reset <= '0';
		
      wait for 100 ns;	
			
		reset <= '1';
			
      wait for clock_period*10;
		
		addr_V <= "0000101000100100100";
      data_where_V <= "01";
		
		wait for 10 ns;
		
		wait for clock_period/2;
      
		
		addr3 <= "0000101000100100100";
      data_in3 <= "111";
      data_write3 <= '1';
		
		wait for clock_period;
		
		addr3 <= "0000101000100100101";
      data_in3 <= "111";
      data_write3 <= '1';
		
		wait for clock_period;
		
		addr3 <= "0000101000100100110";
      data_in3 <= "111";
      data_write3 <= '1';
		
		
		wait for clock_period;
		
		addr3 <= "0000101000100100111";
      data_in3 <= "111";
      data_write3 <= '1';

		
		wait for clock_period;
		
		addr3 <= "0000101000100101000";
      data_in3 <= "111";
      data_write3 <= '1';
		
		wait for clock_period;
		
		addr3 <= "0000101000100101001";
      data_in3 <= "111";
      data_write3 <= '1';
		
		wait for clock_period;
		
		addr3 <= "0000101000100101010";
      data_in3 <= "111";
      data_write3 <= '1';
		
		wait for clock_period;
		
		addr3 <= "0000101000100101011";
      data_in3 <= "111";
      data_write3 <= '1';
		
		wait for clock_period;
		
		addr3 <= "0000101000100101100";
      data_in3 <= "111";
      data_write3 <= '1';
		
		wait for clock_period;
		
		addr3 <= "0000101000100101101";
      data_in3 <= "111";
      data_write3 <= '1';
		
		wait for clock_period;
		
		addr3 <= "0000101000100101110";
      data_in3 <= "111";
      data_write3 <= '1';
		
		wait for clock_period;
		
		addr3 <= "0000101000100101111";
      data_in3 <= "111";
      data_write3 <= '1';
		
		wait for clock_period;
		
		addr3 <= "0000101000100110000";
      data_in3 <= "111";
      data_write3 <= '1';
		
		wait for clock_period;
		
		addr3 <= "0000101000100110001";
      data_in3 <= "111";
      data_write3 <= '1';
		
		wait for clock_period;
		
		addr3 <= "0000101000100110010";
      data_in3 <= "111";
      data_write3 <= '1';
		


      wait;
   end process;

END;
