--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:57:42 01/07/2016
-- Design Name:   
-- Module Name:   C:/Users/Wilfried/Desktop/Projets/MazeGame/NewMazeGame/MazeGame/Maze_Movement_Display/test_movement_management.vhd
-- Project Name:  Maze_Movement_Display
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Movement_Management
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
 
ENTITY test_movement_management IS
END test_movement_management;
 
ARCHITECTURE behavior OF test_movement_management IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Movement_Management
    PORT(
         clock : IN  std_logic;
         reset : IN  std_logic;
         btnU : IN  std_logic;
         btnD : IN  std_logic;
         btnL : IN  std_logic;
         btnR : IN  std_logic;
         VGA_hs : OUT  std_logic;
         VGA_vs : OUT  std_logic;
         VGA_red : OUT  std_logic_vector(3 downto 0);
         VGA_green : OUT  std_logic_vector(3 downto 0);
         VGA_blue : OUT  std_logic_vector(3 downto 0);
         data_out : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal reset : std_logic := '0';
   signal btnU : std_logic := '0';
   signal btnD : std_logic := '0';
   signal btnL : std_logic := '0';
   signal btnR : std_logic := '0';

 	--Outputs
   signal VGA_hs : std_logic;
   signal VGA_vs : std_logic;
   signal VGA_red : std_logic_vector(3 downto 0);
   signal VGA_green : std_logic_vector(3 downto 0);
   signal VGA_blue : std_logic_vector(3 downto 0);
   signal data_out : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Movement_Management PORT MAP (
          clock => clock,
          reset => reset,
          btnU => btnU,
          btnD => btnD,
          btnL => btnL,
          btnR => btnR,
          VGA_hs => VGA_hs,
          VGA_vs => VGA_vs,
          VGA_red => VGA_red,
          VGA_green => VGA_green,
          VGA_blue => VGA_blue,
          data_out => data_out
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
      wait for 100 ns;	

      wait for clock_period*10;

		btnU <= '1';
		
		wait for 1 ps;
		
		btnU <= '0';
		
		wait for 2 ps;
		
		btnU <= '1';
		
		wait for 3 ps;
		
		btnU <= '0';
		
		wait for 5 ps;
		
		btnU <= '1';
		
			
		wait for 10 ns;
		
		btnU <= '0';
		
		wait for 10 ns;
		
		btnU <= '1';
		
		wait for 15 ms;

      wait;
   end process;

END;
