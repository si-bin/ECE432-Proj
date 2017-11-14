-- Intel 8086-Based uComputer Project for ECE432
-- Top Module

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY system IS
   PORT(
      clk : IN std_logic;
      reset : IN std_logic;
      PORTA : IN std_logic_vector (7 DOWNTO 0);
      PORTB : OUT std_logic_vector (7 DOWNTO 0);
      dbusout : INOUT std_logic_vector (7 downto 0);
      abus : INOUT std_logic_vector (19 downto 0);
      dbusin : INOUT std_logic_vector (7 downto 0);
      out_8255 : INOUT std_logic_vector (7 downto 0);
      iom : INOUT std_logic;
      notwr : INOUT std_logic;
      notrd : INOUT std_logic;
      address_mem : INOUT std_logic_vector (11 downto 0);
      cpuerror : OUT    std_logic;
      rdn      : OUT    std_logic;
      resoutn  : OUT    std_logic;
      wran     : OUT    std_logic;
      wrn      : OUT    std_logic;
      inta     : OUT    std_logic
   );
end system;

architecture behavioral of system is 
   --SIGNAL iom : std_logic;
   --SIGNAL notwr : std_logic;
   --SIGNAL notrd : std_logic;
   --SIGNAL abus : std_logic_vector (19 DOWNTO 0);
   --SIGNAL dbusin : std_logic_vector (7 DOWNTO 0);
   -- signal dbusout : std_logic_vector (7 DOWNTO 0);
   --signal address_mem : std_logic_vector (11 downto 0);

   COMPONENT cpu86
   PORT( 
      clk      : IN     std_logic;
      dbus_in  : IN     std_logic_vector (7 DOWNTO 0);
      intr     : IN     std_logic;
      nmi      : IN     std_logic;
      por      : IN     std_logic;
      abus     : OUT    std_logic_vector (19 DOWNTO 0);
      dbus_out : OUT    std_logic_vector (7 DOWNTO 0);
      cpuerror : OUT    std_logic;
      inta     : OUT    std_logic;
      iom      : OUT    std_logic;
      rdn      : OUT    std_logic;
      resoutn  : OUT    std_logic;
      wran     : OUT    std_logic;
      wrn      : OUT    std_logic
   );
   END COMPONENT;

   COMPONENT ROM
   PORT(
      address : IN std_logic_vector(11 downto 0);
      data : OUT std_logic_vector(7 downto 0)
   );
   END COMPONENT;

   COMPONENT I82C55
   port (

      I_ADDR            : in    std_logic_vector(1 downto 0); -- A1-A0
      I_DATA            : in    std_logic_vector(7 downto 0); -- D7-D0
      O_DATA            : out   std_logic_vector(7 downto 0);
      O_DATA_OE_L       : out   std_logic;

      I_CS_L            : in    std_logic;
      I_RD_L            : in    std_logic;
      I_WR_L            : in    std_logic;

      I_PA              : in    std_logic_vector(7 downto 0);
      O_PA              : out   std_logic_vector(7 downto 0);
      O_PA_OE_L         : out   std_logic_vector(7 downto 0);

      I_PB              : in    std_logic_vector(7 downto 0);
      O_PB              : out   std_logic_vector(7 downto 0);
      O_PB_OE_L         : out   std_logic_vector(7 downto 0);

      I_PC              : in    std_logic_vector(7 downto 0);
      O_PC              : out   std_logic_vector(7 downto 0);
      O_PC_OE_L         : out   std_logic_vector(7 downto 0);

      RESET             : in    std_logic;
      ENA               : in    std_logic; -- (CPU) clk enable
      CLK               : in    std_logic
   );
   END COMPONENT;

begin
   address_mem <= abus(12 downto 1);
   maincore : cpu86
     PORT MAP (
        clk => clk,
        por => reset,
        abus => abus,
        dbus_out => dbusout,
        dbus_in => dbusin,
        iom => iom,
        wrn => notwr,
        rdn => notrd,
        nmi => '0',
        intr => '0'
     );
   memory : ROM
     PORT MAP (
        address => address_mem,
        data => dbusin
     );
   I8255 : I82C55
     PORT MAP (
        I_ADDR => abus(2 downto 1),
        I_DATA => dbusout,
        I_CS_L => '1', -- May need to be changed to NOT MIO OR AD0
        I_RD_L => notrd,
        I_WR_L => notwr,  
        I_PA => PORTA,
        I_PB => x"00",
        O_PB => PORTB,
        I_PC => x"00",
        RESET => reset,
        ENA => iom,
        CLK => clk,
        O_DATA => out_8255
     );
end behavioral;