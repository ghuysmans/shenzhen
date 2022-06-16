# This line is a comment.
loop: # until ACC is ten
	teq acc 10
+	jmp end
	mov 50 x2
	add 1
	jmp loop
end:
	mov 0 acc # reset counter
