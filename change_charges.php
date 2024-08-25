<?php
header("Access-Control-Allow-Origin: *");
$service = (float)$_POST['serviceC'];
$trans = (float)$_POST['trans'];

include "dbUpload.php";

$sql = "UPDATE `extra_charges` SET `service_charge`='$service',`transaction_fee`='$trans' WHERE 1";
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
