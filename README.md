# Debouncing and Edge Detection in Verilog

## Overview

This project demonstrates the implementation of **debouncing** and **edge detection** for mechanical switches or push buttons using **Verilog**. Mechanical buttons produce noisy signals due to physical contacts & bounce, leading to multiple transitions that can be misinterpreted as multiple presses. This module ensures stable button input by:

- Filtering out spurious transitions (debouncing).
- Detecting clean rising or falling edges of the button signal (edge detection).

These modules are designed to be synthesizable and compatible with FPGA platforms (e.g., Xilinx Nexys Artix-7 100T).

---

## Debouncing Algorithm

The debounce logic uses a **counter-cum-fsm-based method** to ensure the input signal remains stable for a certain period before registering a change. I have used delayed detection model in my code.

### Key Features:

- A configurable parameter `fv` for debounce delay in the file **delayed_debouncer.v**.
- Updates the output only if the input stays stable for complete debounce duration specified using the parameter `fv`.
