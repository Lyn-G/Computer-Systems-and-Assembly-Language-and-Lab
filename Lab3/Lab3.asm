# # #
# Created by:	Goh, Lynelle
#		ljgoh
#		6 May 2022
# Assignment:	Lab 3: Looping in RISC-V Assembly
#		CSE 12, Computer Systems and Assembly Language and Lab
# 		UC Santa Cruz, Spring 2022
#
# Description:	1. Program will first prompt for the height of the pattern. If the user enters an invalid 
#		input, such as a negative number or zero, an error message will be printed and
#		the user will be prompted again.
#		2. Then the program prints the following pattern using numbers, asterisks, and
#		dollar signs.
#
# Notes: 	RISC-V assembly language programming using RARS.
# # #

# This program first prompts for the height of the pattern.
# If an invalid input is entered, such as a negative number or zero, an error message will be printed and the user will be prompted again.
# If a valid input is entered, the program will print the same number of lines of pattern that was inputted. For example, inputting 3 will output 3 lines of pattern.
# On each of these lines are a pattern of $, *, and an odd number. 
# The pattern starts with $ and the amount on each line corresponds to what line number it is on. 
# Following that is *, but it will only start on and after line 2. The amount of each one corresponds to what line number it is on minus one.
# $ and * are used in the main pattern, the $ being placed first and at the end.  
# The odd number is at the very end of the pattern on each line. It starts with 1 and increases by 2 each line.

#macro (this was taken from multiply.asm that was given to us in the Google Drive)
.macro exit #macro to exit program
		li a7, 10
		ecall
		.end_macro	

.macro print_str(%string1) #macro to print any string
	li a7,4 
	la a0, %string1
	ecall
	.end_macro
	
.macro print_int (%x)  #macro to print any integer or register
	li a7, 1
	add a0, zero, %x
	#zero here refers to register #0
	#the zero register always has constant value of 0
	ecall
	.end_macro
	
#data section of memory
.data
	ask: .asciz "Enter the height of the pattern (must be greater than 0):"
	error: .asciz "Invalid Entry!"
	dollar_sign: .asciz "$"
	asterisk: .asciz "*"
	newline: .asciz  "\n"
	
.text

#begins the program
main:
	print_str(ask)	#asks for input
	li a7, 5	
	ecall 		
	
	addi t0, a0, 0	#set t0 to the input value
	
	#setting up initial loop values
	li t2, 0
	li t4, 0
	li t5, 1
	
	li t6, 1	#set up the beginning odd number
	
#prints out the error message if the input is less than 1
invalid:
	bge t0, t6, loop_body1	#executes loop body if input is less than 1
	print_str(error)
	print_str(newline)
	blt t0, t6, main 	#goes back to main to prompt the user to input a value

#sets the counter (for repeating $ and * after the 2nd line) to 0
return: 
	li t4, 0

#print dollar signs
loop_body1:
	bge t2, t0, loop_exit
	
	print_str(dollar_sign)

#print asterisks	
loop_body2:
	blt t2, t5, loop_body4	#doesn't add an asterisk on the first line of output
	
	print_str(asterisk)
	
	#adds 1 to counter and loops back to print out more dollar signs & asterisks
	addi t4, t4, 1		
	blt t4, t2, loop_body1	
	
#print another dollar sign when output reaches line 2 and above
loop_body3: 
	blt t0, t5, loop_body4 
	print_str(dollar_sign)
	
#print the odd numbers at the end of each line
loop_body4:
	bge t2, t0, loop_exit
	print_int(t6)
	addi t6, t6, 2
	
#print the newline
loop_body5:
	bge t2, t0, loop_exit
	print_str(newline)
	
#update the main loop counter (t2) by 1
loop_update:
	addi t2, t2, 1
	
	b return
	
#finished
loop_exit:
exit
