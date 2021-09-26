library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity debounce is
port (bt : in std_logic;
		clk : in std_logic;
		dboutput : out std_logic);
end debounce;

architecture Behavioral of debounce is
signal d,q : std_logic_vector (3 downto 0);
begin
d(0)<=bt;

process(clk)
begin
	if(clk'event and clk='1') then
		q(0)<=d(0);
	end if;
end process;
d(1)<=q(0);

process(clk)
begin
	if(clk'event and clk='1') then
		q(1)<=d(1);
	end if;
end process;
d(2)<=q(1);


process(clk)
begin
	if(clk'event and clk='1') then
		q(2)<=d(2);
	end if;
end process;
d(3)<=q(2);


process(clk)
begin
	if(clk'event and clk='1') then
		q(3)<=d(3);
	end if;
end process;


dboutput <= q(0) and q(1) and q(2) and q(3);
end Behavioral;

