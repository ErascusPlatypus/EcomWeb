<?php
header("Access-Control-Allow-Origin: *");
include "dbUpload.php";

// Check if the senderID and receiverID are provided
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $senderID = $_POST['senderID'];
    $receiverID = $_POST['receiverID'];

    // Prepare and bind statement
    $stmt = $conn->prepare("SELECT * FROM Message WHERE SenderID = ? AND ReceiverID = ? ORDER BY SentAt ASC");
    $stmt->bind_param("ss", $senderID, $receiverID);

    // Execute the statement
    $stmt->execute();

    // Get result
    $result = $stmt->get_result();

    // Fetch data as associative array
    $messages = array();
    while ($row = $result->fetch_assoc()) {
        // Decrypt the message body if needed
        $row['Body'] = openssl_decrypt($row['Body'], 'AES-256-CBC', 'YourSecretKey', 0, 'YourInitializationVector');
        
        $messages[] = $row;
    }

    // Return JSON response
    header('Content-Type: application/json');
    echo json_encode($messages);
} else {
    // SenderID or ReceiverID not provided
    $response = array("status" => "error", "message" => "SenderID or ReceiverID not provided.");
    
    // Return JSON response
    header('Content-Type: application/json');
    echo json_encode($response);
}

// Close statement
$stmt->close();

// Close connection
$conn->close();
?>
