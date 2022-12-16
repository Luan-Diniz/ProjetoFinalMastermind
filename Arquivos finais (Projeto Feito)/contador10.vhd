library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;

entity contador10 is port ( 
  CLK: in std_logic;
  rst,En: in std_logic;
  max: out std_logic;
  S: out std_logic_vector(3 downto 0));
end contador10;

architecture behv of contador10 is
  signal cnt: std_logic_vector(3 downto 0) := "0000";
begin

  process(CLK,rst)
  begin
    if rst = '1' then
        cnt <= "0000";
        max <= '0';
    elsif En = '1' then
        if (CLK'event and CLK = '1') then 
            if(cnt = "1001") then
                max <= '1';
            else
              cnt <= cnt + "0001";
              max <= '0';
            end if;
        end if;
    end if;
  end process;

  S <= cnt;

end behv;