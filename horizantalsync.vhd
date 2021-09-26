
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity hsync is
	Port( clk, rst : in std_logic;
			h_count:out integer range 0 to 799;
			h_sync: out std_logic;
			h_work:out std_logic

			);
end hsync;

architecture Behavioral of hsync is
signal count : integer range 0 to 799 :=0;
signal temp : std_logic;
begin

process (clk, rst) begin
	if (rst='1') then 
	h_work <= '0';
	count <= 0;
	temp <= '0';
	elsif (clk'event and clk='1') then
			if (count = 799) then
				count <= 0;
				temp <= '0';
			elsif(count = 143) then 
				h_work <='1';
				count <= count + 1;

			elsif(count = 783) then
				h_work <= '0';
			count <= count + 1;

			else 
				count <= count + 1;
				if (count= 95) then
					temp <= '1';
				end if;
			end if;
	end if;
end process;

h_sync <= temp;
h_count<=count;

end Behavioral;

