// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
//
// This program only needs to handle arguments that satisfy
// R0 >= 0, R1 >= 0, and R0*R1 < 32768.

@R1
D = M
@i
M = D
// i = RAM[1]

@result
M = 0
// result = 0

(LOOP)
@i
D = M
@LOOP_END
D; JLE
// end if i <= 0

@R0
D = M
@result
M = M + D
// result += RAM[0]

@i
M = M - 1
// i -= 1

@LOOP
0; JMP

(LOOP_END)

@result
D = M
@R2
M = D
// RAM[2] = result

(EXIT)
@EXIT
0; JMP
