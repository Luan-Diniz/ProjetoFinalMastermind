library IEEE;
use IEEE.Std_Logic_1164.all;

entity roundtoled is
port (round:  in std_logic_vector(3 downto 0);
      LED:  out std_logic_vector(15 downto 0)
     );
end roundtoled;

architecture mydecod of roundtoled is
begin 
  LED      <=  "0000000000000001" when round = "0000" else
               "0000000000000011" when round = "0001" else
               "0000000000000111" when round = "0010" else
               "0000000000001111" when round = "0011" else
               "0000000000011111" when round = "0100" else
               "0000000000111111" when round = "0101" else
               "0000000001111111" when round = "0110" else
               "0000000011111111" when round = "0111" else
               "0000000111111111" when round = "1000" else
               "0000001111111111" when round = "1001" else
               "0000011111111111" when round = "1010" else
               "0000111111111111" when round = "1011" else
               "0001111111111111" when round = "1100" else
               "0011111111111111" when round = "1101" else
               "0111111111111111" when round = "1110" else
               "1111111111111111" when round = "1111" else 
               "0000000000000000";
end mydecod;
