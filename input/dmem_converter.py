# -*- coding: utf-8 -*- 

print('問題番号を入力してください:')
#for row in output_file:
input_file = raw_input()
f = open('Q{0}.txt'.format(input_file),'r')
elements = f.read().split()
#print(elements)
output_file = open('Q{0}.dat'.format(input_file),'w')
for n in elements:
    print(hex(int(n)))
    output_file.write(format(int(n), '02x'))

