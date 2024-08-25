
<?php
header("Access-Control-Allow-Origin: *");
include "dbUpload.php";

// Check if the request method is POST
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    // Extract POST data
    $id = $_POST['id'];
    $feedback = $_POST['feedback'];
    $serviceman_status = $_POST['serviceman_status'];
    $repair_time = $_POST['repair_time'];

    // Update repair_booking table
    $sql = "UPDATE `repair_booking` SET `feedback`='$feedback', `serviceman_status`='$serviceman_status', `repair_time`='$repair_time' WHERE `id`='$id'";
    $result = $conn->query($sql);

    // Check if update was successful
    if ($result === TRUE) {
        echo json_encode(["success" => true]);
    } else {
        echo json_encode(["success" => false, "error" => $conn->error]);
    }

    // Close database connection
    $conn->close();
} else {
    echo json_encode("error: Request method not allowed");
}

?>
