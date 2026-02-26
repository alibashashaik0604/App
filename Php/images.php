<?php
include 'config.php';

$name = $_POST['name'];

if (isset($_FILES['image']) && $_FILES['image']['error'] == 0) {
    $targetDir = "images/";
    $filename = basename($_FILES["image"]["name"]);
    $targetFilePath = $targetDir . $filename;

    // Move uploaded file
    if (move_uploaded_file($_FILES["image"]["tmp_name"], $targetFilePath)) {
        // Insert into DB
        $stmt = $conn->prepare("INSERT INTO AP (name, image) VALUES (?, ?)");
        $stmt->bind_param("ss", $name, $filename);
        if ($stmt->execute()) {
            echo json_encode(['status' => 'success', 'message' => 'Uploaded successfully']);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'DB Insert failed']);
        }
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Upload failed']);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'No image uploaded']);
}
?>
