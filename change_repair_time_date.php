<?php
header("Access-Control-Allow-Origin: *");

$rid = (int)$_POST['rid'];
$text = $_POST['text'];
$id = $_POST['id'];

include "dbUpload.php";

if($id == "time") {
    $sql = "UPDATE `repair_request` SET `timeslot`='$text' WHERE rid='$rid'";
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
} else {
    $sql = "UPDATE `repair_request` SET `date`='$text' WHERE rid='$rid'";
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
}
?>
