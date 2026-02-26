<?php
header('Content-Type: application/json');
require 'config.php';  // Include your database configuration

// Fetch all colleges from the `colleges` table
$sql = "SELECT id, college_name, courses, location FROM colleges ORDER BY college_name ASC";
$result = $conn->query($sql);

if ($result && $result->num_rows > 0) {
    $colleges = [];
    
    while ($row = $result->fetch_assoc()) {
        $colleges[] = [
            'id' => $row['id'],
            'college_name' => $row['college_name'],
            'courses' => explode(',', $row['courses']),  // Convert courses to an array
            'location' => $row['location']
        ];
    }
    
    echo json_encode(['success' => true, 'colleges' => $colleges]);
} else {
    echo json_encode(['success' => false, 'message' => 'No colleges found.']);
}

$conn->close();
?>
