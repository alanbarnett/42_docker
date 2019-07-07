letsencrypt['enable'] = false
nginx['redirect_http_to_https'] = true
nginx['ssl_certificate'] = "/etc/gitlab/ssl/gitlab.abarnett.com.crt"
nginx['ssl_certificate_key'] = "/etc/gitlab/ssl/gitlab.abarnett.com.key"
external_url "https://gitlab.abarnett.com"
