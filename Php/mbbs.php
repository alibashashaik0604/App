<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

$host = "localhost";
$user = "root";
$password = ""; // Update this if your MySQL has a password
$db = "collegehunt";

$conn = new mysqli($host, $user, $password, $db);

if ($conn->connect_error) {
  die(json_encode(["error" => "Connection failed: " . $conn->connect_error]));
}

$sql = "SELECT opportunity, description FROM mbbs_opportunities";
$result = $conn->query($sql);

$opportunities = [];

if ($result->num_rows > 0) {
  while ($row = $result->fetch_assoc()) {
    $opportunities[] = $row;
  }
}

echo json_encode($opportunities);

$conn->close();
?>
