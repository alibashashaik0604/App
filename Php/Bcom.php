<?php
include 'config.php';
header('Content-Type: application/json');

$sql = "SELECT title AS opportunity, description FROM bcom";
$result = mysqli_query($conn, $sql);

$data = [];

if ($result) {
    while ($row = mysqli_fetch_assoc($result)) {
        $data[] = [
            'opportunity' => $row['opportunity'],
            'description' => $row['description']
        ];
    }
    echo json_encode($data);
} else {
    echo json_encode(['error' => 'Query failed']);
}
?>
