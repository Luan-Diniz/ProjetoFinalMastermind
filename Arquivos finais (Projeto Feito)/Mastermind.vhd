library IEEE;
use IEEE.Std_Logic_1164.all;

entity Mastermind is
port (SW:  in std_logic_vector(15 downto 0);
      CLK_500Hz, CLK_1Hz: in std_logic;
      KEY: in std_logic_vector (1 downto 0);
      HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0 :  out std_logic_vector(6 downto 0);
      LEDR: out std_logic_vector(15 downto 0));
end Mastermind;

architecture circuito of Mastermind is
    signal enter_s, reset_s, end_gamee, end_timee, end_roundd: std_logic;
    signal R1_s,R2_s,E1_s,E2_s,E3_s,E4_s,E5_s: std_logic;

    component Datapath is port (Switches : in  std_logic_vector(15 downto 0);
                                Clock1, Clock500             : in  std_logic;
                                R1, R2                       : in  std_logic;
                                E1, E2, E3, E4, E5           : in  std_logic;
                                ledr                         : out std_logic_vector(15 downto 0);
                                hex0, hex1, hex2, hex3       : out std_logic_vector(6 downto 0);
                                hex4, hex5, hex6, hex7       : out std_logic_vector(6 downto 0);
                                end_game, end_time, end_round: out std_logic );
    end component;                                
    
    
    component controlador is port (Enter, Reset: in std_logic;
                                Clock500: in std_logic;
                                end_game, end_time, end_round : in  std_logic;
                                R1,R2,E1,E2,E3,E4,E5: out std_logic);
    end component;
 
    
    component ButtonSync is port(KEY0, KEY1, CLK: in  std_logic;
                            Enter, Reset   : out std_logic);
    end component;
    


begin

    SINCRONIZADOR: ButtonSync port map(KEY0 => KEY(0),
                                    KEY1 => KEY(1),
                                    CLK => CLK_500Hz,
                                    Enter => enter_s,
                                    Reset =>  reset_s); 
                                    




    CONTROLE: controlador port map (Enter => enter_s,
                                    Reset => reset_s,
                                    Clock500 => CLK_500Hz,
                                    end_game => end_gamee,
                                    end_time => end_timee,
                                    end_round => end_roundd,
                                    R1 => R1_s,
                                    R2 => R2_s,
                                    E1 => E1_s,
                                    E2 => E2_s,
                                    E3 => E3_s,
                                    E4 => E4_s,
                                    E5 => E5_s);



    DATAPATH0: Datapath port map (Switches(15 downto 0) => SW(15 downto 0),
                                Clock1 => CLK_1Hz,
                                Clock500  => CLK_500Hz,
                                R1      => R1_s,
                                R2      => R2_s,
                                E1      => E1_s,
                                E2      => E2_s,
                                E3      => E3_s,
                                E4      => E4_s,
                                E5      => E5_s,
                                ledr(15 downto 0) => LEDR(15 downto 0),
                                hex0(6 downto 0) => HEX0(6 downto 0),
                                hex1(6 downto 0) => HEX1(6 downto 0),
                                hex2(6 downto 0) => HEX2(6 downto 0),
                                hex3(6 downto 0) => HEX3(6 downto 0),
                                hex4(6 downto 0) => HEX4(6 downto 0),
                                hex5(6 downto 0) => HEX5(6 downto 0),
                                hex6(6 downto 0) => HEX6(6 downto 0),
                                hex7(6 downto 0) => HEX7(6 downto 0),
                                end_game      => end_gamee,
                                end_time      => end_timee,
                                end_round      =>  end_roundd);
    
    
end circuito;