# -----------------------------------------------------------
# test part1
.section .text;
.align 6;
.global _start;

_start:

test_o:
addi zero, zero, 0; # zero =zero1 + 0
addi x1, zero, 0x00000007; # x1 = 0 + 7 = 7
addi x23, zero, -1; # x23 = 0xf0000003
addi x24, zero, 0x00000002;# x24=2

test_1:
slli x2, x23, 0x00000001; #x2

test_2:
srli x3, x23, 0x00000001;#x3:

test_3:
srai x4, x23, 0x00000001;#x4:

test_4:
add x5, x1, x2; # x5 =x1 +x2=0xe000000d

test_5:
sub x6, x1, x3; # x6 =x1 - x3

test_6:
sll x7, x1, x24;# x7=0x1c

test_7:
slt x8, x1, x2 ;# x8=0

test_8:
sltu x9, x1, x2; # x9=1

test_9:
xor x10, x1, zero; # x10=7

test_10:
srl x11, x23, x24; # x23 = -1, x24 = 2, x11 = 

test_11:
sra x12, x23, x24; # x12=

test_12:
or x13, x1, x2; # x13

test_13:
and x14, x1, x2; # x14

test_14:
addi x15, x1, 0x00000001; # x15 = x1 + 1=8

test_15:
slti x16, x1, -1; # x16 = 0

test_16:
sltiu x17, x1, -1; # x17=1

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






