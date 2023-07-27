@echo off
:: Check if the script is running as an administrator
net session >nul 2>&1
if %errorLevel% == 1 (
    echo FAILED: This script requires administrator privileges. Please run it as an administrator and try again.
    pause
    exit /b 1
) else ( 
    echo PASSED: Running with administrator privileges 
)

:: Check if the computer is connected to the internet
ping 8.8.8.8 -n 1 -w 1000 >nul
if %errorLevel% == 1 (
    echo FAILED: This script requires an active internet connection. Please check your internet connection and try again.
    pause
    exit /b 1
) else ( 
    echo PASSED: Internet connection OK 
)

:: Check if winget is already installed
winget -v >nul 2>&1
if %errorlevel% == 1 (
    echo FAILED: Winget is not installed, please make sure you install it, else nothing else will work.
    set "wg=false"
) else (
    echo PASSED: winget is already installed
    set "wg=true"
)

setlocal EnableDelayedExpansion

rem Select desired packages
echo This script will install selected dev tools and add them to the PATH variables where needed.
echo Please note that Winget is required for all subsequent packages, if you select no, this will terminate.
echo Select the tools/apps you'd like to install/update by pressing y for each app, press Enter or anything else for No
set /p do_descrp=Would you like to see a brief description of each app/tool?  

if /i "%do_descrp%"=="y" (
    set "pr_winget=Winget? (Windows Package Manager) "
    set "pr_update=Update existing Apps? (...via Winget) "
    set "pr_gitcli=Git? (Version control system) "
    set "pr_github=GitHub? (GitHub login) "
    set "pr_docker=Docker? (Containerization platform) "
    set "pr_vscode=VSCode? (Lightweight and powerful code editor) "
    set "pr_vscext=Basic VSCode Extensions (ESLint, Prettier, Docker, Postgres, PowerShell)? (Useful extensions for VSCode) "
    set "pr_intelj=IntelliJ IDEA? (Integrated development environment for Java) "
    set "pr_notepd=Notepad++? (Free source code editor) "
    set "pr_nodejs=Node.js? (JavaScript runtime built on Chrome's V8 JavaScript engine) "
    set "pr_npxcli=npx? (npm package runner) "
    set "pr_python=Python? (Popular programming language) "
    set "pr_pgrsql=PostgreSQL? (Open source relational database system) "
    set "pr_sqlite=SQLite? (Self-contained, serverless, zero-configuration SQL database engine) "
    set "pr_my_sql=MySQL? (Open source relational database management system) "
    set "pr_redisc=Redis? (In-memory data structure store) "
    set "pr_dbeavr=DBeaver? (Free universal database tool) "
    set "pr_pgadmn=pgAdmin? (PostgreSQL management tool) "
    set "pr_gcpsdk=Google Cloud SDK? (Command-line interface for Google Cloud Platform) "
    set "pr_awscli=AWS CLI? (Unified tool for managing AWS services) "
    set "pr_mazure=Azure CLI? (Command-line interface for managing Azure resources) "
    set "pr_kubers=Kubernetes CLI? (Command-line interface for Kubernetes) "
    set "pr_postmn=Postman? (API development tool) "
    set "pr_rabbit=RabbitMQ? (Message broker software) "
    set "pr_reactj=React? (JavaScript library for building user interfaces) "
    set "pr_angulr=Angular? (TypeScript-based open-source web application framework) "
    set "pr_nestjs=NestJS? (Progressive Node.js framework for building efficient, scalable, and enterprise-grade server-side applications) "
) else (
    set "pr_winget=Winget? "
    set "pr_update=Existing Apps? "
    set "pr_gitcli=Git? "
    set "pr_github=GitHub? "
    set "pr_docker=Docker? "
    set "pr_vscode=VSCode? "
    set "pr_vscext=Basic VSCode Extensions (ESLint, Prettier, Docker, Postgres, PowerShell)? "
    set "pr_intelj=IntelliJ IDEA? "
    set "pr_notepd=Notepad++? "
    set "pr_nodejs=Node.js? "
    set "pr_npxcli=npx? "
    set "pr_python=Python? "
    set "pr_pgrsql=PostgreSQL? "
    set "pr_sqlite=SQLite? "
    set "pr_my_sql=MySQL? "
    set "pr_redisc=Redis? "
    set "pr_dbeavr=DBeaver? "
    set "pr_pgadmn=pgAdmin? "
    set "pr_gcpsdk=Google Cloud SDK? "
    set "pr_awscli=AWS CLI? "
    set "pr_mazure=Azure CLI? "
    set "pr_kubers=Kubernetes CLI? "
    set "pr_postmn=Postman? "
    set "pr_rabbit=RabbitMQ? "
    set "pr_reactj=React? "
    set "pr_angulr=Angular? "
    set "pr_nestjs=NestJS? "
)
echo ====== Must haves:
set /p do_winget=%pr_winget%
set /p do_update=%pr_update%
set /p do_gitcli=%pr_gitcli%
set /p do_github=%pr_github%
set /p do_docker=%pr_docker%
echo ====== Choose IDE:
set /p do_vscode=%pr_vscode%
set /p do_vscext=%pr_vscext%
set /p do_intelj=%pr_intelj%
set /p do_notepd=%pr_notepd%
echo ====== Choose programming languages:
set /p do_nodejs=%pr_nodejs%
set /p do_npxcli=%pr_npxcli%
set /p do_python=%pr_python%
echo ====== Choose database and manager:
set /p do_pgrsql=%pr_pgrsql%
set /p do_sqlite=%pr_sqlite%
set /p do_my_sql=%pr_my_sql%
set /p do_redisc=%pr_redisc%
set /p do_dbeavr=%pr_dbeavr%
set /p do_pgadmn=%pr_pgadmn%
echo ====== Choose Cloud service CLI:
set /p do_gcpsdk=%pr_gcpsdk%
set /p do_awscli=%pr_awscli%
set /p do_mazure=%pr_mazure%
echo ====== Advanced tools:
set /p do_kubers=%pr_kubers%
set /p do_postmn=%pr_postmn%
set /p do_rabbit=%pr_rabbit%
echo ====== Choose framework:
set /p do_reactj=%pr_reactj%
set /p do_angulr=%pr_angulr%
set /p do_nestjs=%pr_nestjs%


