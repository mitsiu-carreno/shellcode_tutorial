#include <unistd.h>
#include <iostream>

int main(){
  int return_value = execve("//bin/sh", 0, 0);
  std::cout << "Program completed with: " << return_value << "\n";
  return 0;
}
