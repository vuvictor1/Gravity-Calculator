/*
;********************************************************************************************
; Author Information:                                                                       *
; Name:         Victor V. Vu                                                                *
; Email:        vuvictor@csu.fullerton.edu                                                  *
; Section:      Cpsc 240-07                                                                 *  
;                                                                                           *
; Program Information:                                                                      *
; Program Name: Gravity Calculator                                                          *
; Files: driver.cpp, gravity.asm, and isfloat.c                                             *
; This File: driver.cpp                                                                     *
; Description: Main file that outputs text and calls gravity function for math computations.*
;********************************************************************************************
;                                                                                           *
; Copyright (C) 2022 Victor V. Vu                                                           *
; This program is free software: you can redistribute it and/or modify it under the terms   * 
; of the GNU General Public License version 3 as published by the Free Software Foundation. * 
; This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY  *
; without even the implied Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. * 
; See the GNU General Public License for more details. A copy of the GNU General Public     *
; License v3 is available here:  <https://www.gnu.org/licenses/>.                           *                                                                                          
;********************************************************************************************
*/
#include <cstdio>   // Required header for standard input/output
#include <iomanip>  // Required for I/O manipulation
#include <iostream> // Required header for cout/cin

extern "C" double gravity(); // includes gravity as an external function

int main() {
  std::cout << "\nWelcome to Gravitational Attraction maintained by Victor Vu. "
               "\nThis program was last updated on February 24, 2022\n"
            << std::endl;

  double time_returned =
      gravity(); // Data is being returned from the assembly file

  std::cout << std::endl;

  if (time_returned != -1) { // Check if float has been verified

    std::cout << "The main driver received this number " << std::fixed
              << std::setprecision(9) << time_returned
              << " and will simply keep it. " << std::endl;
  } else {
    std::cout << "The main driver received this number 9.9999999 and will "
                 "simply keep it. "
              << std::endl;
  }

  std::cout << std::endl;

  std::cout << "The driver will now send integer 0 to the operating system. "
               "Have a nice day. Bye"
            << std::endl;

  return 0;
}
