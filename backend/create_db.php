 <?php

include "creds.php";

// Create connection
$conn = new mysqli($servername, $username, $password);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Create database
$sql = "CREATE DATABASE myHDB";
if ($conn->query($sql) === TRUE) {
    echo "Database created successfully";
} else {
    echo "Error creating database: " . $conn->error;
}

// sql to create table
$sql = "CREATE TABLE HDB (
id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
uniqID VARCHAR(40) NOT NULL,
symptoms VARCHAR(40) NOT NULL,
medications VARCHAR(40) NOT NULL,
painscale Int(6) NOT NULL,
user_date VARCHAR(40) NOT NULL,
)";

if ($conn->query($sql) === TRUE) {
    echo "Table MyGuests created successfully";
} else {
    echo "Error creating table: " . $conn->error;
}

$conn->close();
?>

$conn->close();
?> 