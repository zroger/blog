---
  title: Allow Subdirectories Apache
  category: Deployment
  tags:
    - cakephp
    - htaccess
    - apache
    - quicktip
  layout: post
---

{% highlight apache %}
<IfModule mod_rewrite.c>
    RewriteEngine On

    # Overrides
    RewriteCond %{REQUEST_URI} ^/?(development)/(.*)$
    RewriteRule ^.*$ - [L]

    # Cake rewrites here
    RewriteRule    ^$ app/webroot/    [L]
    RewriteRule    (.*) app/webroot/$1 [L]

</IfModule>
{% endhighlight %}