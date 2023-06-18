library ieee;
use ieee.std_logic_1164.all;
library work;

entity FftTest is 
	port( clk_M: in std_logic;
		OPTN: in  std_logic_vector(1  downto 0);
		DATA: in  std_logic_vector(15 downto 0);
		ROW:  out std_logic_vector(7  downto 0);
		COLU: out std_logic_vector(7  downto 0));

end entity;
architecture Behavior of fftTest is

component div_f is
generic (valor: integer := 9999);

port (clk_1: in std_logic;
		clk_2: buffer std_logic);
end component;

component FFT_8 is
port(clk: in std_logic;
	Sx: in std_logic_vector(15 downto 0);
	sy0: out std_logic_vector(15 downto 0);
	sy1: out std_logic_vector(15 downto 0);
	sy2: out std_logic_vector(15 downto 0);
	sy3: out std_logic_vector(15 downto 0);
	sy4: out std_logic_vector(15 downto 0);
	sy5: out std_logic_vector(15 downto 0);
	sy6: out std_logic_vector(15 downto 0);
	sy7: out std_logic_vector(15 downto 0)
	); end component;

component DECO is
port (XK0: in std_logic_vector(15 downto 0); 
		XK1: in std_logic_vector(15 downto 0); 
		XK2: in std_logic_vector(15 downto 0); 	
		XK3: in std_logic_vector(15 downto 0); 	
		XK4: in std_logic_vector(15 downto 0); 
		XK5: in std_logic_vector(15 downto 0); 
		XK6: in std_logic_vector(15 downto 0); 
		XK7: in std_logic_vector(15 downto 0); 
		
		esp0: out std_logic_vector(7 downto 0); 
		esp1: out std_logic_vector(7 downto 0); 
		esp2: out std_logic_vector(7 downto 0); 	
		esp3: out std_logic_vector(7 downto 0); 	
		esp4: out std_logic_vector(7 downto 0); 
		esp5: out std_logic_vector(7 downto 0); 
		esp6: out std_logic_vector(7 downto 0); 
		esp7: out std_logic_vector(7 downto 0)
		); end component;
	
component CtrLed is
port (clk: in std_logic;
		esp0: in std_logic_vector(7 downto 0); 
		esp1: in std_logic_vector(7 downto 0); 
		esp2: in std_logic_vector(7 downto 0); 	
		esp3: in std_logic_vector(7 downto 0); 	
		esp4: in std_logic_vector(7 downto 0); 
		esp5: in std_logic_vector(7 downto 0); 
		esp6: in std_logic_vector(7 downto 0); 
		esp7: in std_logic_vector(7 downto 0); 	
		fil: out std_logic_vector(7 downto 0);
		col: out 	std_logic_vector(7 downto 0));
end component;


signal clk_50k:	std_logic;
signal Clk_100k:	std_logic;
signal Y0:			std_logic_vector(15 downto 0);
signal Y1:			std_logic_vector(15 downto 0);
signal Y2:			std_logic_vector(15 downto 0);
signal Y3:			std_logic_vector(15 downto 0);
signal Y4:			std_logic_vector(15 downto 0);
signal Y5:			std_logic_vector(15 downto 0);
signal Y6:			std_logic_vector(15 downto 0);
signal Y7:			std_logic_vector(15 downto 0);

signal R0:			std_logic_vector(7 downto 0);
signal R1:			std_logic_vector(7 downto 0);
signal R2:			std_logic_vector(7 downto 0);
signal R3:			std_logic_vector(7 downto 0);
signal R4:			std_logic_vector(7 downto 0);
signal R5:			std_logic_vector(7 downto 0);
signal R6:			std_logic_vector(7 downto 0);
signal R7:			std_logic_vector(7 downto 0);

signal MIC: 		std_logic_vector(15 downto 0);
signal SqrW:		std_logic_vector(15 downto 0);
signal Tri:			std_logic_vector(15 downto 0);
signal Cons:		std_logic_vector(15 downto 0);
signal inSignal:  std_logic_vector(15 downto 0);

type estados is (inicio, e1, e2, e3, e4, e5, e6, e7);
signal pres: estados;
signal pres1: estados;

begin
MIC<=DATA and X"0ff0";

CLOCK50K: div_f
	generic map(valor=>10000)
	port map(clk_1=>clk_M,clk_2=>clk_50k);
CLOK100K: div_f 
	generic map(valor=>5000)
	port map(clk_1=>clk_M,clk_2=>clk_100k);
	
OPERACIONES: FFT_8
	port map(clk=>Clk_100k, sx=>inSignal,SY0=>Y0,SY1=>Y1,
		SY2=>Y2,SY3=>Y3,SY4=>Y4,SY5=>Y5,SY6=>Y6,SY7=>Y7);
DECODIFICADOR: DECO
	port map(xk0=>y0,xk1=>y1,xk2=>y2,xk3=>y3,
				xk4=>y4,xk5=>y5,xk6=>y6,xk7=>y7,
				esp0=>R0, esp1=>R1,esp2=>R2, esp3=>R3,
				esp4=>R4, esp5=>R5,esp6=>R6, esp7=>R7);
SALIDAS: CtrLED
	port map(clk=>clk_50k, esp0=>R0, esp1=>R1,esp2=>R2, esp3=>R3,
				esp4=>R4, esp5=>R5,esp6=>R6, esp7=>R7,fil=>ROW, col=>COLU);

MUX_Entradas:
	with optn select
	inSignal <= MIC when "00",
       SqrW when "01",
       Tri 	when "10",
       Cons when "11";
Gen_CONS:
	Cons<= X"0080";
Gen_SQRW:
	process(clk_100k)
	begin 
		if rising_Edge(clk_100k) then 
		case pres is
				when inicio => SqrW<=X"0140";
								pres <= e1;
				when e1 => SqrW<=X"0140";
								pres <= e2;
				when e2 => SqrW<=X"0000";
								pres <= e3;
				when e3 => SqrW<=X"0000";
								pres <= e4;
				when e4 => SqrW<=X"0000";
								pres <= e5;
				when e5 => SqrW<=X"0000";
								pres <= e6;
				when e6 => SqrW<=X"0000";
								pres <= e7;
				when e7 => SqrW<=X"0000";
								pres <= inicio;
				When Others => 
								pres<=inicio;	
			end case;
		end if;
	end process;

Gen_TRI:
	process(clk_100k)
	begin 
		if rising_Edge(clk_100k) then 
		case pres1 is
				when inicio => TRI<=X"0000"; 	-- (0)
								pres1 <= e1;
				when e1 => TRI<=X"0080";    	-- (1)
								pres1 <= e2;
				when e2 => TRI<=X"0000";		-- (0)
								pres1 <= e3;
				when e3 => TRI<=X"FF80";		-- (-1)
								pres1 <= e4;
				when e4 => TRI<=X"0000";    	-- (0)
								pres1 <= e5;
				when e5 => TRI<=X"0080";		-- (1)
								pres1 <= e6;
				when e6 => TRI<=X"0000";		-- (0)
								pres1 <= e7;
				when e7 => TRI<=X"FF80";		-- (-1)
								pres1 <= inicio;
				When Others => 
								pres1<=inicio;	
			end case;
		end if;
	end process;
end behavior;


