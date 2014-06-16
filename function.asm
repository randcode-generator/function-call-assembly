global main

extern printf

section .data
    fmtStr: db '%i',0xA,0
    
section .text
    main:
    push 5				; argment 4
	push 10				; argment 3
	push 20				; argment 2
	push 50				; argment 1
	call calculate		; call the function "calculate"
						; eax has the return value of calculate function
	add esp, 16			; pop stack by 16. (4 arguments * 4 bytes each argument)
	
	push eax			; store the return value in stack
	lea eax, [fmtStr]	; load the formatted string into eax
	push eax			; store formatted string into eax
	call printf			; call the printf function
	add esp, 8			; pop stack by 8 (2 elements * 4 bytes each element)
	ret					; return function
	
	calculate:
	; formula: arg1 * arg2 + arg3 * arg4
	push ebp			; save ebp into stack
	mov ebp, esp		; copy esp into ebp
	sub esp, 4			; move stack pointer by 4 (1 local variable)
	mov eax, [ebp+8]	; copy argument 1 (50) into eax
	imul eax, [ebp+12]	; multiply eax with argument 2 (20) to eax
	mov [ebp-4], eax	; copy the eax value (20 * 50 = 1000) into local variable (ebp-4)
	
	mov eax, [ebp+16]	; copy argument 3 (10) into eax
	imul eax, [ebp+20]	; multiply eax with argument 4 (10 * 5 = 50) to eax
	
	add eax, [ebp-4]	; add eax with local variable (ebp-4)
	
	mov esp, ebp		; copy ebp to esp. All local variables are popped
	pop ebp				; copy the top of the stack to ebp, restore the original ebp value
	ret					; return function
