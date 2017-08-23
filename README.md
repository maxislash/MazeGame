# MazeGame

Realization of a maze game on FPGA using VHDL. 

The user used the four buttons of the Xilinx Nexys4 FPGA board to control the game. A debounce filter was implemented on all the buttons. Then the system checks if the movement was possible (no collision with a wall) then if yes, the RAM were the VGA controller take its data was updated. 

The 48 cells maze was generated using a recursive backtracker algorithm and a random number generator composed of XOR gates and shift registers.

See the report (in French) for more information
