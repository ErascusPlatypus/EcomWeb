<?php
header("Access-Control-Allow-Origin: *");

include "dbUpload.php";
$name=$_POST['name'];
$email = $_POST['email'];
$password = $_POST['password'];
$code = strtoupper($_POST['code']);






$findexist = "SELECT * from allusers where email='$email'";
$resultsearch = mysqli_query($conn, $findexist);
if (mysqli_num_rows($resultsearch) > 0) {
    while ($row = mysqli_fetch_array($resultsearch)) {
        $result["success"] = "3";
        $result["message"] = "user Already exist";
        echo json_encode($result);
        mysqli_close($conn);
    }
} else {
    $arr = array();
    $arr1 = base64_encode(serialize($arr));
    $sql = "INSERT INTO allusers (name,email, password, cart_item,isRestrict) VALUES ('$name','$email', '$password', '$arr1','0');";
    $add = 50;
    $sql2 = "UPDATE `allusers` SET `ref_wallet`= (`ref_wallet` + '$add') WHERE code='$code'";
    $resultsearch2 = mysqli_query($conn, $sql2);
    if (mysqli_query($conn, $sql)) {
        $result["success"] = "1";
        $result["message"] = "Registration success";
        echo json_encode($result);
        mysqli_close($conn);
    } else {
        $result["success"] = "0";
        $result["message"] = "error in Registration";
        echo (json_encode($result).mysqli_error($conn));
        mysqli_close($conn);
    }
}




?>
