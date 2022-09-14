.data
  basenumber: .quad 0
  powernumber: .quad 0

   hello: .asciz  "Hello to the power assignment put in non-negative base"
   
   helloagain: .asciz "And now the exponent please"
   
   basenumberinput: .asciz "%ld"
   
   powernumberinput: .asciz "%ld"
   
   answer: .asciz "The result of the power function is: %ld"
   .data

.global main
.text

main:

  push %rbp
  mov %rsp, %rbp  #These are the prologue statements to set the stack

  mov $hello, %rdi    #prints welcome message and ask for base number
  mov $0, %rax
  call printf

  mov $basenumberinput, %rdi  #scans for base number, stores it 
  mov $basenumber, %rsi       # in basenumber
  mov $0, %rax
  call scanf

  mov $helloagain, %rdi     #asks for power number
  mov $0, %rax
  call printf

  mov $powernumberinput, %rdi   #scans for power number, stores it 
  mov $powernumber, %rsi        # in powernumber
  mov $0, %rax
  call scanf

  mov basenumber, %rax
  mov powernumber, %rsi       #moves numbers to registers where they can be
  mov basenumber, %rdi        # accessed during a subroutine

  call compare
  call pow

  mov $answer, %rdi           #calls the answer text and moves it to rdi
  mov %rax, %rsi               #moves the calculated result to rsi so it can
  mov $0, %rax                           #be inserted into the answer text
  call printf                 #obligatory rax clear before call printf

  mov %rbp, %rsp  # These are the end statements for the stack
  pop %rbp

end:

  call exit        #loads exit code for program

compare:
  cmpq $1, %rsi     #checks if the exponent is greater or equal to 1   
  jl return1         # if exponent < 1 jump to sub returning 1
  ret
pow:
  
  cmpq $1, %rsi        #checks if more iterations are needed
  jle end1            #jumps to end if no iterations are needed
  mulq  %rdi           #Mulitplies %rax by basenumber stored in r8
  dec %rsi             #decrements powernumber by 1
  jmp pow             #returns to loop

end1:
  ret                #returns to main

return1: 
  
    mov $1, %rax    #moves 1 to rax when exponent is 0     
    ret             #returns to main
