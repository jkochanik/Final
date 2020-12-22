	.global _Z12eratosthenesPjj 
_Z12eratosthenesPjj:
	push	{r4, r5}
	push	{r6, r7}
	push	{r8, r9}
	push	{r10, r11}

	@r0 scratch array address -> gen scratch -> to summer for return
	@r1 long term size holder
	@r2 general mem location for ldr in principal iteration
	@r3 The holy index counter (don't fuck with it)
	@r4 long term array address (also don't mess with it)
	@r5 general scratch mem location
	@r6 store number 1 lmao
	@r7 general scratch
	@r8 stores distance between multiples for bitclears
	@r9 multiple index for bitclears
	@r10 loads words for bitclears
	@r11 holds current word count for current pos (r3)
	
	

	mov	r2, #0xFFFFFFFF		@r2 is register to set all true
	lsr	r1, #1
	mov	r4, r0 			@r4 is long term save for array address
	add	r3, r1, #32		@Find counter to set true by 32 bits and keep in r3. Step 1: add by 32
	lsr	r3, #6			@Step 2: divide n by 64
setAllPrime:	
	str	r2, [r0], #4		@store FFFFFFFF in every 32 bits 
	subs	r3, #4			@index counter for FFs filler subs to count down
	bne	setAllPrime

	
	mov	r3, #1			@initialize r3 as pos holder(don't change)
	mov	r6, #1			@r6 scratch register for lsl
getWord:	
	lsr	r11, r3, #5		@store word count in r11 (pos/32 * 4 = pos/8)			
	lsl	r7, r11, #2		@store byte count in r7
	ldr	r2,[r4, r7]		@load word from array store in r2 
getbit:	
	and	r5, r3, #31		@intermediate step to test bit
	lsl	r5, r6, r5		@intermediate step to test bit
	ands	r5, r2			@finally get singular bit: output 1(prime) or 0 (notprime) 
	movne	r9, r3			@r9 is bolean register to keep track if interating multiples or not 
	beq	looper



	lsl	r8, r3, #1
	add	r8, #1		@turns r8 into number counter for bit clears
	add	r9, r8
bitClear:	
	
	lsr	r0, r9, #5
	lsl	r0, #2
	ldr	r10, [r4, r0]		@load word based on where r9 is			 
	and	r5, r9, #31
	lsl	r5, r6, r5
	tst	r10, r5
	bicne	r10, r5
	str	r10, [r4, r0]
	add	r9, r8
	cmp	r1, r9
	bge	bitClear
	mov	r9, #0
	
	
	
looper:
	add	r3, #1
	cmp	r3, r1
	beq	end
	lsr	r0, r3, #5
	cmp	r9, #0
	beq	getWord
	cmp	r11, r0 
	beq	getbit
	b	getWord

end:	
	mov	r0, #0		@sum
	mov	r3, #1		@position index
endloop:
	mov	r5, #32		@word length count down
	ldr	r2, [r4], #4
endloop2:	
	and	r7, r3, #31
	lsl	r7, r6, r7
	tst	r2, r7
	addne	r0, #1
	subs	r5, #1		@counting down from 32 to see when to get new word
	add	r3, #1
	beq 	endloop		@branch to get new word
	cmp	r1, r3		@count down to see when finished entire array
	bne	endloop2	@if not finished loop again


	pop	{r10, r11}
	pop	{r8, r9}
	pop	{r6, r7}
	pop	{r4, r5}
	bx 	lr
	
	
	
	
	
	



	
	
	

	


	
	
	
