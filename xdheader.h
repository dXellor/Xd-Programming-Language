#ifndef XDHEADER_H
#define XDHEADER_H

#define CHAR_BUFFER_SIZE 128
#define TRUE 1
#define FALSE 0

// Data types
enum types {NO_TYPE, INT, FLOAT, CHAR, STRING, BOOL, VOID};

// Arithmetic operators
enum arops {ADD, SUB, MUL, DIV, MOD, INC, DEC};

// Logical operators
enum logop {LT, GT, LE, GE, EQ, NE};

// Bitwise operators
enum bitop {AND, OR, XOR, NOT};

#endif
