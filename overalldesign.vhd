library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use ieee.math_real.all;


entity overalldesign is
	port( 
		clk, rst,restart : in std_logic;
		sw_0,sw_1,sw_2 : in std_logic;
		btnu, btnd : in std_logic;
		h_sync, v_sync : out std_logic;
		rgb : out std_logic_vector (7 downto 0));
end overalldesign;

architecture structural of overalldesign is
	component vsync is
		port (
			clk, rst : in std_logic;
			v_count:out integer range 0 to 520;
			v_sync : out std_logic);
	end component;
	
	component hsync is
		Port( 
			clk, rst : in std_logic;
			h_count:out integer range 0 to 799;
			h_sync: out std_logic;
			h_work:out std_logic);
	end component;
	
	component freq_divider is
		port(
			clk_in,rst:in std_logic;
			clk_out:out std_logic);
	end component;
	
	component red_car IS
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
	END component;
		
		component blue_car IS
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
	END component;
	
	component orange_car IS
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
	END component;
	
		component police_car IS
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
	END component;
	
		component yellow_car IS
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
	END component;
	
	component high_score IS
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
  );
END component;
	
	
	component debounce is
	port (
		bt : in std_logic;
		clk : in std_logic;
		dboutput : out std_logic);
	end component;

	
	signal divided_clk: std_logic; 
	signal temp:std_logic;
	signal temp2: std_logic;
	signal h_count: integer range 0 to 799;
	signal v_count: integer range 0 to 520;
	signal my_car_pixel: std_logic_vector(13 downto 0):="00000000000000";
	signal my_car_pixel_color: std_logic_vector(7 downto 0);
	signal my_car2_pixel: std_logic_vector(13 downto 0):="00000000000000";
	signal my_car2_pixel_color_blue: std_logic_vector(7 downto 0);
	signal my_car2_pixel_color_orange: std_logic_vector(7 downto 0);
	signal my_car2_pixel_color_police: std_logic_vector(7 downto 0);
	signal my_car2_pixel_color_yellow: std_logic_vector(7 downto 0);
	constant v_start : integer := 30;
	constant v_end : integer := 510;
	constant h_start : integer := 143;
	constant h_end : integer := 783;
	constant car_width : integer := 69;
	constant car_length : integer := 121;
	constant v_mid : integer := 210;
	constant grass_start : integer := 120;
	constant grass_end : integer := 350; 
	constant line1 : integer := 220;
	constant line2 : integer := 320;
	constant h_car : integer := 148;
	signal v_car : integer range 120 to 350 := 235 ;
	signal h_car2 : integer range 0 to 1300 :=800;
	signal v_car2 : integer range 120 to 350 := 135;
	signal h_car3 : integer range 0 to 1323 :=1075;
	signal v_car3 : integer range 120 to 350 := 335;
	signal h_car4 : integer range 0 to 1350 :=1350;
	signal v_car4 : integer range 120 to 350 := 235;
	signal upp : std_logic;
	signal down : std_logic;
	signal velocity_counter : integer range 0 to 250000;
	signal movement_counter : integer range 0 to 250000;
	signal velocity : integer range 0 to 20 :=4;
	signal line_count : integer range 0 to 150 :=0; 
	signal line :integer range 0 to 640:=49;
	signal background : std_logic_vector (7 downto 0);
	signal crash : std_logic :='0';
	signal random1 : integer := 0;
	signal random2 : integer := 0;
	signal random3 : integer := 0;
	signal random4 : integer := 0;
	signal score : integer := 0;
	signal timer : integer range 0 to 3:=2;
	signal timer_length : integer range 0 to 640:= 640;
	signal text_on,text_on1,text_on2,text_on3,text_on4:std_logic:='0';
	signal  read_high_score,e_high_score:std_logic_vector(0 downto 0):="0";
	signal in_high_score,out_high_score : std_logic_vector(5 downto 0):="000000";
	
	function int_to_str(
	int:in integer)
	return string is
	variable temp:string(1 to 2);
	begin
	if((int mod 10)=0) then
			temp(2):='0';
		elsif((int mod 10)=1) then
			temp(2):='1';
		elsif((int mod 10)=2) then
			temp(2):='2';
		elsif((int mod 10)=3) then
			temp(2):='3';
		elsif((int mod 10)=4) then
			temp(2):='4';
		elsif((int mod 10)=5) then
			temp(2):='5';
		elsif((int mod 10)=6) then
			temp(2):='6';
		elsif((int mod 10)=7) then
			temp(2):='7';
		elsif((int mod 10)=8) then
			temp(2):='8';
		elsif((int mod 10)=9) then
			temp(2):='9';
	end if;		
	if(int<10) then
		temp(1):='0';
		
	else
	if(int=0) then
			temp(2):='0';
		elsif(int/10=1) then
			temp(1):='1';
		elsif(int/10=2) then
			temp(1):='2';
		elsif(int/10=3) then
			temp(1):='3';
		elsif(int/10=4) then
			temp(1):='4';
		elsif(int/10=5) then
			temp(1):='5';
		elsif(int/10=6) then
			temp(1):='6';
		elsif(int/10=7) then
			temp(1):='7';
		elsif(int/10=8) then
			temp(1):='8';
		elsif(int/10=9) then
			temp(1):='9';
	end if;
	end if;
		return temp;
	end function int_to_str;
	
