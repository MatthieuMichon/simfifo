/* VHDL 2008 */

library ieee;
use ieee.std_logic_1164.all;
package simfifo_pkg_c is new work.simfifo_pkg
    generic map (DATA_WIDTH => 8);

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.numeric_std_unsigned.all;
use work.simfifo_pkg_c.all;

entity simfifo_tb is
    generic (FORCE_FAILURE: integer := 0);
end entity;

architecture simfifo_tb_a of simfifo_tb is
    shared variable fifo: simfifo;
begin
    process is
        variable data: data_t;
        variable pdata: data_t;
    begin
        for i in 1 to 5 loop
            data := std_logic_vector(to_stdlogicvector(i, data_t'length));
            fifo.push(data);
        end loop;
        while (0 /= fifo.get_level) loop
            pdata := fifo.pop;
            report to_string(pdata);
        end loop;
        assert 0 = FORCE_FAILURE
            report "forcing failure"
            severity failure;
        wait;
    end process;
    
end architecture;
