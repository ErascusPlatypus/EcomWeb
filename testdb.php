<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: text/html; charset=UTF-8");

// MySQL connection details
$sname = "127.0.0.1"; // MySQL server address
$uname = "hello"; // MySQL username
$password = "hi1234"; // MySQL password
$db_name = "ecom_new"; // Database name
$port = 3307; // MySQL port

// Establishing connection to the database
$conn = mysqli_connect($sname, $uname, $password, $db_name, $port);

// Check connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

// Query to retrieve all table names
$query = "SHOW TABLES";
$result = mysqli_query($conn, $query);

// Check if query was successful
if (!$result) {
    die("Query failed: " . mysqli_error($conn));
}

// HTML output
echo "<!DOCTYPE html>";
echo "<html lang='en'>";
echo "<head>";
echo "<meta charset='UTF-8'>";
echo "<meta name='viewport' content='width=device-width, initial-scale=1.0'>";
echo "<title>Database Tables</title>";
echo "<style>table { width: 100%; border-collapse: collapse; } th, td { border: 1px solid #ddd; padding: 8px; text-align: left; } th { background-color: #f2f2f2; }</style>";
echo "</head>";
echo "<body>";
echo "<h1>Tables in Database '$db_name'</h1>";
echo "<table>";
echo "<tr><th>Table Name</th></tr>";

// Fetch and display table names
while ($row = mysqli_fetch_row($result)) {
    echo "<tr><td>" . htmlspecialchars($row[0]) . "</td></tr>";
}

// Close HTML table and body
echo "</table>";
echo "</body>";
echo "</html>";

// Close the database connection
mysqli_close($conn);
?>
