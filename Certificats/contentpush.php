<?php

// Put your device token here (without spaces):
$deviceToken = '2177F8AE84A6B0D572CFD32D14925CC800A01DE72004FA17D3968F8A61AFC52B';

// Put your private key's passphrase here:
$passphrase = 'SimplePush';

////////////////////////////////////////////////////////////////////////////////

$ctx = stream_context_create();
stream_context_set_option($ctx, 'ssl', 'local_cert', 'SimplePushCertificats_dev.pem');
stream_context_set_option($ctx, 'ssl', 'passphrase', $passphrase);

// Open a connection to the APNS server
$fp = stream_socket_client(
  'ssl://gateway.sandbox.push.apple.com:2195', $err,
  $errstr, 60, STREAM_CLIENT_CONNECT|STREAM_CLIENT_PERSISTENT, $ctx);

if (!$fp)
  exit("Failed to connect: $err $errstr" . PHP_EOL);

echo 'Connected to APNS' . PHP_EOL;

// Create the payload body
$body['aps'] = array(
  'content-available' => '1',
  'alert' => 'hello',
  'badge' => 4,
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
