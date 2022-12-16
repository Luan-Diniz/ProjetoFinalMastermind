library ieee;
use ieee.std_Logic_1164.all;

entity datapath is port( 
    
    Switches                     : in  std_logic_vector(15 downto 0);
    Clock1, Clock500             : in  std_logic;
    R1, R2                       : in  std_logic;
    E1, E2, E3, E4, E5           : in  std_logic;
    ledr                         : out std_logic_vector(15 downto 0);
    hex0, hex1, hex2, hex3       : out std_logic_vector(6 downto 0);
    hex4, hex5, hex6, hex7       : out std_logic_vector(6 downto 0);
    end_game, end_time, end_round: out std_logic);
    
end datapath;


architecture arc_data of datapath is

signal code, user, s_dec_term, rom0_s, rom1_s, rom2_s, rom3_s: std_logic_vector(15 downto 0); 
signal result: std_logic_vector(7 downto 0);
signal h0_00, h0_01, h0_10, h0_11, h1_01, h1_11, h2_00, h2_01, h2_10, h2_11, h3_01, h3_11, h4_1, h6_1, h7_1: std_logic_vector(6 downto 0);
signal sel: std_logic_vector(5 downto 0);
signal time_c, X, s_soma, F, P_reg_s, E_reg_s, sel_s: std_Logic_vector(3 downto 0);
signal P, P_reg, E, E_reg: std_logic_vector(2 downto 0);
signal sel_mux: std_logic_vector(1 downto 0);
signal end_gamee, end_timee, end_roundd, cmp0_s, cmp1_s, cmp2_s, cmp3_s: std_logic;

component bcd7seg is
    port (bcd_in:  in std_logic_vector(3 downto 0);
      out_7seg:  out std_logic_vector(6 downto 0) );
end component;

component mult2x1 is
    port (A:  in std_logic_vector(6 downto 0);
      B:  in std_logic_vector(6 downto 0) ;
      Sel: in std_logic;
      S: out std_logic_vector(6 downto 0));
end component;

component mult4x1_7bits is
    port (A,B,C,D:  in std_logic_vector(6 downto 0);
      Sel: in std_logic_vector(1 downto 0);
      S: out std_logic_vector(6 downto 0));
end component;

component mult4x1_16bits is
    port (A,B,C,D:  in std_logic_vector(15 downto 0);
      Sel: in std_logic_vector(1 downto 0);
      S: out std_logic_vector(15 downto 0));
end component;

component somador is
    port (A,B: in std_logic_vector(3 downto 0);
      S: out std_logic_vector(3 downto 0) );
end component;

component registrador3bits is
    port (D: in std_logic_vector(2 downto 0);
      clk: in std_logic;
      rst: in std_logic;
      En: in std_logic;
      K: out std_logic_vector(2 downto 0));
end component;

component registrador6bits is
    port (D: in std_logic_vector(5 downto 0);
      clk: in std_logic;
      rst: in std_logic;
      En: in std_logic;
      K: out std_logic_vector(5 downto 0));
end component;

component registrador16bits is
    port (D: in std_logic_vector(15 downto 0);
      clk: in std_logic;
      rst: in std_logic;
      En: in std_logic;
      K: out std_logic_vector(15 downto 0));
end component;

component contador10 is
    port (CLK: in std_logic;
      rst,En: in std_logic;
      max: out std_logic;
      S: out std_logic_vector(3 downto 0));
end component;

component contador16 is
    port (CLK: in std_logic;
  rst,En: in std_logic;
  max: out std_logic;
  S: out std_logic_vector(3 downto 0));
end component;

component comparador4bits is
    port (X,Y: in std_logic_vector(3 downto 0);
      S: out std_logic);
end component;

component somaP is
    port (X,Y,W,Z: in std_logic;
      S: out std_logic_vector(2 downto 0));
end component;

component compP is
    port (X: in std_logic_vector(2 downto 0);
      S: out std_logic);
end component;

component roundtoled is
    port (round:  in std_logic_vector(3 downto 0);
      LED:  out std_logic_vector(15 downto 0));
end component;

component comp_e is
    port(inc, inu: in  std_logic_vector(15 downto 0);
        E : out std_logic_vector(2 downto 0));
end component;

