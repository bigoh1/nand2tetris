// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.
    // ==== INIT ====
    @8192
    D = A
    @SCREEN
    D = A + D
    @end
    M = D
    // end points to the next register after the frame buffer
    // end = 69576

    @screen_colour
    M = 0
    // screen_colour stores in what colour the display is colored
    // screen_colour = 0

    @to_fill
    M = 0
    // to_fill stores in what colour the display should be colored next time
    // to_fill = 0

(LOOP)
    @to_fill
    D = M
    @screen_colour
    M = D
    // screen_colour = to_fill

    @SCREEN
    D = A
    @iter
    M = D
    // iter points to the first register of the frame buffer
    // iter = SCREEN
    // ==== PROBE KEYBOARD ====
    @to_fill
    M = 0
    // set default value
    // to_fill = 0

    @KBD
    D = M
    @NO_KEY
    D; JEQ
    // goto NO_KEY if no key is pressed

    @to_fill
    M = -1
    // if a key is pressed, paint the display in black
    // to_fill = 0b11..1
(NO_KEY)

    @to_fill
    D = M
    @diff
    M = D
    @screen_colour
    D = M
    @diff
    M = M - D
    D = M
    // diff = to_fill - screen_colour
    
    @LOOP
    D; JEQ
    // if the state didn't change, do nothing

(DRAW_LOOP)
    @end
    D = M
    @diff
    M = D
    @iter
    D = M
    @diff
    M = M - D
    D = M
    // diff = end - iter

    @LOOP
    D; JLT
    // goto LOOP if iter > end
    
    @to_fill
    D = M
    @iter
    A = M
    M = D
    // *iter = to_fill

    @iter
    M = M + 1
    // iter += 1

    @DRAW_LOP
    0; JMP