begin
	f1:freq_divider port map(clk,rst,divided_clk);
	s1:vsync port map(temp,rst,v_count,v_sync);
	s2:hsync port map(divided_clk,rst,h_count,temp, temp2);
	c1:red_car port map(divided_clk,my_car_pixel,my_car_pixel_color);
	c2:blue_car port map(divided_clk,my_car2_pixel,my_car2_pixel_color_blue);
	c3:orange_car port map(divided_clk,my_car2_pixel,my_car2_pixel_color_orange);
	c4:police_car port map(divided_clk,my_car2_pixel,my_car2_pixel_color_police);
	c5:yellow_car port map(divided_clk,my_car2_pixel,my_car2_pixel_color_yellow);
	d1: debounce port map(btnu, clk, upp);
	d2: debounce port map(btnd, clk, down);
	h1:high_score port map(clk,e_high_score,read_high_score,in_high_score,out_high_score);
textElement1: entity work.Pixel_On_Text
        generic map (
        	textLength => 6
        )
        port map(
        	clk => clk,
        	displayText => "Score:",
        	position => (200, 100), -- text position (top left)
        	horzCoord => h_count,
        	vertCoord => v_count,
        	pixel => text_on1 -- result
        );
	textElement2: entity work.Pixel_On_Text
        generic map (
        	textLength => 2
        )
        port map(
        	clk => clk,
        	displayText => int_to_str(score) ,
        	position => (250, 100), -- text position (top left)
        	horzCoord => h_count,
        	vertCoord => v_count,
        	pixel => text_on2 -- result
        );		  
	  textElement3: entity work.Pixel_On_Text
        generic map (
        	textLength => 11
        )
        port map(
        	clk => clk,
        	displayText => "High Score:",
        	position => (600, 100), -- text position (top left)
        	horzCoord => h_count,
        	vertCoord => v_count,
        	pixel => text_on3 -- result
        );
	h_sync <=temp;
	  textElement4: entity work.Pixel_On_Text
        generic map (
        	textLength => 2
        )
        port map(
        	clk => clk,
        	displayText => int_to_str(to_integer(unsigned(out_high_score))),
        	position => (700, 100), -- text position (top left)
        	horzCoord => h_count,
        	vertCoord => v_count,
        	pixel => text_on4 -- result
        );
	h_sync <=temp;	
