library IEEE;
use IEEE.Std_Logic_1164.all;

entity registrador3bits is
port (D: in std_logic_vector(2 downto 0);
      clk: in std_logic;
      rst: in std_logic;
      En: in std_logic;
      K: out std_logic_vector(2 downto 0));
end registrador3bits;

architecture circuito of registrador3bits is
    signal Q: std_logic_vector(2 downto 0);

begin

    K(2 downto 0) <= Q(2 downto 0);

 process(clk,rst)
    begin
        if rst = '1' then
            Q <= "000";
        elsif (clk'event and clk = '1') then    
            if  En = '1' then
                Q <= D;
            end if;
        end if;
    end process;

end circuito;