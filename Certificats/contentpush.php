<?php

// Put your device token here (without spaces):
$deviceToken = '895AAE606ABF9D8D76265F8A0019846C59C6BCE8B75EA0F7CFD755BE08CD9E2E';

// Put your private key's passphrase here:
$passphrase = 'SimplePush';

////////////////////////////////////////////////////////////////////////////////

$ctx = stream_context_create();
stream_context_set_option($ctx, 'ssl', 'local_cert', 'SimplePushCertificats_dev.pem');
//stream_context_set_option($ctx, 'ssl', 'local_cert', 'SimplePushCertificats_prod.pem');
stream_context_set_option($ctx, 'ssl', 'passphrase', $passphrase);

// Open a connection to the APNS server
$fp = stream_socket_client(
  'ssl://gateway.sandbox.push.apple.com:2195', $err,
 //  'ssl://gateway.push.apple.com:2195', $err,
  $errstr, 60, STREAM_CLIENT_CONNECT|STREAM_CLIENT_PERSISTENT, $ctx);

if (!$fp)
  exit("Failed to connect: $err $errstr" . PHP_EOL);

echo 'Connected to APNS' . PHP_EOL;

// Create the payload body
$body['aps'] = array(
 
  'alert' => 'hello my friend, this is a real notification !',
  'badge' => 2,
  'category' => 'priceAlert',
  );

// Encode the payload as JSON
$payload = json_encode($body);

// Build the binary notification
$msg = chr(0) . pack('n', 32) . pack('H*', $deviceToken) . pack('n', strlen($payload)) . $payload;

// Send it to the server
$result = fwrite($fp, $msg, strlen($msg));

if (!$result)
  echo 'Message not delivered' . PHP_EOL;
else
  echo 'Message successfully delivered' . PHP_EOL;

// Close the connection to the server
fclose($fp);
