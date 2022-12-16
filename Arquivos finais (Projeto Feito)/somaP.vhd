library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;

entity somaP is
port (X,Y,W,Z: in std_logic;
      S: out std_logic_vector(2 downto 0));
end somaP;

architecture circuito of somaP is
signal soma: std_logic_vector(2 downto 0);
signal cX,cY,cW,cZ: std_logic_vector(2 downto 0);
begin
    cX <= ("00" & X);
    cY <= ("00" & Y);
    cW <= ("00" & W);
    cZ <= ("00" & Z);
    soma <= cX + cY + cW + cZ;
    
    S <= soma;

end circuito;