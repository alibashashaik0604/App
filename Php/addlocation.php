<?php
require 'config.php';

$name = trim($_POST['name']);

if (empty($name)) {
    echo json_encode(['success' => false, 'message' => 'Location name is required.']);
    exit;
}

$stmt = $conn->prepare("INSERT INTO locations1 (name) VALUES (?)");
$stmt->bind_param("s", $name);

if ($stmt->execute()) {
    echo json_encode(['success' => true, 'message' => 'Location added successfully.']);
} else {
    echo json_encode(['success' => false, 'message' => 'Failed to add location.']);
}

$stmt->close();
$conn->close();
?>
