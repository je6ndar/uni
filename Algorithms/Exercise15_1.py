import numpy as np
np.set_printoptions(suppress=True)
from scipy.integrate import solve_ivp
import matplotlib.pyplot as plt
from MyRK4System import MyRK4System

def odefun(t, X):
    dzdt = np.array([-X[0] + X[1] + np.sin(t), -X[0] - X[1]])
    return dzdt

def fexact(t):
    t = np.array(t)
    f = np.array([0.2*np.exp(-t)*np.cos(t) - 0.4*np.exp(-t)*np.sin(t) + 0.6*np.sin(t) - 0.2*np.cos(t),
                  -0.2*np.exp(-t)*np.sin(t) - 0.4*np.exp(-t)*np.cos(t) - 0.2*np.sin(t) + 0.4*np.cos(t)])
    return f

tspan = [0, 10]
X0 = np.array([0, 0])
n = 20
h = (tspan[1] - tspan[0]) / n

print('f_exact goes through x(0)=y(0)=0.')
print(fexact([0]))
print('')

tRK4, XRK4 = MyRK4System(odefun, tspan, X0, n)
Xexact = fexact(tRK4)

plt.plot(tRK4, XRK4, '*', )
x = np.linspace(tspan[0], tspan[1], 200)
y1, y2 = fexact(np.linspace(tspan[0], tspan[1], 200))
plt.plot(x, y1)
plt.plot(x, y2)
plt.legend(['(t,x1(t)) RK4', '(t,x2(t)) RK4', '(t,x1(t)) exact', '(t,x2(t)) exact'], loc='lower left')
plt.title('Test 1: RK4 and analytical solution')
plt.show()

plt.plot(tRK4, np.sqrt(np.sum((XRK4 - Xexact.T)**2, axis=1)),'*')
plt.title('Test 2: error in euclidean distance for RK4')
plt.show()

print('Test 1 and 2 give a reasonable result even though h=0.5 is quite large.')

print('Test 3: For example, try tspan=[0.20], n=10')
print("The crash test -- yes, it's not good")

print('Test 4: On the interval [0,100] there are 100/(2pi) approx 17 periods.')
print('RK4 works quite well even if there')
print('only 4 points per period (n=4*17).')

sol = solve_ivp(odefun, tspan, X0, method='RK45',rtol=1e-8,atol=1e-8)
tRK45, XRK45 = sol.t, sol.y.T
plt.plot(np.diff(tRK45))
plt.title('Lengths of time steps for RK45')
plt.show()

n = len(tRK45) - 1
tRK4, XRK4 = MyRK4System(odefun, tspan, X0, n)

plt.plot(tRK45, np.sqrt(np.sum((XRK45 - fexact(tRK45).T) ** 2,axis=1)),
         tRK4, np.sqrt(np.sum((XRK4 - fexact(tRK4).T) ** 2,axis=1)))
plt.title('RK4 run with the same number of iterations as RK45')
plt.legend(['error for ode45', 'error for RK4'])
plt.show()



