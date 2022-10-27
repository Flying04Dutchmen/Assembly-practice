.data
commainput: .quad  0
storage: .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
output: .asciz "%c"
input: .asciz "%ld"
ending: .asciz "\n"
.global brainfuck

format_str: .asciz "We should be executing the following code:\n%s"
# Your brainfuck subroutine will receive one argument:
# a zero termianted string containing the code to execute.
.text
brainfuck:
	pushq %rbp
	movq %rsp, %rbp

  mov $0, %rsi 
	mov %rdi, %rsi
  push %rdi
	movq $format_str, %rdi
  mov $0, %rax
  call printf

  pop %rdi
 # dec %rdi
  mov $storage, %rcx
 # jmp crazyfast
  mov $0, %rsi
  mov (%rdi), %sil
  jmp divider

	movq %rbp, %rsp
	popq %rbp
	ret

crazyfast:
inc %rdi
mov $0, %rsi
mov (%rdi), %sil
jmp divider

divider:
cmpb $43, %sil
je plus

cmpb $45, %sil
je minus

cmpb $60, %sil
je cellback

cmpb $62, %sil
je cellforward

cmpb $44, %sil
je comma

cmpb $46, %sil
je printer

cmpb $91, %sil
je startsub

cmpb $93, %sil
je stopsub

mov $ending, %rdi
mov $0, %rax
call printf

movq %rbp, %rsp
popq %rbp
ret

plus:
add $1, (%rcx)
jmp crazyfast

minus:
sub $1, (%rcx)
jmp crazyfast

cellback:
sub $1, %rcx
jmp crazyfast

cellforward:
add $1, %rcx
jmp crazyfast

printer:
push %rdi
mov (%rcx), %rsi
push %rcx
mov $output, %rdi
mov $0, %rax
call printf
pop %rcx
pop %rdi
jmp crazyfast

startsub:
push %rdi
jmp crazyfast

stopsub:
mov $0, %rsi
mov (%rcx), %sil
pop %r8
cmp $0, %rsi
je crazyfast
mov %r8, %rdi
dec %rdi
jmp crazyfast

comma:
push %rdi
push %rsi
mov $input, %rdi
mov $commainput, %rsi
mov $0, %rax
call scanf
mov $0, %r8
mov commainput, %r8
pop %rsi
pop %rdi
cmp $0, %r8
jg incrementer

jmp crazyfast


incrementer:
cmp $0, %r8
je crazyfast
add $1, (%rcx)
dec %r8
jmp incrementer


