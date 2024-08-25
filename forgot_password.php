<?php
header("Access-Control-Allow-Origin: *");

include "dbUpload.php";
$user_email = $_POST['email'];
$query = "SELECT * FROM `allusers` WHERE `email` = '$user_email'";
$result = $conn->query($query);

if (mysqli_num_rows($result) > 0) {
    $sql = "UPDATE `allusers` SET `password`='' WHERE `email` = '$user_email'";
    $resultsearch = $conn->query($sql);
    if ($resultsearch) {
        $data['success'] = true;
        echo json_encode($data);
    } else {
        $data['success'] = false;

        echo json_encode($data);
    }
} else {
    $data['success'] = false;
    $data['message']="No user found";
    echo json_encode($data);
}

$conn->close();
