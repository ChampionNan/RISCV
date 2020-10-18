`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: USTC ESLAB
// Engineer: Huang Yifan (hyf15@mail.ustc.edu.cn)
// 
// Design Name: RV32I Core
// Module Name: Hazard Module
// Tool Versions: Vivado 2017.4.1
// Description: Hazard Module is used to control flush, bubble and bypass
// 
//////////////////////////////////////////////////////////////////////////////////

//  鍔熻兘璇存槑
    //  璇嗗埆娴佹按绾夸腑鐨勬暟鎹啿绐侊紝鎺у埗鏁版嵁杞彂锛屽拰flush銆乥ubble淇″彿
// 杈撳叆
    // rst               CPU鐨剅st淇″彿
    // reg1_srcD         ID闃舵鐨勬簮reg1鍦板潃
    // reg2_srcD         ID闃舵鐨勬簮reg2鍦板潃
    // reg1_srcE         EX闃舵鐨勬簮reg1鍦板潃
    // reg2_srcE         EX闃舵鐨勬簮reg2鍦板潃
    // reg_dstE          EX闃舵鐨勭洰鐨剅eg鍦板潃
    // reg_dstM          MEM闃舵鐨勭洰鐨剅eg鍦板潃
    // reg_dstW          WB闃舵鐨勭洰鐨剅eg鍦板潃
    // br                鏄惁branch
    // jalr              鏄惁jalr
    // jal               鏄惁jal
    // src_reg_en        鎸囦护涓殑婧恟eg1鍜屾簮reg2鍦板潃鏄惁鏈夋晥
    // wb_select         鍐欏洖瀵勫瓨鍣ㄧ殑鍊肩殑鏉ユ簮锛圕ache鍐呭鎴栵拷?锟紸LU璁＄畻缁撴灉锟??
    // reg_write_en_MEM  MEM闃舵鐨勫瘎瀛樺櫒鍐欎娇鑳戒俊锟??
    // reg_write_en_WB   WB闃舵鐨勫瘎瀛樺櫒鍐欎娇鑳戒俊锟??
    // alu_src1          ALU鎿嶄綔锟??1鏉ユ簮锟??0琛ㄧず鏉ヨ嚜reg1锟??1琛ㄧず鏉ヨ嚜PC
    // alu_src2          ALU鎿嶄綔锟??2鏉ユ簮锟??2鈥檅00琛ㄧず鏉ヨ嚜reg2锟??2'b01琛ㄧず鏉ヨ嚜reg2鍦板潃锟??2'b10琛ㄧず鏉ヨ嚜绔嬪嵆锟??
// 杈撳嚭
    // flushF            IF闃舵鐨刦lush淇″彿
    // bubbleF           IF闃舵鐨刡ubble淇″彿
    // flushD            ID闃舵鐨刦lush淇″彿
    // bubbleD           ID闃舵鐨刡ubble淇″彿
    // flushE            EX闃舵鐨刦lush淇″彿
    // bubbleE           EX闃舵鐨刡ubble淇″彿
    // flushM            MEM闃舵鐨刦lush淇″彿
    // bubbleM           MEM闃舵鐨刡ubble淇″彿
    // flushW            WB闃舵鐨刦lush淇″彿
    // bubbleW           WB闃舵鐨刡ubble淇″彿
    // op1_sel           ALU鐨勬搷浣滄暟1鏉ユ簮锟??2'b00琛ㄧず鏉ヨ嚜ALU杞彂鏁版嵁锟??2'b01琛ㄧず鏉ヨ嚜write back data杞彂锟??2'b10琛ㄧず鏉ヨ嚜PC锟??2'b11琛ㄧず鏉ヨ嚜reg1
    // op2_sel           ALU鐨勬搷浣滄暟2鏉ユ簮锟??2'b00琛ㄧず鏉ヨ嚜ALU杞彂鏁版嵁锟??2'b01琛ㄧず鏉ヨ嚜write back data杞彂锟??2'b10琛ㄧず鏉ヨ嚜reg2鍦板潃锟??2'b11琛ㄧず鏉ヨ嚜reg2鎴栫珛鍗虫暟
    // reg2_sel          reg2鐨勬潵锟??
// 瀹為獙瑕佹眰
    // 琛ュ叏妯″潡

module HarzardUnit(
    input wire rst,
    input wire [4:0] reg1_srcD, reg2_srcD, reg1_srcE, reg2_srcE, reg_dstE, reg_dstM, reg_dstW,
    input wire br, jalr, jal,
    input wire [1:0] src_reg_en,
    input wire wb_select,
    input wire reg_write_en_EX,
    input wire reg_write_en_MEM,
    input wire reg_write_en_WB,
    input wire cache_write_en_EX,
    input wire alu_src1,
    input wire [1:0] alu_src2,
    input wire Cachemiss,
    output reg flushF, bubbleF, flushD, bubbleD, flushE, bubbleE, flushM, bubbleM, flushW, bubbleW,
    output reg [1:0] op1_sel, op2_sel, reg2_sel
    );
    
    // TODO: Complete this module
    always @ (*)
        begin
             if (rst)
            begin
             flushF <= 1'b1; bubbleF <= 1'b0;
             flushD <= 1'b1; bubbleD <= 1'b0;
             flushE <= 1'b1; bubbleE <= 1'b0;
             flushM <= 1'b1; bubbleM <= 1'b0;
             flushW <= 1'b1; bubbleW <= 1'b0;
             end             
             else if (Cachemiss) 
                begin
                    flushF <= 1'b0; bubbleF <= 1'b1;
                    flushD <= 1'b0; bubbleD <= 1'b1;
                    flushE <= 1'b0; bubbleE <= 1'b1;
                    flushM <= 1'b0; bubbleM <= 1'b1;
                    flushW <= 1'b0; bubbleW <= 1'b1;                    
                end
            else 
            begin
                if (br || jalr)
                    begin
                        flushF <= 1'b0; bubbleF <= 1'b0;
                        flushD <= 1'b1; bubbleD <= 1'b0;
                        flushE <= 1'b1; bubbleE <= 1'b0;
                        flushM <= 1'b0; bubbleM <= 1'b0;
                        flushW <= 1'b0; bubbleW <= 1'b0;                    
                    end                
            else if (wb_select && ((reg_dstE == reg1_srcD) || (reg_dstE == reg2_srcD) && reg_dstE != 5'b0 ))
                begin
                    flushF <= 1'b0; bubbleF <= 1'b1;
                    flushD <= 1'b0; bubbleD <= 1'b1;
                    flushE <= 1'b1; bubbleE <= 1'b0;
                    flushM <= 1'b0; bubbleM <= 1'b0;
                    flushW <= 1'b0; bubbleW <= 1'b0;
                end
            else if (jal)
                begin
                    flushF <= 1'b0; bubbleF <= 1'b0;
                    flushD <= 1'b1; bubbleD <= 1'b0;
                    flushE <= 1'b0; bubbleE <= 1'b0;
                    flushM <= 1'b0; bubbleM <= 1'b0;
                    flushW <= 1'b0; bubbleW <= 1'b0;                    
                end
            else 
                begin
                    flushF <= 1'b0; bubbleF <= 1'b0;
                    flushD <= 1'b0; bubbleD <= 1'b0;
                    flushE <= 1'b0; bubbleE <= 1'b0;
                    flushM <= 1'b0; bubbleM <= 1'b0;
                    flushW <= 1'b0; bubbleW <= 1'b0;                    
                end
            if ((src_reg_en[1] == 1'b1) && (reg_write_en_MEM) && (reg_dstM != 5'b0) && (reg1_srcE == reg_dstM))
                op1_sel <= 2'b00;
            else if ((src_reg_en[1] == 1'b1) && (reg_write_en_WB) && (reg_dstW != 5'b0) && (reg1_srcE == reg_dstW) )
                op1_sel <= 2'b01;
            else if (alu_src1 == 1'b0)
                op1_sel <= 2'b11;
            else if (alu_src1 == 1'b1)
                op1_sel <= 2'b10;

            if ((src_reg_en[0] == 1'b1) && (reg_write_en_MEM) && (reg_dstM != 5'b0) && (reg2_srcE == reg_dstM) && !cache_write_en_EX)
                op2_sel <= 2'b00;
            else if ((src_reg_en[0] == 1'b1) && (reg_write_en_WB) && (reg_dstW != 5'b0) && (reg2_srcE == reg_dstW) && !cache_write_en_EX)
                op2_sel <= 2'b01;
            else if (alu_src2 == 2'b00 || alu_src2 == 2'b10)
                op2_sel <= 2'b11;
            else if (alu_src2 == 2'b01)
                op2_sel <= 2'b10;

            if ((src_reg_en[0] == 1'b1) && (reg_write_en_MEM) && (reg_dstM != 5'b0) && (reg2_srcE == reg_dstM))
                reg2_sel <= 2'b00;
            else if ((src_reg_en[0] == 1'b1) && (reg_write_en_WB) && (reg_dstW != 5'b0) && (reg2_srcE == reg_dstW))
                reg2_sel <= 2'b01;
            else 
                reg2_sel <= 2'b10;	    
        end
                
    end


//=======================================================================================================
//op1_sel
// src_reg_en        鎸囦护涓璼rc reg鐨勫湴锟??鏄惁鏈夋晥锛宻rc_reg_en[1] == 1琛ㄧずreg1琚娇鐢ㄥ埌浜嗭紝src_reg_en[0]==1琛ㄧずreg2琚娇鐢ㄥ埌锟??
    //always @ (*)
        
//=======================================================================================================
//op2_sel
//    always @ (*)
        

//=======================================================================================================
//reg2_sel
  //  always @ (*)
        
endmodule
//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: USTC ESLAB
// Engineer: Huang Yifan (hyf15@mail.ustc.edu.cn)
// 
// Design Name: RV32I Core
// Module Name: Hazard Module
// Tool Versions: Vivado 2017.4.1
// Description: Hazard Module is used to control flush, bubble and bypass
// 
//////////////////////////////////////////////////////////////////////////////////

//  功能说明
    //  识别流水线中的数据冲突，控制数据转发，和flush、bubble信号
// 输入
    // rst               CPU的rst信号
    // reg1_srcD         ID阶段的源reg1地址
    // reg2_srcD         ID阶段的源reg2地址
    // reg1_srcE         EX阶段的源reg1地址
    // reg2_srcE         EX阶段的源reg2地址
    // reg_dstE          EX阶段的目的reg地址
    // reg_dstM          MEM阶段的目的reg地址
    // reg_dstW          WB阶段的目的reg地址
    // br                是否branch
    // jalr              是否jalr
    // jal               是否jal
    // src_reg_en        指令中的源reg1和源reg2地址是否有效
    // wb_select         写回寄存器的值的来源（Cache内容(=1或者ALU计算结果）
    // reg_write_en_MEM  MEM阶段的寄存器写使能信号
    // reg_write_en_WB   WB阶段的寄存器写使能信号
    // alu_src1          ALU操作数1来源：0表示来自reg1，1表示来自PC
    // alu_src2          ALU操作数2来源：2'b00表示来自reg2，2'b01表示来自reg2地址，2'b10表示来自立即数
// 输出
    // flushF            IF阶段的flush信号
    // bubbleF           IF阶段的bubble信号
    // flushD            ID阶段的flush信号
    // bubbleD           ID阶段的bubble信号
    // flushE            EX阶段的flush信号
    // bubbleE           EX阶段的bubble信号
    // flushM            MEM阶段的flush信号
    // bubbleM           MEM阶段的bubble信号
    // flushW            WB阶段的flush信号
    // bubbleW           WB阶段的bubble信号
    // op1_sel           ALU的操作数1来源：2'b00表示来自ALU转发数据，2'b01表示来自write back data转发，2'b10表示来自PC，2'b11表示来自reg1
    // op2_sel           ALU的操作数2来源：2'b00表示来自ALU转发数据，2'b01表示来自write back data转发，2'b10表示来自reg2地址，2'b11表示来自reg2或立即数
    // reg2_sel          reg2的来源
// 实验要求
    // 补全模块

/*
module HarzardUnit(
    input wire rst,
    input wire [4:0] reg1_srcD, reg2_srcD, reg1_srcE, reg2_srcE, reg_dstE, reg_dstM, reg_dstW,
    input wire br, jalr, jal,
    input wire [1:0] src_reg_en,
    input wire wb_select,
    input wire reg_write_en_EX,
    input wire reg_write_en_MEM,
    input wire reg_write_en_WB,
    input wire cache_write_en_EX,
    input wire alu_src1,
    input wire [1:0] alu_src2,
    input wire Cachemiss,
    output reg flushF, bubbleF, flushD, bubbleD, flushE, bubbleE, flushM, bubbleM, flushW, bubbleW,
    output reg [1:0] op1_sel, op2_sel, reg2_sel
    );

    // TODO: Complete this module
	always@(*) begin
		flushF <= rst;//IF寄存器（PC寄存器）只有初始化时需要清空
		flushD <= rst || (br|| jalr|| jal);//ID寄存器（处于IF/ID之间的寄存器）在发生3种跳转时清空
		flushE <= rst || (wb_select && (reg_dstE == reg1_srcD || reg_dstE == reg2_srcD)) || (br || jalr);//EX寄存器在发生2种跳转和无法转发的数据相关时清空
		flushM <= rst;//MEM寄存器（处于EX/MEM之间的寄存器）只有初始化时需要清空
		flushW <= rst;//WB寄存器（处于MEM/WB之间的寄存器）只有初始化时需要清空
		bubbleF <= ~rst && (wb_select && (reg_dstE == reg1_srcD || reg_dstE == reg2_srcD));
		bubbleD <= ~rst && (wb_select && (reg_dstE == reg1_srcD || reg_dstE == reg2_srcD));
		bubbleE <= 1'b0;
		bubbleM <= 1'b0;
		bubbleW <= 1'b0;
	end


	always@(*) begin
		// op1_sel           ALU的操作数1来源：2'b00表示来自ALU转发数据，2'b01表示来自write back data转发，2'b10表示来自PC，2'b11表示来自reg1
        // op2_sel           ALU的操作数2来源：2'b00表示来自ALU转发数据，2'b01表示来自write back data转发，2'b10表示来自reg2地址，2'b11表示来自reg2或立即数
        // reg2_sel          reg2的来源
        // src_reg_en[1] == 1表示reg1被使用到了，src_reg_en[0]==1表示reg2被使用到了
		
        //Forward Register Source 1
        op1_sel[0] <= ~(reg_dstM != 0 && reg_write_en_MEM && src_reg_en[1] && (reg_dstM == reg1_srcE));
        op1_sel[1] <= ~((reg_dstM != 0 && reg_write_en_MEM && src_reg_en[1] && (reg_dstM == reg1_srcE)) || (reg_dstW !=0 && reg_write_en_WB && src_reg_en[1] && (reg_dstW == reg1_srcE)));
		
        //Forward Register Source 2
        op2_sel[0] <= ~(reg_dstM != 0 && reg_write_en_MEM && src_reg_en[0] && (reg_dstM == reg2_srcE));
        op2_sel[1] <= ~((reg_dstM != 0 && reg_write_en_MEM && src_reg_en[0] && (reg_dstM == reg2_srcE)) || (reg_dstW !=0 && reg_write_en_WB && src_reg_en[0] && (reg_dstW == reg1_srcE)));
		
        //Forward Register2
        reg2_sel[0] <= ~(reg_dstM != 0 && reg_write_en_MEM && src_reg_en[0] && (reg_dstM == reg2_srcE));
        reg2_sel[1] <= ~((reg_dstM != 0 && reg_write_en_MEM && src_reg_en[0] && (reg_dstM == reg2_srcE)) || (reg_dstW !=0 && reg_write_en_WB && src_reg_en[0] && (reg_dstW == reg2_srcE)));
    end
endmodule*/