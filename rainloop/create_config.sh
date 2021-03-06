DIR=`ls /var/www/data/_data_* -d`
for i in $(cat /dockermail-config/domains);
 do echo "\
imap_host = \"$i\" 
imap_port = 143
imap_secure = \"TLS\"
smtp_host = \"$i\"
smtp_port = 587
smtp_secure = \"TLS\"
smtp_auth = On" > $DIR/_default_/domains/$i.ini;
 chown -R www-data:www-data $DIR/_default_/domains/$i.ini;
 cp $DIR/_default_domains/$.ini;
done;
cp -r /var/www/data /var/www/html
