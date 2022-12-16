library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;

entity compP is
port (X: in std_logic_vector(2 downto 0);
      S: out std_logic);
end compP;

architecture circuito of compP is
begin
    S <= '1' when X = "100" else
         '0';

end circuito;