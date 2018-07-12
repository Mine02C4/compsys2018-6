# -*- coding: utf-8 -*-
import unittest

import log_initializer

# logging (root)
from logging import getLogger, DEBUG
log_initializer.set_root_level(DEBUG)
logger = getLogger(__name__)


class CompilerTest(unittest.TestCase):

    def setUp(self):
        pass

    def test1(self):
        pass


if __name__ == '__main__':
    unittest.main()
