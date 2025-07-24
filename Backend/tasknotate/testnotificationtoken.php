<?php
include "functions.php";

echo "🔹 Sending test notification...\n";
$response = sendNotificationToDevice("token", "Test message", "e1CcgwzSQMmrv4-d5r8J9v:APA91bGmMP_s-cffY8djQ43YMeaLGTdCUyouPYWCKiP5tkR7NGPteoqRael52KCusNXguMPoBYnCcrTv4g6bDyzFBZ_bX9MtA59vdkpC7dTHL1rwrFrALfU");
echo "🔹 Function Output: " . json_encode($response) . "\n";
echo "✅ Done.\n";
