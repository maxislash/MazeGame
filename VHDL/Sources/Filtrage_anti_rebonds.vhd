----------------------------------------------------------------------------------
-- FERAULT Aurélie
-- MARECHAL Chloé
--
-- Filtre antirebonds de la commande rotative de LED
-- 
-- Date:    09/20/2011 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Filtrage_anti_rebonds is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           ligne_bouton : in  STD_LOGIC_VECTOR (1 downto 0);
           rotation : out  STD_LOGIC_VECTOR (1 downto 0));
end Filtrage_anti_rebonds;

architecture Behavioral of Filtrage_anti_rebonds is
Signal val_rot : STD_LOGIC_VECTOR (1 downto 0);
begin

filtre:process(clk, ligne_bouton, val_rot)
	begin
		if clk'event and clk='1' then
			if reset='1' then val_rot <= "00";
			else
				case ligne_bouton is
					when "00" =>	 val_rot(1) <= val_rot(1);
										val_rot(0) <= '0';
					when "01" => 	val_rot(1) <= '0';
										val_rot(0) <= val_rot(0);
					when "10" => 	val_rot(1) <= '1';
										val_rot(0) <= val_rot(0);
					when "11" => 	val_rot(1) <= val_rot(1);
										val_rot(0) <= '1';
					when others => NULL;
					
				end case;
			end if;
		end if;
	rotation <= val_rot;
end Process filtre;
		
end Behavioral;

