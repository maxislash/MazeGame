--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:46:11 01/08/2016
-- Design Name:   
-- Module Name:   C:/Users/Wilfried/Desktop/Projets/MazeGame/NewMazeGame/MazeGame/Maze_Movement_Display/test_debounce.vhd
-- Project Name:  Maze_Movement_Display
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Debounce
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
 
ENTITY test_debounce IS
END test_debounce;
 
ARCHITECTURE behavior OF test_debounce IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Debounce
    PORT(
         clock : IN  std_logic;
         button : IN  std_logic;
         result : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal button : std_logic := '0';

 	--Outputs
   signal result : std_logic;

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Debounce PORT MAP (
          clock => clock,
          button => button,
          result => result
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
		button <= '1';
		
		wait for 1ps;
		
		button <= '0';
		
		wait for 2ms;
		
		button <= '1';
		
		wait for 500000ns;
		
		button <= '0';
		
		wait for 500000ns;
		
		button <= '1';
		
			
		wait for 10 ns;
		
		button <= '0';
		
		wait for 10 ns;
		
		button <= '1';
		
		wait for 15 ms;
      wait;
   end process;

END;
