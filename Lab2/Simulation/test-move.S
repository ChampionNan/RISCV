# -----------------------------------------------------------
# test part1
.section .text;
.align 6;
.global _start;

_start:

test_o:
addi zero, zero, 0; # zero =zero1 + 0
addi x1, zero, 0x00000007; # x1 = 0 + 7 = 7

test_1:
slli x2, x1, 0x00000001; #x2:0x

test_2:
srli x3, x1, 0x00000001;#x3:3

test_3:
srai x4, x1, 0x00000001;#x4:3

test_4:
add x5, x1, t2; # x5 =x1 +x2=21***********

test_5:
sub x6, x1, x3; # x6 =x1 - x3=4

test_6:
sll x7, x1, x3;# x7=0

test_7:
slt x8, x1, x2 ;# x8=1

test_8:
sltu x9, x1, x2; # x9=1

test_9:
xor x10, x1, zero; # x10=7

test_10:
srl x11, x1, x3; # x11=0

test_11:
sra x12, x1, x3; # x12=0

test_12:
or x13, x1, x2; # x13=15

test_13:
and x14, x1, x2; # x14=6

test_14:
addi x15, x1, 0x00000001; # x15 = x1 + 1=8

test_15:
slti x16, x1, 0x00000008; # x16 = 1

test_16:
sltiu x17, x1, 0x00000008; # x17=1

test_17:
xori x18, x1, 0x00000008; # x18=15

test_18:
ori x19, x1, 0x000000010; # x19=0x00000017

test_19:
andi x20, x1, 0x00000001; # x20=0x00000001

test_20:
lui x21, 0xfffff; # x21=0xfffff

test_21:
auipc x22, 0x00004; # pc=pc+4






