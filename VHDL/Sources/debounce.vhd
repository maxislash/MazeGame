----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:10:12 11/28/2015 
-- Design Name: 
-- Module Name:    debounce - Behavioral 
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

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Debounce is
  generic(
    counter_size  :  integer := 19); --counter size (19 bits gives 10.5ms with our 50MHz clock)
  port(
    clock     : in  std_logic;  --input clock
    button  : in  std_logic;  --input signal to be debounced
    result  : out std_logic); --debounced signal
end debounce;

architecture Behavioral of Debounce is
  signal flipflops   : std_logic_vector(1 downto 0); --input flip flops
  signal counter_set : STD_LOGIC;                    --sync reset to zero
  signal counter_out : STD_LOGIC_VECTOR(counter_size downto 0) := (others => '0'); --counter output
begin

  counter_set <= flipflops(0) xor flipflops(1);   --determine when to start/reset counter
  
 process(clock)
  begin
    if(clock'event and clock = '1') then
		result <='0';
      flipflops(0) <= button;
      flipflops(1) <= flipflops(0);
		
      if(counter_set = '1') then		--reset counter because input is changing
        counter_out <= (others => '0');
      elsif(counter_out(counter_size) = '0') then --stable input time is not yet met
        counter_out <= counter_out + 1;
      else                                        --stable input time is met
        result <= flipflops(1);
      end if;    
    end if;
	 
	 
  end process;
  
end Behavioral;
