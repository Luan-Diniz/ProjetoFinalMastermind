library IEEE;
use IEEE.Std_Logic_1164.all;

entity mult2x1 is
port (A:  in std_logic_vector(6 downto 0);
      B:  in std_logic_vector(6 downto 0) ;
      Sel: in std_logic;
      S: out std_logic_vector(6 downto 0));
end mult2x1;

architecture multiplexador of mult2x1 is
begin 

    S <= A when Sel = '0' else
         B when Sel = '1';


  
end multiplexador;