component ROM0 is
    port (address : in  std_logic_vector(3 downto 0);
      data: out std_logic_vector(15 downto 0));
end component;

component ROM1 is
    port(address : in  std_logic_vector(3 downto 0);
       data: out std_logic_vector(15 downto 0));
end component;

component ROM2 is
    port (address : in  std_logic_vector(3 downto 0);
      data: out std_logic_vector(15 downto 0));
end component;

component ROM3 is
    port (address : in  std_logic_vector(3 downto 0);
      data: out std_logic_vector(15 downto 0));
end component;

component Selector is
    port(in0, in1, in2, in3: in  std_logic;
      saida : out std_logic_vector(1 downto 0));
end component;
    
begin

end_game <= end_gamee; --ao interligar a saida do comp=4, usar o signal end_gamee para evitar erros
end_time <= end_timee; --ao interligar a saida do counter_time, usar o signal end_timee para evitar erros
end_round <= end_roundd;


REGISTRADOR_6BITS: registrador6bits port map (D(5 downto 0) => Switches(5 downto 0),
                                              clk => Clock500,
                                              rst => R2,
                                              En => E1,
                                              K(5 downto 0) => sel(5 downto 0));


REGISTRADOR_16BITS: registrador16bits port map (D(15 downto 0) => Switches(15 downto 0),
                                              clk => Clock500,
                                              rst => R2,
                                              En => E2,
                                              K(15 downto 0) => user(15 downto 0));
                                              

ROM_0: ROM0 port map (address(3 downto 0) => sel(5 downto 2),
                    data(15 downto 0) => rom0_s(15 downto 0));
ROM_1: ROM1 port map (address(3 downto 0) => sel(5 downto 2),
                    data(15 downto 0) => rom1_s(15 downto 0));
ROM_2: ROM2 port map (address(3 downto 0) => sel(5 downto 2),
                    data(15 downto 0) => rom2_s(15 downto 0));
ROM_3: ROM3 port map (address(3 downto 0) => sel(5 downto 2),
                    data(15 downto 0) => rom3_s(15 downto 0));

MUX_16BITS: mult4x1_16bits port map (A(15 downto 0) => rom0_s(15 downto 0),
                                      B(15 downto 0) => rom1_s(15 downto 0),
                                      C(15 downto 0) => rom2_s(15 downto 0),
                                      D(15 downto 0) => rom3_s(15 downto 0),
                                      Sel(1 downto 0) => sel(1 downto 0),
                                      S(15 downto 0) => code(15 downto 0));
                                      
                                      
COMPE: comp_e port map (inc(15 downto 0) => code(15 downto 0),
                    inu(15 downto 0) => user(15 downto 0),
                    E(2 downto 0) => E(2 downto 0));

COMP0: comparador4bits port map (X(3 downto 0) => code(3 downto 0),
                            Y(3 downto 0) => user(3 downto 0),
                            S => cmp0_s);

COMP1: comparador4bits port map (X(3 downto 0) => code(7 downto 4),
                            Y(3 downto 0) => user(7 downto 4),
                            S => cmp1_s);

COMP2: comparador4bits port map (X(3 downto 0) => code(11 downto 8) ,
                            Y(3 downto 0) => user(11 downto 8),
                            S => cmp2_s);

COMP3: comparador4bits port map (X(3 downto 0) => code(15 downto 12) ,
                            Y(3 downto 0) => user(15 downto 12),
                            S => cmp3_s);

SOMA_P: somaP port map(X => cmp0_s,
                      Y => cmp1_s,
                      W => cmp2_s,
                      Z => cmp3_s,
                      S(2 downto 0) => P(2 downto 0));
                      

SELECTOR_MUX: Selector port map(in0 => E1,
                                in1 => E2,
                                in2 => R1,
                                in3 => E5,
                                saida(1 downto 0) => sel_mux(1 downto 0));
                                

COMP_P: compP port map(X(2 downto 0) => P(2 downto 0),
                     S => end_gamee);


REGISTRADOR_3BITS_P: registrador3bits port map (D(2 downto 0) => P(2 downto 0),
                                                  clk => Clock500,
                                                  rst => R2,
                                                  En => E4,
                                                  K(2 downto 0) => P_reg(2 downto 0));

