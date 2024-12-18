import numpy as np
import matplotlib.pyplot as plt
from LagrangeFormInterpolation import LagrangeFormInterpolation

Nvalue=12
I=[-1,3]
x=np.linspace(I[0],I[1],300,endpoint=True)
f = lambda x: np.exp(x)

nodes=np.linspace(I[0],I[1],Nvalue+1)
ydata=f(nodes)

plt.plot(x,LagrangeFormInterpolation(nodes,ydata,x)-f(x))
plt.title('Error in approximation of exponential function')
plt.xlabel('x')
plt.ylabel('approximation error')

fejl=max(abs(f(x)-LagrangeFormInterpolation(nodes,ydata,x)))
print('Largest absolute error is 1.7e-8')
print('Second interpolation theorem gives error<= 1/(4*(n+1)) * e^3 *(4/n)^(n+1)')
print('For n=12 this gives 2.4e-7 which is somewhat larger than the actual error.')
print(fejl, 1/(4*(Nvalue+1))*np.exp(3)*(4/Nvalue)**(Nvalue+1))