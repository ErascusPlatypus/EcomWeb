<?php
header("Access-Control-Allow-Origin: *");

    include "dbUpload.php";


    $issue = $_POST['issue'];
    $address = $_POST['address'];
    $phone = $_POST['phone'];
    $seller_id = (int)$_POST['sellerId'];
    $service = $_POST['service'];
    $email = $_POST['email'];
    $state = $_POST['state'];
    $city = $_POST['city'];
    $locality = $_POST['locality'];
    $landmark = $_POST['landmark'];
    $timeslot = $_POST['timeslot'];
    $date = $_POST['date'];
    $status = "pending";



    $sql1 = "SELECT * FROM allsellers WHERE id='".$seller_id."'";
    $result = $conn->query($sql1);
    $response = array();
    if($result->num_rows >0) {
    while($row = $result->fetch_assoc()) {
            array_push($response, $row);
    }
    }
        $name = $response[0]['email'];

        $sql4 = "INSERT INTO `repair_request`(`user`, `seller`, `address`,`state`,`city`,`locality`,`landmark`, `phone`, `issue`, `service`, `timeslot`, `date`, `status`) VALUES ('$email', '$name', '$address', '$state', '$city', '$locality', '$landmark', '$phone', '$issue', '$service', '$timeslot', '$date', '$status');";
        $result3 = $conn->query($sql4);
        if($result3) {
                echo json_encode("success");

        } else {
                echo json_encode("nosuccess");

        }
        $conn->close();
?>