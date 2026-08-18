FROM httpd:2.4

COPY index.html /usr/local/apache2/htdocs/index.html

# Habilita SSL e configura o Apache para HTTPS
RUN sed -i \
    -e 's/^#LoadModule ssl_module/LoadModule ssl_module/' \
    -e 's/^#LoadModule socache_shmcb_module/LoadModule socache_shmcb_module/' \
    -e 's/^#Include conf\/extra\/httpd-ssl.conf/Include conf\/extra\/httpd-ssl.conf/' \
    /usr/local/apache2/conf/httpd.conf

EXPOSE 443

CMD ["httpd-foreground"]