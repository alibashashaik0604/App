<?php
header('Content-Type: application/json');
require_once 'config.php';  // This will give you $conn

$sql = "SELECT id, title, description FROM bsc_opportunities ORDER BY id ASC";
$result = $conn->query($sql);

if ($result === false) {
    echo json_encode(['status' => 'error', 'message' => $conn->error]);
    exit;
}

$opportunities = [];
while ($row = $result->fetch_assoc()) {
    $opportunities[] = $row;
}

echo json_encode(['status' => 'success', 'data' => $opportunities]);
