<?php
require 'config.php';

$name = trim($_POST['name']);

if (empty($name)) {
    echo json_encode(['success' => false, 'message' => 'Course name is required.']);
    exit;
}

$stmt = $conn->prepare("INSERT INTO courses1 (name) VALUES (?)");
$stmt->bind_param("s", $name);

if ($stmt->execute()) {
    echo json_encode(['success' => true, 'message' => 'Course added successfully.']);
} else {
    echo json_encode(['success' => false, 'message' => 'Failed to add course.']);
}

$stmt->close();
$conn->close();
?>
