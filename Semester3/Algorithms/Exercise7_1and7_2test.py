import numpy as np
import matplotlib.pyplot as plt
from CardinalPolynomial import cardinalpoly
from LagrangeFormInterpolation import LagrangeFormInterpolation

# Exercise 7.1: Test of CardinalPolynomial from exercise 6.1

x = np.linspace(-1.5, 4.5, 150)
knots = [-1, 1, 3, 4]


plt.plot(x,cardinalpoly(knots,0,x))
plt.plot(x,cardinalpoly(knots,1,x))
plt.plot(x,cardinalpoly(knots,2,x))
plt.plot(x,cardinalpoly(knots,3,x))

plt.plot(knots,[0, 0, 0, 0],'*b')
plt.plot(knots,[1, 1, 1, 1],'o')

plt.title('Cardinal polynomials')
plt.legend(['l1','l2','l3','l4','data1','data2'])
plt.show()
print('We can see that the cardinal polynomials are either 0 or 1 at the nodes x_i'); 

print(LagrangeFormInterpolation([0, 1, 3], [2, 3, 2], [2]))
print('The Lagrange form yields 3 at t=2 as expected')
