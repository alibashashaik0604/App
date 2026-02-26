<?php
header('Content-Type: application/json');

$host = 'localhost';
$user = 'root';
$password = '';
$database = 'collegehunt';

$conn = new mysqli($host, $user, $password, $database);

if ($conn->connect_error) {
    echo json_encode(['message' => 'Database connection failed.', 'error' => $conn->connect_error]);
    exit;
}
?>
