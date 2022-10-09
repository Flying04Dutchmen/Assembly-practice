.data
output: .asciz "%c"
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

  mov %rdi, %r8
  mov %rdi, %r9
  mov %rdi, %r10
  add $1, %r9
  add $2, %r8
  mov (%r8), %r8b
  mov (%r9), %r9b
  mov %r9b, %cl
  movb (%r10), %r10b
  mov $0, %rsi
  mov %r10b, %sil
  call printer
  call compar
  call decode
  

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
 
  pushq %rbp      # push the base pointer (and align the stack)
  movq  %rsp, %rbp    # copy stack pointer value to base pointer

  mov $output, %rdi
  mov $0, %rax
  call printf
  dec %cl 
  cmp $0, %cl
  jg printer
  movq  %rbp, %rsp    # clear local variables from stack
  popq  %rbp      # restore base pointer location 

compar:
  pushq %rbp      # push the base pointer (and align the stack)
  movq  %rsp, %rbp    # copy stack pointer value to base pointer

  cmp $0, %r8b
  je end1
  mov $0, %rax
  mov %r8b, %al
  mov $8, %r15
  mul %r15
  mov $MESSAGE, %rdi
  add %rax, %rdi
  

  movq  %rbp, %rsp    # clear local variables from stack
  popq  %rbp      # restore base pointer location 
  ret
end1:

    ret
