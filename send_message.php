<?php
header("Access-Control-Allow-Origin: *");

$from = $_POST["from"];
$to = $_POST["to"];
$msg = $_POST["msg"];

include "dbUpload.php";

$sql = "INSERT INTO `messages`(`fromEmail`, `toEmail`, `msg`) VALUES ('$from','$to','$msg')";
$result = $conn->query($sql);
if($result) {
    $conn->close();
    header('Content-Type: application/json');
    echo json_encode("success");

} else {
    $conn->close();
    header('Content-Type: application/json');
    echo json_encode("unsuccessful");

}



?>
