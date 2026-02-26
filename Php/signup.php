<?php
require 'config.php';

$data = json_decode(file_get_contents("php://input"), true);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $data['email'] ?? '';
    $password = $data['password'] ?? '';
    $confirmPassword = $data['confirmPassword'] ?? '';

    if (empty($email) || empty($password) || empty($confirmPassword)) {
        echo json_encode(['message' => 'All fields are required.']);
        exit;
    }

    if ($password !== $confirmPassword) {
        echo json_encode(['message' => "Passwords don't match."]);
        exit;
    }

    $email = $conn->real_escape_string($email);
    $password = $conn->real_escape_string($password);

    $checkQuery = "SELECT COUNT(*) as count FROM login WHERE email = '$email'";
    $result = $conn->query($checkQuery);
    $row = $result->fetch_assoc();

    if ($row['count'] > 0) {
        echo json_encode(['message' => 'Email already exists.']);
        exit;
    }

    $sql = "INSERT INTO login (email, password, confirmPassword) VALUES ('$email', '$password', '$confirmPassword')";

    if ($conn->query($sql)) {
        echo json_encode(['message' => 'User registered successfully.']);
    } else {
        echo json_encode(['message' => 'Database error.', 'error' => $conn->error]);
    }
} else {
    echo json_encode(['message' => 'Method not allowed.']);
}
?>
