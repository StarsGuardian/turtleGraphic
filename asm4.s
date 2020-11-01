.text 
.globl turtle_init
# for i in range(len(array)):
#	if i < 4:
#		array[i] = 0
#	elif i = 4:
# 		array[i] = a1
#	elif i = 8:
#		array[i] = 0
turtle_init:
addiu $sp, $sp, -24		# allocate stack space -- default of 24 here
sw $fp, 0($sp)			# allocate stack space -- default of 24 here
sw $ra, 4($sp)			# save return address
addiu $fp, $sp, 20		# setup main's frame pointer

sb $zero, 0($a0)		# reset x to zero
sb $zero, 1($a0)		# reset y to zero
sb $zero, 2($a0)		# reset dir to zero
sb $zero, 3($a0)		# reset pad to zero	
sw $a1, 4($a0)			# reset name to given name
sw $zero, 8($a0)		# reset odom to zero

lw $ra, 4($sp)			# standard epilogue
lw $fp, 0($sp)
addiu $sp, $sp, 24
jr $ra

.text
.globl turtle_debug
# print("Turtle " + array[4])
# print("pos " + array[0] + array[1])
# if array[2] == 0:
#	print("dir " + north)
# elif array[2] == 1:
#	print("dir " + east)
# elif array[2] == 2:
# 	print("dir " + south)
# else:
#	print("dir " + west)
# print("odometer " + array[8])
turtle_debug:
addiu $sp, $sp, -24		# allocate stack space -- default of 24 here
sw $fp, 0($sp)			# allocate stack space -- default of 24 here
sw $ra, 4($sp)			# save return address
addiu $fp, $sp, 20		# setup main's frame pointer

.data
turtle: .asciiz "Turtle "
pos: .asciiz "  pos "
dir: .asciiz "  dir "
odometer: .asciiz "  odometer "
newline: .asciiz "\n"
comma: .asciiz ","
north: .asciiz "North"
east: .asciiz "East"
south: .asciiz "South"
west: .asciiz "West"
quot: .word '"' 

.text
add $t6, $zero, $zero		# represent north
addi $t7, $zero, 1		# represent east
addi $t8, $zero ,2		# represent south
addi $t9, $zero, 3		# represent west

.text
add $t0, $a0, $zero		# store $a0 to $t0

addi $v0, $zero, 4
la $a0, turtle			# print Turtle	
syscall				# print Turtle

addi $v0, $zero, 4
la $a0, quot			# print quotation marks
syscall				# print quotation marks

addi $v0, $zero, 4
lw $t1, 4($t0)
add $a0, $zero, $t1		# print name
syscall				# print name

addi $v0, $zero, 4
la $a0, quot			# print quotation marks
syscall				# print quotation marks

addi $v0, $zero, 4
la $a0, newline			# print newline
syscall				# print newline

addi $v0, $zero, 4
la $a0, pos			# print pos
syscall				# print pos

addi $v0, $zero, 1
lb $a0, 0($t0)			# print x coordinate
syscall				# print x coordinate

addi $v0, $zero, 4
la $a0, comma			# print comma
syscall				# print comma

addi $v0, $zero, 1
lb $a0, 1($t0)			# print y coordinate
syscall				# print y coordinate

addi $v0, $zero, 4
la $a0, newline			# print newline
syscall				# print newline

addi $v0, $zero, 4	
la $a0, dir			# print dir
syscall				# print dir

lb $a0, 2($t0)
beq $a0, $t6, North
beq $a0, $t7, East
beq $a0, $t8, South
beq $a0, $t9, West

North:
addi $v0, $zero, 4
la $a0, north			# print direction	
syscall				# print direction
j end

East:
addi $v0, $zero, 4
la $a0, east			# print direction	
syscall				# print direction
j end

South:
addi $v0, $zero, 4
la $a0, south			# print direction	
syscall				# print direction
j end

West:
addi $v0, $zero, 4
la $a0, west			# print direction	
syscall				# print direction
j end

end:
addi $v0, $zero, 4
la $a0, newline			# print newline
syscall				# print newline

addi $v0, $zero, 4		# print odometer
la $a0, odometer		# print odometer
syscall

addi $v0, $zero, 1
lw $t1, 8($t0)		
add $a0, $zero, $t1		# print odometer
syscall				# print odometer

addi $v0, $zero, 4
la $a0, newline			# print newline
syscall				# print newline

addi $v0, $zero, 4
la $a0, newline			# print newline
syscall				# print newline

lw $ra, 4($sp)			# standard epilogue
lw $fp, 0($sp)
addiu $sp, $sp, 24
jr $ra

