#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import argparse
import sys
import os

# modules
import log_initializer
from compsys_compiler import compile_lines

# logging
from logging import getLogger, INFO
log_initializer.set_fmt()
log_initializer.set_root_level(INFO)
logger = getLogger(__name__)


def parse_arguments(argv):
    parser = argparse.ArgumentParser(description='Compiler for Compsys2018-6')
    parser.add_argument('infile', type=str, metavar='PATH')
    parser.add_argument('-o', type=str, metavar='PATH', dest='outfile',
                        default='imem.dat')
    args = parser.parse_args(argv)
    return args


def read_lines(filename):
    if not os.path.exists(filename):
        logger.error('Input file dose not exist ("%s")', filename)
        return False
    with open(filename, 'r') as f:
        return f.read()


def write_lines(filename, lines):
    with open(filename, 'w') as f:
        f.write(lines)


def main(argv):
    # Argument
    args = parse_arguments(argv)

    # Read a source file
    inp_lines = read_lines(args.infile)
    if not inp_lines:
        return

    # Compile
    out_lines = compile_lines(inp_lines)

    # Save
    write_lines(args.outfile, out_lines)


if __name__ == '__main__':
    main(sys.argv[1:])
