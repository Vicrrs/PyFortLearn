module linear_regression_mod
    implicit none
    contains

    subroutine linear_regression(x, y, n, slope, intercept)
        ! Argumentos
        double precision, intent(in) :: x(:), y(:) ! Arrays de entrada
        integer, intent(in) :: n                    ! Tamanho dos arrays
        double precision, intent(out) :: slope, intercept ! Resultados

        ! Variáveis locais
        double precision :: sx, sy, sxx, sxy, delta

        ! Cálculos para os componentes da fórmula de mínimos quadrados
        sx = sum(x)
        sy = sum(y)
        sxx = sum(x**2)
        sxy = sum(x*y)
        delta = n*sxx - sx**2

        ! Calculando o slope (coeficiente angular) e intercept (coeficiente linear)
        slope = (n*sxy - sx*sy) / delta
        intercept = (sxx*sy - sx*sxy) / delta
    end subroutine linear_regression
end module linear_regression_mod
