import math
import random 
import sys
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
import numpy as np
from matplotlib import cm

def Func_optim(x,y):
    """Функция оптимизации f(x,y)"""
    up = 0.1*x + y**2
    down = (10*abs(x+y)+1)**(0.5)
    return -5*up/down

def T(t, iter):
    """Функция уменьшения температуры:
    t - акутальная температура,
    iter - №итерации t."""
    return (2*t)/iter 

def New_state(x_state, y_state, t):
    """Генерация нового состояния,
    x_state, y_state - актуальное состояние,
    t - актуальная температура."""
    x = x_state + random.uniform(-t/100,t/100)
    y = y_state + random.uniform(-t/100,t/100)
    return x,y

def Prob(dF, t):
    """ Функция проверки согласия на новое состояние:
    dF = F(state)-F(new_state),
    t = температура."""
    rnd = random.random()
    p = (math.exp(dF/t))
    return True if (p < 0) or (rnd < p) else False 

def Simulated_annealing():
    """ Алгоритм имитации отжига """
    x,y = random.uniform(-5,5),random.uniform(-5,5)
    Tmin, t, iter = 1, 1000, 1
    while t > Tmin:
        x_new, y_new = New_state(x,y,t)
        if Prob((Func_optim(x,y)-Func_optim(x_new,y_new)),t):
            x,y = x_new, y_new
        t = T(t, iter)
        iter += 1
    return x,y

def main():
    """ Основная функция вызова алгоритма и отрисовка графика"""
    n = int(input("Количество запусков: "))
    x_res = []
    y_res = []
    z_res = []
    for i in range(n):
        x,y = Simulated_annealing()
        x_res.append(x)
        y_res.append(y)
        z_res.append(Func_optim(x,y))
        print("#{}. Min: {}".format(i+1, z_res[-1]))
    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')
    x = np.linspace(min(x_res), max(x_res), 100)
    y = np.linspace(min(y_res), max(y_res), 100)
    x, y = np.meshgrid(x, y)
    z = Func_optim(x,y)
    ax.plot_surface(x, y, z, rstride = 1,cstride = 1, cmap = cm.viridis)
    ax.scatter(x_res, y_res, z_res, marker='^', color = 'red')
    fig.show()

if __name__ == "__main__":
    sys.exit(main())
