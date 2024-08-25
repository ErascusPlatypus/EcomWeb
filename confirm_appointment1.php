<?php
header("Access-Control-Allow-Origin: *");

    include "dbUpload.php";


        $user = $_POST['user'];
        $seller = $_POST['seller'];
        $date = $_POST['date'];
        $time = $_POST['time'];
        $service = $_POST['service'];
        $address = $_POST['address'];
        $issue = $_POST['issue'];
        $rid = $_POST['rid'];
        $phone = $_POST['phone'];






        $sql = "UPDATE `repair_request` SET `status`='accepted' WHERE rid='$rid';";
        $result = $conn->query($sql);
        $sql4 = "INSERT INTO `repair_booking`(`user`, `seller`, `service`, `address`, `issue`, `date`, `time`, `mechanic_phone`) VALUES ('$user', '$seller', '$service', '$address', '$issue', '$date', '$time', '$phone');";
        $result3 = $conn->query($sql4);
        if($result3 && $result) {
                echo json_encode("success");

        } else {
                echo json_encode("nosuccess");

        }

        $conn->close();

?>
