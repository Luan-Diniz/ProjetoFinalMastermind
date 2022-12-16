library IEEE;
use IEEE.Std_Logic_1164.all;

entity mult4x1_7bits is
port (A,B,C,D:  in std_logic_vector(6 downto 0);
      Sel: in std_logic_vector(1 downto 0);
      S: out std_logic_vector(6 downto 0));
end mult4x1_7bits;

architecture multiplexador of mult4x1_7bits is
begin 

    S <= A when Sel = "00" else
         B when Sel = "01" else
         C when Sel = "10" else
         D;

end multiplexador;