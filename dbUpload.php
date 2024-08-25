<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: text/html; charset=UTF-8");

$sname = "127.0.0.1"; // MySQL server address
$uname = "hello"; // MySQL username
$password = "hi1234"; // MySQL password
$db_name = "ecom_new"; // Ensure this matches the database you imported
$port = 3307; // Default MySQL port

// Establishing connection
$conn = mysqli_connect($sname, $uname, $password, $db_name, $port);

if (!$conn) {
    echo "Connection failed: " . mysqli_connect_error();
    exit();
} 

?>
