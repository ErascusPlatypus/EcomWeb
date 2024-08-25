
<?php
header("Access-Control-Allow-Origin: *");
include "dbUpload.php";

// Receive data sent from the client
$email = $_POST['email'];
$currentPassword = $_POST['currentPassword'];
$newPassword = $_POST['newPassword'];

// Validate input parameters
if (empty($email) || empty($currentPassword) || empty($newPassword)) {
    die(json_encode(array("error" => "Missing parameters")));
}

// Check if the email exists in the database
$stmt = $conn->prepare("SELECT password FROM allusers WHERE email = ?");
$stmt->bind_param("s", $email);
$stmt->execute();
$stmt->store_result();

if ($stmt->num_rows == 0) {
    die(json_encode(array("error" => "Email not found")));
}

$stmt->bind_result($storedPassword);
$stmt->fetch();

// Verify if the current password matches the stored password
if ($currentPassword !== $storedPassword) {
    die(json_encode(array("error" => "Incorrect current password")));
}

// Update the password with the new password in the database
$stmt = $conn->prepare("UPDATE allusers SET password = ? WHERE email = ?");
$stmt->bind_param("ss", $newPassword, $email);
$stmt->execute();

if ($stmt->affected_rows > 0) {
    echo json_encode(array("message" => "Password updated successfully"));
} else {
    echo json_encode(array("error" => "Failed to update password"));
}

$stmt->close();
$conn->close();
?>