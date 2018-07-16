# -*- coding: utf-8 -*-

import re

# logging
from logging import getLogger, NullHandler
logger = getLogger(__name__)
logger.addHandler(NullHandler())


def compile_lines(inp_lines):
    '''
    Entry point to compile
    '''

    # Parse for each line
    out_lines = list()
    for i, line in enumerate(inp_lines.splitlines()):
        # Remove comment
        comm_idx = line.find('//')
        if 0 <= comm_idx:
            line = line[: comm_idx]
        # Ignore break line
        line = line.strip()
        if len(line) == 0:
            continue
        # Compile
        ret = _compile_line(line, i)
        if not ret:
            break
        out_lines.append(ret)
    return '\n'.join(out_lines)


def _print_error(msg, line_idx, line):
    logger.error('%s', msg)
    logger.error('  (line %d, "%s")', line_idx + 1, line)


class Instruction32(object):

    def __init__(self, inst_rep):
        self.inst_rep = ''
        self.reg_vars = list()
        self.imm_vars = list()

        self._prepare_rep(inst_rep)

    def _prepare_rep(self, inst_rep):
        # Ignore '|'
        inst_rep = inst_rep.replace('|', '')

        self.inst_rep = inst_rep
        self.reg_vars = list()
        self.imm_vars = list()

        # Search variables
        pattern = re.compile(r'[ri]\d+\{\d+}')
        while True:
            found = pattern.search(inst_rep)
            if found is None:
                break
            var = found.group()
            if var[0] == 'r':
                self.reg_vars.append(var)
            else:
                self.imm_vars.append(var)
            # Remove found variable
            inst_rep = inst_rep.replace(var, '')

        # The rest must be 0 or 1
        assert re.compile('^[01]*$').match(inst_rep)

    def _extract_bit_width(self, s):
        p = re.compile(r'\d+\{(\d+)\}')
        f = p.findall(s)
        assert len(f) == 1
        return int(f[0])

    def _extract_arg_idx(self, s):
        p = re.compile(r'(\d+)\{\d+\}')
        f = p.findall(s)
        assert len(f) == 1
        return int(f[0])

    def _insert_arguments(self, args, var_list, inst_rep):
        for var in var_list:
            idx = self._extract_arg_idx(var)
            width = self._extract_bit_width(var)
            val = args[idx]
            if val < 0:
                mask = (1 << width) - 1
                rep = format(val & mask, '0{}b'.format(width))
            else:
                rep = format(val, '0{}b'.format(width))
            inst_rep = inst_rep.replace(var, rep)
        return inst_rep

    def parse(self, reg_args, imm_args, line_idx, inp_line):
        # Check input argument
        if len(reg_args) != len(self.reg_vars):
            _print_error('Invalid arguments for register (%d vs %d)' %
                         (len(reg_args), len(self.reg_vars)),
                         line_idx, inp_line)
            return False
        if len(imm_args) != len(self.imm_vars):
            _print_error('Invalid arguments for immediate value (%d vs %d)' %
                         (len(imm_args), len(self.imm_vars)),
                         line_idx, inp_line)
            return False

        inst_rep = str(self.inst_rep)
        # Insert register arguments
        inst_rep = self._insert_arguments(reg_args, self.reg_vars, inst_rep)
        # Insert immediate value arguments
        inst_rep = self._insert_arguments(imm_args, self.imm_vars, inst_rep)

        assert len(inst_rep) == 32

        # Convert to base 16
        inst_rep = format(int(inst_rep, 2), '08x')

        return inst_rep


# Instructions
#   '|': ignored, 'r': register, 'i': immediate number, '{n}': bit width
INST_SCHEMES = {
        'add':   Instruction32('000000|r1{5}|r2{5}|r0{5}|00000|100000'),
        'sub':   Instruction32('000000|r1{5}|r2{5}|r0{5}|00000|100010'),
        'and':   Instruction32('000000|r1{5}|r2{5}|r0{5}|00000|100100'),
        # 'mult':  Instruction32('000000|r1{5}|r2{5}|r0{5}|00000|011000'),
        'or':    Instruction32('000000|r1{5}|r2{5}|r0{5}|00000|100101'),
        'xor':   Instruction32('000000|r1{5}|r2{5}|r0{5}|00000|100110'),
        'nor':   Instruction32('000000|r1{5}|r2{5}|r0{5}|00000|100111'),
        'slt':   Instruction32('000000|r1{5}|r2{5}|r0{5}|00000|101010'),
        'jr':    Instruction32('000000|r0{5}|00000|00000|00000|001000'),
        'jalr':  Instruction32('000000|r0{5}|00000|00000|00000|001001'),
        'addi':  Instruction32('001000|r1{5}|r0{5}|i0{16}|'),
        'ori':   Instruction32('001101|r1{5}|r0{5}|i0{16}|'),
        'andi':  Instruction32('001100|r1{5}|r0{5}|i0{16}|'),
        'lui':   Instruction32('001111|00000|r0{5}|i0{16}|'),
        'beq':   Instruction32('000100|r1{5}|r0{5}|i0{16}|'),
        'bne':   Instruction32('000101|r1{5}|r0{5}|i0{16}|'),
        'j':     Instruction32('000010|i0{26}|'),
        'jal':   Instruction32('000011|i0{26}|'),
        'jpush': Instruction32('010000|i0{26}|'),
        'jpop':  Instruction32('010000|00000|000000000000000000000'),
        'push':  Instruction32('010000|r0{5}|000000000000000000000'),
        'pop':   Instruction32('010000|r0{5}|000000000000000000000'),
        'rand':  Instruction32('000001|00000|00000|r0{5}|00000|000000'),
        'lb':    Instruction32('100000|r1{5}|r0{5}|i0{16}'),
        'sb':    Instruction32('101000|r1{5}|r0{5}|i0{16}'),
        'lw':    Instruction32('100011|r1{5}|r0{5}|i0{16}'),
        'sw':    Instruction32('101011|r1{5}|r0{5}|i0{16}'),
}


def _split(s, sep, n=0):
    ret = s.split(sep, maxsplit=(n - 1))
    if 0 < n and len(ret) != n:
        return False
    return ret


def _compile_line(inp_line, line_idx):
    logger.debug('Compile one line: "%s"', inp_line)

    # Extract operator
    ret = _split(inp_line, ' ', 2)
    if ret:
        op, args = ret
    else:
        op = inp_line
        args = ''
    op = op.strip()  # Remove extra spaces
    if op not in INST_SCHEMES:
        _print_error('Invalid operator', line_idx, inp_line)
        return False
    logger.debug(' op: %s', op)

    # Split arguments
    args = _split(args, ',')
    for i, arg in enumerate(args):
        args[i] = arg.strip()  # Remove extra spaces
    if len(args) == 1 and not args[0]:  # For no arguments
        args = list()
    logger.debug(' args: %s', args)

    # Divide input arguments into reg and imm
    reg_args = list()
    imm_args = list()
    for arg in args:
        try:
            if arg[0] == '$':
                reg_args.append(int(arg[1:]))
            else:
                imm_args.append(int(arg))
        except ValueError:
            _print_error('Invalid argument (register nor immediate value "%s")'
                         % arg, line_idx, inp_line)
            return False

    # Parse with registered instruction
    return INST_SCHEMES[op].parse(reg_args, imm_args, line_idx, inp_line)
