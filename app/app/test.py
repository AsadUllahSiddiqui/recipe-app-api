"""
sample test
"""
from django.test import SimpleTestCase

from app import calc

class CalcTests(SimpleTestCase):
  """ test the calc modile."""

  def test_add_numbers(self):
    """test adding numbers """
    res = calc.add(5, 6)

    self.assertEqual(res, 11)

# use unittest.mock
# patch -overrides code for tests
# MagicMock/Mock -Replace real objects
