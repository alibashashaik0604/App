<?php
require_once 'config.php';

header('Content-Type: application/json');

$data = json_decode(file_get_contents("php://input"), true);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $data['email'] ?? '';
    $password = $data['password'] ?? '';

    if (empty($email) || empty($password)) {
        http_response_code(400);
        echo json_encode(['message' => 'All fields are required.']);
        exit;
    }

    $email = $conn->real_escape_string($email);
    $password = $conn->real_escape_string($password);

    $sql = "SELECT email, password FROM login WHERE email = '$email'";
    $result = $conn->query($sql);

    if ($result && $result->num_rows > 0) {
        $user = $result->fetch_assoc();
        
        if ($password === $user['password']) {
            http_response_code(200);
            echo json_encode([
                'message' => 'Login successful.',
                'success' => true,
                'email' => $user['email']
            ]);
        } else {
            http_response_code(401);
            echo json_encode(['message' => 'Invalid email or password.', 'success' => false]);
        }
    } else {
        http_response_code(401);
        echo json_encode(['message' => 'Invalid email or password.', 'success' => false]);
    }
} else {
    http_response_code(405);
    echo json_encode(['message' => 'Method not allowed.']);
}
?>
