
.data
basenumber: .double 0
powernumber: .double 0

   hello: .asciz  "Hello to the power assignment put in a number"
   
   helloagain: .asciz "Another one please"
   
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

  mov $basenumber, %rcx       #takes basenumber, stores it in rcx for mult
  mov $basenumber, %r8        #takes basenumber, stores it in r8 for result
  mov $powernumber, %r9       #takes powernumber, stores it in r9 to calcula
                              #the amount of loops needed for answer
  
  mov $answer, %rdi           #calls the answer text and moves it to rdi
  mov %r8, %rsi               #moves the calculated result to rsi so it can 
  mov $0, %rax                #be inserted into the answer text
  call printf                 #obligatory rax clear before call printf

  call exit

  mov %rbp, %rsp  # These are the end statements for the stack
  pop %rbp

loop:           #for calculating the end result
  cmp $1, %r9   #calculates whether to run the loop, runs if r9 > 1
  jle end       #jumps to end if r9 <= 1
  imul %rcx, %r8    #multiplies result of r8 with basenumber in rcx
  sub $1, %r9     #decrements r9 with 1 so loop doesn't run infinitely
  jmp loop        #runs it again
end:
  


