<?php
require 'config.php';

$result = $conn->query("SELECT name FROM locations1");

if ($result) {
    $locations = [];

    while ($row = $result->fetch_assoc()) {
        $locations[] = $row['name'];
    }

    echo json_encode(['success' => true, 'locations' => $locations]);
} else {
    echo json_encode(['success' => false, 'message' => 'Failed to fetch locations.']);
}

$conn->close();
?>
