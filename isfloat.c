/*
;********************************************************************************************
; Author Information:                                                                       *
; Name:         Victor V. Vu                                                                *
; Email:        vuvictor@csu.fullerton.edu                                                  *    
;                                                                                           *
; Program Information:                                                                      *
; Program Name: Gravity Calculator                                                          *
; Files: driver.cpp, gravity.asm, and isfloat.c                                             *
; This File: isfloat.c                                                                      *
; Description: Called on by gravity.asm to verify if input is a float.                      *
;********************************************************************************************
*/
#include <ctype.h>
#include <stdio.h>

extern int isfloat(char[]); // Make ispositivefloat visible to functions

int isfloat(char user_input[]) {
  int result = 1; // Result is a float

  int decimal_found = 0; // Decimal not found

  int current_index = 0; // Starting point

  if (user_input[current_index] == '+') // if index start has a + proceed
  {
    ++current_index;
  }

  while (user_input[current_index] != '\0' && result) {
    if ((user_input[current_index] == '.') &&
        !decimal_found) // Search for decimal
    {
      decimal_found = 1;
    } else {

      if (isdigit(user_input[current_index]) == 0) {
        result = 0; // Return 0 = Not a float
        break;
      }
    }
    ++current_index;
  }

  return (result && decimal_found); // return confirmation if file is a float
}
