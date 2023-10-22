        section .text
        global  alt_sum

alt_sum:
        push rdi                       ; pointer to mat
        push rdx                       ; number of rows/ columns of the matrix (n)
        push r11

; ; 0-indexing on all matrices
; ; mat1[j][i] = rdi+(r9*j+i)*8
; ; GOAL - Perform matrix alternate summation of elements in matrix and return the sum

; ; TODO - Fill your code here performing the matrix alternate summation in the following order
; ; for(int i = 0; i < n; i++){for(int j = 0; j < n; j++){sum += (-1)^(i+j)*mat1[i][j];}}

        mov r12, 0  ;; represents i
        mov r13, 0  ;; represents j 
        mov rsi, 0  ;; final sum

        loop_i:
                cmp r12, r9
                je loop_i_end   ;; if (i == n) outer loop breaks

                loop_j:
                        cmp r13, r9   ;; if (j == n) inner loop breaks
                        je loop_j_end

                        mov rbx, r12
                        imul rbx, r9
                        imul rax, rbx  
                        add rax, r13
                        imul rax, 8
                        mov r14, [rdi+rax] ;; storing mat1[i][j] in r14

                        mov rax, r12
                        add rax, r13

                        test rax, 1 

                        jz is_even    ; Jump to is_even label if the LSB is 0 (even)
                        jmp is_odd    ; Jump to is_odd label if the LSB is 1 (odd)

                        is_even:
                                add rsi, r14
                                inc r13
                                jmp loop_j
                        is_odd:
                                imul r14, -1
                                add rsi, r14
                                inc r13
                                jmp loop_j

                        
                loop_j_end:
                        mov r13, 0
                        inc r12
                        jmp loop_i

        loop_i_end:
                ; outer loop breaks


; ; End of code to be filled
        pop r11
        pop rdx
        pop rdi
        ret