rem check if winget is already installed, update if yes, else install, exit if not install and not selected
if /i "%do_winget%"=="y" (
    echo BEGIN: Installing Winget
    if %wg% == true (
        echo Winget is already installed. Checking for updates...
        winget update
    ) else (
        echo Winget is not installed. Installing...
        curl.exe -o winget.msixbundle -L https://github.com/microsoft/winget-cli/releases/latest/download/winget.msixbundle
        start /wait AppInstaller.exe /install winget.msixbundle
        del winget.msixbundle
    )
    echo ENDED: Installing Winget
) else (
    rem Stop if winget is not installed
    if %wg% == false (
        echo ENDED: Winget is not installed. Please install Winget first.
        exit /b 1
    )
)

rem install selected apps
if /i "%do_update%"=="y" (
    winget upgrade --all
    )
if /i "%do_gitcli%"=="y" (
    winget install Git.Git 
    setx /M PATH "%PATH%;C:\Program Files\Git\bin"
    )
if /i "%do_github%"=="y" (
    echo BEGIN: GitHub login

    :: Prompt the user for name and save the input to NAME variable
    set /p "NAME=Enter your name: "
    set /p "EMAIL=Enter your email: "
    :: Remove leading and trailing spaces from EMAIL
    for /f "tokens=* delims= " %%a in ("!EMAIL!") do set "EMAIL=%%a"
    for /f "tokens=* delims= " %%a in ("!NAME!") do set "NAME=%%a"

    :: Set Git configuration if confirmed
    git config --global user.name "!NAME!" 
    git config --global user.email "!EMAIL!" 
    git config --global core.editor "code --wait" 
    git config --global --list

    echo ENDED: GitHub login

    )
