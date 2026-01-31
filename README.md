# Custom-Processor-System

A custom-built processor designed and implemented from scratch. This project focuses on supporting core instruction types including R-type, I-type, load/store, and branch instructions, with an emphasis on correct control flow and instruction execution.

## Overview
The processor is designed as a basic RISC-style architecture with a custom instruction set. It demonstrates how instructions are fetched, decoded, executed, and written back using a modular datapath and control logic.

## Supported Instructions
The processor supports:
- R-type instructions for arithmetic and logical operations
- I-type instructions for immediate-based operations
- Load Word (LW) for reading data from memory
- Store Word (SW) for writing data to memory
- Branch instructions for conditional program flow control

## Architecture
The design includes:
- Instruction Fetch and Program Counter logic
- Instruction Decode and Control Unit
- ALU for execution
- Memory interface for load and store operations
- Write-back logic to registers
- Branch handling logic for correct PC updates

## Design Focus
This project emphasizes:
- Accurate branch handling
- Correct instruction execution
- Clear separation of datapath and control
- Modular and extensible processor design

## Purpose
The goal of this project is to strengthen understanding of processor architecture, instruction set design, control units, and datapath implementation by building a processor from the ground up.

## Future Improvements
Possible future enhancements include:
- Instruction pipelining
- Hazard detection and forwarding
- Extended instruction set support
- Performance optimization

## Concepts Used
- Processor Architecture
- Instruction Set Architecture (ISA)
- Datapath and Control Design
- Branch Logic
- Load and Store Mechanisms

