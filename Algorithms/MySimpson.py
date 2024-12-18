import numpy as np

'''
MySimpson calculation of the Simpsons rule for 
   f: function to be integrated 
   a: lower integration boundary
   b: upper integration boundary
   n: the EVEN integer number of intervals
'''

def MySimpson(f,a,b,n):

    if ((np.mod(n,2)!=0) or (n<2)):
        print('Simpsons method requires an even number of intervals n')
        S = np.NaN
        return S

    h = (b-a)/n

    x = np.linspace(a,b,n+1)
    w = 2*np.ones(n+1)
    w[0] = 1
    w[-1] = 1
    w[1:-1:2] = 4

    S = f(x[0])
    for i in range(1,n,1):
        S += f(x[i])*w[i]

    S = S+f(x[-1])
    S = S*h/3
    return S


