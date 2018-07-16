#!/usr/bin/env python3
# -*- coding: utf-8 -*- 

import argparse

parser = argparse.ArgumentParser(description='Problem converter')
parser.add_argument('input_file', type=argparse.FileType('r'), metavar='PATH')
parser.add_argument('-o', type=argparse.FileType('w'), metavar='PATH', dest='output_file')
args = parser.parse_args()
elements = args.input_file.read().split()
if len(elements) % 4 != 0:
    elements.extend(["0"] * (4- len(elements) % 4))
two_elements = iter(elements)
for first, second, third, fourth in zip(two_elements,two_elements,two_elements,two_elements):
    args.output_file.write(format(int(first), '02x'))
    args.output_file.write(format(int(second), '02x'))
    args.output_file.write(format(int(third), '02x'))
    args.output_file.write(format(int(fourth), '02x'))
    args.output_file.write("\r\n")
args.output_file.close()

