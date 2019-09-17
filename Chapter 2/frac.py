# File frac.py

import gcd

class Frac:
	""" Fractional class. A Frac is a pair of integers num, den
	    (with den != 0) whose GCD is 1.
	"""

	def __init__(self, n, d):
		""" Construct a Frac from integers n and d.
		    Needs error message if d = 0!
		"""

		hcf = gcd.gcd(n, d)
		self.num, self.den = n/hcf, d/hcf

	def __str__(self):
		""" Generate a string representation of a Frac. """
		return "%d/%d" %(self.num, self.den)

	def __mul__(self, another):
		""" Multiply two Fracs to product a Frac. """
		return Frac(self.num * another.num, self.den * another.den)

	def __add__(self, another):
		""" Add two Fracs to product a Frac. """
		return Frac(self.num * another.den + self.den * another.num, self.den * another.den)

	def to_real(self):
		""" return floating point value of Frac. """
		return float(self.num)/float(self.den)

if __name__ == "__main__":
	a = Frac(3, 7)
	b = Frac(24, 56)
	print("a.num=", a.num, "b.den=", b.den)
	print(a)
	print(b)
	print("floating point value of a is %5.3f" %(a.to_real()))
	print("product=", a * b)
	print("sum=", a + b)