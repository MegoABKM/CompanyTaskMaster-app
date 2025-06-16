<?php
include "functions.php";

echo "🔹 Sending test notification...\n";
$response = sendNotificationToTopicwithcomposer("Topic", "Test message", "news");
echo "🔹 Function Output: " . json_encode($response) . "\n";
echo "✅ Done.\n";
