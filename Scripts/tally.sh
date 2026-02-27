#!/usr/bin/env bash

echo
echo "this can take a while, ~1 minute 30 seconds for 10000 files"
echo

# Recursive globbing
shopt -s globstar nullglob

awk '
BEGIN {
    # RV32IM + selected pseudo instructions
    split("\
            add \
            sub \
            xor \
            or \
            and \
            sll \
            srl \
            sra \
            slt \
            sltu \
            addi \
            xori \
            ori \
            andi \
            slli \
            srli \
            srai \
            slti \
            sltiu \
            lb \
            lh \
            lw \
            lbu \
            lhu \
            sb \
            sh \
            sw \
            beq \
            bne \
            blt \
            bge \
            bltu \
            bgeu \
            jal \
            jalr \
            lui \
            auipc \
            ecall \
            ebreak \
            mul \
            mulh \
            mulhsu \
            mulhu \
            div \
            divu \
            rem \
            remu \
            li \
            nop",
           insts)

    for (i in insts) {
        counts[insts[i]] = 0
        valid[insts[i]] = 1
    }
}

{
    sub(/\r$/, "") #handles windows line endings or sumthin

    # Remove comments
    sub(/#.*/, "", $0)

    # Trim leading whitespace
    sub(/^[ \t]+/, "", $0)

    # Skip empty lines
    if ($0 == "") next

    # Skip directives
    if ($0 ~ /^\./) next

    # Remove label if present
    sub(/^[^:]+:[ \t]*/, "", $0)
    if ($0 == "") next

    # Extract first token (mnemonic)
    split($0, fields, /[ \t,]+/)
    inst = tolower(fields[1])

    if (inst in valid) {
        counts[inst]++
    }
}

END {
    print "==== Instruction Counts ===="
    for (i in insts) {
        printf "%-8s %d\n", insts[i], counts[insts[i]]
    }
}
' **/*.s
