<?php
header("Access-Control-Allow-Origin: *");
include "dbUpload.php";

$email = $_POST['email'];

$sql = "SELECT email, name, phone FROM user_contacts WHERE email='$email'";
$result = $conn->query($sql);
$response = array();
if($result->num_rows >0) {
    while($row = $result->fetch_assoc()) {
        array_push($response, $row);
    }
}
$conn->close();
header('Content-Type: application/json');
echo json_encode($response[0]);

?>
