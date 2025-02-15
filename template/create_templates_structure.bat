@echo off
REM Set the XAMPP htdocs directory path (default for Windows)
set "XAMPP_HTDOCS=C:\xampp\htdocs"
set "PROJECT_DIR=%XAMPP_HTDOCS%\templates"

echo Creating project structure in %PROJECT_DIR%

REM Create directories
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

REM ============================
REM Create Controller Files
REM ============================

REM Create AdminController.php
(
echo ^<?php
echo namespace App\Controllers\Admin^;
echo.
echo use App\Core\Controller^;
echo.
echo class AdminController extends Controller {
echo     public function index() {
echo         $data = array('title' => 'Admin Home');
echo         $this->view("admin/dashboard", $data);
echo     }
echo }
) > "%PROJECT_DIR%\app\controllers\admin\AdminController.php"

REM Create DashboardController.php
(
echo ^<?php
echo namespace App\Controllers\Admin^;
echo.
echo use App\Core\Controller^;
echo.
echo class DashboardController extends Controller {
echo     public function index() {
echo         $data = array('title' => 'Dashboard');
echo         $this->view("admin/dashboard", $data);
echo     }
echo }
) > "%PROJECT_DIR%\app\controllers\admin\DashboardController.php"

REM Create UserController.php
(
echo ^<?php
echo namespace App\Controllers\User^;
echo.
echo use App\Core\Controller^;
echo.
echo class UserController extends Controller {
echo     public function index() {
echo         $data = array('title' => 'User Home');
echo         $this->view("user/profile", $data);
echo     }
echo }
) > "%PROJECT_DIR%\app\controllers\user\UserController.php"

REM Create ProfileController.php
(
echo ^<?php
echo namespace App\Controllers\User^;
echo.
echo use App\Core\Controller^;
echo.
echo class ProfileController extends Controller {
echo     public function index() {
echo         $data = array('title' => 'User Profile');
echo         $this->view("user/profile", $data);
echo     }
echo }
) > "%PROJECT_DIR%\app\controllers\user\ProfileController.php"

REM ============================
REM Create Model Files
REM ============================

REM Create Admin.php
(
echo ^<?php
echo namespace App\Models^;
echo.
echo class Admin {
echo     // Sample admin model code
echo }
) > "%PROJECT_DIR%\app\models\Admin.php"

REM Create User.php
(
echo ^<?php
echo namespace App\Models^;
echo.
echo class User {
echo     // Sample user model code
echo }
) > "%PROJECT_DIR%\app\models\User.php"

REM ============================
REM Create View Files - Admin
REM ============================

REM Create admin dashboard view (dashboard.php)
(
echo ^<?php
echo // app/views/admin/dashboard.php
echo ?^>
echo ^<!DOCTYPE html^>
echo ^<html^>
echo ^<head^>
echo     ^<title^>^<^?php echo isset($data['title']) ? $data['title'] : "Admin Dashboard"; ?^>^</title^>
echo ^</head^>
echo ^<body^>
echo     ^<?php include "layouts/header.php"; ?^>
echo     ^<h1^>Admin Dashboard^</h1^>
echo     ^<?php include "layouts/footer.php"; ?^>
echo ^</body^>
echo ^</html^>
) > "%PROJECT_DIR%\app\views\admin\dashboard.php"

REM Create admin header layout (header.php)
(
echo ^<header^>
echo     ^<h2^>Admin Panel Header^</h2^>
echo     ^<nav^>
echo         ^<!-- admin navigation links -->^
echo     ^</nav^>
echo ^</header^>
) > "%PROJECT_DIR%\app\views\admin\layouts\header.php"

REM Create admin footer layout (footer.php)
(
echo ^<footer^>
echo     ^<p^>&copy; ^<?php echo date("Y"); ?^> Admin Panel^</p^>
echo ^</footer^>
) > "%PROJECT_DIR%\app\views\admin\layouts\footer.php"

REM ============================
REM Create View Files - User
REM ============================

REM Create user profile view (profile.php)
(
echo ^<?php
echo // app/views/user/profile.php
echo ?^>
echo ^<!DOCTYPE html^>
echo ^<html^>
echo ^<head^>
echo     ^<title^>^<^?php echo isset($data['title']) ? $data['title'] : "User Profile"; ?^>^</title^>
echo ^</head^>
echo ^<body^>
echo     ^<?php include "layouts/header.php"; ?^>
echo     ^<h1^>User Profile^</h1^>
echo     ^<?php include "layouts/footer.php"; ?^>
echo ^</body^>
echo ^</html^>
) > "%PROJECT_DIR%\app\views\user\profile.php"

