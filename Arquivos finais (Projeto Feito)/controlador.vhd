library ieee;
use ieee.std_logic_1164.all;

entity controlador is port (
    Enter, Reset: in std_logic;
    Clock500: in std_logic;
    end_game, end_time, end_round : in  std_logic;
    R1,R2,E1,E2,E3,E4,E5: out std_logic);
    
end controlador;

architecture controle of controlador is
type STATES is (Init, Setup, Play, Check, Result, Waitt);
type FIRST_ROUND is (First, NotFirst);

signal ESTADO: STATES := Init;
signal PEstado: STATES := Setup;
signal Round: FIRST_ROUND := First;

begin
    process(Clock500, Reset, Enter)
        begin
            if Reset = '1' then
                ESTADO <= Init;
                Round <= First;
                
            elsif (Clock500'event and Clock500 = '1') then
                if ESTADO = Init then
                    R1 <= '1';
                    R2 <= '1';
                    E1 <= '0';
                    E2 <= '0';
                    E3 <= '0';
                    E4 <= '0';
                    E5 <= '0';
                    
                    Round <= First;
                    ESTADO <= PEstado;
            
            
                elsif ESTADO = Setup then
                    R1 <= '0';
                    R2 <= '0';
                    E1 <= '1';
                    
                    if Enter = '1' then
                        ESTADO <= PEstado;
                    end if;
                
                
                elsif ESTADO = Play then
                    E1 <= '0';
                    E2 <= '1';
                    R1 <= '0';
                    E4 <= '0';
                    
                    if Round = First then
                        E3 <= '1';
                        Round <= NotFirst;
                    elsif Round = NotFirst then
                        E3 <= '0';
                    end if;
                    
                    if end_time = '1' then
                        ESTADO <= Result;
                
                    elsif Enter = '1' and end_time = '0' then
                        ESTADO <= PEstado;
                    end if;
               
               
                elsif ESTADO = Check then
                    E2 <= '0';
                    E3 <= '0';
                    
                    if (end_game = '1') or (end_round = '1') then
                        ESTADO <= Result;
                    elsif not (end_game = '1' or end_round = '1') then
                        ESTADO <= PEstado;
                    end if;
                    
                
                elsif ESTADO = Waitt then
                    R1 <= '1';
                    E4 <= '1';
                    E3 <= '1';
                    
                    if Enter = '1' then
                        ESTADO <= PEstado;
                    end if;
               
                
                elsif ESTADO = Result then
                    E2 <= '0';
                    E3 <= '0';
                    E5 <= '1';
                    
                    if Enter = '1' then
                        ESTADO <= PEstado;
                    end if;
                
                
                end if;        
            end if;
                
    
    end process;

    
    
    process(ESTADO)
        begin
            case ESTADO is
                when Init => PEstado <= Setup;
                
                when Setup => PEstado <= Play;
                
                when Play => PEstado <= Check;
                
                when Check => PEstado <= Waitt;
                
                when Waitt => PEstado <= Play;
            
                when Result => PEstado <= Init;
                
            end case;
        
    end process;
    
    

   
end architecture controle;