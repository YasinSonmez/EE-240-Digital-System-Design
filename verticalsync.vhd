library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vsync is
	port(
			clk, rst : in std_logic;
			v_count:out integer range 0 to 520;
			v_sync : out std_logic);
end vsync;

architecture vertical of vsync is
signal count : integer range 0 to 520 :=0;
signal temp : std_logic;
begin

process (clk, rst) begin
	if (rst='1') then 
	count <= 0;
	temp <= '0';
	elsif (clk'event and clk='1') then
			if (count = 520) then
				count <= 0;
				temp <= '0';
			else 
				count <= count + 1;
				if (count= 1) then
					temp <= '1';
				end if;
			end if;
	end if;
end process;

v_sync <= temp;
v_count <= count;
end vertical;

