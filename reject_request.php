<?php
header("Access-Control-Allow-Origin: *");


$rid = (int)$_POST['rid'];

include "dbUpload.php";
$sql = "UPDATE `repair_request` SET `status`='rejected' WHERE rid='$rid';";
$result = $conn->query($sql);
if($result) {
    $conn->close();
    header('Content-Type: application/json');
    echo json_encode("success");

}



?>
