import numpy as np
import matplotlib.pyplot as plt
from CardinalPolynomial import cardinalpoly
from LagrangeFormInterpolation import LagrangeFormInterpolation

#Excercise 7.3: Interpolation of table

x=np.linspace(0.5,5.5,200)
nodes=[1, 2.5, 3, 5]
ydata=[1, 2, 3, 4 ]


plt.plot(x,cardinalpoly(nodes,0,x))
plt.plot(x,cardinalpoly(nodes,1,x))
plt.plot(x,cardinalpoly(nodes,2,x))
plt.plot(x,cardinalpoly(nodes,3,x))

plt.plot(x,LagrangeFormInterpolation(nodes, ydata,x),'r-')
plt.plot(nodes,ydata,'*')

plt.title('The 4 cardinal and the interpolating polynomial')
plt.show()