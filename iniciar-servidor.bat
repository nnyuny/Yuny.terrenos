@echo off
echo Procurando Node.js...

if exist "C:\Program Files\nodejs\node.exe" (
    set NODE="C:\Program Files\nodejs\node.exe"
    goto :found
)
if exist "C:\Program Files (x86)\nodejs\node.exe" (
    set NODE="C:\Program Files (x86)\nodejs\node.exe"
    goto :found
)
for /f "tokens=*" %%i in ('where node 2^>nul') do (
    set NODE="%%i"
    goto :found
)

echo Node.js nao encontrado.
echo Instale em: https://nodejs.org
pause
exit /b 1

:found
echo Node encontrado: %NODE%

echo Verificando Python e pywin32...
py -c "import win32com.client" 2>nul
if errorlevel 1 goto :instalar_pywin32
echo pywin32 OK.
goto :iniciar

:instalar_pywin32
echo Instalando pywin32...
py -m pip install pywin32 --quiet 2>nul
if errorlevel 1 (
    echo AVISO: Python nao encontrado. Instale em https://python.org
    echo O calculo automatico do Relatorio nao estara disponivel.
) else (
    echo pywin32 instalado com sucesso.
)

:iniciar
set CHROME=
if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" set CHROME="%ProgramFiles%\Google\Chrome\Application\chrome.exe"
if exist "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" set CHROME="%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"
if exist "%LocalAppData%\Google\Chrome\Application\chrome.exe" set CHROME="%LocalAppData%\Google\Chrome\Application\chrome.exe"

if defined CHROME (
    start "" %CHROME% "http://localhost:8080"
) else (
    echo Chrome nao encontrado, abrindo no navegador padrao...
    start "" "http://localhost:8080"
)
%NODE% servidor.js
pause
