# SimplePush
A simple project to demonstrate push for iOs with APNS

1. Open the App and send the device token to your email adress
2. Edit the file contentpush.php and replace the device token with the one copied from the email
3. If you are debugging locally with XCode, make sure that the sandbox url and development certificats for the APNS are uncomment in contentpush.php
4. If you have installed the App with Testflight, make sure that the production url and production certificats for the APNS are uncomment in contentpush.php
5. Open a terminal and send your first push notification with : php contentpush.php

Silent push
If you want to test silent push, add the following key to your notification payload:
'content-available' => 1,

Warning: make sure that in case of silent notifications you don't add an alert to the payload. Otherwise if the App run in the inactive or running in the background, iOS will display the alert even for silent notifications.
