#include <iostream>
using namespace std;


uint32_t eratosthenes(uint32_t* isPrime, uint32_t n);

int main (){
  uint32_t n = 1E9;
  const uint32_t size = (n+32)/64;
  uint32_t* p = new uint32_t[size];

  cout << size << endl;                                                                                                                  
  cout << eratosthenes(p, n) << '\n';
  
 

  return 1;
}

