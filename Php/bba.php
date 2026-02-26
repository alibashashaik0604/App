<?php
include 'config.php';  // make sure config.php connects $conn correctly
header('Content-Type: application/json');

$sql = "SELECT title, description FROM bba_opportunities";
$result = mysqli_query($conn, $sql);

$data = [];

if ($result) {
    while ($row = mysqli_fetch_assoc($result)) {
        $data[] = [
            'opportunity' => $row['title'],
            'description' => $row['description']
        ];
    }
    echo json_encode($data);
} else {
    echo json_encode(['error' => 'Query failed']);
}
?>
