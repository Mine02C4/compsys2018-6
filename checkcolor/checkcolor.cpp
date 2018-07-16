#include<stdio.h>
#include<stdlib.h>
#include<iostream>
#include<fstream>
//#include<time.h>


unsigned short int genrand(unsigned short int x){
  
  x ^= x << 7;
  x ^= x >> 3;
  x ^= x << 11;
  
  return x;
  
}

int main(){
  unsigned short int i,qnum;
  std::cout<<"解く問題の番号を入力してください（1〜9）"<<std::endl;
  std::cin>>qnum;
  //i=9;
  //std::cout<<i<<" "<<sizeof(i)<<std::endl;
  //poen reading file
  std::ifstream fpi0;
  if(qnum==1)fpi0.open("input/Q1.txt");
  else if(qnum==2)fpi0.open("input/Q2.txt");
  else if(qnum==3)fpi0.open("input/Q3.txt");
  else if(qnum==4)fpi0.open("input/Q4.txt");
  else if(qnum==5)fpi0.open("input/Q5.txt");
  else if(qnum==6)fpi0.open("input/Q6.txt");
  else if(qnum==7)fpi0.open("input/Q7.txt");
  else if(qnum==8)fpi0.open("input/Q8.txt");
  else if(qnum==9)fpi0.open("input/Q9.txt");  
  else{
    std::cout<<"正しく入力されていません"<<std::endl;
    return 0;
  }

  //output file
  std::ofstream fpo0("answer.txt");
  
  if(fpi0.fail()){
    std::cerr <<"ファイルを開けません\n";
    exit(1);
  }
  unsigned short int seed,kukan,henn;
  seed=5;
  fpi0>>kukan>>henn;
  //std::cout<<kukan<<" "<<henn<<std::endl;
  
  unsigned short int *block,*kyoukai;
  block=new unsigned short int[kukan];
  kyoukai=new unsigned short int[henn*2];
  
  for(i=0;i<henn;i++){
    fpi0.ignore();
    fpi0>>kyoukai[i*2+0]>>kyoukai[i*2+1];
    //    std::cout<<kyoukai[i*2+0]<<kyoukai[i*2+1]<<std::endl;
  }

  unsigned short int swich1=0,swich2=0,st,count=0,failnum=0;
  //  time_t t = time(NULL);
  st=genrand(seed);
  
    while(swich1==0){
      for(i=0;i<kukan;i++){
	if(i==0 && swich2==0){
	  block[0]=st;
	  swich2=1;
	}
	else if(i==0 && swich2==1){
	 block[0]=block[kukan-1];
	}
	else{
	block[i]=genrand(block[i-1]);
	}
	//std::cout<<block[i]%4<<std::endl;
      }

      for(i=0;i<henn;i++){
	if(block[kyoukai[i*2+0]]%4!=block[kyoukai[i*2+1]]%4)count+=1;
      }
      //std::cout<<count<<std::endl;
      if(count==henn){
      swich1=1;
      }
      failnum+=1;
      count=0;
    }
    std::cout<<"答えは以下になります．"<<failnum<<"回目で成功しました．"<<std::endl;

    //---output file---
    fpo0<<kukan<<" "<<henn<<std::endl;
    for(i=0;i<henn;i++){
      fpo0<<kyoukai[i*2+0]<<" "<<kyoukai[i*2+1]<<std::endl;
    }
    
    for(i=0;i<kukan;i++){
      std::cout<<block[i]%4<<std::endl;
      fpo0<<i<<" "<<block[i]%4<<std::endl;
    } 
  return 0; 
}
