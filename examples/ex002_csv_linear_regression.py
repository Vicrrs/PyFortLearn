import numpy as np
import matplotlib.pyplot as plt
from src.csv_linear_regression import csv_linear_regression_mod


def main():
    file_name = '/home/vicrrs/Projetos_github/PyFortLearn/data02.csv'

    # Tenta abrir o arquivo para determinar o número de dados
    try:
        with open(file_name, 'r') as file:
            n = sum(1 for line in file if line.strip()) - \
                1  # Exclui o cabeçalho
    except FileNotFoundError:
        print("Arquivo não encontrado.")
        return

    # Preparar arrays para receber os dados
    x = np.empty(n, dtype=np.float64)
    y = np.empty(n, dtype=np.float64)

    # Ler dados do CSV
    success = csv_linear_regression_mod.read_csv(file_name, x, y, n)
    if success:
        # Calcular a regressão linear
        slope, intercept = csv_linear_regression_mod.linear_regression(x, y, n)

        # Preparar dados para a linha de regressão
        x_line = np.linspace(min(x), max(x), 300)
        y_line = slope * x_line + intercept

        # Plotar os dados e a linha de regressão
        plt.figure(figsize=(10, 6))
        plt.scatter(x, y, color='blue', label='Dados Observados')
        plt.plot(x_line, y_line, color='red',
                 label=f'Linha de Regressão: y = {slope:.2f}x + {intercept:.2f}')
        plt.title('Regressão Linear')
        plt.xlabel('X')
        plt.ylabel('Y')
        plt.legend()
        plt.grid(True)
        plt.show()
    else:
        print("Falha ao ler os dados do arquivo.")


if __name__ == "__main__":
    main()
