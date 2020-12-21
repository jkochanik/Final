cout << "The counter is " << counter;
  return 1;
}
#include <iostream>
using namespace std;


uint32_t eratosthenes(bool isPrime[], uint32_t n);

int main (){
  uint32_t n = 1E9;
  const uint32_t size = (n+32  ) / 64;
  bool* p = new bool[size];

  //cout << size << endl;                                                                                                                  
  cout << eratosthenes(p, n) << '\n';
int counter = 0;
        for(int i = 0; i<=size; i++){
                if(p[i]){
                counter++;
}
        }
cout << "The counter is " << counter;
  return 1;
}

