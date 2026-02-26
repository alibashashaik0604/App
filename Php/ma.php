<?php
header('Content-Type: application/json');
require 'config.php'; // contains $conn

$sql = "SELECT id, name, address, state, image_url FROM ma ORDER BY id DESC";
$result = mysqli_query($conn, $sql);

$colleges = [];

if ($result && mysqli_num_rows($result) > 0) {
    while ($row = mysqli_fetch_assoc($result)) {
        $colleges[] = $row;
    }
    echo json_encode(['success' => true, 'colleges' => $colleges]);
} else {
    echo json_encode(['success' => false, 'message' => 'No colleges found']);
}
?>
