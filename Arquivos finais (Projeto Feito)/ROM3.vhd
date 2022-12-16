library ieee;
use ieee.std_logic_1164.all;

entity ROM3 is port (

    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0));
    
end ROM3;

architecture Rom_Arch of ROM3 is
  
type memory is array (00 to 15) of std_logic_vector(15 downto 0);
constant my_Rom : memory := (

	00 => "1000001101000111",  --8347
	01 => "0010001101000101",  --2345
    02 => "1001100001000101",  --9845
	03 => "0000000110010010",  --0192
	04 => "1001001100101000",  --9328
	05 => "0110010110000011",  --6583
	06 => "0111010001010011",  --7453
	07 => "0010001110000100",  --2384
	08 => "0001000000101001",  --1029
	09 => "0011100001110000",  --3870
    10 => "0110001110000010",  --6382
	11 => "1000000110010010",  --8192
	12 => "0000100110000001",  --0981
	13 => "1001100001110001",  --9871
	14 => "0111001101100010",  --7362
	15 => "0101011000100001"); --5621
	 
	
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