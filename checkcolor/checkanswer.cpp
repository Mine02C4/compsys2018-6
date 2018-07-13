#include<stdio.h>
#include<stdlib.h>
#include<iostream>
#include<fstream>
//#include<time.h>


int main(){
  unsigned short int i,qnum;
  std::ifstream fpi0;
  fpi0.open("answer.txt");
  
  /*  if( !fpi0 ){
    std::cout << "Error: cannot open file" << std::endl;
    exit(1);
    }*/

  
  unsigned short int seed,kukan,henn;
  fpi0>>kukan>>henn;
  //std::cout<<kukan<<" "<<henn<<std::endl;
  
  unsigned short int *block,*kyoukai,*answer,gomi;
  block=new unsigned short int[kukan];
  answer=new unsigned short int[kukan];
  kyoukai=new unsigned short int[henn*2];
  
  for(i=0;i<henn;i++){
    fpi0.ignore();
    fpi0>>kyoukai[i*2+0]>>kyoukai[i*2+1];
  }
  
  for(i=0;i<kukan;i++){
    fpi0.ignore();
    fpi0>>gomi>>answer[i];
    //std::cout<<answer[i]<<std::endl;
  }
  
  unsigned short int count=0;

  for(i=0;i<henn;i++){                                                                           
    if(answer[kyoukai[i*2+0]]%4!=answer[kyoukai[i*2+1]]%4)count+=1;
    //else if(answer[kyoukai[i*2+0]]%4==block[kyoukai[i*2+1]]%4)std::cout<<i<<" "<<answer[kyoukai[i*2+0]]%4<<" "<<answer[kyoukai[i*2+1]]%4<<std::endl;
  }
  //std::cout<<count<<std::endl;
  if(count==henn)std::cout<<"正解です"<<std::endl;
  else if(count!=henn)std::cout<<"間違っています"<<std::endl;
  else std::cout<<"errorです"<<std::endl;
  return 0; 
}
