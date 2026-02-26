<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

require 'config.php'; // <-- Now using config.php instead of db.php

$sql = "SELECT id, title, description FROM btechopportunities";
$result = $conn->query($sql);

$opportunities = [];

if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $opportunities[] = $row;
    }
}

echo json_encode($opportunities);
$conn->close();
?>
