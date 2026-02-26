<?php
// Enable error reporting for development
ini_set('display_errors', 1);
error_reporting(E_ALL);

// Headers
header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');

// Include your database connection
require 'config.php';

// ✅ Updated query to match actual table name
$sql = "SELECT id, name, address, state, image_url FROM ap ORDER BY id DESC";
$result = mysqli_query($conn, $sql);

// Process the result
if ($result && mysqli_num_rows($result) > 0) {
    $colleges = [];

    while ($row = mysqli_fetch_assoc($result)) {
        $colleges[] = $row;
    }

    echo json_encode([
        'success' => true,
        'colleges' => $colleges
    ]);
} else {
    echo json_encode([
        'success' => false,
        'message' => 'No colleges found'
    ]);
}

mysqli_close($conn);
?>
