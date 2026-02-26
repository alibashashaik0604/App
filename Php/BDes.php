<?php
include 'config.php';
header('Content-Type: application/json');

// Query the correct columns from the 'bdes' table
$sql = "SELECT title AS opportunity, description FROM bdes";
$result = mysqli_query($conn, $sql);

$data = [];

if ($result) {
    while ($row = mysqli_fetch_assoc($result)) {
        $data[] = [
            'opportunity' => $row['opportunity'],
            'description' => $row['description']
        ];
    }
}

// Output data as JSON
echo json_encode($data);
?>
