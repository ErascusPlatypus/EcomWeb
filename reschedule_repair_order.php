<?php
header("Access-Control-Allow-Origin: *");

    include "dbUpload.php";


    $email = $_POST['email'];
    $timeslot = $_POST['timeslot'];
    $date = $_POST['date'];

    $sql = "SELECT phone FROM all_service_users WHERE email='$email'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $phone = $row['phone'];

        $sql1 = "UPDATE `repair_booking` SET `time`='$timeslot' WHERE `mechanic_phone` = '$phone'";
        $sql2 = "UPDATE `repair_booking` SET `date`='$date' WHERE `mechanic_phone` = '$phone'";

        $result1 = mysqli_query($conn, $sql1);
        $result2 = mysqli_query($conn, $sql2);

        if ($result1 && $result2) {
            $data['success'] = true;
            $data["message"] = "Repair order has been rescheduled.";
            echo json_encode($data);
        } else {
            $data['success'] = false;
            $data["message"] = "Failed to reschedule repair order.";
            echo json_encode($data);
        }

        $conn->close();
    } else {
        $conn->close();
        echo "No phone number found for the service man.";
    }
?>
