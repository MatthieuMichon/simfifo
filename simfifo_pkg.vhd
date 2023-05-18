/* VHDL 2008 */

library ieee;
context ieee.ieee_std_context;

package simfifo_pkg is

    generic (DATA_WIDTH: positive);
    subtype data_t is std_logic_vector(DATA_WIDTH-1 downto 0);
    subtype level_t is natural;

    type simfifo is protected
        procedure push(constant data: in data_t);
        impure function pop return data_t;
        impure function get_level return level_t;
    end protected;

end package;

package body simfifo_pkg is
    type simfifo is protected body
        type item_t;
        type ptr is access item_t;
        type item_t is record
            data: data_t;
            next_item: ptr;
        end record;
        variable root: ptr;
        variable depth: natural;

        procedure push(
            constant data: in data_t
        ) is
            variable new_item: ptr := new item_t;
            variable node: ptr;
        begin
            new_item.data := data;
            new_item.next_item := null;

            if (null = root) then
                root := new_item;
                depth := 1;
            else
                node := root;
                while (null /= node.next_item) loop
                    node := node.next_item;
                end loop;
                depth := depth + 1;
                node.next_item := new_item;
            end if;
        end procedure;

        impure function pop return data_t is
            variable node: ptr := root;
            variable data: data_t;
        begin
            if (null /= root) then
                data := root.data;
                node := root;
                root := root.next_item;
                deallocate(node);
                depth := depth - 1;
            end if;
            return data;
        end function;

        impure function get_level return level_t
        is begin
            return depth;
        end function;

    end protected body;
end package body;
