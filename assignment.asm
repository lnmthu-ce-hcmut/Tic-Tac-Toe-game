.data:
	square:		.word 48, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 
	111, 112, 113, 114, 115, 116, 117, 118, 119, 121, 122
	char0:		.asciiz "Player "
	char1:		.asciiz ", enter a character: "
	char2:		.asciiz "Invalid move, please input again\n"
	
	char_board_0:	.asciiz "\n.........................................\n"
	char_board_1:	.asciiz "\t Tic-Tac-Toe (5x5)\n"
	char_board_2:	.asciiz "   Player 1 (X)  -  Player 2 (O)\n"
	char_board_3:	.asciiz "\t|     |     |     |     |     |\n"
	char_board_4:	.asciiz "\t|  "
	char_board_5:	.asciiz "  |  "
	char_board_6:	.asciiz "  |\n"
	char_board_7:	.asciiz "\t|_____|_____|_____|_____|_____|\n"
	char_board_8:	.asciiz "\t _____ _____ _____ _____ _____\n"
	
	char3:		.asciiz "   ==> Player "
	char4:		.asciiz " is the winner!"
	char5:		.asciiz "   ==> Game draw :("
	char6:		.asciiz "\nDo you wanna undo? (1/0): "
	char7:		.asciiz "\nThis is your first turn. You're not allowed to use this position \n"
	char8:		.asciiz "Undo successfully. Choose another one please \n"

