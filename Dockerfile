FROM httpd:alpine3.18

RUN apk add --no-cache apache2 apache2-utils apache2-webdav mod_dav_svn apache2-ssl \
  && apk add --no-cache subversion \
  && mkdir -pv /srv/svn/conf.d && mkdir -v /srv/svn/repos \
  && touch /srv/svn/conf.d/passwd

RUN echo -e "\
[groups] \n\
\n\
[/]\n\
* = r\n\
" > /srv/svn/conf.d/authz
   
RUN chown -Rc apache:apache /srv/svn/ \
  && chmod u+s -R /srv/svn/

COPY svn.conf /etc/apache2/conf.d/svn.conf

WORKDIR /srv/svn/repos
CMD ["/usr/sbin/httpd", "-f", "/etc/apache2/httpd.conf", "-DFOREGROUND"]
EXPOSE 80 

