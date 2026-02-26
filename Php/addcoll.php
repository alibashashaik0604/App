<?php
$host = "localhost";
$username = "root";
$password = "";
$dbname = "collegehunt";

$conn = new mysqli($host, $username, $password, $dbname);

if ($conn->connect_error) {
    die(json_encode(['success' => false, 'message' => 'Database connection failed']));
}

$college_name = $_POST['college_name'];
$courses = $_POST['courses'];
$location = $_POST['location'];

$sql = "INSERT INTO colleges (name, courses, location) VALUES ('$college_name', '$courses', '$location')";

if ($conn->query($sql) === TRUE) {
    echo json_encode(['success' => true]);
} else {
    echo json_encode(['success' => false, 'message' => $conn->error]);
}

$conn->close();
?>
