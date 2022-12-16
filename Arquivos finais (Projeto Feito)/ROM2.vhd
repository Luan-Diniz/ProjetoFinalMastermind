library ieee;
use ieee.std_logic_1164.all;

entity ROM2 is port (

    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0));
    
end ROM2;

architecture Rom_Arch of ROM2 is
  
type memory is array (00 to 15) of std_logic_vector(15 downto 0);
constant my_Rom : memory := (

	00 => "0111010000110001",  -- 7431
	01 => "0000001100100101",  -- 0325
    02 => "0110011100110100",  -- 6734
	03 => "0011010001010010",  -- 3452
	04 => "0111000000010010",  -- 7012
	05 => "0110001101000101",  -- 6345
	06 => "0000011101100011",  -- 0763
	07 => "0100010100110010",  -- 4532
	08 => "0011010001110010",  -- 3472
	09 => "0001001001000011",  -- 1243
    10 => "0111000100100100",  -- 7124
	11 => "0000011001110011",  -- 0673
	12 => "0101010000000111",  -- 5407
	13 => "0101010000110001",  -- 5431
	14 => "0100010100110110",  -- 4536
	15 => "0000000100100101"); -- 0125
	 
	
begin
   process (address)
   begin
     case address is
       when "0000" => data <= my_rom(00);
       when "0001" => data <= my_rom(01);
       when "0010" => data <= my_rom(02);
       when "0011" => data <= my_rom(03);
       when "0100" => data <= my_rom(04);
       when "0101" => data <= my_rom(05);
       when "0110" => data <= my_rom(06);
       when "0111" => data <= my_rom(07);
       when "1000" => data <= my_rom(08);
       when "1001" => data <= my_rom(09);
	   when "1010" => data <= my_rom(10);
	   when "1011" => data <= my_rom(11);
       when "1100" => data <= my_rom(12);
	   when "1101" => data <= my_rom(13);
	   when "1110" => data <= my_rom(14);
	   when others => data <= my_rom(15);
     end case;
  end process;
end architecture Rom_Arch;