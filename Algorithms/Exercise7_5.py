import numpy as np
import matplotlib.pyplot as plt
from LagrangeFormInterpolation import LagrangeFormInterpolation

# Excercise 7.5: Instability

Nvalues=[5, 7, 9, 11, 15, 21, 31]
limit=5.0 # limit=0.9 see below
x=np.linspace(-limit,limit,300,endpoint=True)
f = lambda x: (1+x**2)**(-1)
err = []

for k in range(len(Nvalues)):

    nodes=np.linspace(-limit,limit,Nvalues[k]+1,endpoint=True)
    ydata=f(nodes)
    
    plt.plot(x,LagrangeFormInterpolation(nodes,ydata,x))
    plt.plot(x,f(x))
    plt.legend(['Interpolation','True function'])

    err.append(max(abs(f(x)-LagrangeFormInterpolation(nodes,ydata,x))))
    plt.title(f'Fit with n={(Nvalues[k])}: max abs err is {(err[k])}')
    plt.show()

print('The interpolation error is largest near the interval endpoints')
print('We also see that the error grows with n')

plt.semilogy(Nvalues,(err),'.')
plt.title('Max abs error as function of n')
plt.show()
print('The estimated maximum error grows strongly with n - apparently faster than exponentially!')


limit=0.9
x=np.linspace(-limit,limit,300)
err = []

for k in range(len(Nvalues)):

    nodes=np.linspace(-limit,limit,Nvalues[k]+1,endpoint=True)
    ydata=f(nodes)
    
    plt.plot(x,LagrangeFormInterpolation(nodes,ydata,x))
    plt.plot(x,f(x))
    plt.legend(['Interpolation','True function'])

    err.append(max(abs(f(x)-LagrangeFormInterpolation(nodes,ydata,x))))
    plt.title(f'Fit with n={(Nvalues[k])}: max abs err is {(err[k])}')
    plt.show()

print('On the smaller interval, the interpolation works.')

plt.semilogy(Nvalues,err,'.')
plt.title('Max abs error as function of n')
plt.show()
