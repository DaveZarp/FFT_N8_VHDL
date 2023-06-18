----------------------------------------------------------------------------------------------
------------------------------Declaración de paquetes y librerías-----------------------------
----------------------------------------------------------------------------------------------
LIBRARY IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

----------------------------------------------------------------------------------------------
---------------------------------- Definición de identidad -----------------------------------
----------------------------------------------------------------------------------------------
entity FFT_4 is 
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
);
end FFT_4;
----------------------------------------------------------------------------------------------

architecture Behavior of FFT_4 is 
----------------------------------------------------------------------------------------------
--------------------------------- Definición de componentes ----------------------------------
----------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------	
------------------- Declaración de señales y definición de variables -------------------------
----------------------------------------------------------------------------------------------
type estados is (inicio, e1, e2, e3, e4, e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15,e16,e17,edec0,edec1);
signal pres: estados;

type registro is array (0 to 7) of std_logic_vector(15 downto 0);
type wkncoefs is array (0 to 3) of std_logic_vector(15 downto 0);
type multiplicacion is array (0 to 1) of std_logic_vector(31 downto 0);
type multiplicacion_signed is array (0 to 1) of signed(31 downto 0);

type multiplicacion_FIXED is array (0 to 3) of std_logic_vector(15 downto 0);
type auxiliar is array (0 to 7) of std_logic_vector(31 downto 0);
type auxiliar2 is array (0 to 7) of signed(31 downto 0);



--Definicion de constantes,parte real e imaginaria
constant wkn_R: wkncoefs:=(X"0080",X"005a",X"0000",X"FFA6"); -- (1, 0.707, 0, -0.707)
constant wkn_I: wkncoefs:=(X"0000",X"FFA6",X"FF80",X"FFA6");  --(0, -0.707, -1, -0.707)

signal mem: registro;
signal dec: registro;
signal sum: registro;

signal mul_R:multiplicacion;
signal mul_I: multiplicacion;

signal muls_R:multiplicacion_signed;
signal muls_I: multiplicacion_signed;

signal mFix_R: multiplicacion_FIXED;
signal mFix_I: multiplicacion_FIXED;

signal sum_R: registro;
signal sum_I: registro;

signal res_R: registro;
signal res_I: registro;

signal mag: auxiliar;
signal mag_sig: auxiliar2;
signal mag_fixed: registro;

--constant Sx: std_logic_vector(15 downto 0):= X"0080";
----------------------------------------------------------------------------------------------
begin
----------------------------------------------------------------------------------------------
------------------------------Carta ASM para correcta sincronización--------------------------
----------------------------------------------------------------------------------------------

	process(clk)
begin
	if rising_edge(clk) then
		case pres is
			when inicio => mem(0)<=X"0000";mem(1)<=X"0000";mem(2)<=X"0000";mem(3)<=X"0000";
					pres <= e1;
