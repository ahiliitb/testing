        section .text
        global hadarmard_prod

hadarmard_prod:
        push rdi                       ; pointer to mat1
        push rsi                       ; scaler 1
        push rdx                       ; pointer to mat2
        push rcx                       ; scaler 2
        push r8                        ; pointer to mat3
        push r9                        ; number of rows/ columns of the matrix (n)
        push r11


; ; 0-indexing on all matrices
; ; mat1[j][i] = rdi+(r9*j+i)*8
; ; GOAL - Compute hadarmard product of of mat1, mat2 and save the result in mat3
; ; Note : mat1, mat2 and mat3 here are not the same as one given in problem statement.
; ; They are just placeholders for any three matrices using this functionality.

; ; TODO - Fill your code here performing the hadarmard product in the following order
; ; for(int i = 0; i < n; i++){for(int j = 0; j < n; j++){mat3[i][j] = mat1[i][j] * mat2[i][j];}}

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
                        imul rax, rbx  ;; finding both matrix elements
                        add rax, r13
                        imul rax, 8
                        mov r14, [rdi+rax]
                        mov r15, [rdx+rax]

                        imul r14, r15  ;; multiplying
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
