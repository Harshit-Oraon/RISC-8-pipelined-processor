<h1 align="center">🧠 Semi-Custom VLSI Design and Implementation of 8-bit Pipelined RISC Processor</h1>

<p align="center">
  <img src="Screenshot-from-2025-11-01-17-19-13.jpg" width="80%" alt="Processor Layout"/><br>
  <em>Placed and Routed Design in Cadence Innovus</em>
</p>

---

## 📘 Abstract
This project presents the **design, synthesis, and physical implementation** of an **8-bit pipelined RISC processor** using a **semi-custom VLSI flow**.  
The processor adopts a **5-stage pipeline architecture** with **hazard detection and forwarding units**, implemented using **Cadence Genus** and **Cadence Innovus** with **TSMC 180nm CMOS technology**.

---

## 🏗️ Architecture Overview
| Component | Specification |
|------------|----------------|
| **Data Width** | 8-bit |
| **Pipeline Stages** | IF, ID, EX, MEM, WB |
| **Register File** | 8 × 8-bit |
| **Clock Frequency** | 50 MHz |
| **Power Consumption** | 204.4 µW |
| **Core Area** | 5715 µm² |

### 🔁 Pipeline Design Flow
1. **Instruction Fetch (IF)** – Reads instructions from program memory  
2. **Instruction Decode (ID)** – Decodes opcodes and fetches register operands  
3. **Execution (EX)** – Performs ALU operations  
4. **Memory Access (MEM)** – Handles data read/write  
5. **Write Back (WB)** – Updates register file  

---

## ⚙️ Tools and Technology Stack
| Tool | Purpose |
|------|----------|
| **Cadence Genus** | Logic Synthesis |
| **Cadence Innovus** | Physical Design (Placement & Routing) |
| **TSMC 180nm CMOS Library** | Standard Cell Library |
| **Vivado / Verilog HDL** | RTL Design and Simulation |

---

## 📊 Design Results Summary
| Metric | Value | Unit |
|--------|--------|------|
| **Clock Frequency** | 50 | MHz |
| **Total Power** | 0.2044 | mW |
| **Cell Area** | 5714.76 | µm² |
| **Utilization** | 70.02 | % |
| **Worst Negative Slack (WNS)** | +14.99 | ns |
| **Hold Slack** | -0.329 | ns |
| **DRC Errors** | 0 | ✅ Clean Layout |

---

## 📈 Design Highlights
- ✔️ **Fully functional 8-bit pipelined RISC processor**
- ⚡ **Optimized timing and area under 180nm technology**
- 🔄 **Pipeline hazard detection and forwarding**
- 🧩 **Modular Verilog design hierarchy**
- 🧠 **Semi-custom VLSI flow implementation**
- 🧮 **Post-layout verification with zero DRC violations**

---
### 🧑‍💻 Author
**HARSHIT ORAON**  
Department of Electronics and Communication Engineering   
📅 *November 2025*
