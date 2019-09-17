# File: fib.py Fibonacci numbers

"""Module fib: Fibonacci numbers
   Contains one function fib(n)
"""
 
def fib(n):
	"""Returns n'th Fibonacci number. """
	a, b = 0, 1
	for i in range(n):
		a, b = b, a+b
	return a

##########################################
if __name__ == "__main__":
	for i in range(10):
		print("fib(", i, ")=", fib(i))