----------------------------------------------------------------------------------------------
----------------------Registro de corrimiento para almacenamiento de 8 datos------------------
----------------------------------------------------------------------------------------------
			when e1 => mem(0)<=Sx; mem(1)<=mem(0); mem(2)<=mem(1); mem(3)<=mem(2); 
					mem(4)<=mem(3); mem(5)<=mem(4); mem(6)<=mem(5); mem(7)<=mem(6);
					pres <= e2;
			when e2 => mem(0)<=Sx; mem(1)<=mem(0); mem(2)<=mem(1); mem(3)<=mem(2); 
					mem(4)<=mem(3); mem(5)<=mem(4); mem(6)<=mem(5); mem(7)<=mem(6);
					pres <= e3;
			when e3 => mem(0)<=Sx; mem(1)<=mem(0); mem(2)<=mem(1); mem(3)<=mem(2); 
					mem(4)<=mem(3); mem(5)<=mem(4); mem(6)<=mem(5); mem(7)<=mem(6);
					pres <= e4;
			when e4 => mem(0)<=Sx; mem(1)<=mem(0); mem(2)<=mem(1); mem(3)<=mem(2); 
					mem(4)<=mem(3); mem(5)<=mem(4); mem(6)<=mem(5); mem(7)<=mem(6);
					pres <= e5;
			when e5 => mem(0)<=Sx; mem(1)<=mem(0); mem(2)<=mem(1); mem(3)<=mem(2); 
					mem(4)<=mem(3); mem(5)<=mem(4); mem(6)<=mem(5); mem(7)<=mem(6);
					pres <= e6;
			when e6 => mem(0)<=Sx; mem(1)<=mem(0); mem(2)<=mem(1); mem(3)<=mem(2); 
					mem(4)<=mem(3); mem(5)<=mem(4); mem(6)<=mem(5); mem(7)<=mem(6);
					pres <= e7;
			when e7 => mem(0)<=Sx; mem(1)<=mem(0); mem(2)<=mem(1); mem(3)<=mem(2); 
					mem(4)<=mem(3); mem(5)<=mem(4); mem(6)<=mem(5); mem(7)<=mem(6);
					pres <= e8;
			when e8 => mem(0)<=Sx; mem(1)<=mem(0); mem(2)<=mem(1); mem(3)<=mem(2); 
					mem(4)<=mem(3); mem(5)<=mem(4); mem(6)<=mem(5); mem(7)<=mem(6);
					pres <= edec0;
			--when e8=> mem(0)<=X"0140"; mem(1)<=X"0140"; mem(2)<=X"0000"; mem(3)<=X"0000";   --ESCALON 2.5 * 2
			--			mem(4)<=X"0000"; mem(5)<=X"0000"; mem(6)<=X"0000"; mem(7)<=X"0000"; 
			--			pres <= edec0;
			when edec0=>dec(0)<=mem(0); dec(1)<=mem(4); dec(2)<=mem(2); dec(3)<=mem(6);
					dec(4)<=mem(1); dec(5)<=mem(5); dec(6)<=mem(3); dec(7)<=mem(7);
					pres<=edec1;
			when edec1=> mem(0)<=dec(0); mem(1)<=dec(1); mem(2)<=dec(2); mem(3)<=dec(3);
					mem(4)<=dec(4); mem(5)<=dec(5); mem(6)<=dec(6); mem(7)<=dec(7);
					pres<=e9;
			
----------------------------------------------------------------------------------------------
-------------------------------Resultado de la primera mariposa-------------------------------
----------------------------------------------------------------------------------------------
			when e9=> sum(0)<= mem(0)+ mem(1);
					sum(1)<= mem(0)-mem(1);
					sum(2)<= mem(2)+mem(3);
					sum(3)<= mem(2)-mem(3);
					sum(4)<= mem(4)+mem(5);
					sum(5)<= mem(4)-mem(5);
					sum(6)<= mem(6)+mem(7);
					sum(7)<= mem(6)-mem(7);
					pres <= e10;
----------------------------------------------------------------------------------------------
-------------------------------Resultado segunda mariposa-----------------------------
----------------------------------------------------------------------------------------------
		when e10=> 
					sum_R(0)<= sum(0)+sum(2);
					sum_I(0)<= X"0000";
					
					sum_R(1)<= sum(1);
					sum_I(1)<= -sum(3);
					
					sum_R(2)<= sum(0)-sum(2);
					sum_I(2)<= X"0000";
					
					sum_R(3)<= sum(1);
					sum_I(3)<= sum(3);
					
					sum_R(4)<= sum(4)+sum(6);
					sum_I(4)<= X"0000";
				
					sum_R(5)<= sum(5);
					sum_I(5)<= -sum(7);
					
					sum_R(6)<= sum(4)-sum(6);
					sum_I(6)<= X"0000";
					
					sum_R(7)<= sum(5);
					sum_I(7)<= sum(7);
					
		
				pres<=e11;
