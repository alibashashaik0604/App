<?php
header('Content-Type: application/json');
require_once 'config.php';  // your config file which provides $conn

$sql = "SELECT id, title, description FROM BEd ORDER BY id ASC";
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
?>
