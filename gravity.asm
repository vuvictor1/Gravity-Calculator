;********************************************************************************************
; Author Information:                                                                       *
; Name:         Victor V. Vu                                                                *
; Email:        vuvictor@csu.fullerton.edu                                                  *
; Section:      Cpsc 240-07                                                                 *  
;                                                                                           *
; Program Information:                                                                      *
; Program Name: Gravity Calculator                                                          *
; Files: driver.cpp, gravity.asm, and isfloat.c                                             *
; This File: gravity.asm                                                                    *
; Description: Takes user input, verify float(call atof), and calculates gravity.           *
;********************************************************************************************
;                                                                                           *
; Copyright (C) 2022 Victor V. Vu                                                           *
; This program is free software: you can redistribute it and/or modify it under the terms   * 
; of the GNU General Public License version 3 as published by the Free Software Foundation. * 
; This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY  *
; without even the implied Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. * 
; See the GNU General Public License for more details. A copy of the GNU General Public     *
; License v3 is available here:  <https://www.gnu.org/licenses/>.                           *                                                                                          
;********************************************************************************************

extern printf
extern scanf
extern fgets
extern stdin
extern strlen ; Required externs to use functions
extern isfloat ; Uses isfloat file
extern atof ; converts string to float

INPUT_LEN equ 256 ; Max bytes of name, title, response

global gravity ; Giving the function global scope

segment .data ; Indicates initialized data

welcome db "If errors are discovered please report them to Victor at victor@colunbia.com for a rapid update. At Columbia, Inc, the customer comes first.", 10, 10, 0 ; 0 = endline / 10 means newline

prompt db "Please enter your first and last name: ", 0 ; Prompt output

string_format db "%s", 0 ; Format specifier for strings, creates an array of characters

job_output db 10, "Thank you %s. We appreciate your bussiness.", 10, 10, 0

job db 10, "Please enter your job title (Nurse, Programmer, Teacher, Carpenter, Mechanic, Bus Driver, Barista, Hair Dresser, Acrobat, Senator, Sales Clerk, etc): ", 0

text db "We understand that you plan to drop a marble from a high vantage point.", 10, 10, 0

meter db "Please enter the height of the marble above ground surface in meters: ", 0

float_format db "%lf", 0

float_output db 10, "The marble you drop from that height will reach earth after %lf seconds.", 10, 10, 0

name_output db "Thank you %s for your participation. May you always reach great heights.", 10, 0

error db 10, "An error was detected in the input data. You may run this program again.", 10, 10, 0

error_name db "Thank you %s for your participation. May you never lose sight of the goal.", 10, 0

segment .bss ; Indicates values that require user input

title: resb INPUT_LEN
name: resb INPUT_LEN ; Reserve bytes
user_input: resb 32

segment .text ; Stores executable code

gravity: ; = int main() {} <--- assembly enters program

; Required 15 pushes and pops for asssembly to run
push       rbp

mov        rbp, rsp
push       rbx
push       rcx
push       rdx
push       rsi
push       rdi
push       r8
push       r9
push       r10
push       r11
push       r12
push       r13
push       r14
push       r15
pushf

; Printf blocks for welcome message
mov rax, 0 ; tells not to print float
mov rdi, welcome ; passes intro
call printf ; call function to print

; print out prompt for user input
mov rax, 0
mov rdi, prompt 
call printf

; fgets block to take input
mov rax, 0
mov rdi, name
mov rsi, INPUT_LEN ; read 256 btyes
mov rdx, [stdin] ; Move data from stdin to rdx
call fgets ; Call fgets function

mov rax, 0
mov rdi, name
call strlen ; call strlen which returns length of string up to \0
sub rax, 1 ; subtract 1 from rax to find \n
mov byte [name + rax], 0 ; replace byte where \n is with \0

; print out Job prompt
mov rax, 0
mov rdi, job
call printf

mov rax, 0
mov rdi, title
mov rsi, INPUT_LEN ; read 256 btyes
mov rdx, [stdin] ; Move data from stdin to rdx
call fgets ; Call fgets function

mov rax, 0
mov rdi, title
call strlen ; call strlen which returns length of string up to \0
sub rax, 1 ; subtract 1 from rax to find \n
mov byte [title + rax], 0 ; replace byte where \n is with \0

; print job title
mov rax, 0
mov rdi, job_output
mov rsi, title
call printf

mov rax, 0
mov rdi, text
call printf

; print prompt asking for meter
mov rax, 0
mov rdi, meter
call printf

mov rax, 0
mov rdi, string_format ; Takes height as a string
mov rsi, user_input ; scans for height
call scanf

; pass user input into isfloat to check for float
mov rax, 0
mov rdi, user_input ; Passes user_input string into checker
call isfloat

cmp rax, 0
je bad_input ; Jump if input is not a float

mov rax, 1
mov rdi, user_input
call atof ; Convert string to float
movsd xmm15, xmm0

;------------------------------------------------
; Math Portion
mov rax, 0x402399999999999a ; Move value of 9.8
movq xmm14, rax

divsd xmm15, xmm14 ; Divide
sqrtsd xmm15, xmm15 ; Squareroot

mov rax, 1
mov rdi, float_output
movsd xmm0, xmm15
call printf
;------------------------------------------------

mov rax, 0
mov rdi, name_output
mov rsi, name
call printf

jmp good_input ; If code is good move on

bad_input: ; Where bad code jumps to
mov rax, 0
mov rdi, error
call printf

mov rax, 0
mov rdi, error_name
mov rsi, name
call printf

mov rax, 1
neg rax ; -1
cvtsi2sd xmm0, rax ; Sends driver -1 for failure

jmp end_of_file ; End program

good_input:
movsd xmm0, xmm15 ; Return time to driver

end_of_file:

; Backs up 15 pushes and pop, required for assembly
popf
pop rbx
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rcx
pop rdx
pop rsi
pop rdi
pop rbp

ret ; return statemnt