REGISTRADOR_3BITS_E: registrador3bits port map (D(2 downto 0) => E(2 downto 0),
                                                  clk => Clock500,
                                                  rst => R2,
                                                  En => E4,
                                                  K(2 downto 0) => E_reg(2 downto 0)); 
                                                  
        
CONTADOR_TEMPO: contador10 port map(CLK => Clock1,
                                  rst => R1,
                                  En => E2,
                                  max => end_timee,
                                  S(3 downto 0) => time_c(3 downto 0));

CONTADOR_ROUNDS: contador16 port map(CLK => Clock500,
                                  rst => R2,
                                  En => E3,
                                  max => end_roundd,
                                  S(3 downto 0) => X(3 downto 0));
                                  
DECODER_TERMOMETRICO: roundtoled port map(round(3 downto 0) => X(3 downto 0),
                                        LED(15 downto 0) => s_dec_term(15 downto 0));

--ledr <= s_dec_term when E1 = '0' else
          --"0000000000000000";

ledr(0) <= s_dec_term(0) and (not E1);
ledr(1) <= s_dec_term(1) and (not E1);
ledr(2) <= s_dec_term(2) and (not E1);
ledr(3) <= s_dec_term(3) and (not E1);
ledr(4) <= s_dec_term(4) and (not E1);
ledr(5) <= s_dec_term(5) and (not E1);
ledr(6) <= s_dec_term(6) and (not E1);
ledr(7) <= s_dec_term(7) and (not E1);
ledr(8) <= s_dec_term(8) and (not E1);
ledr(9) <= s_dec_term(9) and (not E1);
ledr(10) <= s_dec_term(10) and (not E1);
ledr(11) <= s_dec_term(11) and (not E1);
ledr(12) <= s_dec_term(12) and (not E1);
ledr(13) <= s_dec_term(13) and (not E1);
ledr(14) <= s_dec_term(14) and (not E1);
ledr(15) <= s_dec_term(15) and (not E1);

SOMA: somador port map(A(3 downto 0) => X(3 downto 0),
                    B(3 downto 0) => "0000",
                    S(3 downto 0) => s_soma(3 downto 0));

--Exemplo em decimal: se fiz 4 rounds, o circuito precisa adicionar o complemento de 4 na 16. Por isso eh feito o complemento de 2 de X(3 downto 0)
F(3) <= (not s_soma(3)) and (not end_timee);
F(2) <= (not s_soma(2)) and (not end_timee);
F(1) <= (not s_soma(1)) and (not end_timee);
F(0) <= (not s_soma(0)) and (not end_timee);

result(7 downto 0) <= "000" & end_gamee & F(3 downto 0); 

--hex7
DECODIFICADOR1: bcd7seg port map (bcd_in(3 downto 0) => result(7 downto 4),
                                out_7seg(6 downto 0) => h7_1(6 downto 0)); 

MUX_2X1_1: mult2x1 port map(A(6 downto 0) => "1111111" ,
                              B(6 downto 0)  => h7_1(6 downto 0),
                              Sel => E5,
                              S(6 downto 0) => hex7(6 downto 0));

--hex6
DECODIFICADOR2: bcd7seg port map (bcd_in(3 downto 0) => result(3 downto 0),
                                out_7seg(6 downto 0) => h6_1(6 downto 0));

MUX_2X1_2: mult2x1 port map(A(6 downto 0) => "1111111" ,
                              B(6 downto 0)  => h6_1(6 downto 0),
                              Sel => E5,
                              S(6 downto 0) => hex6(6 downto 0));
                            
--hex5                              
MUX_2X1_3: mult2x1 port map(A(6 downto 0) => "1111111" ,
                              B(6 downto 0)  => "0000111",
                              Sel => E2,
                              S(6 downto 0) => hex5(6 downto 0));


--hex4
DECODIFICADOR3: bcd7seg port map (bcd_in(3 downto 0) => time_c(3 downto 0),
                                out_7seg(6 downto 0) => h4_1(6 downto 0));


MUX_2X1_4: mult2x1 port map(A(6 downto 0) => "1111111" ,
                              B(6 downto 0)  => h4_1(6 downto 0),
                              Sel => E2,
                              S(6 downto 0) => hex4(6 downto 0));


