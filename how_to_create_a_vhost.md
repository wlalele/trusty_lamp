# How to create a apache2 vhost

1. Create apache2 vhost config
---------------------------
```
sudo vim /etc/apache2/sites-available/example.conf
```
2. Declare the vhost
-----------------
```
<VirtualHost *:80>
    ServerName example.local
    ServerAlias www.example.local

    DocumentRoot /var/www/html/developer/example/web

    <Directory /var/www/html/developer/example/web>
        Options -Indexes +FollowSymLinks +MultiViews
        AllowOverride All
        Require all granted
    </Directory>

    <FilesMatch \.php$>
        # 2.4.10+ can proxy to unix socket
        # SetHandler "proxy:unix:/var/run/php5-fpm.sock|fcgi://localhost/"

        # Else we can just use a tcp socket:
        SetHandler "proxy:fcgi://127.0.0.1:9000"
    </FilesMatch>

    # Possible values include: debug, info, notice, warn, error, crit,
    # alert, emerg.
    LogLevel warn

    ErrorLog ${APACHE_LOG_DIR}/example-error.log
    CustomLog ${APACHE_LOG_DIR}/example-access.log combined
</VirtualHost>
```
3. Enable the vhost
-------------------
```
sudo a2ensite example
```
4. Reload apache service
------------------------
```
sudo service apache2 reload
```
