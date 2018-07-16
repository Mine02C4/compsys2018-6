#!/usr/bin/env python3


import argparse

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='imem converter')
    parser.add_argument('imemdat', type=argparse.FileType('r'), metavar='PATH')
    parser.add_argument('-t', type=argparse.FileType('r'), metavar='PATH', dest='template')
    parser.add_argument('-o', type=argparse.FileType('w'), metavar='PATH', dest='outfile')
    args = parser.parse_args()
    ostr = ""
    for i, line in enumerate(args.imemdat):
        line = line.replace('\n', '')
        ostr += ("mem[{}] <= 32'h{};\n".format(i, line))
    text = args.template.read().replace("PLACEHOLDER", ostr)
    args.outfile.write(text)

