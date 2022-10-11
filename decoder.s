.data
output: .asciz "%c"
output2: .asciz "%ld"
.text

.include "helloWorld.s"

.global main

# ************************************************************
# Subroutine: decode                                         *
# Description: decodes message as defined in Assignment 3    *
#   - 2 byte unknown                                         *
#   - 4 byte index                                           *
#   - 1 byte amount                                          *
#   - 1 byte character                                       *
# Parameters:                                                *
#   first: the address of the message to read                *
#   return: no return value                                  *
# ************************************************************
decode:
	# prologue
	pushq	%rbp 			# push the base pointer (and align the stack)
	movq	%rsp, %rbp		# copy stack pointer value to base pointer

  push %rdi
  call compar

	# epilogue
	movq	%rbp, %rsp		# clear local variables from stack
	popq	%rbp			# restore base pointer location 
	ret

main:
	pushq	%rbp 			# push the base pointer (and align the stack)
	movq	%rsp, %rbp		# copy stack pointer value to base pointer

	movq	$MESSAGE, %rdi	# first parameter: address of the message
	call	decode			# call decode

	mov %rsp, %rbp
  popq	%rbp			# restore base pointer location 
	movq	$0, %rdi		# load program exit code
	call	exit			# exit the program

printer:
 
  pop %rcx
  cmpq $1, %rcx
  jl compar2
  dec %rcx
  
  pop %r9
  mov %r9, %rsi
  push %r9
  push %rcx
  

  mov $output, %rdi
  mov $0, %rax
  call printf
  jmp printer
  
  
compar:
  
 
  pop %r9
  mov $0, %r11
  mov (%r9), %r11b
  inc %r9
  mov $0, %r8
  mov (%r9), %r8b
  inc %r9
  mov $0, %r12
  mov (%r9), %r12b
  push %r12
  push %r11
  push %r8
  jmp printer
  
compar2:
  pop %r15
  
  pop %r8
  
  cmp $0, %r8
  je end1
  mov $8, %rax
  mul %r8
  mov $MESSAGE, %r9
  add %rax, %r9
  push %r9
  jmp compar

end1:
  movq  %rbp, %rsp    # clear local variables from stack
  popq  %rbp      # restore base pointer location 
  ret
