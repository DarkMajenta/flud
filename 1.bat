
@echo off
REM Получить список CSV файлов в каталоге
for /f "tokens=*" %%f in ('dir /b /a-d *.csv') do (
    REM Извлечь первые 4 символа имени файла
    set "fname=%%~nf"
    set "prefix=!fname:~0,4!"

    REM Проверить, начинается ли имя файла с тех же 4 символов
    if "!fname:~0,4!"=="!prefix!" (
        REM Установить имена входных файлов
        set file1=!prefix!*.csv
        set file2=!prefix!*.csv

        REM Получить первые два файла, соответствующие префиксу
        for /f "tokens=*" %%g in ('dir /b /a-d "!file1!"') do (
            set file1=%%g
            goto next
        )
        :next
        for /f "tokens=*" %%h in ('dir /b /a-d "!file2!"') do (
            set file2=%%h
            goto process
        )
        :process

        REM Установить имя выходного файла
        set output=!prefix!_result.csv

        REM Инициализировать выходной файл
        echo Difference > !output!

        REM Проход по каждой строке во входных файлах
        for /f "tokens=1-3 delims=;" %%a in (!file1!) do (
            REM Счиать соответствующую строку из второго файла
            for /f "tokens=1-3 delims=;" %%x in (!file2!) do (
                REM Вычислить разницу значений 3-го столбца
                set /a diff=%%c-%%z
                REM Записать результат в выходной файл
                echo %%a,%%b,%diff% >> !output!
            )
        )
    )
)
