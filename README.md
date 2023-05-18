# simfifo

![blank](https://github.com/MatthieuMichon/simfifo/actions/workflows/blank.yml/badge.svg)

This is a functional model of FIFO intended for VHDL simulations.

# Usage

## Requirements

* VHDL-2008 compatible simulator.

Testing:

* ghdl
* make

## Instantiation

This `simfifo` design unit supports generic data bus width, defined on package declaration using the `DATA_WIDTH` argument:

```vhd
package simfifo_pkg_dword is new work.simfifo_pkg
    generic map (DATA_WIDTH => 32);
```

`simfifo` uses the `std_logic_vector` type for its arguments, meaning that this type must be declared prior the package declaration. Which means that the design unit should start with:

```vhd
library ieee;
context ieee.ieee_std_context;
package simfifo_pkg_dword is new work.simfifo_pkg
    generic map (DATA_WIDTH => 32);

-- The lines above could be in a separate file

library ieee;
context ieee.ieee_std_context;
use work.simfifo_pkg_dword.all;
use ieee.numeric_std_unsigned.all;
```

## API

`simfifo` exposes the following objects:
- `data_t`: `std_logic_vector` with a width of `DATA_WIDTH` bits.
- `level_t`: defining the type of FIFO level in data words.
- `simfifo`: the core object supporting the following methods:
  - `push(data_t)`: pushes a given `data_t` in the FIFO.
  - `pop()`: returns the oldest `data_t` value pushed in the FIFO.
  - `get_level()`: returns number of `data_t` values currently residing in the FIFO.

# Example

See [`simfifo_tb.vhd`](./simfifo_tb.vhd) as an example.
