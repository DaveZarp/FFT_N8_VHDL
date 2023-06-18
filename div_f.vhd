library ieee;
use ieee.std_logic_1164.all;

entity div_f is
generic (valor: integer := 9999);

port (clk_1: in std_logic;
		clk_2: buffer std_logic);
end entity;

architecture algo of div_f is
signal cont: integer range 0 to valor;
begin
process (clk_1)
begin
	if rising_edge(clk_1) then
		if cont = valor then
			cont <= 0;
			clk_2 <= not clk_2;
		else
			cont <= cont + 1;
		end if;
	end if;
end process;
end algo;