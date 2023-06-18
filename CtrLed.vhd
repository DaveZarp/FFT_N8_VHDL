library ieee;
use ieee.std_logic_1164.all;

	entity CtrLed is
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
end entity;

architecture Behavior of CtrLed is
type estados is (inicio, e1, e2, e3, e4, e5, e6, e7);
signal pres: estados;
begin

	process(clk)
	begin
		if rising_edge(clk) then
			case pres is
				when inicio => col<="10000000";
								fil<=esp0;
								pres <= e1;
				when e1 => col<="01000000";
								fil<=esp1;
								pres <= e2;
				when e2 => col<="00100000";
								fil<=esp2;
								pres <= e3;
				when e3 => col<="00010000";
								fil<=esp3;
								pres <= e4;
				when e4 => col<="00001000";
								fil<=esp4;
								pres <= e5;
				when e5 => col<="00000100";
								fil<=esp5;
								pres <= e6;
				when e6 => col<="00000010";
								fil<=esp6;
								pres <= e7;
				when e7 => col<="00000001";
								fil<=esp7;
								pres <= inicio;
				When Others => 
								pres<=inicio;	
			end case;
		end if;
	end process;
	
end Behavior;
					