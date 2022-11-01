.data
commainput: .quad  0
output: .asciz "%c"
input: .asciz "%c"
ending: .asciz "\n"

storage: .fill 60000

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
  mov $storage, %rcx
  mov $0, %rsi
  mov (%rdi), %sil
  mov $1, %r14
  jmp divider

	movq %rbp, %rsp
	popq %rbp
	ret

crazyfast:
inc %rdi
movq $0, %rsi
movb (%rdi), %sil
jmp divider

divider:                            #this subroutine checks the current BF
cmpb $43, %sil                      #with its ascii value to go to the correct 
je plus                             #subroutine

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

cmpb $0, %sil
je end

jmp crazyfast

plus:
addb $1, (%rcx)                 #increments current cell
jmp crazyfast

minus:
subb $1, (%rcx)                 #decrements current cell
jmp crazyfast

cellback:
sub $1, %rcx                  #the name speaks for itself
jmp crazyfast

cellforward:
add $1, %rcx                  #the name speaks for itselft
jmp crazyfast

printer:
push %rdi
mov $0, %rsi
mov (%rcx), %sil
push %rcx                               
mov $output, %rdi           #subroutine for printing the value of the current
mov $0, %rax                #cell as a character to the terminal
call printf
pop %rcx
pop %rdi
jmp crazyfast

startsub:
mov $0, %rsi
mov (%rcx), %sil
cmp $0, %rsi
je skipper
push %rdi                         #subroutine for starting subroutines
mov $0, %rax
push %rax
jmp crazyfast

stopsub:
pop %rax
pop %r8
mov (%rcx), %sil                  #subroutine for ending subroutines
cmp $0, %sil
je crazyfast
mov %r8, %rdi
dec %rdi
jmp crazyfast

comma:
push %rdi
mov $input, %rdi                    #subroutine for taking input
mov %rcx, %rsi
push %rcx
movq $0, %rax
call scanf
pop %rcx
pop %rdi

jmp crazyfast

skipper:
inc %rdi
movq $0, %rsi
movb (%rdi), %sil                   #This subroutine iterates through the
cmp $93, %rsi                       #instructions when a subroutine doesn't 
je decounter                        #satisfy the if condition
cmp $91, %rsi
je counter
jmp skipper

counter:
add $1, %r14                      #counter for opening brackets
jmp skipper   

decounter:
dec %r14                  
cmp $0, %r14                      #counter for closing brackets
jne skipper
mov $1, %r14
jmp crazyfast

end:
mov $ending, %rdi                 #Skips a line for neater results
mov $0, %rax                      
call printf

movq %rbp, %rsp                   #statemetns to return to main
popq %rbp
ret

