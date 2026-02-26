<?php
header('Content-Type: application/json');

// DB config
$host = 'localhost';
$db   = 'collegehunt';
$user = 'root';
$pass = '';
$charset = 'utf8mb4';
$dsn = "mysql:host=$host;dbname=$db;charset=$charset";
$options = [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
];

try {
    $pdo = new PDO($dsn, $user, $pass, $options);
    $stmt = $pdo->query("SELECT * FROM iiit_hyderabad LIMIT 1");
    $college = $stmt->fetch();

    if ($college) {
        // Prepend image paths with /collegehunt/uploads/
        foreach (['image_logo', 'image1', 'image2', 'image3'] as $key) {
            if (!empty($college[$key])) {
                $college[$key] = 'http://localhost/collegehunt/uploads/' . $college[$key];
            }
        }

        echo json_encode([
            'success' => true,
            'college' => $college
        ]);
    } else {
        echo json_encode(['success' => false, 'message' => 'No data found']);
    }

} catch (PDOException $e) {
    echo json_encode([
        'success' => false,
        'message' => 'Database error: ' . $e->getMessage()
    ]);
}
?>
