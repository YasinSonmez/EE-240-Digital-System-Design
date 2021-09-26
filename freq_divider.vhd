----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:42:26 04/18/2019 
-- Design Name: 
-- Module Name:    freq_divider - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity freq_divider is
port(clk_in, rst:in std_logic;
clk_out:out std_logic);
end freq_divider;

architecture Behavioral of freq_divider is
signal temporal:std_logic:='0';
signal count: integer range 0 to 1 ;
begin

process(clk_in, rst)
begin
if(rst ='1') then
count <= 0;
temporal <= '0';
elsif rising_edge(clk_in)then 
if(count =1) then
temporal <= not(temporal);
count<=0;
else
count <= count + 1;
end if;
end if;
end process;
clk_out <= temporal;


end Behavioral;

