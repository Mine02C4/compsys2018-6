#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import unittest

# modules
import log_initializer
from compsys_compiler import compile_lines

# logging (root)
from logging import getLogger, INFO
log_initializer.set_root_level(INFO)
logger = getLogger(__name__)


def conv_b2to32(rep):
    # Convert to base 16
    rep = rep.replace('|', '')
    assert(len(rep) == 32)
    rep = format(int(rep, 2), '08x')
    return rep


class CompilerTest(unittest.TestCase):

    def test_r_inst(self):
        self.assertEqual(compile_lines('add $3, $1, $2'),
                         conv_b2to32('000000|00001|00010|00011|00000|100000'))
        self.assertEqual(compile_lines('sub $4, $1, $2'),
                         conv_b2to32('000000|00001|00010|00100|00000|100010'))
        self.assertEqual(compile_lines('and $31, $0, $16'),
                         conv_b2to32('000000|00000|10000|11111|00000|100100'))
        self.assertEqual(compile_lines('jr $10'),
                         conv_b2to32('000000|01010|00000|00000|00000|001000'))

    def test_i_inst(self):
        self.assertEqual(compile_lines('addi $3, $1, 2'),
                         conv_b2to32('001000|00001|00011|0000000000000010'))


if __name__ == '__main__':
    unittest.main()
