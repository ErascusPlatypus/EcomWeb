<?php
header("Access-Control-Allow-Origin: *");

include "dbUpload.php";

$sql = "SELECT * FROM `all_service_users`";

if (isset($_POST['seller_id']) && isset($_POST['service_id'])) {
    $sql = "SELECT * FROM all_service_users WHERE seller_id = '{$_POST['seller_id']}' and service_id='{$_POST['service_id']}'";
}


$result = $conn->query($sql);
$response = array();
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        array_push($response, $row);
    }
}
$conn->close();
header('Content-Type: application/json');
echo json_encode($response);



?>