text_on<=text_on1 or text_on2 or text_on3 or text_on4;	

	process(clk)
	
	begin
	if(rising_edge(clk)) then
		if(random1=29) then
			random1<=0;
		else
			random1<=random1+1;
		end if;

	end if;
	end process;
	
	
	
	process(divided_clk) --Car Print
		variable place : integer :=0;
	begin
	if(rising_edge(divided_clk)) then
	if(text_on='1') then
	rgb<="11111111";
	else
	if(v_count>v_start and v_count<v_end and h_count>h_start and h_count<h_end) then

		if(v_count > v_car and v_count < v_car+car_width and h_count > h_car and h_count < h_car+car_length) then
			my_car_pixel <= my_car_pixel + "00000000000001";
			rgb<=my_car_pixel_color;
		elsif (v_count > v_car2 and v_count < v_car2+car_width and h_count > h_car2 and h_count < h_car2+car_length+1) then
			place := (car_length-1)*(v_count-v_car2)+h_count-h_car2-1;
			my_car2_pixel<= std_logic_vector(to_unsigned(place, my_car2_pixel'length));

			if(random2=1) then 
				rgb<=my_car2_pixel_color_orange;
			elsif( random2=0) then
				rgb<=my_car2_pixel_color_blue;
			else
				rgb<=my_car2_pixel_color_yellow;
			end if;
			
		
		elsif (v_count > v_car3 and v_count < v_car3+car_width and h_count > h_car3 and h_count < h_car3+car_length+1) then
			place := (car_length-1)*(v_count-v_car3)+h_count-h_car3-1;
			my_car2_pixel<= std_logic_vector(to_unsigned(place, my_car2_pixel'length));

			if(random3=1) then 
				rgb<=my_car2_pixel_color_orange;
			elsif( random3=0) then
				rgb<=my_car2_pixel_color_blue;
			elsif(random3=2) then
				rgb<=my_car2_pixel_color_police;
			else
				rgb<=my_car2_pixel_color_yellow;
			end if;
		
		
		elsif (v_count > v_car4 and v_count < v_car4+car_width and h_count > h_car4 and h_count < h_car4+car_length+1) then
			place := (car_length-1)*(v_count-v_car4)+h_count-h_car4-1;
			my_car2_pixel<= std_logic_vector(to_unsigned(place, my_car2_pixel'length));

			if(random4=1) then 
				rgb<=my_car2_pixel_color_orange;
			elsif( random4=0) then
				rgb<=my_car2_pixel_color_blue;
			else
				rgb<=my_car2_pixel_color_yellow;
			end if;
		
		else
			rgb<=background;
		end if;
		if (v_count=(v_car+car_width) and h_count=(h_car+car_length)) then
			my_car_pixel<="00000000000000";
		elsif (v_count=(v_car2+car_width) and h_count=(h_car2+car_length)) then
			my_car2_pixel<="00000000000000";
		end if;
	else
		rgb<=background;
	end if;
	end if;
	end if;	
	end process;
	
	process(divided_clk,rst) -- Buttons and car move

	begin 
	if(restart='0' and rst='0') then
	if(rising_edge(divided_clk) and crash='0' and timer_length>0) then
	
		if(h_car2<26) then
			h_car2<=h_car4+270;
			score<=score+1;
			random2<=((random1+v_car)mod 3);

			if(((random1+v_car) mod 3)=2) then
				v_car2<=135;
			elsif(((random1+v_car) mod 3)=1) then
				v_car2<=235;
			else
				v_car2<=335;
			end if;			
		elsif(v_count=510 and h_count =789) then 
			h_car2<=h_car2-(velocity-4);
		end if;
		
		if(h_car3<26) then
			h_car3<=h_car2+270;
			score<=score+1;
			random3<=((random1+v_car)mod 4);

			if(((random1+v_car+1) mod 3)=2) then
				v_car3<=135;
			elsif(((random1+v_car+1) mod 3)=1) then
				v_car3<=235;
			else
				v_car3<=335;
			end if;			
		elsif(v_count=510 and h_count =789) then 
			h_car3<=h_car3-(velocity-4);
		end if;
		
		
		if(h_car4<26) then
			h_car4<=h_car3+270;
			score<=score+1;
			random4<=((random1+v_car+2)mod 3);

			if(((random1+v_car+2) mod 3)=2) then
				v_car4<=135;
			elsif(((random1+v_car+2) mod 3)=1) then
				v_car4<=235;
			else
				v_car4<=335;
			end if;			
		elsif(v_count=510 and h_count =789) then 
			h_car4<=h_car4-(velocity-4);
		end if;
		

		if(upp='1' and down='0' and v_car > grass_start and v_count=510 and h_count =789) then
				v_car <= v_car -(velocity-1);
		elsif (down='1' and upp='0' and v_car < grass_end and v_count=510 and h_count =789) then
				v_car <= v_car +(velocity-1);
		end if;
	end if;
	elsif (restart='1') then
			v_car<=235;
			v_car2<=135;
			h_car2<=800;
			h_car3<=1075;
			h_car4<=1350;
			v_car3<=335;
			v_car3<=235;
			score<=0;
			--timer_length<=640;
			
	end if;
	end process;
	
	
process(divided_clk)
	begin
	if(rising_edge(divided_clk) and rst='0') then
		if(v_count>v_start and v_count<v_end and h_count>h_start and h_count<h_end) then
				if(v_count<grass_start or v_count>grass_end+car_width) then
					if(v_count=500 and h_count= 780) then
						if(timer=1 and timer_length>0 and restart='0' and crash='0')then 
							timer<=0;
							timer_length<=timer_length-1;
						elsif (restart='1') then
							timer_length<=640;
						elsif (crash='0') then
							timer<=timer+1;
						end if;
						
						if(line=0) then
									line<=80;
						elsif(crash='0' and timer_length>0) then 
									line<=line-velocity;
						end if;
					end if;
					if(v_count<grass_end+car_width+8 and v_count>grass_start) then
						if(h_count<h_start+timer_length) then
							background<="11000000";
						else
							background<="00000000";
						end if;
					else
						background<="00001000";
					end if;
				elsif((v_count <line1+5 and v_count > line1-5) or (v_count <line2+5 and v_count > line2-5)) then
														
						if(h_count=h_start+1) then
							line_count<=0;
						elsif(line_count=639) then
							line_count<=0;
						elsif (((h_count-line) mod 80 )> 35) then
							background <="01101101";
							line_count<=line_count+1;
						else 
							background <="11111111";
							line_count<=line_count+1;
						
						end if;
				else
					background<="01101101";
				end if;
		else 
			background<="00000000";
		end if;
	end if;		
	end process;
	
	process(divided_clk)
	begin 
	if(((h_car>h_car2-car_length+5 and h_car<h_car2+car_length-5 and v_car>v_car2-car_width+5 and v_car<v_car2+car_width-5) 
	or (h_car>h_car3-car_length+5 and h_car<h_car3+car_length-5 and v_car>v_car3-car_width+5 and v_car<v_car3+car_width-5)
	or (h_car>h_car4-car_length+5 and h_car<h_car4+car_length-5 and v_car>v_car4-car_width+5 and v_car<v_car4+car_width-5)) and rst='0') then
		crash <='1';
	else
		crash <='0';
	end if;
	end process;
	
	
	process(divided_clk)
	begin
	if(sw_2='1') then
		velocity<=13;
	elsif(sw_1='1') then
		velocity <=10;
	elsif(sw_0='1') then
		velocity <=7;
	else
		velocity <=4;
	end if;
	end process;
	
	process(score)
	variable temp :integer;
	begin
		temp:=to_integer(unsigned(out_high_score));
		if(score>temp) then
			e_high_score<="1";
			in_high_score<= std_logic_vector(to_unsigned(score, out_high_score'length));
		else
			e_high_score<="0";
		end if;
	end process;
end structural;