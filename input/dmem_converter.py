# -*- coding: utf-8 -*- 

print('問題番号を入力してください(例)01,02,03..:')
#for row in output_file:
input_file = raw_input()
f = open('Q{0}.txt'.format(input_file),'r')
elements = f.read().split()
#print(elements)
output_file = open('dmem{0}.dat'.format(input_file),'w')
for n in elements:
    output_file.write(format(int(n), '02x'))
output_file.close()
f.close()
print('output file is dmem{0}.dat'.format(input_file))
