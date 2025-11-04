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
1. **Design Entry:** Implemented using **Verilog HDL** in *Xilinx Vivado*  
2. **Simulation:** Verified functionality through **behavioral simulation** using *Vivado Simulator* and *ModelSim*  
3. **Synthesis & Implementation:** Performed using *Xilinx Artix-7 FPGA* on Vivado  
4. **Bitstream Generation:** Generated the `.bit` file for FPGA configuration  
5. **Hardware Testing:** Programmed onto the FPGA board and verified using on-board I/O devices  

---

### 🔹 Example Hardware Setup
- **Board Used:** Basys 3 / Nexys A7 (Artix-7 FPGA)  
- **Clock Source:** 50 MHz onboard oscillator  
- **Inputs:** Switches used to load instructions or input data  
- **Outputs:** LEDs used to visualize ALU results or register outputs  

---

### 🔹 Special Design Features

#### 🧠 Block Memory (BRAM)
Used for **instruction and data memory** instead of distributed LUT RAM.  
This approach provides:
- Faster and more efficient memory access  
- Reduced LUT utilization  
- Realistic processor memory behavior inside the FPGA  

#### 🔍 Integrated Logic Analyzer (ILA)
The **ILA core** was integrated to perform real-time debugging inside the FPGA.  
It allowed monitoring of:
- Internal pipeline signals  
- Register updates  
- Control and hazard signals  

This method eliminated the need for external logic analyzers and made debugging seamless.

#### ⚙️ Pipeline Verification
Each pipeline stage (**IF**, **ID**, **EX**, **MEM**, **WB**) was verified both in simulation and on hardware using ILA captures.  
This confirmed the correct instruction flow, hazard handling, and data forwarding.

---

### 🧩 Summary
This FPGA implementation demonstrates a **fully functional 8-bit pipelined RISC processor**, designed and tested from RTL to real hardware.  
By using **BRAM** for memory and **ILA** for signal tracing, the design achieves:
- High efficiency  
- Real-time visibility  
- Reliable verification from simulation to FPGA hardware  

---

### 📸 Project Images and Results

#### 🔷 Block Diagram / Schematic 
![Block Diagram](FPGA-Implementation/Output/schemetic.png)

#### 🔷 Simulation Waveform 
![Simulation Waveform](FPGA-Implementation/Output/zedbordoutput01.png)
![Simulation Waveform](FPGA-Implementation/Output/zedbordoutput02.png)

#### 🔷 Device Utilization Report
> *(Attach screenshot of synthesis utilization report)*  
![Device Utilization](images/device_utilization.png)

#### 🔷 Timing Summary
> *(Attach timing analysis result or screenshot from Vivado)*  
![Timing Report](images/timing_report.png)

---

📁 *All related images and reports should be placed inside the* `images/` *folder.*


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
