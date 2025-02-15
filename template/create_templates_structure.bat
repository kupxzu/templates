@echo off
REM Set the XAMPP htdocs directory path (default on Windows)
set "XAMPP_HTDOCS=C:\xampp\htdocs"
set "PROJECT_DIR=%XAMPP_HTDOCS%\templates"

echo Creating project structure in %PROJECT_DIR%

REM Create project directories
mkdir "%PROJECT_DIR%\app\controllers\admin"
mkdir "%PROJECT_DIR%\app\controllers\user"
mkdir "%PROJECT_DIR%\app\models"
mkdir "%PROJECT_DIR%\app\views\admin\layouts"
mkdir "%PROJECT_DIR%\app\views\user\layouts"
mkdir "%PROJECT_DIR%\app\core"
mkdir "%PROJECT_DIR%\config"
mkdir "%PROJECT_DIR%\public\assets\css"
mkdir "%PROJECT_DIR%\public\assets\js"
mkdir "%PROJECT_DIR%\public\assets\img"

REM Create controller files
type nul > "%PROJECT_DIR%\app\controllers\admin\AdminController.php"
type nul > "%PROJECT_DIR%\app\controllers\admin\DashboardController.php"
type nul > "%PROJECT_DIR%\app\controllers\user\UserController.php"
type nul > "%PROJECT_DIR%\app\controllers\user\ProfileController.php"

REM Create model files
type nul > "%PROJECT_DIR%\app\models\Admin.php"
type nul > "%PROJECT_DIR%\app\models\User.php"

REM Create view files for admin
type nul > "%PROJECT_DIR%\app\views\admin\dashboard.php"
type nul > "%PROJECT_DIR%\app\views\admin\layouts\header.php"
type nul > "%PROJECT_DIR%\app\views\admin\layouts\footer.php"

REM Create view files for user
type nul > "%PROJECT_DIR%\app\views\user\profile.php"
type nul > "%PROJECT_DIR%\app\views\user\layouts\header.php"
type nul > "%PROJECT_DIR%\app\views\user\layouts\footer.php"

REM Create core files
type nul > "%PROJECT_DIR%\app\core\App.php"
type nul > "%PROJECT_DIR%\app\core\Controller.php"

REM Create config file
type nul > "%PROJECT_DIR%\config\config.php"

REM Create public index file
type nul > "%PROJECT_DIR%\public\index.php"

REM Create .htaccess file in project root
type nul > "%PROJECT_DIR%\.htaccess"

echo.
echo Project structure created successfully in %PROJECT_DIR%.
pause
