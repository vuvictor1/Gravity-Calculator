/*
;********************************************************************************************
; Author Information:                                                                       *
; Name:         Victor V. Vu                                                                *
; Email:        vuvictor@csu.fullerton.edu                                                  *    
;                                                                                           *
; Program Information:                                                                      *
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