.text
.globl turtle_turnLeft
# if parameter == 0:
#	array[2] = 3
# elif parameter == 1:
#	array[2] = 0
# elif parameter == 2:
#	array[2] = 1
# elif parameter == 3:
#	array[2] = 2
turtle_turnLeft:
addiu $sp, $sp, -24		# allocate stack space -- default of 24 here
sw $fp, 0($sp)			# allocate stack space -- default of 24 here
sw $ra, 4($sp)			# save return address
addiu $fp, $sp, 20		# setup main's frame pointer

add $t0, $zero, $zero		# represent north
addi $t1, $zero, 1		# represent east
addi $t2, $zero ,2		# represent south
addi $t3, $zero, 3		# represent west

lb $t4, 2($a0)			# get current direction
beq $t4, $t0, NtoW		# when facing north, turns left to west
beq $t4, $t1, EtoN		# when facing east, turns left to north
beq $t4, $t2, StoE		# when facing south, turns left to east
beq $t4, $t3, WtoS		# when facing west, turns left to south

NtoW:
addi $t1, $zero, 3
sb $t1, 2($a0)			# update direction to west
j done

EtoN:
add $t1, $zero, $zero
sb $t1, 2($a0)			# update direction to north
j done

StoE:
addi $t1, $zero, 1
sb $t1, 2($a0)			# update direction to east
j done

WtoS:
addi $t1, $zero, 2
sb $t1, 2($a0)			# update direction to south
j done

done:

lw $ra, 4($sp)			# standard epilogue
lw $fp, 0($sp)
addiu $sp, $sp, 24
jr $ra

.text
.globl turtle_turnRight
# if parameter == 0:
#	array[2] = 1
# elif parameter == 1:
#	array[2] = 2
# elif parameter == 2:
#	array[2] = 3
# elif parameter == 3:
#	array[2] = 0
turtle_turnRight:
addiu $sp, $sp, -24		# allocate stack space -- default of 24 here
sw $fp, 0($sp)			# allocate stack space -- default of 24 here
sw $ra, 4($sp)			# save return address
addiu $fp, $sp, 20		# setup main's frame pointer

add $t0, $zero, $zero		# represent north
addi $t1, $zero, 1		# represent east
addi $t2, $zero ,2		# represent south
addi $t3, $zero, 3		# represent west

lb $t5, 2($a0)
beq $t5, $t0, NtoE		# when facing north, turns right to east
beq $t5, $t1, EtoS		# when facing east, turns right to south
beq $t5, $t2, StoW		# when facing south, turns right to west
beq $t5, $t3, WtoN		# when facing west, turns right to north

NtoE:
addi $t2, $zero, 1
sb $t2, 2($a0)			# update direction to east
j Done

EtoS:
addi $t2, $zero, 2
sb $t2, 2($a0)			# update direction to south
j Done

StoW:
addi $t2, $zero, 3
sb $t2, 2($a0)			# update direction to west
j Done

WtoN:
add $t2, $zero, $zero
sb $t2, 2($a0)			# update direction to north
j Done

Done:

lw $ra, 4($sp)			# standard epilogue
lw $fp, 0($sp)
addiu $sp, $sp, 24
jr $ra

.text
.globl turtle_move
turtle_move:
# if parameter_1 == 0:
#	if parameter_2 < 0:
#		array[1] = array[1] - parameter_2
#	else:
#		array[1] = array[1] + parameter_2
# elif parameter_1 == 2:
#	if parameter_2 < 0:
#		array[1] = array[1] - parameter_2
#	else:
#		array[1] = array[1] - parameter_2
# elif parameter_1 == 1:
#	if parameter_2 < 0:
#		array[0] = array[0] - parameter_2
#	else:
#		array[0] = array[0] + parameter_2
# else:
#	if parameter_2 < 0:
#		array[0] = array[1] - parameter_2
#	else:
#		array[0] = array[1] - parameter_2
addiu $sp, $sp, -24		# allocate stack space -- default of 24 here
sw $fp, 0($sp)			# allocate stack space -- default of 24 here
sw $ra, 4($sp)			# save return address
addiu $fp, $sp, 20		# setup main's frame pointer

add $t0, $zero, $zero		# represent north
addi $t1, $zero, 1		# represent east
addi $t2, $zero ,2		# represent south
addi $t3, $zero, 3		# represent west

lb $t4, 2($a0)			# get the current direction
lb $t5, 0($a0)			# get x coordinate
lb $t6, 1($a0)			# get y coordinate
lw $t9, 8($a0)			# get odometer

beq $t4, $t0, moveOnNY		# if facing to north, moving on Y coordinate
beq $t4, $t2, moveOnSY		# if facing to south, moving on Y coordinate
beq $t4, $t1, moveOnEX		# if facing to east, moving on X coordinate
beq $t4, $t3, moveOnWX		# if facing to west, moving on X coordinate

