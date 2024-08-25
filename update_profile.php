<?php
header("Access-Control-Allow-Origin: *");
error_reporting(E_ALL);
ini_set('display_errors', 1);
include "dbUpload.php";

// Output POST data to verify what is being received
//var_dump($_POST);

$sql = "UPDATE `allusers` 
        SET `name` = '{$_POST['name']}', 
            `email` = '{$_POST['email']}'
            
        WHERE `id` = {$_POST['id']}";

// Output the SQL query to debug
//echo $sql;

$resultsearch = mysqli_query($conn, $sql);

// Check if the query was successful
if ($resultsearch) {
    echo json_encode("done");
} else {
    echo json_encode("notdone");
    echo "Error: " . mysqli_error($conn);
}

$conn->close();
?>
