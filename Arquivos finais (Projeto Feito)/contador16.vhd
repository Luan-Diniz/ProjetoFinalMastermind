library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;

entity contador16 is port ( 
  CLK: in std_logic;
  rst,En: in std_logic;
  max: out std_logic;
  S: out std_logic_vector(3 downto 0));
end contador16;

architecture behv of contador16 is
  type CHANGED is (Yes,No);
  type PRIMEIRA is (eh, naoeh);
  signal cnt: std_logic_vector(3 downto 0) := "0000";
  signal mudou: CHANGED := No;
  signal rodada: PRIMEIRA := eh;
  signal maximo: std_logic := '0';
begin

  process(CLK,rst,En)
  begin
    if rst = '1' then
        cnt <= "0000";
        max <= '0';
        maximo <= '0';
        rodada <= eh;
        mudou <= no;
    elsif (En = '1') and (mudou = No) and (maximo = '0')  then
        if (CLK'event and CLK = '1') then 
            if rodada = eh then
                rodada <= naoeh;
                mudou <= Yes;
            else
              if (cnt = "1110") then
                max <= '1';
                maximo <= '1';
              else
                max <= '0';
              end if;
              cnt <= cnt + "0001";
              mudou <= Yes;
            end if;
        end if;
    
    elsif En = '0' then
        mudou <= No;
    end if;
  end process;

  S <= cnt;

end behv;