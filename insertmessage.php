
<?php
header("Access-Control-Allow-Origin: *");
include "dbUpload.php";

// Check if the form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Retrieve form data
    $senderID = $_POST['senderID'];
    $receiverID = $_POST['receiverID'];
    $body = $_POST['body'];
    $sentAt = $_POST['sentAt'];

    // Check if sentAt is null, set it to current time
    if (empty($sentAt)) {
        $sentAt = date('Y-m-d H:i:s');
    }

    // Encrypt the message body
    $encryptedBody = openssl_encrypt($body, 'AES-256-CBC', 'YourSecretKey', 0, 'YourInitializationVector');

    // Prepare and bind statement
    $stmt = $conn->prepare("INSERT INTO Message (SenderID, ReceiverID, Body, SentAt) VALUES (?, ?, ?, ?)");
    $stmt->bind_param("ssss", $senderID, $receiverID, $encryptedBody, $sentAt);

    // Execute the statement
    if ($stmt->execute()) {
        // Message inserted successfully
        $response = array("status" => "success", "message" => "Message inserted successfully.");
    } else {
        // Error inserting message
        $response = array("status" => "error", "message" => "Error inserting message: " . $stmt->error);
    }

    // Close statement
    $stmt->close();

    // Return JSON response
    header('Content-Type: application/json');
    echo json_encode($response);
}

// Close connection
$conn->close();
?>