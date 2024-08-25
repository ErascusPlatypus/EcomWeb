<?php
header("Access-Control-Allow-Origin: *");
$id = (int)$_POST['shopid'];
$gst = (float)$_POST['gst'];

include "dbUpload.php";
if($id != 0) {
    $sql = "UPDATE `allsellers` SET `gst`='$gst' WHERE id='$id'";
    $result = $conn->query($sql);
    $sql1 = "UPDATE `products` SET `gst`='$gst' WHERE seller_id='$id'";
    $result1 = $conn->query($sql1);
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
    $sql = "UPDATE `allsellers` SET `gst`='$gst' WHERE 1";
    $result = $conn->query($sql);
    $sql1 = "UPDATE `products` SET `gst`='$gst' WHERE 1";
    $result1 = $conn->query($sql1);
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