if /i "%do_docker%"=="y" (
    winget install Docker.DockerDesktop 
    setx /M PATH "%PATH%;C:\Program Files\Docker\Docker\resources\bin;C:\ProgramData\DockerDesktop\version-bin"
    )
if /i "%do_vscode%"=="y" (
    winget install Microsoft.VisualStudioCode 
    setx /M PATH "%PATH%;%LOCALAPPDATA%\Programs\Microsoft VS Code\bin" 
    reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\Open with VSCode\command" /ve /d "\"%LOCALAPPDATA%\\Programs\\Microsoft VS Code\\Code.exe\" \"%V%\"" /f 
    code --install-extension dbaeumer.vscode-eslint 
    code --install-extension ms-azuretools.vscode-docker 
    code --install-extension ms-ossdata.vscode-postgresql 
    code --install-extension esbenp.prettier-vscode 
    code --install-extension ms-vscode.PowerShell
    )
if /i "%do_intelj%"=="y" (
    winget install JetBrains.IntelliJIDEA.Community.EAP
    )
if /i "%do_notepd%"=="y" (
    winget install Notepad++.Notepad++
    )
if /i "%do_pgrsql%"=="y" (
    winget install PostgreSQL.PostgreSQL 
    setx /M PATH "%PATH%;C:\Program Files\PostgreSQL\14\bin"
    )
if /i "%do_sqlite%"=="y" (
    winget install Oracle.MySQL
    )
if /i "%do_my_sql%"=="y" (
    winget install SQLite.SQLite
    )
if /i "%do_redisc%"=="y" (
    winget install Redis --accept-package-agreements
    )
if /i "%do_dbeavr%"=="y" (
    winget install dbeaver.dbeaver
    )
if /i "%do_pgadmn%"=="y" (
    winget install PostgreSQL.pgAdmin
    )
if /i "%do_nodejs%"=="y" (
    winget install OpenJS.NodeJS 
    setx /M PATH "%PATH%;C:\Program Files\nodejs"
    )
if /i "%do_npxcli%"=="y" (
    npm install -g npx
    )
if /i "%do_python%"=="y" (
    winget install Python.Python 
    setx /M PATH "%PATH%;C:\Python39"
    )
if /i "%do_gcpsdk%"=="y" (
    winget install Google.CloudSDK 
    setx /M PATH "%PATH%;C:\Program Files\Google\Cloud SDK\google-cloud-sdk\bin"
    )
if /i "%do_awscli%"=="y" (
    winget install Amazon.AWSCLI 
    setx /M PATH "%PATH%;C:\Program Files\Amazon\AWSCLI"
    )
if /i "%do_mazure%"=="y" (
    winget install Microsoft.AzureCLI 
    setx /M PATH "%PATH%;C:\Program Files\Microsoft SDKs\Azure\CLI2\wbin"
    )
if /i "%do_kubers%"=="y" (
    winget install Kubernetes.kubectl 
    setx /M PATH "%PATH%;C:\Program Files (x86)\Kubernetes\bin"
    )
if /i "%do_postmn%"=="y" (
    winget install Postman.Postman 
    setx /M PATH "%PATH%;C:\Users%USERNAME%\AppData\Local\Postman"
    )
if /i "%do_rabbit%"=="y" (
    winget install RabbitMQ.RabbitMQ-Server
    )
if /i "%do_reactj%"=="y" (
    npm install -g create-react-app 
    setx /M PATH "%PATH%;C:\Users%USERNAME%\AppData\Roaming\npm"
    )
if /i "%do_angulr%"=="y" (
    npm install -g @angular/cli
    )
if /i "%do_nestjs%"=="y" (
    npm install -g @nestjs/cli
    )

endlocal
pause