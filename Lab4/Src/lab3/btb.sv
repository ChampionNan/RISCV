`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: USTC ESLAB
// Engineer: Bingnan Chen (cbn990512@mail.ustc.edu.cn)
// 
// Design Name: RV32I Core
// Module Name: btb.sv
// Tool Versions: Vivado 2017.4.1
// Description: one-bit prediction file
//////////////////////////////////////////////////////////////////////////////////


//功能说明
    // 实现1-bit分支预测器
//实验要求  
    // 自行设计

module btb # (
    parameter ENTRY_NYM = 64;//BTB大小
)(
    input clk, 
    input rst, 
    input [31:0] PC_IF, 
    input [31:0] PC_EX, 
    input [31:0] br_target, 
    input br, 
    input [6:0] Opcode_EX, 
    output reg [31:0] PredictPC, //PC预测结果
    output reg PredictF      //预测结果有效
);
//分支Opcode
localparam BR_OP = 7'b110_0011; 
//Buffer define
reg [31:0] BranchTagAddress[ENTRY_NYM - 1 : 0]; 
reg [31:0] BranchTargetAddress[ENTRY_NYM - 1 : 0]; 
reg Valid[ENTRY_NYM - 1 : 0]; 
//FIFO Index
reg [15 : 0] Index; 
//Produce PredictPC
always @ (*) begin
    if (rst) begin
        PredictPC <= 32'b0; 
        PredictF <= 1'b0; 
    end
    else begin
        PredictPC <= 32'b0; 
        PredictValid <= 1'b0; 
        for (integer i = 0; i < ENTRY_NYM ; i++ ) begin
            if ((PC_IF == BranchTagAddress[i]) && Valid[i]) begin
                PredictF <= 1'b1; 
                PredictPC <= BranchTargetAddress[i]; 
            end
        end
    end
end 
//Renew Buffer
always @ (posedge clk or posedge rst) begin
    if (rst) begin
        for (integer i = 0; i < ENTRY_NYM ; i++ ) begin
            Valid[i] <= 1'b0; 
            BranchTagAddress[i] <= 32'd0; 
            BranchTargetAddress[i] <= 32'd0; 
        end
        Index <= 16'd0; 
    end
    else begin
        if (Opcode_EX == BR_OP) begin
            integer i; 
            for (i = 0; i < ENTRY_NYM; i++) begin
                if (PC_EX == BranchTagAddress[i]) begin
                    BranchTargetAddress[i] <= br_target; 
                    Valid[i] <= br; 
                    break; 
                end
            end
            if (i == ENTRY_NUM) begin
                BranchTargetAddress[Index] <= br_target; 
                Valid[Index] <= br; 
                BranchTagAddress[Index] <= PC_EX; 
                Index = Index + 1; 
            end
        end
    end
end
endmodule