from src.linear_regression import linear_regression_mod
import matplotlib.pyplot as plt
import numpy as np
import sys
import matplotlib
# Ou outro backend interativo como 'Qt5Agg', 'GTK3Agg', etc.
matplotlib.use('TkAgg')

sys.path.append('/home/vicrrs/Projetos_github/PyFortLearn')


# Dados de exemplo
x = np.array([1, 2, 3, 4, 5], dtype=np.float64)
y = np.array([2, 4, 5, 4, 5], dtype=np.float64)

# Chamando a função Fortran
n = len(x)
slope, intercept = linear_regression_mod.linear_regression(x, y, n)

# Usando os coeficientes para prever e plotar
y_pred = slope * x + intercept

# Plotando os dados e a linha de regressão
plt.scatter(x, y, color='blue', label='Dados')
plt.plot(x, y_pred, color='red', label='Linha de Regressão')
plt.xlabel('X')
plt.ylabel('Y')
plt.title('Regressão Linear via Fortran')
plt.legend()
plt.show()
