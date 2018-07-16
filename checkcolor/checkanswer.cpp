#include<cstdio>
#include<cstdlib>
#include<iostream>
#include<fstream>

int main(int argc, char *argv[], char *envp[])
{
  using namespace std;
  unsigned short int i,qnum;
  std::ifstream fpi_answer, fpi_problem;
  if (argc != 3) {
    cerr << "Number of command line parametaers must be 2." << endl;
  }
  fpi_answer.open(argv[1]);
  if ( !fpi_answer ) {
    std::cerr << "Error: cannot open answer file" << std::endl;
    exit(1);
  }
  fpi_problem.open(argv[2]);
  if ( !fpi_problem ) {
    std::cerr << "Error: cannot open problem file" << std::endl;
    exit(1);
  }

  unsigned short int seed,num_of_areas,henn;
  fpi_problem >> num_of_areas >> henn;
  unsigned short int *block,*kyoukai,*answer,gomi;
  block = new unsigned short int[num_of_areas];
  answer = new unsigned short int[num_of_areas];
  kyoukai = new unsigned short int[henn*2];
  for (i = 0; i < henn; i++) {
    fpi_problem.ignore();
    fpi_problem >> kyoukai[i*2+0] >> kyoukai[i*2+1];
  }
  for (i = 0; i < num_of_areas; i++) {
    fpi_answer >> answer[i];
  }

  unsigned short int count=0;

  for (i = 0; i < henn; i++) {
    if(answer[kyoukai[i*2+0]]%4 != answer[kyoukai[i*2+1]]%4) count+=1;
  }
  if (count == henn) {
    cout << "正解です" << endl;
    return 0;
  } else {
    cout << "間違っています" << endl;
    return 1;
  }
}
