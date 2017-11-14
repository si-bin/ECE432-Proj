library ieee;
use ieee.std_logic_1164.all;

entity ROM is
  port ( address : in std_logic_vector(11 downto 0);
         data : out std_logic_vector(7 downto 0);
         psel : in std_logic);
end entity ROM;

architecture behavioral of ROM is
begin
   process (address)
   begin
     if(psel = '0') then
         case address is
           when x"FF8" => data <= x"E9";
           when x"FF9" => data <= x"80";
           when x"080" => data <= x"B0";
           when x"081" => data <= x"90";
           when x"082" => data <= x"E6";
           when x"083" => data <= x"FE";
           when x"084" => data <= x"E4";
           when x"085" => data <= x"F8";
           when x"086" => data <= x"E6";
           when x"087" => data <= x"FA";
           when x"088" => data <= x"EB";
           when x"089" => data <= x"FA";
           when others => data <= x"90";
         end case;
	 elsif(psel = '1') then
        case address is
                when x"FF8" => data <= x"E9";
                when x"FF9" => data <= x"80";
                when x"080" => data <= x"B0";
                when x"081" => data <= x"90";
                when x"082" => data <= x"E6";
                when x"083" => data <= x"FE";
                when x"084" => data <= x"BB";
                when x"085" => data <= x"10";
                when x"086" => data <= x"00";
                when x"087" => data <= x"00";
                when x"088" => data <= x"00";
                when x"089" => data <= x"E4";
                when x"08A" => data <= x"F8";
                when x"08B" => data <= x"D7";
                when x"08C" => data <= x"E6";
                when x"08D" => data <= x"FA";
                when x"08E" => data <= x"EB";
                when x"08F" => data <= x"F9";
                -- 7 Seg Values
                when x"010" => data <= x"7E";
                when x"011" => data <= x"30";
                when x"012" => data <= x"6D";
                when x"013" => data <= x"79";
                when x"014" => data <= x"33";
                when x"015" => data <= x"5B";
                when x"016" => data <= x"5F";
                when x"017" => data <= x"70";
                when x"018" => data <= x"7F";
                when x"019" => data <= x"7B";
                when x"01A" => data <= x"77";
                when x"01B" => data <= x"1F";
                when x"01C" => data <= x"4E";
                when x"01D" => data <= x"3D";
                when x"01E" => data <= x"4F";
                when x"01F" => data <= x"47";
                when others => data <= x"90";
              end case;
	 end if;
  end process;
end architecture behavioral;