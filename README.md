# RISC-8-pipelined-processor
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Semi-Custom Processor Design Project</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f8f8f8; margin: 0; padding: 0; }
        .container { max-width: 1100px; margin: auto; background: white; padding: 32px; box-shadow: 0 0 10px #ccc; }
        h1 { color: #324057; }
        h2 { color: #477ca8; border-bottom: 1px solid #eee; }
        img { max-width: 100%; margin: 10px 0; border: 1px solid #ddd; }
        .section { margin-bottom: 34px; }
        .code-block { background: #222; color: #fff; padding: 20px; border-radius: 6px; font-family: "Courier New", Courier, monospace; }
        ul { padding-left: 18px; }
        .placeholder { color: #adadad; font-style: italic; }
    </style>
</head>
<body>
<div class="container">
    <h1>Semi-Custom Processor Design Project</h1>
    <p>
        This repository contains the full-flow implementation of a custom RISC processor using industry-standard EDA tools. The design flow is organized into three major stages: Genus (logic synthesis), NLaunch (standard cell library and constraints preparation), and Innovus (physical design). Here, Genus results are presented first, followed by the NLaunch section as a placeholder, ready for future updates.
    </p>
    
    <div class="section">
        <h2>Genus Synthesis Stage</h2>
        <ul>
            <li><b>RTL Description:</b> Verilog source code of an 8-bit RISC pipelined processor (see Design_Processor.v in repository).</li>
            <li><b>Modules:</b> ALU, Program Counter, Forwarding Unit, Register File, Instruction/Data Memory, Control Unit, etc.</li>
            <li><b>Key Results:</b>
                <ul>
                    <li>Synthesized hierarchy available in report files.</li>
                    <li>Logic timing, gate count, and area summary accessible in Genus reports.</li>
                    <li>Power analysis and QoR summary.</li>
                </ul>
            </li>
        </ul>
        <h3>Reports and Files:</h3>
        <ul>
            <li>processor_timing_180nm.rpt</li>
            <li>processor_area_180nm.rpt</li>
            <li>processor_gates_180nm.rpt</li>
            <li>processor_power_180nm.rpt</li>
            <li>processor_qor_180nm.rpt</li>
            <li>processor_hierarchy.rpt</li>
            <li>check_design_map.rpt</li>
            <li>check_design_opt.rpt</li>
            <li>check_design_generic.rpt</li>
        </ul>
        <h3>Schematic Preview:</h3>
        <img src="sch.jpg" alt="Genus Schematic Image">
        <img src="gui_schematic.jpg" alt="Genus GUI Schematic">
        <h3>3D Design Snapshots:</h3>
        <img src="3DSnapShot.jpg" alt="3D Design Snapshot">
    </div>
    
    <div class="section">
        <h2>NLaunch Preparation Stage</h2>
        <p class="placeholder">
            NLaunch step details and results will be added here once received from the author. This step involves the setup and characterization of the standard cell library and constraint files required for subsequent synthesis and physical design.
        </p>
    </div>
    
    <div class="section">
        <h2>Future Sections</h2>
        <ul>
            <li><b>Innovus Physical Design:</b> To be added after NLaunch. Will include full chip layout, routing, DRC, and LVS checks with further analysis and images.</li>
        </ul>
    </div>
    
    <div class="section">
        <h2>Author & Contributions</h2>
        <ul>
            <li>Design and Implementation – [Your Name]</li>
            <li>EDA Flow – Cadence Genus, NLaunch (to be added), Innovus</li>
        </ul>
    </div>
</div>
</body>
</html>

