#in this section of code, you must direct the new position of the pixel based on the label we branched to in lab4.asm

#remember at this point, (x,y) coordinates are in a0,a1 registers respectively
#do the appropriate change in a0 a1 values based on the labels below.

#within each label, make sure to jump to the correct label in  lab4.asm file. 
#This is so that exactly one of the labels moveleft,moveright, movedown, moveup is executed depending on which key user enetered as defined in lab4.asm

#NOTE: To make sure you ONLY use a0,a1 registers in your instructions below. There is no need to involve any other rgeister in this section of code!

moveleft:
	addi a0,a0,-1
	j newPosition
movedown:
	addi a1,a1,1
	j newPosition
	
moveright:
	addi a0,a0,1
	j newPosition
	
moveup:
	addi a1,a1,-1
	j newPosition
	
moveDiagonalLeftUp:
	addi a0,a0,-1
	addi a1,a1,-1
	j newPosition
 	
moveDiagonalLeftDown:
	addi a0,a0,-1
	addi a1,a1,1
	j newPosition
 	
moveDiagonalRightUp:
	addi a0,a0,1
	addi a1,a1,-1
	j newPosition
	
moveDiagonalRightDown:
	addi a0,a0,1
	addi a1,a1,1
	j newPosition