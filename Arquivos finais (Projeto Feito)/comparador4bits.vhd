library IEEE;
use IEEE.Std_Logic_1164.all;

entity comparador4bits is
port (X,Y: in std_logic_vector(3 downto 0);
      S: out std_logic);
end comparador4bits;

architecture circuito of comparador4bits is
begin

    S <= '1' when X(3 downto 0) = Y(3 downto 0) else
    '0';

end circuito;