moveOnNY:
addi $t0, $zero, 10		# grid size, never changed
addi $t1, $zero, -10		# grid size, never changed
slt $t7, $zero, $a1		# check distance is pos or neg
beq $t7, $zero, NYnegMove	# if distance is neg
bne $t7, $zero, NYposMove	# if distance is pos

NYnegMove:
add $t7, $t6, $a1		# subtract distance from Y coordinate
sub $t8, $zero, $a1		# get absolute val of distance
add $t9, $t9, $t8		# add odometer
slt $t2, $t7, $t1		# check if reaches the border
bne $t2, $zero, resetNYneg	# if over the border reset coordinates
j normalNYneg		
resetNYneg:
addi $t7, $zero, -10		# reset coordinates
normalNYneg:
sb $t7, 1($a0)			# update Y coordinate
sw $t9, 8($a0)			# update odometer
j DONE

NYposMove:
add $t7, $t6, $a1		# add distance to Y coordinate
add $t9, $t9, $a1		# add odometer
slt $t2, $t7, $t0		# check if reaches the border
beq $t2, $zero, resetNYpos	# if over the border reset coordinates
j normalNYpos		
resetNYpos:
addi $t7, $zero, 10		# reset coordinates
normalNYpos:
sb $t7, 1($a0)			# update Y coordinate
sw $t9, 8($a0)			# update odometer
j DONE

moveOnSY:
addi $t0, $zero, 10		# grid size, never changed
addi $t1, $zero, -10		# grid size, never changed
slt $t7, $zero, $a1		# check distance is pos or neg
beq $t7, $zero, SYnegMove	# if distance is neg
bne $t7, $zero, SYposMove	# if distance is pos

SYnegMove:
sub $t7, $t6, $a1		# add distance to Y coordinate
sub $t8, $zero, $a1		# get absolute val of distance
add $t9, $t9, $t8		# add odometer
slt $t2, $t7, $t0		# check if reaches the border
beq $t2, $zero, resetSYneg	# if over the border reset coordinates
j normalSYneg		
resetSYneg:
addi $t7, $zero, 10		# reset coordinates
normalSYneg:
sb $t7, 1($a0)			# update Y coordinate
sw $t9, 8($a0)			# update odometer
j DONE

SYposMove:
sub $t7, $t6, $a1		# subtract distance from Y coordinate
add $t9, $t9, $a1		# add odometer
slt $t2, $t7, $t1		# check if reaches the border
bne $t2, $zero, resetSYpos	# if over the border reset coordinates
j normalSYpos		
resetSYpos:
addi $t7, $zero, -10		# reset coordinates
normalSYpos:
sb $t7, 1($a0)			# update Y coordinate
sw $t9, 8($a0)			# update odometer
j DONE

moveOnEX:
addi $t0, $zero, 10		# grid size, never changed
addi $t1, $zero, -10		# grid size, never changed
slt $t7, $zero, $a1		# check distance is pos or neg
beq $t7, $zero, EXnegMove	# if distance is neg
bne $t7, $zero, EXposMove	# if distance is pos

EXnegMove:
add $t7, $t5, $a1		# subtract distance from X coordinate
sub $t8, $zero, $a1		# get absolute val of distance
add $t9, $t9, $t8		# add odometer
slt $t2, $t7, $t1		# check if reaches the border
bne $t2, $zero, resetEXneg	# if over the border reset coordinates
j normalEXneg		
resetEXneg:
addi $t7, $zero, -10		# reset coordinates
normalEXneg:
sw $t9, 8($a0)			# update odometer
sb $t7, 0($a0)			# update X coordinate
j DONE

EXposMove:
add $t7, $t5, $a1		# add distance to X coordinate
add $t9, $t9, $a1		# add odometer
slt $t2, $t7, $t0		# check if reaches the border
beq $t2, $zero, resetEXpos	# if over the border reset coordinates
j normalEXpos		
resetEXpos:
addi $t7, $zero, 10		# reset coordinates
normalEXpos:
sw $t9, 8($a0)			# update odometer
sb $t7, 0($a0)			# update X coordinate
j DONE

moveOnWX:
addi $t0, $zero, 10		# grid size, never changed
addi $t1, $zero, -10		# grid size, never changed
slt $t7, $zero, $a1		# check distance is pos or neg
beq $t7, $zero, WXnegMove	# if distance is neg
bne $t7, $zero, WXposMove	# if distance is pos

WXnegMove:
sub $t7, $t5, $a1		# subtract distance from X coordinate
sub $t8, $zero, $a1		# get absolute val of distance
add $t9, $t9, $t8		# add odometer
slt $t2, $t7, $t0		# check if reaches the border
beq $t2, $zero, resetWXneg	# if over the border reset coordinates
j normalWXneg		
resetWXneg:
addi $t7, $zero, 10		# reset coordinates
normalWXneg:
sw $t9, 8($a0)			# update odometer
sb $t7, 0($a0)			# update X coordinate
j DONE