.text:
	#3 ham: main, checkwin, board
	main:
	#int player = 1, i, choice
	#char mark
	#$s0 = player
	#$s1 = free
	#$s2 = choice
	#$s3 = mark
	#$s4 = i
	#s5 = square base address
	#$s7 = -1
	la		$s5, square
	li		$s7, -1
	li		$s0, 1
	
	li		$s4, -1
	
	li 		$t6, 1
	li		$t7, 1
	li		$t9, 0	
	
	main_dowhile:
		
		jal	board
		li	$s1, 2
		div	$s0, $s1
		mfhi	$s1
		#s1 = 0 => player%2 => player = 2
		bne	$s1, $0, assign_player_1
		li	$s0, 2
		j	continue_loop
		
	assign_player_1:
		li	$s0, 1
	
	continue_loop:
		#print
		li	$v0, 4
		la	$a0, char0
		syscall
		move	$a0, $s0
		li	$v0, 1
		syscall
		li 	$v0, 4
		la 	$a0, char1
		syscall
			
		#take cin
		li 	$v0, 12
		syscall
		move	$s2, $v0 #s2 = choice
		
		jal 	plus_round	
		
		bnez 	$t7, checkUndoFlag      #t7 = 1
		li 	$t7, 0
		
	checkUndoFlag:
		
		beqz 	$t9, toUndo	        #t9 = 0
	cont:
		li 	$t8, 0
		li	$t9, 0    #undo flag down
		
		#mark = (player == 1)? 'X' : 'O'
		#mark = $s3
		li 	$s3, 1
		beq 	$s0, $s3, assign_X
		li 	$s3, 79
		
		j 	continue_loop_1	
		
	assign_X:
		addi 	$s3, $zero, 88
		
	continue_loop_1:
				
		#nhieu dòng if else
		li 	$s1, 1
		move	$t5, $s2
		subi 	$t5, $t5, 96
		bne 	$t5, $s1, second_loop
		#choice == a
		#check square[1] == 'a'
		#load square[1]
		sll 	$s1, $s1, 2
		add 	$s6, $s5, $s1
		lb 	$s7, 0($s6)
		#$s6 = square[1]
		addi 	$s1, $zero, 97
		#$s1 = '1'
		bne 	$s7, $s1, second_loop
		sw 	$s3, 0($s6)
		j 	update_dowhile
		
	second_loop:
		li 	$s1, 2
		move	$t5, $s2
		subi 	$t5, $t5, 96
		bne 	$t5, $s1, third_loop
		#choice == b
		#check square[2] == 'b'
		sll $s1, $s1, 2
		add $s6, $s5, $s1
		lw $s7, 0($s6)
		#$s6 = square[2]
		addi $s1, $zero, 98
		#$s1 = '2'
		bne $s7, $s1, third_loop
		sw $s3, 0($s6)
		j update_dowhile
						
	third_loop:
		li	$s1, 3
		move	$t5, $s2
		subi 	$t5, $t5, 96
		bne 	$t5, $s1, four_loop
		#choice == 3
		#check square[3] == '3'
		sll	$s1, $s1, 2
		add 	$s6, $s5, $s1
		lw	$s7, 0($s6)
		#$s6 = square[3]
		addi 	$s1, $zero, 99
		#$s1 = '3'
		bne	$s7, $s1, four_loop
		sw 	$s3, 0($s6)
		j	update_dowhile
	four_loop:
		li 	$s1, 4
		move	$t5, $s2
		subi 	$t5, $t5, 96
		bne 	$t5, $s1, five_loop
		#choice == 4
		#check square[4] == '4'
		sll 	$s1, $s1, 2
		add 	$s6, $s5, $s1
		lw 	$s7, 0($s6)
		#$s6 = square[4]
		addi 	$s1, $zero, 100
		#$s1 = '4'
		bne	$s7, $s1, five_loop
		sw	$s3, 0($s6)
		j 	update_dowhile
			
	five_loop:
		li	$s1, 5
		move	$t5, $s2
		subi 	$t5, $t5, 96
		bne	$t5, $s1, six_loop
		#choice == 5
		#check square[5] == '5'
		sll	$s1, $s1, 2
		add	$s6, $s5, $s1
		lw	$s7, 0($s6)
		#$s6 = square[5]
		addi	$s1, $zero, 101
		#$s1 = '5'
		bne	$s7, $s1, six_loop
		sw	$s3, 0($s6)
		j	update_dowhile
		
	six_loop:
		li	$s1, 6
		move	$t5, $s2
		subi 	$t5, $t5, 96
		bne	$t5, $s1, seven_loop
		#choice == 6
		#check square[6] == '6'
		sll	$s1, $s1, 2
		add	$s6, $s5, $s1
		lw	$s7, 0($s6)
		#$s6 = square[6]
		addi	$s1, $zero, 102
		#$s1 = '6'
		bne	$s7, $s1, seven_loop
		sw	$s3, 0($s6)
		j	update_dowhile
		
	seven_loop:
		li	$s1, 7
		move	$t5, $s2
		subi 	$t5, $t5, 96
		bne	$t5, $s1, eight_loop
		#choice == 7
		#check square[7] == '7'
		sll 	$s1, $s1, 2
		add 	$s6, $s5, $s1
		lw 	$s7, 0($s6)
		#$s6 = square[7]
		addi 	$s1, $zero, 103
		#$s1 = '7'
		bne 	$s7, $s1, eight_loop
		sw 	$s3, 0($s6)
		j 	update_dowhile
			
	eight_loop:
		li 	$s1, 8
		move	$t5, $s2
		subi 	$t5, $t5, 96
		bne 	$t5, $s1, nine_loop
		#choice == 8
		#check square[8] == '8'
		sll 	$s1, $s1, 2
		add 	$s6, $s5, $s1
		lw 	$s7, 0($s6)
		#$s6 = square[8]
		addi 	$s1, $zero, 104
		#$s1 = '8'
		bne 	$s7, $s1, nine_loop
		sw 	$s3, 0($s6)
		j 	update_dowhile
			
	nine_loop:
		li 	$s1, 9
		move	$t5, $s2
		subi 	$t5, $t5, 96
		bne 	$t5, $s1, ten_loop
		#choice == 9
		#check square[9] == '9'
		sll 	$s1, $s1, 2
		add 	$s6, $s5, $s1
		lw 	$s7, 0($s6)
		#$s6 = square[9]
		addi 	$s1, $zero, 105
		#$s1 = '9'
		bne 	$s7, $s1, ten_loop
		sw 	$s3, 0($s6)
		j 	update_dowhile
		
	ten_loop:
		li 	$s1, 10
		move	$t5, $s2
		subi 	$t5, $t5, 96
		bne 	$t5, $s1, eleven_loop
		#choice == 9
		#check square[9] == '9'
		sll 	$s1, $s1, 2
		add 	$s6, $s5, $s1
		lw 	$s7, 0($s6)
		#$s6 = square[9]
		addi 	$s1, $zero, 106
		#$s1 = '9'
		bne 	$s7, $s1, eleven_loop
		sw 	$s3, 0($s6)
		j 	update_dowhile
		
	eleven_loop:
		li 	$s1, 11
		move	$t5, $s2
		subi 	$t5, $t5, 96
		bne 	$t5, $s1, twelve_loop
		#choice == 9
		#check square[9] == '9'
		sll 	$s1, $s1, 2
		add 	$s6, $s5, $s1
		lw 	$s7, 0($s6)
		#$s6 = square[9]
		addi 	$s1, $zero, 107
		#$s1 = 'j'
		bne 	$s7, $s1, twelve_loop
		sw 	$s3, 0($s6)
		j 	update_dowhile
		
	twelve_loop:
		li 	$s1, 12
		move	$t5, $s2
		subi 	$t5, $t5, 96
		bne 	$t5, $s1, thirteen_loop
		#choice == 9
		#check square[9] == '9'
		sll 	$s1, $s1, 2
		add 	$s6, $s5, $s1
		lw 	$s7, 0($s6)
		#$s6 = square[9]
		addi 	$s1, $zero, 108
		#$s1 = '9'
		bne 	$s7, $s1, thirteen_loop
		sw 	$s3, 0($s6)
		j 	update_dowhile
		
	thirteen_loop:
		li 	$s1, 13
		move	$t5, $s2
		subi 	$t5, $t5, 96
		bne 	$t5, $s1, fourteen_loop
		jal 	check_1st_move
		#choice == 9
		#check square[9] == '9'
		sll 	$s1, $s1, 2
		add 	$s6, $s5, $s1
		lw 	$s7, 0($s6)
		#$s6 = square[9]
		addi 	$s1, $zero, 109
		#$s1 = '9'
		bne 	$s7, $s1, fourteen_loop
		sw 	$s3, 0($s6)
		j 	update_dowhile
		
	check_1st_move:
		slti 	$t8, $t6, 4
		bne 	$t8, $zero, small_loop_check
		li 	$t8, 0
		jr 	$ra
		
	small_loop_check:
		li	$v0, 4
		la	$a0, char7
		syscall
		j	main_dowhile
		
	fourteen_loop:
		li 	$s1, 14
		move	$t5, $s2
		subi 	$t5, $t5, 96
		bne 	$t5, $s1, fifteen_loop
		#choice == 9
		#check square[9] == '9'
		sll 	$s1, $s1, 2
		add 	$s6, $s5, $s1
		lw 	$s7, 0($s6)
		#$s6 = square[9]
		addi 	$s1, $zero, 110
		#$s1 = '9'
		bne 	$s7, $s1, fifteen_loop
		sw 	$s3, 0($s6)
		j 	update_dowhile
		
	fifteen_loop:
		li 	$s1, 15
		move	$t5, $s2
		subi 	$t5, $t5, 96
		bne 	$t5, $s1, sixteen_loop
		#choice == 9
		#check square[9] == '9'
		sll 	$s1, $s1, 2
		add 	$s6, $s5, $s1
		lw 	$s7, 0($s6)
		#$s6 = square[9]
		addi 	$s1, $zero, 111
		#$s1 = '9'
		bne 	$s7, $s1, sixteen_loop
		sw 	$s3, 0($s6)
		j 	update_dowhile
		
	sixteen_loop:
		li 	$s1, 16
		move	$t5, $s2
		subi 	$t5, $t5, 96
		bne 	$t5, $s1, seventeen_loop
		#choice == 9
		#check square[9] == '9'
		sll 	$s1, $s1, 2
		add 	$s6, $s5, $s1
		lw 	$s7, 0($s6)
		#$s6 = square[9]
		addi 	$s1, $zero, 112
		#$s1 = '9'
		bne 	$s7, $s1, seventeen_loop
		sw 	$s3, 0($s6)
		j 	update_dowhile
		
	seventeen_loop:
		li 	$s1, 17
		move	$t5, $s2
		subi 	$t5, $t5, 96
		bne 	$t5, $s1, eighteen_loop
		#choice == 9
		#check square[9] == '9'
		sll 	$s1, $s1, 2
		add 	$s6, $s5, $s1
		lw 	$s7, 0($s6)
		#$s6 = square[9]
		addi 	$s1, $zero, 113
		#$s1 = '9'
		bne 	$s7, $s1, eighteen_loop
		sw 	$s3, 0($s6)
		j 	update_dowhile
		
	eighteen_loop:
		li 	$s1, 18
		move	$t5, $s2
		subi 	$t5, $t5, 96
		bne 	$t5, $s1, nineteen_loop
		#choice == 9
		#check square[9] == '9'
		sll 	$s1, $s1, 2
		add 	$s6, $s5, $s1
		lw 	$s7, 0($s6)
		#$s6 = square[9]
		addi 	$s1, $zero, 114
		#$s1 = '9'
		bne 	$s7, $s1, nineteen_loop
		sw 	$s3, 0($s6)
		j 	update_dowhile
		
	nineteen_loop:
		li 	$s1, 19
		move	$t5, $s2
		subi 	$t5, $t5, 96
		bne 	$t5, $s1, twenty_loop
		#choice == 9
		#check square[9] == '9'
		sll 	$s1, $s1, 2
		add 	$s6, $s5, $s1
		lw 	$s7, 0($s6)
		#$s6 = square[9]
		addi $s1, $zero, 115
		#$s1 = '9'
		bne 	$s7, $s1, twenty_loop
		sw 	$s3, 0($s6)
		j 	update_dowhile
		
	twenty_loop:
		li 	$s1, 20
		move	$t5, $s2
		subi 	$t5, $t5, 96
		bne 	$t5, $s1, twentyone_loop
		#choice == 9
		#check square[9] == '9'
		sll 	$s1, $s1, 2
		add 	$s6, $s5, $s1
		lw 	$s7, 0($s6)
		#$s6 = square[9]
		addi 	$s1, $zero, 116
		#$s1 = '9'
		bne 	$s7, $s1, twentyone_loop
		sw 	$s3, 0($s6)
		j 	update_dowhile
		
	twentyone_loop:
		li 	$s1, 21
		move	$t5, $s2
		subi 	$t5, $t5, 96
		bne 	$t5, $s1, twentytwo_loop
		#choice == 9
		#check square[9] == '9'
		sll 	$s1, $s1, 2
		add 	$s6, $s5, $s1
		lw 	$s7, 0($s6)
		#$s6 = square[9]
		addi 	$s1, $zero, 117
		#$s1 = '9'
		bne 	$s7, $s1, twentytwo_loop
		sw 	$s3, 0($s6)
		j 	update_dowhile
		
	twentytwo_loop:
		li	$s1, 22
		move	$t5, $s2
		subi 	$t5, $t5, 96
		bne 	$t5, $s1, twentythree_loop
		#choice == 9
		#check square[9] == '9'
		sll 	$s1, $s1, 2
		add 	$s6, $s5, $s1
		lw 	$s7, 0($s6)
		#$s6 = square[9]
		addi 	$s1, $zero, 118
		#$s1 = '9'
		bne 	$s7, $s1, twentythree_loop
		sw 	$s3, 0($s6)
		j 	update_dowhile
		
	twentythree_loop:
		li 	$s1, 23
		move	$t5, $s2
		subi 	$t5, $t5, 96
		bne 	$t5, $s1, twentyfour_loop
		#choice == 9
		#check square[9] == '9'
		sll 	$s1, $s1, 2
		add 	$s6, $s5, $s1
		lw 	$s7, 0($s6)
		#$s6 = square[9]
		addi 	$s1, $zero, 119
		#$s1 = '9'
		bne 	$s7, $s1, twentyfour_loop
		sw 	$s3, 0($s6)
		j 	update_dowhile
		
	twentyfour_loop:
		li 	$s1, 24
		move	$t5, $s2
		subi 	$t5, $t5, 97
		bne 	$t5, $s1, twentyfive_loop
		#choice == 9
		#check square[9] == '9'
		sll 	$s1, $s1, 2
		add 	$s6, $s5, $s1
		lw 	$s7, 0($s6)
		#$s6 = square[9]
		addi $s1, $zero, 121
		#$s1 = '9'
		bne 	$s7, $s1, twentyfive_loop
		sw 	$s3, 0($s6)
		j 	update_dowhile
		
	twentyfive_loop:
		li 	$s1, 25
		move	$t5, $s2
		subi 	$t5, $t5, 97
		bne 	$t5, $s1, else_loop
		#choice == 9
		#check square[9] == '9'
		sll 	$s1, $s1, 2
		add 	$s6, $s5, $s1
		lw 	$s7, 0($s6)
		#$s6 = square[25]
		addi 	$s1, $zero, 122
		#$s1 = 'z'
		bne 	$s7, $s1, else_loop
		sw 	$s3, 0($s6)
		j 	update_dowhile
	
	else_loop:
		li	$v0, 4
		la 	$a0, char2
		syscall
		addi	$s0, $s0, -1
		
		#jal getch
			
				
	update_dowhile:
		#i = checkwin()
		#s4 = i
		jal	checkwin
		move	$s4, $v0
		#player++
		addi	$s0, $s0, 1		
		li	$s7, -1
		
		#if i != -1 => endgame
	beq	$s4, $s7, main_dowhile
	jal	board
	
	#check winner
	li	$s1, 1
	bne	$s4, $s1, main_else
	addi	$s0, $s0, -1
	li	$v0, 4
	la	$a0, char3
	syscall
	move	$a0, $s0
	li	$v0, 1
	syscall
	li	$v0, 4
	la	$a0, char4
	syscall
	j 	main_done
		
	#check draw
	main_else:
		li	$v0, 4
		la	$a0, char5 #draw message
		syscall
		j	main_done
	
	
	checkwin:
		#chú ý chi nên xài t, ko xài s
		#dòng if else 
		#s5 = square base address
		li	$t0, 2
		li	$t1, 3
		sll	$t0, $t0, 2
		sll	$t1, $t1, 2
		add	$t2, $t0, $s5 #t2 = square + t0*4
		add	$t3, $t1, $s5 #t3 = square + t1*4
		lw	$t4, 0($t2)
		lw	$t5, 0($t3)
		bne	$t4, $t5, checkwin_loop_2
		li	$t0, 1
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw	$t4, 0($t2)
		bne	$t4, $t5, checkwin_loop_1_1
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_1_1:
		li	$t0, 4
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw	$t4, 0($t2)
		bne	$t4, $t5, checkwin_loop_2
		li	$v0, 1
		jr	$ra	
				
	checkwin_loop_2:
		li	$t0, 7
		li	$t1, 8
		sll	$t0, $t0, 2
		sll	$t1, $t1, 2
		add	$t2, $t0, $s5 #t2 = square + t0*4
		add	$t3, $t1, $s5 #t3 = square + t1*4
		lw	$t4, 0($t2)
		lw	$t5, 0($t3)
		bne	$t4, $t5, checkwin_loop_3
		li	$t0, 6
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw	$t4, 0($t2)
		bne	$t4, $t5, checkwin_loop_2_1
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_2_1:
		li	$t0, 9
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw	$t4, 0($t2)
		bne	$t4, $t5, checkwin_loop_3
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_3:
		li	$t0, 12
		li	$t1, 13
		sll	$t0, $t0, 2
		sll	$t1, $t1, 2
		add	$t2, $t0, $s5 #t2 = square + t0*4
		add	$t3, $t1, $s5 #t3 = square + t1*4
		lw	$t4, 0($t2)
		lw	$t5, 0($t3)
		bne	$t4, $t5, checkwin_loop_4
		li	$t0, 11
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw	$t4, 0($t2)
		bne	$t4, $t5, checkwin_loop_3_1
		addi	$v0, $zero, 1
		jr	$ra
	
	checkwin_loop_3_1:
		li	$t0, 14
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw	$t4, 0($t2)
		bne	$t4, $t5, checkwin_loop_4
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_4:
		li	$t0, 17
		li	$t1, 18
		sll	$t0, $t0, 2
		sll	$t1, $t1, 2
		add	$t2, $t0, $s5 #t2 = square + t0*4
		add	$t3, $t1, $s5 #t3 = square + t1*4
		lw	$t4, 0($t2)
		lw	$t5, 0($t3)
		bne	$t4, $t5, checkwin_loop_5
		li	$t0, 16
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw	$t4, 0($t2)
		bne	$t4, $t5, checkwin_loop_4_1
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_4_1:
		li	$t0, 19
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw	$t4, 0($t2)
		bne	$t4, $t5, checkwin_loop_5
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_5:
		li	$t0, 22
		li	$t1, 23
		sll	$t0, $t0, 2
		sll	$t1, $t1, 2
		add	$t2, $t0, $s5 #t2 = square + t0*4
		add	$t3, $t1, $s5 #t3 = square + t1*4
		lw	$t4, 0($t2)
		lw	$t5, 0($t3)
		bne	$t4, $t5, checkwin_loop_6
		li	$t0, 21
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw	$t4, 0($t2)
		bne	$t4, $t5, checkwin_loop_5_1
		addi	$v0, $zero, 1
		jr	$ra
	
	checkwin_loop_5_1:
		li	$t0, 24
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw	$t4, 0($t2)
		bne	$t4, $t5, checkwin_loop_6
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_6:
		li	$t0, 3
		li	$t1, 4
		sll	$t0, $t0, 2
		sll	$t1, $t1, 2
		add	$t2, $t0, $s5 #t2 = square + t0*4
		add	$t3, $t1, $s5 #t3 = square + t1*4
		lw	$t4, 0($t2)
		lw	$t5, 0($t3)
		bne	$t4, $t5, checkwin_loop_7
		li	$t0, 5
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw	$t4, 0($t2)
		bne	$t4, $t5, checkwin_loop_7
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_7:
		li	$t0, 8
		li 	$t1, 9
		sll	$t0, $t0, 2
		sll	$t1, $t1, 2
		add	$t2, $t0, $s5 #t2 = square + t0*4
		add	$t3, $t1, $s5 #t3 = square + t1*4
		lw	$t4, 0($t2)
		lw	$t5, 0($t3)
		bne	$t4, $t5, checkwin_loop_8
		li	$t0, 10
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw	$t4, 0($t2)
		bne	$t4, $t5, checkwin_loop_8
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_8:
		li	$t0, 13
		li	$t1, 14
		sll	$t0, $t0, 2
		sll	$t1, $t1, 2
		add	$t2, $t0, $s5 #t2 = square + t0*4
		add	$t3, $t1, $s5 #t3 = square + t1*4
		lw	$t4, 0($t2)
		lw	$t5, 0($t3)
		bne	$t4, $t5, checkwin_loop_9
		li	$t0, 15
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw	$t4, 0($t2)
		bne	$t4, $t5, checkwin_loop_9
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_9:
		li	$t0, 18
		li	$t1, 19
		sll	$t0, $t0, 2
		sll	$t1, $t1, 2
		add	$t2, $t0, $s5 #t2 = square + t0*4
		add	$t3, $t1, $s5 #t3 = square + t1*4
		lw	$t4, 0($t2)
		lw	$t5, 0($t3)
		bne	$t4, $t5, checkwin_loop_10
		li	$t0, 20
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw	$t4, 0($t2)
		bne	$t4, $t5, checkwin_loop_10
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_10:
		li 	$t0, 23
		li	$t1, 24
		sll	$t0, $t0, 2
		sll	$t1, $t1, 2
		add	$t2, $t0, $s5 #t2 = square + t0*4
		add	$t3, $t1, $s5 #t3 = square + t1*4
		lw	$t4, 0($t2)
		lw	$t5, 0($t3)
		bne	$t4, $t5, checkwin_loop_11
		li	$t0, 25
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_11
		li	$v0, 1
		jr	$ra
	
	
	
	checkwin_loop_11: #16th
		li 	$t0, 6
		li	$t1, 11
		sll	$t0, $t0, 2
		sll	$t1, $t1, 2
		add	$t2, $t0, $s5 #t2 = square + t0*4
		add	$t3, $t1, $s5 #t3 = square + t1*4
		lw	$t4, 0($t2)
		lw	$t5, 0($t3)
		bne	$t4, $t5, checkwin_loop_12
		li	$t0, 1
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_11_1
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_11_1: #17th
		li	$t0, 16
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_12
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_12:
		li 	$t0, 7
		li	$t1, 12
		sll	$t0, $t0, 2
		sll	$t1, $t1, 2
		add	$t2, $t0, $s5 #t2 = square + t0*4
		add	$t3, $t1, $s5 #t3 = square + t1*4
		lw	$t4, 0($t2)
		lw	$t5, 0($t3)
		bne	$t4, $t5, checkwin_loop_13
		li	$t0, 2
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_12_1
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_12_1: #19th
		li	$t0, 17
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_13
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_13:
		li 	$t0, 8
		li	$t1, 13
		sll	$t0, $t0, 2
		sll	$t1, $t1, 2
		add	$t2, $t0, $s5 #t2 = square + t0*4
		add	$t3, $t1, $s5 #t3 = square + t1*4
		lw	$t4, 0($t2)
		lw	$t5, 0($t3)
		bne	$t4, $t5, checkwin_loop_14
		li	$t0, 3
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_13_1
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_13_1: #21st
		li	$t0, 18
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_14
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_14:
		li 	$t0, 9
		li	$t1, 14
		sll	$t0, $t0, 2
		sll	$t1, $t1, 2
		add	$t2, $t0, $s5 #t2 = square + t0*4
		add	$t3, $t1, $s5 #t3 = square + t1*4
		lw	$t4, 0($t2)
		lw	$t5, 0($t3)
		bne	$t4, $t5, checkwin_loop_15
		li	$t0, 4
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_14_1
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_14_1: #23rd
		li	$t0, 19
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_15
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_15:
		li 	$t0, 10
		li	$t1, 15
		sll	$t0, $t0, 2
		sll	$t1, $t1, 2
		add	$t2, $t0, $s5 #t2 = square + t0*4
		add	$t3, $t1, $s5 #t3 = square + t1*4
		lw	$t4, 0($t2)
		lw	$t5, 0($t3)
		bne	$t4, $t5, checkwin_loop_16
		li	$t0, 5
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_15_1
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_15_1:  #25th
		li	$t0, 20
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_16
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_16: #26th
		li 	$t0, 11
		li	$t1, 16
		sll	$t0, $t0, 2
		sll	$t1, $t1, 2
		add	$t2, $t0, $s5 #t2 = square + t0*4
		add	$t3, $t1, $s5 #t3 = square + t1*4
		lw	$t4, 0($t2)
		lw	$t5, 0($t3)
		bne	$t4, $t5, checkwin_loop_17
		li	$t0, 21
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_17
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_17:  #27th
		li 	$t0, 12
		li	$t1, 17
		sll	$t0, $t0, 2
		sll	$t1, $t1, 2
		add	$t2, $t0, $s5 #t2 = square + t0*4
		add	$t3, $t1, $s5 #t3 = square + t1*4
		lw	$t4, 0($t2)
		lw	$t5, 0($t3)
		bne	$t4, $t5, checkwin_loop_18
		li	$t0, 22
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_18
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_18:  #28th
		li 	$t0, 13
		li	$t1, 18
		sll	$t0, $t0, 2
		sll	$t1, $t1, 2
		add	$t2, $t0, $s5 #t2 = square + t0*4
		add	$t3, $t1, $s5 #t3 = square + t1*4
		lw	$t4, 0($t2)
		lw	$t5, 0($t3)
		bne	$t4, $t5, checkwin_loop_19
		li	$t0, 23
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_19
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_19:
		li 	$t0, 14
		li	$t1, 19
		sll	$t0, $t0, 2
		sll	$t1, $t1, 2
		add	$t2, $t0, $s5 #t2 = square + t0*4
		add	$t3, $t1, $s5 #t3 = square + t1*4
		lw	$t4, 0($t2)
		lw	$t5, 0($t3)
		bne	$t4, $t5, checkwin_loop_20
		li	$t0, 24
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_20
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_20:  #30th
		li 	$t0, 15
		li	$t1, 20
		sll	$t0, $t0, 2
		sll	$t1, $t1, 2
		add	$t2, $t0, $s5 #t2 = square + t0*4
		add	$t3, $t1, $s5 #t3 = square + t1 *4
		lw	$t4, 0($t2)
		lw	$t5, 0($t3)
		bne	$t4, $t5, checkwin_loop_21
		li	$t0, 25
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_21
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_21:
		li 	$t0, 7
		li	$t1, 13
		sll	$t0, $t0, 2
		sll	$t1, $t1, 2
		add	$t2, $t0, $s5 #t2 = square + t0*4
		add	$t3, $t1, $s5 #t3 = square + t1*4
		lw	$t4, 0($t2)
		lw	$t5, 0($t3)
		bne	$t4, $t5, checkwin_loop_22
		li	$t0, 1
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_21_1
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_21_1:  #32nd
		li	$t0, 19
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_22
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_22:
		li 	$t0, 8
		li	$t1, 14
		sll	$t0, $t0, 2
		sll	$t1, $t1, 2
		add	$t2, $t0, $s5 #t2 = square + t0*4
		add	$t3, $t1, $s5 #t3 = square + t1*4
		lw	$t4, 0($t2)
		lw	$t5, 0($t3)
		bne	$t4, $t5, checkwin_loop_23
		li	$t0, 2
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_22_1
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_22_1:  #34th
		li	$t0, 20
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_23
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_23:
		li 	$t0, 12
		li	$t1, 18
		sll	$t0, $t0, 2
		sll	$t1, $t1, 2
		add	$t2, $t0, $s5 #t2 = square + t0*4
		add	$t3, $t1, $s5 #t3 = square + t1*4
		lw	$t4, 0($t2)
		lw	$t5, 0($t3)
		bne	$t4, $t5, checkwin_loop_24
		li	$t0, 6
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_23_1
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_23_1:  #36th
		li	$t0, 24
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_24
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_24:
		li 	$t0, 9
		li	$t1, 13
		sll	$t0, $t0, 2
		sll	$t1, $t1, 2
		add	$t2, $t0, $s5 #t2 = square + t0*4
		add	$t3, $t1, $s5 #t3 = square + t1*4
		lw	$t4, 0($t2)
		lw	$t5, 0($t3)
		bne	$t4, $t5, checkwin_loop_25
		li	$t0, 5
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_24_1
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_24_1:  #38th
		li	$t0, 17
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_25
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_25:
		li 	$t0, 8
		li	$t1, 12
		sll	$t0, $t0, 2
		sll	$t1, $t1, 2
		add	$t2, $t0, $s5 #t2 = square + t0*4
		add	$t3, $t1, $s5 #t3 = square + t1*4
		lw	$t4, 0($t2)
		lw	$t5, 0($t3)
		bne	$t4, $t5, checkwin_loop_26
		li	$t0, 4
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_25_1
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_25_1:  #40th
		li	$t0, 16
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_26
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_26:
		li 	$t0, 14
		li	$t1, 18
		sll	$t0, $t0, 2
		sll	$t1, $t1, 2
		add	$t2, $t0, $s5 #t2 = square + t0*4
		add	$t3, $t1, $s5 #t3 = square + t1*4
		lw	$t4, 0($t2)
		lw	$t5, 0($t3)
		bne	$t4, $t5, checkwin_loop_27
		li	$t0, 10
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_26_1
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_26_1:  #42nd
		li	$t0, 22
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_27
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_27:
		li 	$t0, 13
		li	$t1, 19
		sll	$t0, $t0, 2
		sll	$t1, $t1, 2
		add	$t2, $t0, $s5 #t2 = square + t0*4
		add	$t3, $t1, $s5 #t3 = square + t1*4
		lw	$t4, 0($t2)
		lw	$t5, 0($t3)
		bne	$t4, $t5, checkwin_loop_28
		li	$t0, 25
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_28
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_28:  #44th
		li 	$t0, 13
		li	$t1, 17
		sll	$t0, $t0, 2
		sll	$t1, $t1, 2
		add	$t2, $t0, $s5 #t2 = square + t0*4
		add	$t3, $t1, $s5 #t3 = square + t1*4
		lw	$t4, 0($t2)
		lw	$t5, 0($t3)
		bne	$t4, $t5, checkwin_loop_29
		li	$t0, 21
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_29
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_29:  #45th
		li 	$t0, 3
		li	$t1, 9
		sll	$t0, $t0, 2
		sll	$t1, $t1, 2
		add	$t2, $t0, $s5 #t2 = square + t0*4
		add	$t3, $t1, $s5 #t3 = square + t1*4
		lw	$t4, 0($t2)
		lw	$t5, 0($t3)
		bne	$t4, $t5, checkwin_loop_30
		li	$t0, 15
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_30
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_30:  #46th
		li 	$t0, 11
		li	$t1, 17
		sll	$t0, $t0, 2
		sll	$t1, $t1, 2
		add	$t2, $t0, $s5 #t2 = square + t0*4
		add	$t3, $t1, $s5 #t3 = square + t1*4
		lw	$t4, 0($t2)
		lw	$t5, 0($t3)
		bne	$t4, $t5, checkwin_loop_31
		li	$t0, 23
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_31
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_31:  #47th
		li 	$t0, 3
		li	$t1, 7
		sll	$t0, $t0, 2
		sll	$t1, $t1, 2
		add	$t2, $t0, $s5 #t2 = square + t0*4
		add	$t3, $t1, $s5 #t3 = square + t1*4
		lw	$t4, 0($t2)
		lw	$t5, 0($t3)
		bne	$t4, $t5, checkwin_loop_32
		li	$t0, 11
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_32
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_32:
		li 	$t0, 15
		li	$t1, 19
		sll	$t0, $t0, 2
		sll	$t1, $t1, 2
		add	$t2, $t0, $s5 #t2 = square + t0*4
		add	$t3, $t1, $s5 #t3 = square + t1*4
		lw	$t4, 0($t2)
		lw	$t5, 0($t3)
		bne	$t4, $t5, checkwin_loop_33
		li	$t0, 23
		sll	$t0, $t0, 2
		add	$t2, $t0, $s5 
		lw 	$t4, 0($t2)
		bne 	$t4, $t5, checkwin_loop_33
		li	$v0, 1
		jr	$ra
	
	checkwin_loop_33:
		#check square[1]!='a'
		li	$t0, 1
		sll	$t0, $t0, 2
		add	$t1, $s5, $t0
		lw	$t2, 0($t1)
		li	$t3, 'a'
		beq	$t2, $t3, checkwin_else
		
		#check square[2]!='b'
		li	$t0, 2
		sll	$t0, $t0, 2
		add 	$t1, $s5, $t0
		lw 	$t2, 0($t1)
		li 	$t3, 'b'
		beq 	$t2, $t3, checkwin_else
		
		#check square[3]!='c'
		li 	$t0, 3
		sll 	$t0, $t0, 2
		add 	$t1, $s5, $t0
		lw	$t2, 0($t1)
		li 	$t3, 'c'
		beq 	$t2, $t3, checkwin_else
		
		#check square[4]!='d'
		li	$t0, 4
		sll 	$t0, $t0, 2
		add 	$t1, $s5, $t0
		lw 	$t2, 0($t1)
		li 	$t3, 'd'
		beq 	$t2, $t3, checkwin_else
		
		#check square[5]!='e'
		li 	$t0, 5
		sll	$t0, $t0, 2
		add	$t1, $s5, $t0
		lw 	$t2, 0($t1)
		li	$t3, 'e'
		beq 	$t2, $t3, checkwin_else
		
		#check square[6]!='f'
		li	$t0, 6
		sll 	$t0, $t0, 2
		add 	$t1, $s5, $t0
		lw 	$t2, 0($t1)
		li 	$t3, 'f'
		beq 	$t2, $t3, checkwin_else
		
		#check square[7]!='g'
		li 	$t0, 7
		sll 	$t0, $t0, 2
		add 	$t1, $s5, $t0
		lw 	$t2, 0($t1)
		li 	$t3, 'g'
		beq 	$t2, $t3, checkwin_else
		
		#check square[8]!='h'
		li 	$t0, 8
		sll 	$t0, $t0, 2
		add 	$t1, $s5, $t0
		lw 	$t2, 0($t1)
		li 	$t3, 'h'
		beq 	$t2, $t3, checkwin_else
		
		#check square[9]!='i'
		li 	$t0, 9
		sll 	$t0, $t0, 2
		add 	$t1, $s5, $t0
		lw 	$t2, 0($t1)
		li 	$t3, 'i'
		beq 	$t2, $t3, checkwin_else
		
		#check square[10]!='j'
		li 	$t0, 10
		sll 	$t0, $t0, 2
		add 	$t1, $s5, $t0
		lw 	$t2, 0($t1)
		li 	$t3, 'j'
		beq 	$t2, $t3, checkwin_else
		
		#check square[11]!='k'
		li 	$t0, 11
		sll 	$t0, $t0, 2
		add 	$t1, $s5, $t0
		lw 	$t2, 0($t1)
		li 	$t3, 'k'
		beq 	$t2, $t3, checkwin_else
		
		#check square[12]!='l'
		li 	$t0, 12
		sll 	$t0, $t0, 2
		add 	$t1, $s5, $t0
		lw 	$t2, 0($t1)
		li 	$t3, 'l'
		beq 	$t2, $t3, checkwin_else
		
		#check square[13]!='m'
		li 	$t0, 13
		sll 	$t0, $t0, 2
		add 	$t1, $s5, $t0
		lw 	$t2, 0($t1)
		li 	$t3, 'm'
		beq 	$t2, $t3, checkwin_else
		
		#check square[14]!='n'
		li 	$t0, 14
		sll 	$t0, $t0, 2
		add 	$t1, $s5, $t0
		lw 	$t2, 0($t1)
		li 	$t3, 'n'
		beq 	$t2, $t3, checkwin_else
		
		#check square[15]!='o'
		li 	$t0, 15
		sll 	$t0, $t0, 2
		add 	$t1, $s5, $t0
		lw 	$t2, 0($t1)
		li 	$t3, 'o'
		beq 	$t2, $t3, checkwin_else
		
		#check square[16]!='lp
		li 	$t0, 16
		sll 	$t0, $t0, 2
		add 	$t1, $s5, $t0
		lw 	$t2, 0($t1)
		li 	$t3, 'p'
		beq 	$t2, $t3, checkwin_else
		
		#check square[17]!='q'
		li 	$t0, 17
		sll 	$t0, $t0, 2
		add 	$t1, $s5, $t0
		lw 	$t2, 0($t1)
		li 	$t3, 'q'
		beq 	$t2, $t3, checkwin_else
		
		#check square[18]!='r'
		li 	$t0, 18
		sll 	$t0, $t0, 2
		add 	$t1, $s5, $t0
		lw 	$t2, 0($t1)
		li 	$t3, 'r'
		beq 	$t2, $t3, checkwin_else
		
		#check square[19]!='s'
		li 	$t0, 19
		sll 	$t0, $t0, 2
		add 	$t1, $s5, $t0
		lw 	$t2, 0($t1)
		li 	$t3, 's'
		beq 	$t2, $t3, checkwin_else
		
		#check square[20]!='t'
		li 	$t0, 20
		sll 	$t0, $t0, 2
		add 	$t1, $s5, $t0
		lw 	$t2, 0($t1)
		li 	$t3, 't'
		beq 	$t2, $t3, checkwin_else
		
		#check square[21]!='u'
		li 	$t0, 21
		sll 	$t0, $t0, 2
		add 	$t1, $s5, $t0
		lw 	$t2, 0($t1)
		li 	$t3, 'u'
		beq 	$t2, $t3, checkwin_else
		
		#check square[22]!='v'
		li 	$t0, 22
		sll 	$t0, $t0, 2
		add 	$t1, $s5, $t0
		lw 	$t2, 0($t1)
		li 	$t3, 'v'
		beq 	$t2, $t3, checkwin_else
		
		#check square[23]!='w'
		li 	$t0, 23
		sll 	$t0, $t0, 2
		add 	$t1, $s5, $t0
		lw 	$t2, 0($t1)
		li 	$t3, 'w'
		beq 	$t2, $t3, checkwin_else
		
		#check square[24]!='y'
		li 	$t0, 24
		sll 	$t0, $t0, 2
		add 	$t1, $s5, $t0
		lw 	$t2, 0($t1)
		li 	$t3, 'y'
		beq 	$t2, $t3, checkwin_else
		
		#check square[25]!='z'
		li 	$t0, 12
		sll 	$t0, $t0, 2
		add 	$t1, $s5, $t0
		lw 	$t2, 0($t1)
		li 	$t3, 'z'
		beq 	$t2, $t3, checkwin_else
		
		li 	$v0,  0
		jr 	$ra
		
	checkwin_else:
	li	$v0, -1
	jr	$ra
	
	board:
		addi	$sp, $sp, -8
		sw	$a0, 0($sp)
		sw	$v0, 4($sp)
		
		
		li	$v0, 4
		la	$a0, char_board_0
		syscall
		li	$v0, 4
		la	$a0, char_board_1
		syscall
		li	$v0, 4
		la	$a0, char_board_0
		syscall
		li	$v0, 4
		la	$a0, char_board_2
		syscall
		li	$v0, 4
		la	$a0, char_board_0
		syscall
		li	$v0, 4
		la	$a0, char_board_8
		syscall
		li	$v0, 4
		la	$a0, char_board_4
		syscall
		
		#load square[1]
		addi	$t1, $zero, 1
		sll	$t1, $t1, 2
		add	$t2, $s5, $t1
		lw	$t3, 0($t2)
		add	$a0, $t3, $zero
		li	$v0, 11
		syscall
		
		li	$v0, 4
		la	$a0, char_board_5
		syscall
		
		#load square[2]
		addi	$t1, $zero, 2
		sll	$t1, $t1, 2
		add	$t2, $s5, $t1
		lw	$t3, 0($t2)
		add	$a0, $t3, $zero
		li	$v0, 11
		syscall
		
		li	$v0, 4
		la	$a0, char_board_5
		syscall
		
		#load square[3]
		addi	$t1, $zero, 3
		sll	$t1, $t1, 2
		add	$t2, $s5, $t1
		lw	$t3, 0($t2)
		add	$a0, $t3, $zero
		li	$v0, 11
		syscall
		
		li	$v0, 4
		la	$a0, char_board_5
		syscall
		
		#load square[4]
		addi	$t1, $zero, 4
		sll	$t1, $t1, 2
		add	$t2, $s5, $t1
		lw	$t3, 0($t2)
		add	$a0, $t3, $zero
		li	$v0, 11
		syscall
		
		li	$v0, 4
		la	$a0, char_board_5
		syscall
		
		#load square[5]
		addi	$t1, $zero, 5
		sll	$t1, $t1, 2
		add	$t2, $s5, $t1
		lw	$t3, 0($t2)
		add	$a0, $t3, $zero
		li	$v0, 11
		syscall
		
		li	$v0, 4
		la	$a0, char_board_6
		syscall
		
		li	$v0, 4
		la	$a0, char_board_7
		syscall
		#xong hàng 1 ;-;
		#hàng 2:
		li	$v0, 4
		la	$a0, char_board_4
		syscall
		
		#load square[6]
		addi	$t1, $zero, 6
		sll	$t1, $t1, 2
		add	$t2, $s5, $t1
		lw	$t3, 0($t2)
		add	$a0, $t3, $zero
		li	$v0, 11
		syscall
		
		li	$v0, 4
		la	$a0, char_board_5
		syscall
		
		#load square[7]
		addi	$t1, $zero, 7
		sll	$t1, $t1, 2
		add	$t2, $s5, $t1
		lw	$t3, 0($t2)
		add	$a0, $t3, $zero
		li	$v0, 11
		syscall
		
		li	$v0, 4
		la	$a0, char_board_5
		syscall
		
		#load square[8]
		addi	$t1, $zero, 8
		sll	$t1, $t1, 2
		add	$t2, $s5, $t1
		lw	$t3, 0($t2)
		add	$a0, $t3, $zero
		li	$v0, 11
		syscall
		
		li	$v0, 4
		la	$a0, char_board_5
		syscall
		
		#load square[9]
		addi	$t1, $zero, 9
		sll	$t1, $t1, 2
		add	$t2, $s5, $t1
		lw	$t3, 0($t2)
		add	$a0, $t3, $zero
		li	$v0, 11
		syscall
		
		li	$v0, 4
		la	$a0, char_board_5
		syscall
		
		#load square[10]
		addi	$t1, $zero, 10
		sll	$t1, $t1, 2
		add	$t2, $s5, $t1
		lw	$t3, 0($t2)
		add	$a0, $t3, $zero
		li	$v0, 11
		syscall
		
		li	$v0, 4
		la	$a0, char_board_6
		syscall
		
		li	$v0, 4
		la	$a0, char_board_7
		syscall
		#h?t hàng 2
		#hàng 3:
		li	$v0, 4
		la	$a0, char_board_4
		syscall
		
		#load square[11]
		addi	$t1, $zero, 11
		sll	$t1, $t1, 2
		add	$t2, $s5, $t1
		lw	$t3, 0($t2)
		add	$a0, $t3, $zero
		li 	$v0, 11
		syscall
		
		li	$v0, 4
		la	$a0, char_board_5
		syscall
		
		#load square[12]
		addi	$t1, $zero, 12
		sll	$t1, $t1, 2
		add	$t2, $s5, $t1
		lw	$t3, 0($t2)
		add	$a0, $t3, $zero
		li	$v0, 11
		syscall
		
		li	$v0, 4
		la	$a0, char_board_5
		syscall
		
		#load square[13]
		addi	$t1, $zero, 13
		sll	$t1, $t1, 2
		add	$t2, $s5, $t1
		lw	$t3, 0($t2)
		add	$a0, $t3, $zero
		li	$v0, 11
		syscall
		
		li	$v0, 4
		la	$a0, char_board_5
		syscall
		
		#load square[14]
		addi	$t1, $zero, 14
		sll	$t1, $t1, 2
		add	$t2, $s5, $t1
		lw	$t3, 0($t2)
		add	$a0, $t3, $zero
		li	$v0, 11
		syscall
		
		li	$v0, 4
		la	$a0, char_board_5
		syscall
		
		#load square[15]
		addi	$t1, $zero, 15
		sll	$t1, $t1, 2
		add	$t2, $s5, $t1
		lw	$t3, 0($t2)
		add	$a0, $t3, $zero
		li	$v0, 11
		syscall
		
		li	$v0, 4
		la	$a0, char_board_6
		syscall
		
		li	$v0, 4
		la	$a0, char_board_7
		syscall
		
		#xong hàng 3 ;-;
		#hàng 4:
		li	$v0, 4
		la	$a0, char_board_4
		syscall
		
		#load square[16]
		addi	$t1, $zero, 16
		sll	$t1, $t1, 2
		add	$t2, $s5, $t1
		lw	$t3, 0($t2)
		add	$a0, $t3, $zero
		li	$v0, 11
		syscall
		
		li	$v0, 4
		la	$a0, char_board_5
		syscall
		
		#load square[17]
		addi	$t1, $zero, 17
		sll	$t1, $t1, 2
		add	$t2, $s5, $t1
		lw	$t3, 0($t2)
		add	$a0, $t3, $zero
		li	$v0, 11
		syscall
		
		li	$v0, 4
		la	$a0, char_board_5
		syscall
		
		#load square[18]
		addi	$t1, $zero, 18
		sll	$t1, $t1, 2
		add	$t2, $s5, $t1
		lw	$t3, 0($t2)
		add	$a0, $t3, $zero
		li	$v0, 11
		syscall
		
		li	$v0, 4
		la	$a0, char_board_5
		syscall
		
		#load square[19]
		addi	$t1, $zero, 19
		sll	$t1, $t1, 2
		add	$t2, $s5, $t1
		lw	$t3, 0($t2)
		add	$a0, $t3, $zero
		li	$v0, 11
		syscall
		
		li	$v0, 4
		la	$a0, char_board_5
		syscall
		
		#load square[20]
		addi	$t1, $zero, 20
		sll	$t1, $t1, 2
		add	$t2, $s5, $t1
		lw	$t3, 0($t2)
		add	$a0, $t3, $zero
		li	$v0, 11
		syscall
		
		li	$v0, 4
		la	$a0, char_board_6
		syscall
		
		li	$v0, 4
		la	$a0, char_board_7
		syscall
		li	$v0, 4
		
	        #xong hàng 4 ;-;
		#hàng 5:
		li	$v0, 4
		la	$a0, char_board_4
		syscall
		
		#load square[21]
		addi	$t1, $zero, 21
		sll	$t1, $t1, 2
		add	$t2, $s5, $t1
		lw	$t3, 0($t2)
		add	$a0, $t3, $zero
		li	$v0, 11
		syscall
		
		li	$v0, 4
		la	$a0, char_board_5
		syscall
		
		#load square[22]
		addi	$t1, $zero, 22
		sll	$t1, $t1, 2
		add	$t2, $s5, $t1
		lw	$t3, 0($t2)
		add	$a0, $t3, $zero
		li	$v0, 11
		syscall
		
		li	$v0, 4
		la	$a0, char_board_5
		syscall
		
		#load square[23]
		addi	$t1, $zero, 23
		sll	$t1, $t1, 2
		add	$t2, $s5, $t1
		lw	$t3, 0($t2)
		add	$a0, $t3, $zero
		li	$v0, 11
		syscall
		
		li $v0, 4
		la $a0, char_board_5
		syscall
		
		#load square[24]
		addi	$t1, $zero, 24
		sll	$t1, $t1, 2
		add	$t2, $s5, $t1
		lw	$t3, 0($t2)
		add	$a0, $t3, $zero
		li	$v0, 11
		syscall
		
		li	$v0, 4
		la	$a0, char_board_5
		syscall
		
		#load square[25]
		addi	$t1, $zero, 25
		sll	$t1, $t1, 2
		add	$t2, $s5, $t1
		lw	$t3, 0($t2)
		add	$a0, $t3, $zero
		li	$v0, 11
		syscall
		
		li	$v0, 4
		la	$a0, char_board_6
		syscall
		
		li	$v0, 4
		la	$a0, char_board_7
		syscall
		
		la	$a0, char_board_0
		syscall
		
		
		lw 	$a0, 0($sp)
		lw	$v0, 4($sp)
		addi	$sp, $sp, 8
		jr	$ra

	increment:
		addi 	$t6, $t6, 1
		jr 	$ra	
		
	plus_round:
		beqz 	$t8, increment
		jr 	$ra	
		
	toUndo:
	
		# prompt undo
		
		li 	$v0, 4
		la 	$a0, char6
		syscall
		li 	$v0, 5
		syscall
		move 	$t7, $v0
		li 	$t9, 1      #undo flag up
		li 	$t8, 1
		
		beqz 	$t7, cont	#t7 =0
		li	$v0, 4
		la	$a0, char8
		syscall
		j 	main_dowhile
		
	
	main_done:
		li	$v0, 10 #terminate execution
		syscall

	
