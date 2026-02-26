<?php
require 'config.php';

$result = $conn->query("SELECT name FROM courses1");

if ($result) {
    $courses = [];

    while ($row = $result->fetch_assoc()) {
        $courses[] = $row['name'];
    }

    echo json_encode(['success' => true, 'courses' => $courses]);
} else {
    echo json_encode(['success' => false, 'message' => 'Failed to fetch courses.']);
}

$conn->close();
?>