WXposMove:
sub $t7, $t5, $a1		# add distance to X coordinate
add $t9, $t9, $a1		# add odometer
slt $t2, $t7, $t1		# check if reaches the border
bne $t2, $zero, resetWXpos	# if over the border reset coordinates
j normalWXpos		
resetWXpos:
addi $t7, $zero, -10		# reset coordinates
normalWXpos:
sw $t9, 8($a0)			# update odometer
sb $t7, 0($a0)			# update X coordinate
j DONE


DONE:
lw $ra, 4($sp)			# standard epilogue
lw $fp, 0($sp)
addiu $sp, $sp, 24
jr $ra

.text
.globl turtle_searchName
# for i in range(len(arrray)):
#	name = array[i*4]
#	if name == parameter_3:
#		return i
# return -1
turtle_searchName:
addiu $sp, $sp, -32		# allocate stack space -- default of 24 here
sw $fp, 0($sp)			# allocate stack space -- default of 24 here
sw $ra, 4($sp)			# save return address
addiu $fp, $sp, 28		# setup main's frame pointer

add $t1, $zero, $zero		# loop index
addi $t6, $zero, 4		# address

LOOP:
slt $t2, $t1, $a1		# if loop index less than array length
bne $t2, $zero, find		# loop starts
j loopends

find:
add $t3, $t6, $a0		# get address of nth object in array
lw $t4, 0($t3)			# get name
sw $a0, 8($sp)			# store first parameter to stack
sw $a1, 12($sp)			# store second parameter to stack
sw $a2, 16($sp)			# store third parameter to stack
sw $t1, 20($sp)			# store $t1, loop index to stack
sw $t6, 24($sp)			# store adress to stack
add $a0, $t4, $zero		# give strcmp first parameter name
add $a1, $a2, $zero		# give strcmp second parameter needle
jal strcmp
lw $a0, 8($sp)			# get first parameter back
lw $a1, 12($sp)			# get second parameter back
lw $a2, 16($sp)			# get third parameter back
lw $t1, 20($sp)			# get $t1, loop index back
lw $t6, 24($sp)			# get adress back
beq $v0, $zero, returnTrue	# compare name
addi $t1, $t1, 1		# index increment by 1
addi $t6, $t6, 12		# address increment by 12
j LOOP

returnTrue:
add $v0, $zero, $t1		# return address
j functends

loopends:
addi $v0, $zero, -1		# return -1

functends:
lw $ra, 4($sp)			# standard epilogue
lw $fp, 0($sp)
addiu $sp, $sp, 32
jr $ra

.text
.globl turtle_sortByX_indirect

# def bubble_sort(l):
#    end = len(l)
#    for i in range(0, len(l)):
#        for j in range(0, end-1):
#            if l[j] > l[j+1]:
#                l[j], l[j+1] = l[j+1], l[j]
#        end -= 1
#    return l

turtle_sortByX_indirect:
addiu $sp, $sp, -24		# allocate stack space -- default of 24 here
sw $fp, 0($sp)			# allocate stack space -- default of 24 here
sw $ra, 4($sp)			# save return address
sw $s0, 8($sp)
addiu $fp, $sp, 16		# setup main's frame pointer

addi $t0, $a1, -1		# end = array length - 1
add $t1, $zero, $zero		# index i
add $t2, $zero, $zero		# index j

outloop:
add $s0, $zero, $zero
slt $t3, $t1, $a1		# loop range
bne $t3, $zero, innerloop	# if $t1 < array length, sort
j result

innerloop:
slt $t4, $t2, $t0		# loop range
bne $t4, $zero, swap		# if $t2 < array length - 1, swap
addi $t0, $t0, -1		# end -= 1
addi $t1, $t1, 1
add $t2, $zero, $zero		# reset inner loop index
j outloop

swap:
add $t5, $s0, $a0		# get address of turtle obj
lw  $t6, 0($t5)			# get turtle obj
lb  $t7, 0($t6)			# get x			
lw  $t8, 4($t5)			# get next turtle obj
lb  $t9, 0($t8)			# get another x
slt $t3, $t7, $t9		# compare first x and second x
beq $t3, $zero, doswap		# if first x greater than second x
addi $t2, $t2, 1		# move to next
addi $s0, $s0, 4		# next obj address
j innerloop

doswap:
sw $t6, 4($t5)
sw $t8, 0($t5)
addi $t2, $t2, 1		# move to next
addi $s0, $s0, 4		# next obj address
j innerloop

result:
lw $s0, 8($sp)			# restore sX register
lw $ra, 4($sp)			# standard epilogue
lw $fp, 0($sp)
addiu $sp, $sp, 24
jr $ra
