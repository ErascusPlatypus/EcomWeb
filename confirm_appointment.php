
<?php
header("Access-Control-Allow-Origin: *");
// Enable error reporting
error_reporting(E_ALL);
ini_set('display_errors', 0); // Disable displaying errors on the screen

// Set the path to the error log file
//$errorLogFilePath = '/public_html/ecom/error.log'; // Replace '/path/to/error.log' with the actual path to your error log file

// Include database connection
include "dbUpload.php";

// Assuming $_POST data is provided correctly
$user = $_POST['user'];
$seller = $_POST['seller'];
$date = $_POST['date'];
$time = $_POST['time'];
$service = $_POST['service'];
$address = $_POST['address'];
$issue = $_POST['issue'];
$rid = $_POST['rid'];
$phone = $_POST['phone'];
$serviceman_email = $_POST['serviceman_email'];

// Update repair_request status
$sql = "UPDATE `repair_request` SET `status`='accepted' WHERE rid='$rid';";
$result = $conn->query($sql);

// Insert into repair_booking
$sql4 = "INSERT INTO `repair_booking`(`user`, `seller`, `service`, `address`, `issue`, `date`, `time`, `mechanic_phone`, `serviceman_email`) VALUES ('$user', '$seller', '$service', '$address', '$issue', '$date', '$time', '$phone', '$serviceman_email');";
$result3 = $conn->query($sql4);

if ($result3 && $result) {
    echo json_encode("success");
} else {
    // Log errors to the error log file
    $errorMessage = "nosuccess: " . $conn->error . PHP_EOL;
    error_log($errorMessage, 3, $errorLogFilePath);

    echo json_encode("nosuccess: An error occurred. Please try again later.");
}

$conn->close();
?>