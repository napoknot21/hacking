# Web

## Phase 1 (Authentification)

Following the text in the web, it's said that 
`"Il pensa coder en front-end, par facilitation"`. 

That means we have to check in the front-end code so in the html code ! We find this in the html code source !
```
<script>
  // Système d'authentification
  function auth() {
    if (
      document.getElementById("username").value === "admin" &&
      document.getElementById("password").value === "h5cf8gf2s5q7d"
    ) {
      window.location.href = "/fable/partie-2-cookie";
    }
  }
</script>
```

So we have the user and passwd credentials !
```
user: admin
psswd: h5cf8gf2s5q7d
```

## Phase 2 (Cookie)

The texts gives us a attack vector: the cookie !

Checking the cooking in the console of the browser, there's only one that is 
```
Name                            value
isAdmin                         false
```

Juste change `false` by `true` and reload the page !


## Phase 3 (Redirect)
