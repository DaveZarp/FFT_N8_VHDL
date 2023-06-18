library ieee;
use ieee.std_logic_1164.all;

entity DECO is
port (--clk: in std_logic;
		XK0: in std_logic_vector(15 downto 0); 
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
		);

end entity;

architecture Behavior of DECO is

begin

	XK0_16_8:
			esp0 <= X"00" WHEN (XK0 >= X"2000") ELSE
				X"80" WHEN (XK0 >= X"1880" and XK0< X"2000") ELSE -- 7<x<8
				X"C0" WHEN (XK0 >= X"1200" and XK0< X"1880") ELSE -- 6<x<7
				X"E0" WHEN (XK0 >= X"0C80" and XK0< X"1200") ELSE -- 5<x<6
				X"F0" WHEN (XK0 >= X"0800" and XK0< X"0C80") ELSE -- 4<x<5
				X"F8" WHEN (XK0 >= X"0480" and XK0< X"0800") ELSE -- 3<x<4
				X"FC" WHEN (XK0 >= X"0200" and XK0< X"0480") ELSE -- 2<x<3
				X"FE" WHEN (XK0 >= X"0080" and XK0< X"0200") ELSE -- 1<x<2
				X"FF";
	XK1_16_8:
			esp1 <= X"00" WHEN (XK1 >= X"2000") ELSE
				X"80" WHEN (XK1 >= X"1880" and XK1< X"2000") ELSE -- 7<x<8
				X"C0" WHEN (XK1 >= X"1200" and XK1< X"1880") ELSE -- 6<x<7
				X"E0" WHEN (XK1 >= X"0C80" and XK1< X"1200") ELSE -- 5<x<6
				X"F0" WHEN (XK1 >= X"0800" and XK1< X"0C80") ELSE -- 4<x<5
				X"F8" WHEN (XK1 >= X"0480" and XK1< X"0800") ELSE -- 3<x<4
				X"FC" WHEN (XK1 >= X"0200" and XK1< X"0480") ELSE -- 2<x<3
				X"FE" WHEN (XK1 >= X"0080" and XK1< X"0200") ELSE -- 1<x<2
				X"FF";
	XK2_16_8:
			esp2 <= X"00" WHEN (XK2 >= X"2000") ELSE
				X"80" WHEN (XK2 >= X"1880" and XK2< X"2000") ELSE -- 7<x<8
				X"C0" WHEN (XK2 >= X"1200" and XK2< X"1880") ELSE -- 6<x<7
				X"E0" WHEN (XK2 >= X"0C80" and XK2< X"1200") ELSE -- 5<x<6
				X"F0" WHEN (XK2 >= X"0800" and XK2< X"0c80") ELSE -- 4<x<5
				X"F8" WHEN (XK2 >= X"0480" and XK2< X"0800") ELSE -- 3<x<4
				X"FC" WHEN (XK2 >= X"0200" and XK2< X"0480") ELSE -- 2<x<3
				X"FE" WHEN (XK2 >= X"0080" and XK2< X"0200") ELSE -- 1<x<2
				X"FF";
	XK3_16_8:
			esp3 <= X"00" WHEN (XK3 >= X"2000") ELSE
				X"80" WHEN (XK3 >= X"1880" and XK3< X"2000") ELSE -- 7<x<8
				X"C0" WHEN (XK3 >= X"1200" and XK3< X"1880") ELSE -- 6<x<7
				X"E0" WHEN (XK3 >= X"0C80" and XK3< X"1200") ELSE -- 5<x<6
				X"F0" WHEN (XK3 >= X"0800" and XK3< X"0c80") ELSE -- 4<x<5
				X"F8" WHEN (XK3 >= X"0480" and XK3< X"0800") ELSE -- 3<x<4
				X"FC" WHEN (XK3 >= X"0200" and XK3< X"0480") ELSE -- 2<x<3
				X"FE" WHEN (XK3 >= X"0080" and XK3< X"0200") ELSE -- 1<x<2
				X"FF";
	XK4_16_8:
			esp4 <= X"00" WHEN (XK4 >= X"2000") ELSE
				X"80" WHEN (XK4 >= X"1880" and XK4< X"2000") ELSE -- 7<x<8
				X"C0" WHEN (XK4 >= X"1200" and XK4< X"1880") ELSE -- 6<x<7
				X"E0" WHEN (XK4 >= X"0C80" and XK4< X"1200") ELSE -- 5<x<6
				X"F0" WHEN (XK4 >= X"0800" and XK4< X"0C80") ELSE -- 4<x<5
				X"F8" WHEN (XK4 >= X"0480" and XK4< X"0800") ELSE -- 3<x<4
				X"FC" WHEN (XK4 >= X"0200" and XK4< X"0480") ELSE -- 2<x<3
				X"FE" WHEN (XK4 >= X"0080" and XK4< X"0200") ELSE -- 1<x<2
				X"FF";				
	XK5_16_8:
			esp5 <= X"00" WHEN (XK5 >= X"2000") ELSE
				X"80" WHEN (XK5 >= X"1880" and XK5< X"2000") ELSE -- 7<x<8
				X"C0" WHEN (XK5 >= X"1200" and XK5< X"1880") ELSE -- 6<x<7
				X"E0" WHEN (XK5 >= X"0c80" and XK5< X"1200") ELSE -- 5<x<6
				X"F0" WHEN (XK5 >= X"0800" and XK5< X"0C80") ELSE -- 4<x<5
				X"F8" WHEN (XK5 >= X"0480" and XK5< X"0800") ELSE -- 3<x<4
				X"FC" WHEN (XK5 >= X"0200" and XK5< X"0480") ELSE -- 2<x<3
				X"FE" WHEN (XK5 >= X"0080" and XK5< X"0200") ELSE -- 1<x<2
				X"FF";
	XK6_16_8:
			esp6 <= X"00" WHEN (XK6 >= X"2000") ELSE
				X"80" WHEN (XK6 >= X"1880" and XK6< X"2000") ELSE -- 7<x<8
				X"C0" WHEN (XK6 >= X"1200" and XK6< X"1880") ELSE -- 6<x<7
				X"E0" WHEN (XK6 >= X"0c80" and XK6< X"1200") ELSE -- 5<x<6
				X"F0" WHEN (XK6 >= X"0800" and XK6< X"0C80") ELSE -- 4<x<5
				X"F8" WHEN (XK6 >= X"0480" and XK6< X"0800") ELSE -- 3<x<4
				X"FC" WHEN (XK6 >= X"0200" and XK6< X"0480") ELSE -- 2<x<3
				X"FE" WHEN (XK6 >= X"0080" and XK6< X"0200") ELSE -- 1<x<2
				X"FF";			
	XK7_16_8:
			esp7 <= X"00" WHEN (XK7 >= X"2000") ELSE				  -- x>7
				X"80" WHEN (XK7 >= X"1880" and XK7< X"2000") ELSE -- 6<x<=7
				X"C0" WHEN (XK7 >= X"1200" and XK7< X"1880") ELSE -- 5<x<=6
				X"E0" WHEN (XK7 >= X"0c80" and XK7< X"1200") ELSE -- 4<x<=5
				X"F0" WHEN (XK7 >= X"0800" and XK7< X"0C80") ELSE -- 3<x<=4
				X"F8" WHEN (XK7 >= X"0480" and XK7< X"0800") ELSE -- 2<x<=3
				X"FC" WHEN (XK7 >= X"0200" and XK7< X"0480") ELSE -- 1<x<=2
				X"FE" WHEN (XK7 >= X"0080" and XK7< X"0200") ELSE -- 0<x<=1
				X"FF";		
	








	
end Behavior;
					