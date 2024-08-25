<?php
header("Access-Control-Allow-Origin: *");

$email = $_POST['email'];


include "dbUpload.php";

$sql1 = "SELECT * FROM allusers WHERE email='".$email."'";
    $result1 = $conn->query($sql1);
    $row = mysqli_fetch_assoc($result1);
    echo json_encode($row["ref_wallet"]);

?>
