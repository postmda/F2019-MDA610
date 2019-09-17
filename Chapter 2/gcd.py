# File gcd.py Implementing the GCD Encludean algorithm

""" Module gcd: Contains two implementations of the Euclidean
    GCD algorithm, gcdr and gcd.
"""
    
def gcdr(a, b):
	"""Enclidean algorithm, recursive vers., returns GCD """
	if b == 0: 
		return a
	else:
		return gcdr(b, a % b)

def gcd(a, b):
	"""Enclidean algorithm, non-recursive vers., returns GCD """
	while b:
		a, b = b, a % b
	return a

##########################################
if __name__ == "__main__":
	import fib

	for i in range(980):
		print(i, " ", gcd(fib.fib(i), fib.fib(i+1)))