
<?php
header("Access-Control-Allow-Origin: *");
// Include database connection
include "dbUpload.php";

// Assuming form data is submitted via POST method
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Extract serviceman_email from POST data
    $serviceman_email = $_POST['serviceman_email'];

    // Prepare SQL query to select data from repair_booking
    $sql = "SELECT * FROM repair_booking WHERE serviceman_email = '$serviceman_email'";
    // $sql = "SELECT user, seller, address, issue, date, time, mechanic_phone, serviceman_email, repair_time, serviceman_status, feedback FROM repair_booking WHERE serviceman_email = '$serviceman_email'";

    // Perform the query
    $result = $conn->query($sql);

    // Check if there are any rows returned
    if ($result->num_rows > 0) {
        // Array to hold the results
        $booking_details = array();

        // Fetch rows from the result set
        while ($row = $result->fetch_assoc()) {
            // Add each row to the array
            $booking_details[] = $row;
        }

        // Encode the array as JSON and output it
        echo json_encode($booking_details);
    } else {
        // No rows found, return empty array
        echo json_encode([]);
    }

    // Close database connection
    $conn->close();
} else {
    // Request method not allowed
    echo json_encode(["error" => "Request method not allowed"]);
}
?>