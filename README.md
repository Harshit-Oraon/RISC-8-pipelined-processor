<h1 align="center">🧠 8-bit Pipelined RISC Processor</h1>
<p align="center">
  <em>FPGA Implementation + Semi-Custom VLSI Design</em><br><br>
</p>
<div align="center">

![Made with Verilog](https://img.shields.io/badge/Made%20with-Verilog-blue)
![Tool-Vivado](https://img.shields.io/badge/Tool-Xilinx%20Vivado-orange)
![Tool-Cadence](https://img.shields.io/badge/Tool-Cadence%20Genus%2FInnovus-red)
![License](https://img.shields.io/badge/License-MIT-green)

</div>


---
## 📘 Abstract  
This project presents the **design, simulation, FPGA implementation, and semi-custom VLSI realization** of an **8-bit pipelined RISC processor**.  
The processor follows a **five-stage pipeline** — *Instruction Fetch (IF), Instruction Decode (ID), Execute (EX), Memory Access (MEM), and Write Back (WB)* — and integrates **hazard detection**, **data forwarding**, and **branch handling** for efficient instruction execution.  

---

### 🧩 FPGA Implementation  
- Designed in **Verilog HDL** and implemented using **Xilinx Vivado**.  
- **Target Device:** *ZedBoard (XC7Z020CLG484-1)*  
- Utilized **Block Memory Generator (BRAM)** IP for instruction/data memory.  
- Employed **Integrated Logic Analyzer (ILA)** IP to visualize real-time internal waveforms.  



### ⚙️ VLSI Semi-Custom Implementation  
- Complete ASIC design flow performed using **Cadence tools**:  
  - **NCLaunch** → Simulation  
  - **Genus** → Logic Synthesis  
  - **Innovus** → Place and Route  
- Based on **TSMC 180nm CMOS technology**.  



This dual implementation validates a **fully functional and optimized processor**, bridging **FPGA prototyping** and **ASIC realization**, and demonstrates a complete **end-to-end digital design flow** from RTL to physical layout.

---

## ⚙️ Tools and Technologies

| Tool / Technology | Purpose |
|-------------------|----------|
| **Vivado 2023.2** | FPGA Synthesis, Simulation & Bitstream |
| **Cadence nclunch** |  Simulation |
| **Cadence Genus** | Logic Synthesis , Netlist |
| **Cadence Innovus** | Placement, Routing, Physical Verification |
| **TSMC 180nm CMOS** | ASIC Standard Cell Library |
| **Verilog** | RTL Design Language |

---

## 🏗️ Processor Architecture Overview

| Component | Description |
|------------|-------------|
| **Data Width** | 8-bit |
| **Pipeline Stages** | IF → ID → EX → MEM → WB |
| **Register File** | 8 × 8-bit |
| **ALU Operations** | Arithmetic & Logical (ADD, SUB, AND, OR, etc.) |
| **Hazard Detection** | Implemented |
| **Forwarding Unit** | Implemented |
| **Control Unit** | Hardwired FSM |

<p align="center">
  <img src="images/architecture.png" width="75%" alt="Architecture Diagram">
</p>

---

## 💻 FPGA Implementation

### 🔹 Flow
1. **Design Entry:** Verilog HDL  
2. **Simulation:** Behavioral verification in Vivado/ModelSim  
3. **Synthesis & Implementation:** Using Xilinx Vivado  
4. **Bitstream Generation:** Output `.bit` file for FPGA  
5. **Hardware Testing:** Functional verification on FPGA board  

### 🔹 Example Hardware Setup
- **Board Used:** Basys3 / Nexys A7 (Artix-7 FPGA)  
- **Clock:** 50 MHz onboard oscillator  
- **Inputs/Outputs:** Switches for opcodes, LEDs for results  

<p align="center">
  <img src="images/waveform.png" width="80%" alt="Simulation Waveform">
  <br><em>Simulation output in Vivado showing pipeline operation</em>
</p>

---

## ⚡ VLSI Semi-Custom Design Flow

### 🔹 Flow Overview
1. RTL Design → Logic Synthesis (Cadence Genus)  
2. Netlist → Placement & Routing (Cadence Innovus)  
3. DRC/LVS Checks → Power/Timing Analysis  
4. GDS Export  

### 🔹 Results Summary

| Metric | Value | Unit |
|--------|--------|------|
| **Clock Frequency** | 50 | MHz |
| **Total Power** | 0.2044 | mW |
| **Cell Area** | 5714.76 | µm² |
| **Utilization** | 70.02 | % |
| **WNS** | +14.99 | ns |
| **Hold Slack** | -0.329 | ns |
| **DRC Errors** | 0 | ✅ Clean Layout |

<p align="center">
  <img src="images/layout.png" width="80%" alt="Chip Layout">
  <br><em>Placed and Routed Design in Cadence Innovus</em>
</p>

---

## 🧠 Comparison: FPGA vs VLSI Implementation

| Parameter | FPGA | VLSI Semi-Custom |
|------------|------|------------------|
| **Technology Node** | Xilinx 28nm | TSMC 180nm |
| **Clock Frequency** | 50 MHz | 50 MHz |
| **Power Consumption** | ~10.4 mW | 0.2044 mW |
| **Design Tool** | Vivado | Cadence Genus/Innovus |
| **Target** | Reconfigurable Logic | Fabricated Chip |
| **Outcome** | Working FPGA prototype | Optimized ASIC layout |

---

## 📈 Design Highlights
- ✔️ **Fully functional 8-bit pipelined RISC processor**
- 🔄 **Pipeline hazard detection and forwarding**
- ⚡ **Optimized timing and area under 180nm technology**
- 🧮 **Post-layout STA and power analysis verified**
- 🧱 **FPGA & VLSI implementation within one unified design flow**
- 🧠 **Educational + research-oriented open hardware design**

---

## 📎 Full Report
📄 [`report.tex`](report/report.tex) – LaTeX source  
📘 [`Project_Report.pdf`](report/Project_Report.pdf) – Final report  

---

## 🧑‍💻 Author
**Your Name**  
Department of Electronics and Communication Engineering  
**Your Institution Name**  
📅 *November 2025*

<p align="center">
  ⭐ If you found this project helpful, consider giving it a star!  
  <br><em>Knowledge shared is innovation multiplied.</em>
</p>
