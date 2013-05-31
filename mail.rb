require 'net/smtp'

message = <<EOF
From: SENDER <FROM@gmail.com>
To: RECEIVER <TO@gmail.com>
Subject: SMTP Test E-mail
This is a test message.
EOF

smtp = Net::SMTP.new 'smtp.gmail.com', 587
smtp.enable_starttls
smtp.start('gmail.com', 'alex.stoicajr@gmail.com', '#######', :login)
smtp.send_message message, 'FROM@gmail.com', 'alex.stoicajr@gmail.com'
smtp.finish