REM Create user header layout (header.php)
(
echo ^<header^>
echo     ^<h2^>User Panel Header^</h2^>
echo     ^<nav^>
echo         ^<!-- user navigation links -->^
echo     ^</nav^>
echo ^</header^>
) > "%PROJECT_DIR%\app\views\user\layouts\header.php"

REM Create user footer layout (footer.php)
(
echo ^<footer^>
echo     ^<p^>&copy; ^<?php echo date("Y"); ?^> User Panel^</p^>
echo ^</footer^>
) > "%PROJECT_DIR%\app\views\user\layouts\footer.php"

REM ============================
REM Create Core Files
REM ============================

REM Create App.php
(
echo ^<?php
echo namespace App\Core^;
echo.
echo class App {
echo     protected $controller = "HomeController";
echo     protected $method = "index";
echo     protected $params = array();
echo.
echo     public function run() {
echo         $url = $this->parseUrl();
echo.
echo         if(isset($url[0]) && ($url[0] == "admin" || $url[0] == "user")) {
echo             $userType = array_shift($url);
echo             $controllerName = ucfirst(array_shift($url)) . "Controller";
echo             $controllerNamespace = "App\\Controllers\\" . ucfirst($userType);
echo             $controllerClass = $controllerNamespace . "\\" . $controllerName;
echo             if(class_exists($controllerClass)) {
echo                 $this->controller = new $controllerClass;
echo             } else {
echo                 $this->error404();
echo                 return;
echo             }
echo         } else {
echo             $controllerName = ucfirst(array_shift($url)) . "Controller";
echo             $controllerClass = "App\\Controllers\\" . $controllerName;
echo             if(class_exists($controllerClass)) {
echo                 $this->controller = new $controllerClass;
echo             }
echo         }
echo.
echo         if(isset($url[0]) && method_exists($this->controller, $url[0])) {
echo             $this->method = array_shift($url);
echo         }
echo         $this->params = $url ? array_values($url) : array();
echo         call_user_func_array(array($this->controller, $this->method), $this->params);
echo     }
echo.
echo     public function parseUrl() {
echo         if(isset($_GET["url"])) {
echo             return explode("/", filter_var(rtrim($_GET["url"], "/"), FILTER_SANITIZE_URL));
echo         }
echo         return array();
echo     }
echo.
echo     protected function error404() {
echo         header("HTTP/1.0 404 Not Found");
echo         echo "404 Not Found";
echo         exit;
echo     }
echo }
) > "%PROJECT_DIR%\app\core\App.php"

REM Create Controller.php
(
echo ^<?php
echo namespace App\Core^;
echo.
echo class Controller {
echo     public function view($view, $data = array()) {
echo         require_once "../app/views/%view%.php";
echo     }
echo }
) > "%PROJECT_DIR%\app\core\Controller.php"

REM ============================
REM Create Config File
REM ============================

REM Create config.php
(
echo ^<?php
echo // config/config.php
echo.
echo // Database configuration
echo define("DB_HOST", "localhost");
echo define("DB_USER", "root");
echo define("DB_PASS", "");
echo define("DB_NAME", "your_database_name");
) > "%PROJECT_DIR%\config\config.php"

REM ============================
REM Create Public Files
REM ============================

REM Create index.php in public folder
(
echo ^<?php
echo // public/index.php
echo.
echo require_once "../config/config.php";
echo.
echo spl_autoload_register(function($class) {
echo     $file = "../" . str_replace("\\", "/", $class) . ".php";
echo     if(file_exists($file)) {
echo         require_once $file;
echo     }
echo });
echo.
echo $app = new App\Core\App();
echo $app->run();
) > "%PROJECT_DIR%\public\index.php"

REM ============================
REM Create .htaccess File
REM ============================

(
echo RewriteEngine On
echo RewriteCond %%{REQUEST_FILENAME} !-f
echo RewriteCond %%{REQUEST_FILENAME} !-d
echo RewriteRule ^(.*)$ public/index.php?url=$1 [QSA,L]
) > "%PROJECT_DIR%\.htaccess"

echo.
echo Project structure with sample code created successfully in %PROJECT_DIR%.
pause
