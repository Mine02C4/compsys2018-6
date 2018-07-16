#!/usr/bin/env python2
# -*- coding: utf-8 -*- 

print('問題番号を入力してください(例)01,02,03..:')
#for row in output_file:
input_file = raw_input()
f = open('Q{0}.txt'.format(input_file),'r')
elements = f.read().split()
if len(elements) % 4 != 0:
    elements.extend(["0"] * (4- len(elements) % 4))
print(elements)
output_file = open('dmem{0}.dat'.format(input_file),'w')
two_elements = iter(elements)
for first, second, third, fourth in zip(two_elements,two_elements,two_elements,two_elements):
    output_file.write(format(int(first), '02x'))
    output_file.write(format(int(second), '02x'))
    output_file.write(format(int(third), '02x'))
    output_file.write(format(int(fourth), '02x'))
    output_file.write("\r\n")
output_file.close()
f.close()
print('output file is dmem{0}.dat'.format(input_file))

