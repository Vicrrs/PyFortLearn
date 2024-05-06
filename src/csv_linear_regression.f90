module csv_linear_regression_mod
    implicit none  ! Garante que todas as variáveis sejam explicitamente declaradas

    contains

    ! Subrotina para ler dados de um arquivo CSV
    subroutine read_csv(file_name, x, y, n, success)
        character(len=*), intent(in) :: file_name  ! Nome do arquivo para leitura
        double precision, intent(inout) :: x(:), y(:)  ! Arrays para armazenar dados de x e y
        integer, intent(in) :: n  ! Número esperado de pontos de dados a serem lidos
        integer, intent(out) :: success  ! Flag de sucesso ou falha na operação
        character(100) :: line  ! Variável para armazenar linhas lidas do arquivo
        integer :: i, ios  ! Contadores e indicador de status de I/O
        real :: xi, yi  ! Variáveis temporárias para armazenar dados convertidos

        ! Abre o arquivo para leitura com gerenciamento de erros
        open(unit=10, file=file_name, status='old', action='read', iostat=ios)
        if (ios /= 0) then
            print*, 'Erro ao abrir o arquivo'  ! Se erro, imprime mensagem
            success = 0
            return
        endif

        ! Lê e descarta a linha de cabeçalho do arquivo CSV
        read(10, '(A)') line

        ! Lê dados linha por linha até atingir o número esperado de dados
        i = 1
        do while (i <= n)
            read(10, *, iostat=ios) xi, yi  ! Lê um par de números por linha
            if (ios /= 0) then  ! Checa por erros de leitura
                success = 0
                exit  ! Sai do loop em caso de erro
            endif
            x(i) = xi  ! Armazena os dados nos arrays
            y(i) = yi
            i = i + 1
        end do
        success = 1  ! Define sucesso na leitura dos dados

        close(10)  ! Fecha o arquivo
    end subroutine read_csv

    ! Subrotina para calcular a regressão linear
    subroutine linear_regression(x, y, n, slope, intercept)
        double precision, intent(in) :: x(:), y(:)  ! Arrays com dados de entrada
        integer, intent(in) :: n  ! Número de pontos de dados
        double precision, intent(out) :: slope, intercept  ! Parâmetros da regressão a serem retornados
        double precision :: sx, sy, sxx, sxy, delta  ! Variáveis para cálculos intermediários

        ! Calcula somas e produtos necessários para os mínimos quadrados
        sx = sum(x)
        sy = sum(y)
        sxx = sum(x**2)
        sxy = sum(x*y)
        delta = n*sxx - sx**2  ! Denominador da fórmula da regressão

        ! Calcula o coeficiente angular (slope) e interceptação (intercept)
        slope = (n*sxy - sx*sy) / delta
        intercept = (sxx*sy - sx*sxy) / delta
    end subroutine linear_regression

end module csv_linear_regression_mod
