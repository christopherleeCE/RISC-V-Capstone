start:
        li t0, 0x0
        li t1, 0xF
        jal zero, label
        nop
        nop
        nop
        label:
        nop
        nop
        nop


        beq t0, t1, end
label_0:        
        beq t0, t1, end
label_1:        
        beq t1, t1, end
        #jal zero, end
label_2:        
        beq t0, t1, end
label_3:        
        beq t0, t1, end
label_4:        
        beq t0, t1, end
label_5:        
        beq t0, t1, end
label_6:        
        beq t0, t1, label_12
label_7:        
        beq t0, t1, label_13
label_8:        
        beq t0, t1, label_14
label_9:        
        beq t0, t1, label_15
label_10:        
        beq t0, t1, label_16
label_11:        
        beq t0, t1, label_17
label_12:        
        beq t0, t1, label_18
label_13:        
        beq t0, t1, label_19
label_14:        
        beq t0, t1, label_20
label_15:        
        beq t0, t1, label_16
label_16:        
        beq t0, t1, label_17
label_17:        
        beq t0, t1, label_18
label_18:        
        beq t0, t1, label_19
label_19:        
        beq t0, t1, label_20
label_20:        
        #jal zero, end_after_end
        beq t0, t1, end
        nop
        nop
        nop
end:
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        ebreak
        nop
        nop
        nop
        nop
        nop
        nop
        nop