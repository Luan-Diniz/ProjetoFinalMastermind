library ieee;
use ieee.std_logic_1164.all;

entity ROM1 is port (

    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0));
    
end ROM1;

architecture Rom_Arch of ROM1 is

type memory is array (00 to 15) of std_logic_vector(15 downto 0);
constant my_Rom : memory := (

	00 => "0101010000100001",  -- 5421
	01 => "0011010000000001",  -- 3401
    02 => "0001001100100100",  -- 1324
	03 => "0000010100100001",  -- 0521
	04 => "0010000001000011",  -- 2043
	05 => "0000001000010101",  -- 0215
	06 => "0100010100010011",  -- 4513
	07 => "0011001000010100",  -- 3214
	08 => "0101001000110000",  -- 5230
	09 => "0011000101010100",  -- 3154
    10 => "0101010000110010",  -- 5432
	11 => "0100001100100001",  -- 4321
	12 => "0011010100000001",  -- 3501
	13 => "0100001000010000",  -- 4210
	14 => "0101001000110001",  -- 5231
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