----------------------------------------------------------------------------------------------
------------------------------- Aplicacion de constantes WKN´S--------------------------------
----------------------------------------------------------------------------------------------
			when e11 =>
				mul_R(0)<= wkn_R(1)*sum_R(5)-sum_I(5)*wkn_I(1);  --w1_R
				mul_I(0)<= sum_R(5)*wkn_I(1)+sum_I(5)*wkn_R(1);  --w1_I
				mul_R(1)<= wkn_R(3)*sum_R(7)-sum_I(7)*wkn_I(3);  --w3_R
				mul_I(1)<= sum_R(7)*wkn_I(3)+sum_I(7)*wkn_R(3);  --w3_I
				pres<=e12;
			when e12=>
				muls_R(0)<=shift_right(signed(mul_R(0)),7);
				muls_I(0)<=shift_right(signed(mul_I(0)),7);
				muls_R(1)<=shift_right(signed(mul_R(1)),7);
				muls_I(1)<=shift_right(signed(mul_I(1)),7);
				pres<=e13;
			when e13=>
				mFix_R(0)<=std_logic_vector(resize(muls_R(0),16));
				mFix_I(0)<=std_logic_vector(resize(muls_I(0),16));
				mFix_R(1)<=std_logic_vector(resize(muls_R(1),16));
				mFix_I(1)<=std_logic_vector(resize(muls_I(1),16));
				pres<=e14;
----------------------------------------------------------------------------------------------
------------------------------- Resultado Tercera Mariposa --------------------------------
----------------------------------------------------------------------------------------------
			when e14=>
				res_R(0)<= sum_R(0)+sum_R(4);
				res_I(0)<= X"0000";
				
				res_R(1)<=sum_R(1)+mFix_R(0);
				res_I(1)<=sum_I(1)+mFix_I(0);
				
				res_R(2)<=sum_R(2);
				res_I(2)<=sum_R(6);
				
				res_R(3)<=sum_R(3)+mFix_R(1);
				res_I(3)<=sum_I(3)+mFix_I(1);
				
				
				res_R(4)<= sum_R(0)-sum_R(4);
				res_I(4)<= X"0000";
				
				res_R(5)<=sum_R(1)-mFix_R(0);
				res_I(5)<=sum_I(1)-mFix_I(0);
				
				res_R(6)<=sum_R(2);
				res_I(6)<=-sum_R(6);
				
				res_R(7)<=sum_R(3)-mFix_R(1);
				res_I(7)<=sum_I(3)-mFix_I(1);
				pres<=e15;
----------------------------------------------------------------------------------------------
------------------------------- Calculo de magnitud  --------------------------------
----------------------------------------------------------------------------------------------
			when e15=>
				mag(0)<= res_R(0)*res_R(0)+res_I(0)*res_I(0);
				mag(1)<= res_R(1)*res_R(1)+res_I(1)*res_I(1);
				mag(2)<= res_R(2)*res_R(2)+res_I(2)*res_I(2);
				mag(3)<= res_R(3)*res_R(3)+res_I(3)*res_I(3);
				mag(4)<= res_R(4)*res_R(4)+res_I(4)*res_I(4);
				mag(5)<= res_R(5)*res_R(5)+res_I(5)*res_I(5);
				mag(6)<= res_R(6)*res_R(6)+res_I(6)*res_I(6);
				mag(7)<= res_R(7)*res_R(7)+res_I(7)*res_I(7);
				pres<=e16;
			when e16=>
				mag_sig(0)<= shift_right(signed(mag(0)),7);
				mag_sig(1)<= shift_right(signed(mag(1)),7);
				mag_sig(2)<= shift_right(signed(mag(2)),7);
				mag_sig(3)<= shift_right(signed(mag(3)),7);
				mag_sig(4)<= shift_right(signed(mag(4)),7);
				mag_sig(5)<= shift_right(signed(mag(5)),7);
				mag_sig(6)<= shift_right(signed(mag(6)),7);
				mag_sig(7)<= shift_right(signed(mag(7)),7);
				pres<=e17;
			when e17=>
				sy0<=std_logic_vector(resize(mag_sig(0),16));
				sy1<=std_logic_vector(resize(mag_sig(1),16));
				sy2<=std_logic_vector(resize(mag_sig(2),16));
				sy3<=std_logic_vector(resize(mag_sig(3),16));
				sy4<=std_logic_vector(resize(mag_sig(4),16));
				sy5<=std_logic_vector(resize(mag_sig(5),16));
				sy6<=std_logic_vector(resize(mag_sig(6),16));
				sy7<=std_logic_vector(resize(mag_sig(7),16));
				pres<=inicio;
			when others =>
				pres <=inicio;
			end case;
		end if;
	end process;
end behavior;