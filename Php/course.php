<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

include 'config.php'; // include your DB connection

$sql = "SELECT name, screen, duration, eligibility, fees FROM courses";
$result = $conn->query($sql);

$courses = [];

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $courses[] = $row;
    }
}

echo json_encode($courses);

$conn->close();
?>