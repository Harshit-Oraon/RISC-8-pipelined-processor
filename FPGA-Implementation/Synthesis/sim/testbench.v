`timescale 1ns/1ps

module risc8_pipeline_tb;

    reg clk_in;
    reg reset_n_in;
    
    risc8_pipeline_top uut (
        .clk_in(clk_in),         
        .reset_n_in(reset_n_in) 
    );
    
    initial begin
        clk_in = 0;
        forever #5 clk_in = ~clk_in;
    end
    
    initial begin
        $dumpfile("risc8_pipeline.vcd");
        $dumpvars(0, risc8_pipeline_tb);
        
        // Display header
        $display("\n========================================");
        $display("RISC-8 PIPELINED PROCESSOR TESTBENCH");
        $display("========================================\n");
        
        // Initialize signals
        reset_n_in = 0;
        
        // Apply reset for 5 clock cycles
        $display("Time=%0t: Applying Reset", $time);
        repeat(5) @(posedge clk_in);
        reset_n_in = 1;
        $display("Time=%0t: Reset Released\n", $time);
        
        // Wait for reset synchronizer to settle
        repeat(5) @(posedge clk_in);
        
        // Run for sufficient cycles to execute program
        repeat(50) @(posedge clk_in);
        
        // Display final register states
        $display("\n========================================");
        $display("FINAL REGISTER FILE STATE");
        $display("========================================");
        display_registers();
        
        $display("\n========================================");
        $display("TEST COMPLETED");
        $display("========================================\n");
        
        $finish;
    end
    
    initial begin
        #20; // Wait for reset
        $display("Time\tPC\tInstr\t\tOpcode\tStall\tFlush");
        $display("----\t--\t-----\t\t------\t-----\t-----");
        forever begin
            @(posedge clk_in);
            #1; // Wait for signals to settle
            $display("%0t\t%h\t%h\t%h\t%b\t%b", 
                     $time, uut.pc, uut.instr, uut.opcode, 
                     uut.stall, uut.flush_ifid);
        end
    end
    
    // Task to display register file contents
    task display_registers;
        integer i;
        begin
            $display("Register File:");
            for (i = 0; i < 8; i = i + 1) begin
                $display("  R%0d = 0x%02h (%3d)", i, 
                        uut.RF.regs[i], uut.RF.regs[i]);
            end
        end
    endtask
    
    // Task to display pipeline stages
    task display_pipeline_state;
        begin
            $display("\n--- Pipeline State at Time=%0t ---", $time);
            $display("Buffered Clock Active: %b", uut.clk);
            $display("Synchronized Reset: %b", uut.reset_n);
            
            $display("IF Stage:");
            $display("  PC = 0x%04h, Instruction = 0x%04h", uut.pc, uut.instr);
            
            $display("ID Stage:");
            $display("  Instruction = 0x%04h, Opcode = 0x%h", uut.id_instr, uut.opcode);
            $display("  RS1 = R%0d, RS2 = R%0d, RD = R%0d", uut.rs1, uut.rs2, uut.rd);
            
            $display("EX Stage:");
            $display("  ALU Op = 0x%h, ALU Result = 0x%02h", uut.ex_aluop, uut.alu_y_pipe);
            $display("  RD = R%0d, Forward A=%b, Forward B=%b", 
                     uut.ex_rd, uut.forwardA, uut.forwardB);
            
            $display("MEM Stage:");
            $display("  ALU Result = 0x%02h, RD = R%0d", uut.mem_alu_y, uut.mem_rd);
            $display("  MemRead = %b, MemWrite = %b", uut.mem_memread, uut.mem_memwrite);
            
            $display("WB Stage:");
            $display("  Writeback Data = 0x%02h, RD = R%0d", uut.writeback_data, uut.wb_rd);
            $display("  RegWrite = %b", uut.wb_regwrite);
            $display("--------------------------------\n");
        end
    endtask
    
    // Periodic pipeline state display
    initial begin
        #100; 
        repeat(15) begin
            @(posedge clk_in);
            #2; 
            display_pipeline_state();
            repeat(1) @(posedge clk_in); 
        end
    end
    
    // Hazard detection monitoring
    initial begin
        @(posedge reset_n_in);
        @(posedge uut.reset_n); 
        forever begin
            @(posedge clk_in);
            #1;
            if (uut.stall)
                $display(">>> Time=%0t: HAZARD DETECTED - Pipeline Stalled <<<", $time);
            if (uut.branch_taken)
                $display(">>> Time=%0t: BRANCH TAKEN - Flushing Pipeline <<<", $time);
        end
    end
    
    // Monitor writebacks
    initial begin
        @(posedge reset_n_in);
        @(posedge uut.reset_n);
        #50; 
        
        $display("\n--- Monitoring Register Writebacks ---");
        forever begin
            @(posedge clk_in);
            #1;
            if (uut.wb_regwrite && uut.wb_rd != 3'b000) begin
                $display("Time=%0t: Writeback R%0d <= 0x%02h (%3d)", 
                        $time, uut.wb_rd, uut.writeback_data, uut.writeback_data);
            end
        end
    end
    
    // Memory operations monitor
    initial begin
        @(posedge reset_n_in);
        @(posedge uut.reset_n);
        #50;
        
        forever begin
            @(posedge clk_in);
            #1;
            if (uut.mem_memwrite) begin
                $display("Time=%0t: MEM WRITE: Addr=0x%02h, Data=0x%02h", 
                        $time, uut.mem_alu_y, uut.mem_rd2);
            end
            if (uut.mem_memread) begin
                $display("Time=%0t: MEM READ: Addr=0x%02h", 
                        $time, uut.mem_alu_y);
            end
        end
    end
    
    // Watchdog timer
    initial begin
        #100000; // 100 microseconds timeout
        $display("\n*** WATCHDOG TIMEOUT ***");
        $display("Simulation exceeded maximum time limit");
        $finish;
    end

endmodule
