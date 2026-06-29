#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct proc {
    union EAX {
        uint32_t eax;
        struct AX {
            union {
                uint16_t ax;
                struct {
                    uint8_t al_ax;
                    uint8_t ah_ax;
                } u16_8_ax;
            } t16_ax;
        } AX;
    } EAX;

    union ECX {
        uint32_t ecx;
        struct CX {
            union {
                uint16_t cx;
                struct {
                    uint8_t al_cx;
                    uint8_t ah_cx;
                } u16_8_cx;
            } t16_cx;
        } CX;
    } ECX;

    union EDX {
        uint32_t edx;
        struct DX {
            union {
                uint16_t dx;
                struct {
                    uint8_t al_dx;
                    uint8_t ah_dx;
                } u16_8_dx;
            } t16_dx;
        } DX;
    } EDX;

    uint32_t EIP;
};
struct proc cpu;

void parser(char command[50]);
uint32_t* get_register_ptr(char *reg, int* type);
void mov(char reg1[50], char reg2[50]);
void add(char reg1[50], char reg2[50]);
void sub(char reg1[50], char reg2[50]);
void shw(char reg[50]);

int main() {
    FILE* fin = fopen("commands.txt", "r");
    char command[50];
    cpu.EIP = 0;
    while (fgets(command, sizeof(command), fin)) {
        if (strlen(command) > 0 && command[0] != '\n' && command[0] != '\r' && command[0] != '\t' && command[0] != EOF) {
            cpu.EIP += 1;
            parser(command);
        }
    }
    fclose(fin);
    return 0;
}

void parser(char command[50]) {
    char cmd[10], arg1[50] = {0}, arg2[50] = {0};
    int args = sscanf(command, "%s %s %s", cmd, arg1, arg2);

    if (args == 2 && strcmp(cmd, "shw") == 0) {
        shw(arg1);
    } else if (args == 3) {
        if (strcmp(cmd, "mov") == 0)
            mov(arg1, arg2);
        else if (strcmp(cmd, "add") == 0)
            add(arg1, arg2);
        else if (strcmp(cmd, "sub") == 0)
            sub(arg1, arg2);
    }
}

uint32_t* get_register_ptr(char *reg, int* type) {
    if (strcmp(reg, "EAX") == 0) { *type = 32; return &cpu.EAX.eax; }
    else if (strcmp(reg, "AX") == 0) { *type = 16; return (uint32_t*)&cpu.EAX.AX.t16_ax.ax; }
    else if (strcmp(reg, "AL") == 0) { *type = 8; return (uint32_t*)&cpu.EAX.AX.t16_ax.u16_8_ax.al_ax; }
    else if (strcmp(reg, "AH") == 0) { *type = 8; return (uint32_t*)&cpu.EAX.AX.t16_ax.u16_8_ax.ah_ax; }
    else if (strcmp(reg, "ECX") == 0) { *type = 32; return &cpu.ECX.ecx; }
    else if (strcmp(reg, "CX") == 0) { *type = 16; return (uint32_t*)&cpu.ECX.CX.t16_cx.cx; }
    else if (strcmp(reg, "CL") == 0) { *type = 8; return (uint32_t*)&cpu.ECX.CX.t16_cx.u16_8_cx.al_cx; }
    else if (strcmp(reg, "CH") == 0) { *type = 8; return (uint32_t*)&cpu.ECX.CX.t16_cx.u16_8_cx.ah_cx; }
    else if (strcmp(reg, "EDX") == 0) { *type = 32; return &cpu.EDX.edx; }
    else if (strcmp(reg, "DX") == 0) { *type = 16; return (uint32_t*)&cpu.EDX.DX.t16_dx.dx; }
    else if (strcmp(reg, "DL") == 0) { *type = 8; return (uint32_t*)&cpu.EDX.DX.t16_dx.u16_8_dx.al_dx; }
    else if (strcmp(reg, "DH") == 0) { *type = 8; return (uint32_t*)&cpu.EDX.DX.t16_dx.u16_8_dx.ah_dx; }
    else if (strcmp(reg, "EIP") == 0) { *type = 32; return &cpu.EIP; }
    return NULL;
}

void mov(char reg1[50], char reg2[50]) {
    int type1, type2;
    uint32_t value;
    uint32_t *ptr1 = get_register_ptr(reg1, &type1);

    if (strncmp(reg2, "0x", 2) == 0) { value = strtoul(reg2, NULL, 16); }
    else { value = *get_register_ptr(reg2, &type2); }

    if (type1 == 16) *(uint16_t*)ptr1 = (uint16_t)value;
    else if (type1 == 8) *(uint8_t*)ptr1 = (uint8_t)value;
    else *ptr1 = value;
}

void add(char reg1[50], char reg2[50]) {
    int type1, type2;
    uint32_t val1, val2;
    uint32_t *ptr1 = get_register_ptr(reg1, &type1);
    
    if (type1 == 32) val1 = *ptr1;
    else if (type1 == 16) val1 = *(uint16_t*)ptr1;
    else val1 = *(uint8_t*)ptr1;
    
    if (strncmp(reg2, "0x", 2) == 0) { val2 = strtoul(reg2, NULL, 16); }
    else {
        uint32_t *ptr2 = get_register_ptr(reg2, &type2);
        if (type2 == 32) val2 = *ptr2;
        else if (type2 == 16) val2 = *(uint16_t*)ptr2;
        else val2 = *(uint8_t*)ptr2;
    }
    
    uint32_t result = val1 + val2;
    if (type1 == 32) *ptr1 = result;
    else if (type1 == 16) *(uint16_t*)ptr1 = (uint16_t)result;
    else *(uint8_t*)ptr1 = (uint8_t)result;
}

void sub(char reg1[50], char reg2[50]) {
    int type1, type2;
    uint32_t val1, val2;
    uint32_t *ptr1 = get_register_ptr(reg1, &type1);
    
    if (type1 == 32) val1 = *ptr1;
    else if (type1 == 16) val1 = *(uint16_t*)ptr1;
    else val1 = *(uint8_t*)ptr1;
    
    if (strncmp(reg2, "0x", 2) == 0) { val2 = strtoul(reg2, NULL, 16); }
    else {
        uint32_t *ptr2 = get_register_ptr(reg2, &type2);
        if (type2 == 32) val2 = *ptr2;
        else if (type2 == 16) val2 = *(uint16_t*)ptr2;
        else val2 = *(uint8_t*)ptr2;
    }
    
    uint32_t result = val1 - val2;
    if (type1 == 32) *ptr1 = result;
    else if (type1 == 16) *(uint16_t*)ptr1 = (uint16_t)result;
    else *(uint8_t*)ptr1 = (uint8_t)result;
}


void shw(char reg[50]) {
    int type1;
    uint32_t result;
    if (strncmp(reg, "0x", 2) == 0) { result = strtoul(reg, NULL, 16); }
    else {
        uint32_t *ptr = get_register_ptr(reg, &type1);
        if (type1 == 32) { result = *ptr; }
        else if (type1 == 16) { result = *(uint16_t*)ptr; }
        else if (type1 == 8) { result = *(uint8_t*)ptr; }
    }
    printf("0x%x\n", result);
}
/*
gcc -std=c11 -Wall -Werror -Wextra processor.c -o processor
./processor > processor_output.txt
*/