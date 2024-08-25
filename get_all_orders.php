<?php
header("Access-Control-Allow-Origin: *");
header('Content-Type: application/json');

include "dbUpload.php";

$sql = "SELECT * FROM  buy_now_table";

$result = $conn->query($sql);
$response = array();

if($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        array_push($response, $row);
    }
}

$conn->close();
echo json_encode($response);
?>
