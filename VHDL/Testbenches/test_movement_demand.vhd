--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:42:05 12/13/2015
-- Design Name:   
-- Module Name:   C:/Users/Wilfried/Desktop/Projets/MazeGame/NewMazeGame/MazeGame/Maze_Movement_Display/test_movement_demand.vhd
-- Project Name:  Maze_Movement_Display
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Movement_Demand
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
 
ENTITY test_movement_demand IS
END test_movement_demand;
 
ARCHITECTURE behavior OF test_movement_demand IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Movement_Demand
    PORT(
         addr_D : IN  std_logic_vector(18 downto 0);
         data_where_D : IN  std_logic_vector(1 downto 0);
         addr : IN  std_logic_vector(18 downto 0);
         data_where : IN  std_logic_vector(1 downto 0);
         enable_movement : IN  std_logic;
         clock : IN  std_logic;
         reset : IN  std_logic;
         position : OUT  std_logic_vector(18 downto 0);
         addr2 : OUT  std_logic_vector(18 downto 0);
         data_rw : OUT  std_logic_vector(1 downto 0);
         data_in2 : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal addr_D : std_logic_vector(18 downto 0) := (others => '0');
   signal data_where_D : std_logic_vector(1 downto 0) := (others => '0');
   signal addr : std_logic_vector(18 downto 0) := (others => '0');
   signal data_where : std_logic_vector(1 downto 0) := (others => '0');
   signal enable_movement : std_logic := '0';
   signal clock : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal position : std_logic_vector(18 downto 0);
   signal addr2 : std_logic_vector(18 downto 0);
   signal data_rw : std_logic_vector(1 downto 0);
   signal data_in2 : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Movement_Demand PORT MAP (
          addr_D => addr_D,
          data_where_D => data_where_D,
          addr => addr,
          data_where => data_where,
          enable_movement => enable_movement,
          clock => clock,
          reset => reset,
          position => position,
          addr2 => addr2,
          data_rw => data_rw,
          data_in2 => data_in2
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
		addr_D <= "0000000000000011111";
		data_where_D <= "01";
		
		addr <= "0000110010100101111";
		data_where <= "01";
		
		reset <= '0';
		
      wait for 100 ns;	

      wait for clock_period*10;
		
		reset <= '1';

      -- insert stimulus here 
		

		
		enable_movement <= '0';
		
		wait for 1 ms;
		
		enable_movement <= '1';
		
		wait for 20ms;
		
		enable_movement <= '0';
		

      wait;
   end process;

END;
