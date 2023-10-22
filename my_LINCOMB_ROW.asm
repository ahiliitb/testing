        section .text
        global lin_comb

lin_comb:
        push rdi                       ; pointer to mat1
        push rsi                       ; scaler 1
        push rdx                       ; pointer to mat2
        push rcx                       ; scaler 2
        push r8                        ; pointer to mat3
        push r9                        ; number of rows/ columns of the matrix (n)
        push r11

; ; 0-indexing on all matrices
; ; mat1[j][i] = rdi+(r9*j+i)*8
; ; GOAL - Perform matrix linear combination of mat1, mat2 and save result in mat3
; ; Note : mat1, mat2 and mat3 here are not the same as one given in problem statement.
; ; They are just placeholders for any three matrices using this functionality.

; ; TODO - Fill your code here performing the matrix linear combination in the following order
; ; for(int i = 0; i < n; i++){for(int j = 0; j < n; j++){mat3[i][j] = s1*mat1[i][j] + s2*mat2[i][j];}}

        mov r12, 0  ;; represents i
        mov r13, 0  ;; represents j 

        loop_i:
                cmp r12, r9
                je loop_i_end   ;; if (i == n) outer loop breaks

                loop_j:
                        cmp r13, r9   ;; if (j == n) inner loop breaks
                        je loop_j_end

                        mov rbx, r12
                        imul rbx, r9
                        imul rax, rbx    ;;operations for the first term i.e. mat1
                        add rax, r13
                        imul rax, 8
                        mov r14, [rdi+rax]
                        mov rbx, r14
                        imul rbx, rsi
                        imul rax, rbx
                        mov r14, rax

                        mov rbx, r12
                        imul rbx, r9
                        imul rax, rbx    ;;operations for the second term i.e. mat2
                        add rax, r13
                        imul rax, 8
                        mov r15, [rdx+rax]
                        mov rbx, r15
                        imul rbx, rcx
                        imul rax, rbx
                        mov r15, rax

                        add r14, r15   ;; adding both the terms

                        mov rbx, r12
                        imul rbx, r9
                        imul rax, rbx    ;;moving the sum into the mat3
                        add rax, r13
                        imul rax, 8
                        mov [r8+rax], r14


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
        pop r9
        pop r8
        pop rcx
        pop rdx
        pop rsi
        pop rdi
        ret
