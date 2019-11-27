# pipeline

## Execute

- environment: linux

- language: verilog

- require package: iverilog

- compile and run

  ```bash
  cd code
  bash run.sh
  ```

## Structure



![datapath](image/datapath.png?raw=true)

```
pipeline
└── code
    │   # testbench and core
    ├── testbench.v
    ├── CPU.v
    │
    │   # modules
    ├── MUX_PC.v
    ├── PC.v
    ├── Add_PC.v
    ├── Instruction_memory.v
    │
    ├── Pipeline_IFID.v
    ├── HazzardDetection.v
    ├── Control.v
    ├── MUX_IDEX.v
    ├── Add_Branch.v
    ├── Register.v
    ├── ImmGem.v
    │
    ├── Pipeline_IDEX.v
    ├── MUX_ALUSrc.v
    ├── MUX_ALU1.v
    ├── MUX_ALU2.v
    ├── ALU_Control.v
    ├── ALU.v
    ├── Forwarding.v
    │
    ├── Pipeline_EXMEM.v
    ├── Data_Memory.v
    ├── Pipeline_MEMWB.v
    └── MUX_WB.v
```

## Instructions

### Main Control

| Instruction | inst[6:0] | ALUOp | ALUSrc | Branch | MemRead | MemWrite | RegWrite | MemtoReg |
| :---------: | :-------: | :---: | :----: | :----: | :-----: | :------: | :------: | :------: |
|     lw      |  0000011  |  00   |   1    |   0    |    1    |    0     |    1     |    1     |
|     sw      |  0100011  |  00   |   1    |   0    |    0    |    1     |    0     |    0     |
|     beq     |  1100011  |  01   |   0    |   1    |    0    |    0     |    0     |    0     |
|  R-format   |  0110011  |  10   |   0    |   0    |    0    |    0     |    1     |    0     |
|    addi     |  0010011  |  11   |   1    |   0    |    0    |    0     |    1     |    0     |

### ALU Control

| Instruction | ALUOp | funct7  | funct3 | ALUCtr |
| :---------: | :---: | :-----: | :----: | :----: |
|     lw      |  00   |         |        |  000   |
|     sw      |  00   |         |        |  000   |
|     beq     |  01   |         |        |  001   |
|     add     |  10   | 0000000 |  000   |  000   |
|     sub     |  10   | 0100000 |  000   |  001   |
|     mul     |  10   | 0000001 |  000   |  010   |
|     or      |  10   | 0000000 |  110   |  100   |
|     and     |  10   | 0000000 |  111   |  101   |
|    addi     |  11   |         |        |  000   |

### ALU

| ALUCtr |   Operation    |
| :----: | :------------: |
|  000   |    addition    |
|  001   |  subtraction   |
|  010   | multiplication |
|  100   |   logical OR   |
|  101   |  logical AND   |