--hex3
DECODIFICADOR4: bcd7seg port map (bcd_in(3 downto 0) => user(15 downto 12),
                                out_7seg(6 downto 0) => h3_01(6 downto 0));
                                

DECODIFICADOR5: bcd7seg port map (bcd_in(3 downto 0) => code(15 downto 12),
                                out_7seg(6 downto 0) => h3_11(6 downto 0));


MUX_4X1_7BITS_1: mult4x1_7bits port map (A(6 downto 0) => "1000110",
                                      B(6 downto 0) => h3_01(6 downto 0),
                                      C(6 downto 0) => "0001100",
                                      D(6 downto 0)  => h3_11(6 downto 0),
                                      Sel(1 downto 0) => sel_mux(1 downto 0),
                                      S(6 downto 0) => hex3(6 downto 0));
                                      

--hex2    
DECODIFICADOR6: bcd7seg port map (bcd_in(3 downto 0) => sel(5 downto 2),
                                out_7seg(6 downto 0) => h2_00(6 downto 0));


DECODIFICADOR7: bcd7seg port map (bcd_in(3 downto 0) => user(11 downto 8),
                                out_7seg(6 downto 0) => h2_01(6 downto 0));

P_reg_s <= '0' & P_reg(2 downto 0);

DECODIFICADOR8: bcd7seg port map (bcd_in(3 downto 0) => P_reg_s(3 downto 0),
                                out_7seg(6 downto 0) => h2_10(6 downto 0));


DECODIFICADOR9: bcd7seg port map (bcd_in(3 downto 0) => code(11 downto 8),
                                out_7seg(6 downto 0) => h2_11(6 downto 0));

MUX_4X1_7BITS_2: mult4x1_7bits port map (A(6 downto 0) => h2_00(6 downto 0),
                                      B(6 downto 0) => h2_01(6 downto 0),
                                      C(6 downto 0) => h2_10(6 downto 0),
                                      D(6 downto 0)  => h2_11(6 downto 0),
                                      Sel(1 downto 0) => sel_mux(1 downto 0),
                                      S(6 downto 0) => hex2(6 downto 0));


--hex1
DECODIFICADOR10: bcd7seg port map (bcd_in(3 downto 0) => user(7 downto 4),
                                out_7seg(6 downto 0) => h1_01(6 downto 0));

DECODIFICADOR11: bcd7seg port map (bcd_in(3 downto 0) => code(7 downto 4),
                                out_7seg(6 downto 0) => h1_11(6 downto 0));

MUX_4X1_7BITS_3: mult4x1_7bits port map (A(6 downto 0) => "1000111",
                                      B(6 downto 0) => h1_01(6 downto 0),
                                      C(6 downto 0) => "0000110",
                                      D(6 downto 0)  => h1_11(6 downto 0),
                                      Sel(1 downto 0) => sel_mux(1 downto 0),
                                      S(6 downto 0) => hex1(6 downto 0));


--hex0
sel_s <= "00" & sel(1 downto 0);
E_reg_s <= '0' & E_reg(2 downto 0);

DECODIFICADOR12: bcd7seg port map (bcd_in(3 downto 0) => sel_s(3 downto 0),
                                out_7seg(6 downto 0) => h0_00(6 downto 0));
                                
DECODIFICADOR13: bcd7seg port map (bcd_in(3 downto 0) => user(3 downto 0),
                                out_7seg(6 downto 0) => h0_01(6 downto 0));
                                
DECODIFICADOR14: bcd7seg port map (bcd_in(3 downto 0) => E_reg_s(3 downto 0),
                                out_7seg(6 downto 0) => h0_10(6 downto 0));
                                
DECODIFICADOR15: bcd7seg port map (bcd_in(3 downto 0) => code(3 downto 0),
                                out_7seg(6 downto 0) => h0_11(6 downto 0));

MUX_4X1_7BITS_4: mult4x1_7bits port map (A(6 downto 0) => h0_00(6 downto 0),
                                      B(6 downto 0) => h0_01(6 downto 0),
                                      C(6 downto 0) => h0_10(6 downto 0),
                                      D(6 downto 0)  => h0_11(6 downto 0),
                                      Sel(1 downto 0) => sel_mux(1 downto 0),
                                      S(6 downto 0) => hex0(6 downto 0));


end arc_data;
