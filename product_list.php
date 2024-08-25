<?php
header("Access-Control-Allow-Origin: *");
include "dbUpload.php";
$sql = "SELECT * FROM products where category_id=1;";
$result = $conn->query($sql);
$response = array();
if($result->num_rows >0) {
    while($row = $result->fetch_assoc()) {
        array_push($response, $row);
    }
}
$conn->close();
header('Content-Type: application/json');
echo json_encode($response);



?>
