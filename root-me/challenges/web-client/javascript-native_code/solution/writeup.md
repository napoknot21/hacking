# JavaScript Native Code

CREDENTIALS:
  passwd: toto123lol

CHECK the source code, then in the <script> balise, we find this message:
```
É=-~-~[],ó=-~É,Ë=É<<É,þ=Ë+~[];Ì=(ó-ó)[Û=(''+{})[É+ó]+(''+{})[ó-É]+([].ó+'')[ó-É]+(!!''+'')[ó]+({}+'')[ó+ó]+(!''+'')[ó-É]+(!''+'')[É]+(''+{})[É+ó]+({}+'')[ó+ó]+(''+{})[ó-É]+(!''+'')[ó-É]][Û];Ì(Ì((!''+'')[ó-É]+(!''+'')[ó]+(!''+'')[ó-ó]+(!''+'')[É]+((!''+''))[ó-É]+([].$+'')[ó-É]+'\''+''+'\\'+(ó-É)+(É+É)+(ó-É)+'\\'+(þ)+(É+ó)+'\\'+(ó-É)+(ó+ó)+(ó-ó)+'\\'+(ó-É)+(ó+ó)+(É)+'\\'+(ó-É)+(É+ó)+(þ)+'\\'+(ó-É)+(É+ó)+(É+ó)+'\\'+(ó-É)+(ó+ó)+(ó-ó)+'\\'+(ó-É)+(ó+ó)+(É+É)+'\\'+(É+ó)+(ó-ó)+'\\'+(É+É)+(þ)+'\\'+(ó-É)+(ó-ó)+(É+ó)+'\\'+(ó-É)+(É+ó)+(ó+ó)+'\\'+(ó-É)+(ó+ó)+(É+É)+'\\'+(ó-É)+(ó+ó)+(É)+'\\'+(ó-É)+(É+É)+(É+ó)+'\\'+(ó-É)+(þ)+(É)+'\\'+(É+É)+(ó-ó)+'\\'+(ó-É)+(É+ó)+(É+É)+'\\'+(ó-É)+(É+É)+(É+ó)+'\\'+(É+É)+(ó-ó)+'\\'+(ó-É)+(É+ó)+(É+ó)+'\\'+(ó-É)+(É+ó)+(þ)+'\\'+(ó-É)+(ó+ó)+(É+É)+'\\'+(É+É)+(ó-ó)+'\\'+(ó-É)+(É+É)+(É+É)+'\\'+(ó-É)+(É+É)+(É+ó)+'\\'+(É+É)+(ó-ó)+'\\'+(ó-É)+(ó+ó)+(ó-ó)+'\\'+(ó-É)+(É+É)+(ó-É)+'\\'+(ó-É)+(ó+ó)+(ó)+'\\'+(ó-É)+(ó+ó)+(ó)+'\\'+(ó-É)+(É+É)+(É+ó)+'\\'+(É+É)+(þ)+'\\'+(É+ó)+(ó-É)+'\\'+(þ)+(ó)+'\\'+(ó-É)+(É+ó)+(ó-É)+'\\'+(ó-É)+(É+É)+(ó+ó)+'\\'+(É+ó)+(ó-ó)+'\\'+(ó-É)+(É+É)+(ó-É)+'\\'+(þ)+(É+ó)+'\\'+(þ)+(É+ó)+'\\'+(É+É)+(þ)+'\\'+(ó-É)+(ó+ó)+(É+É)+'\\'+(ó-É)+(É+ó)+(þ)+'\\'+(ó-É)+(ó+ó)+(É+É)+'\\'+(ó-É)+(É+ó)+(þ)+'\\'+(ó+ó)+(ó-É)+'\\'+(ó+ó)+(É)+'\\'+(ó+ó)+(ó)+'\\'+(ó-É)+(É+ó)+(É+É)+'\\'+(ó-É)+(É+ó)+(þ)+'\\'+(ó-É)+(É+ó)+(É+É)+'\\'+(É+É)+(þ)+'\\'+(É+ó)+(ó-É)+'\\'+(ó-É)+(þ)+(ó)+'\\'+(ó-É)+(É+É)+(ó-É)+'\\'+(ó-É)+(É+ó)+(É+É)+'\\'+(ó-É)+(É+É)+(É+ó)+'\\'+(ó-É)+(ó+ó)+(É)+'\\'+(ó-É)+(ó+ó)+(É+É)+'\\'+(É+ó)+(ó-ó)+'\\'+(É+É)+(þ)+'\\'+(ó-É)+(É+É)+(É)+'\\'+(ó-É)+(ó+ó)+(É)+'\\'+(ó-É)+(É+É)+(ó-É)+'\\'+(ó-É)+(ó+ó)+(ó+ó)+'\\'+(ó-É)+(É+ó)+(þ)+'\\'+(É+É)+(þ)+'\\'+(É+ó)+(ó-É)+'\\'+(þ)+(ó)+'\\'+(ó-É)+(þ)+(É+ó)+'\\'+(ó-É)+(É+É)+(É+ó)+'\\'+(ó-É)+(É+ó)+(É+É)+'\\'+(ó-É)+(ó+ó)+(ó)+'\\'+(ó-É)+(É+É)+(É+ó)+'\\'+(ó-É)+(þ)+(ó)+'\\'+(ó-É)+(É+É)+(ó-É)+'\\'+(ó-É)+(É+ó)+(É+É)+'\\'+(ó-É)+(É+É)+(É+ó)+'\\'+(ó-É)+(ó+ó)+(É)+'\\'+(ó-É)+(ó+ó)+(É+É)+'\\'+(É+ó)+(ó-ó)+'\\'+(É+É)+(þ)+'\\'+(ó-É)+(É+É)+(ó+ó)+'\\'+(ó-É)+(É+É)+(ó-É)+'\\'+(ó-É)+(É+ó)+(ó-É)+'\\'+(ó-É)+(É+ó)+(É+É)+'\\'+(É+ó)+(ó+ó)+'\\'+(É+ó)+(ó+ó)+'\\'+(É+ó)+(ó+ó)+'\\'+(É+É)+(þ)+'\\'+(É+ó)+(ó-É)+'\\'+(þ)+(ó)+'\\'+(ó-É)+(þ)+(É+ó)+'\'')())()

```

THEN, we need to obfuscate this code ! (whit an online tool or whatever)

SO, we have this result :
```
eval(function(p,a,c,k,e,d){e=function(c){return(c<a?"":e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)d[e(c)]=k[c]||e(c);k=[function(e){return d[e]}];e=function(){return'\\w+'};c=1;};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p;}('0=-~-~[],1=-~0,4=0<<0,2=4+~[];3=(1-1)[5=(\'\'+{})[0+1]+(\'\'+{})[1-0]+([].1+\'\')[1-0]+(!!\'\'+\'\')[1]+({}+\'\')[1+1]+(!\'\'+\'\')[1-0]+(!\'\'+\'\')[0]+(\'\'+{})[0+1]+({}+\'\')[1+1]+(\'\'+{})[1-0]+(!\'\'+\'\')[1-0]][5];3(3((!\'\'+\'\')[1-0]+(!\'\'+\'\')[1]+(!\'\'+\'\')[1-1]+(!\'\'+\'\')[0]+((!\'\'+\'\'))[1-0]+([].$+\'\')[1-0]+\'\\\'\'+\'\'+\'\\\\\'+(1-0)+(0+0)+(1-0)+\'\\\\\'+(2)+(0+1)+\'\\\\\'+(1-0)+(1+1)+(1-1)+\'\\\\\'+(1-0)+(1+1)+(0)+\'\\\\\'+(1-0)+(0+1)+(2)+\'\\\\\'+(1-0)+(0+1)+(0+1)+\'\\\\\'+(1-0)+(1+1)+(1-1)+\'\\\\\'+(1-0)+(1+1)+(0+0)+\'\\\\\'+(0+1)+(1-1)+\'\\\\\'+(0+0)+(2)+\'\\\\\'+(1-0)+(1-1)+(0+1)+\'\\\\\'+(1-0)+(0+1)+(1+1)+\'\\\\\'+(1-0)+(1+1)+(0+0)+\'\\\\\'+(1-0)+(1+1)+(0)+\'\\\\\'+(1-0)+(0+0)+(0+1)+\'\\\\\'+(1-0)+(2)+(0)+\'\\\\\'+(0+0)+(1-1)+\'\\\\\'+(1-0)+(0+1)+(0+0)+\'\\\\\'+(1-0)+(0+0)+(0+1)+\'\\\\\'+(0+0)+(1-1)+\'\\\\\'+(1-0)+(0+1)+(0+1)+\'\\\\\'+(1-0)+(0+1)+(2)+\'\\\\\'+(1-0)+(1+1)+(0+0)+\'\\\\\'+(0+0)+(1-1)+\'\\\\\'+(1-0)+(0+0)+(0+0)+\'\\\\\'+(1-0)+(0+0)+(0+1)+\'\\\\\'+(0+0)+(1-1)+\'\\\\\'+(1-0)+(1+1)+(1-1)+\'\\\\\'+(1-0)+(0+0)+(1-0)+\'\\\\\'+(1-0)+(1+1)+(1)+\'\\\\\'+(1-0)+(1+1)+(1)+\'\\\\\'+(1-0)+(0+0)+(0+1)+\'\\\\\'+(0+0)+(2)+\'\\\\\'+(0+1)+(1-0)+\'\\\\\'+(2)+(1)+\'\\\\\'+(1-0)+(0+1)+(1-0)+\'\\\\\'+(1-0)+(0+0)+(1+1)+\'\\\\\'+(0+1)+(1-1)+\'\\\\\'+(1-0)+(0+0)+(1-0)+\'\\\\\'+(2)+(0+1)+\'\\\\\'+(2)+(0+1)+\'\\\\\'+(0+0)+(2)+\'\\\\\'+(1-0)+(1+1)+(0+0)+\'\\\\\'+(1-0)+(0+1)+(2)+\'\\\\\'+(1-0)+(1+1)+(0+0)+\'\\\\\'+(1-0)+(0+1)+(2)+\'\\\\\'+(1+1)+(1-0)+\'\\\\\'+(1+1)+(0)+\'\\\\\'+(1+1)+(1)+\'\\\\\'+(1-0)+(0+1)+(0+0)+\'\\\\\'+(1-0)+(0+1)+(2)+\'\\\\\'+(1-0)+(0+1)+(0+0)+\'\\\\\'+(0+0)+(2)+\'\\\\\'+(0+1)+(1-0)+\'\\\\\'+(1-0)+(2)+(1)+\'\\\\\'+(1-0)+(0+0)+(1-0)+\'\\\\\'+(1-0)+(0+1)+(0+0)+\'\\\\\'+(1-0)+(0+0)+(0+1)+\'\\\\\'+(1-0)+(1+1)+(0)+\'\\\\\'+(1-0)+(1+1)+(0+0)+\'\\\\\'+(0+1)+(1-1)+\'\\\\\'+(0+0)+(2)+\'\\\\\'+(1-0)+(0+0)+(0)+\'\\\\\'+(1-0)+(1+1)+(0)+\'\\\\\'+(1-0)+(0+0)+(1-0)+\'\\\\\'+(1-0)+(1+1)+(1+1)+\'\\\\\'+(1-0)+(0+1)+(2)+\'\\\\\'+(0+0)+(2)+\'\\\\\'+(0+1)+(1-0)+\'\\\\\'+(2)+(1)+\'\\\\\'+(1-0)+(2)+(0+1)+\'\\\\\'+(1-0)+(0+0)+(0+1)+\'\\\\\'+(1-0)+(0+1)+(0+0)+\'\\\\\'+(1-0)+(1+1)+(1)+\'\\\\\'+(1-0)+(0+0)+(0+1)+\'\\\\\'+(1-0)+(2)+(1)+\'\\\\\'+(1-0)+(0+0)+(1-0)+\'\\\\\'+(1-0)+(0+1)+(0+0)+\'\\\\\'+(1-0)+(0+0)+(0+1)+\'\\\\\'+(1-0)+(1+1)+(0)+\'\\\\\'+(1-0)+(1+1)+(0+0)+\'\\\\\'+(0+1)+(1-1)+\'\\\\\'+(0+0)+(2)+\'\\\\\'+(1-0)+(0+0)+(1+1)+\'\\\\\'+(1-0)+(0+0)+(1-0)+\'\\\\\'+(1-0)+(0+1)+(1-0)+\'\\\\\'+(1-0)+(0+1)+(0+0)+\'\\\\\'+(0+1)+(1+1)+\'\\\\\'+(0+1)+(1+1)+\'\\\\\'+(0+1)+(1+1)+\'\\\\\'+(0+0)+(2)+\'\\\\\'+(0+1)+(1-0)+\'\\\\\'+(2)+(1)+\'\\\\\'+(1-0)+(2)+(0+1)+\'\\\'\')())()',6,6,'É|ó|þ|Ì|Ë|Û'.split('|'),0,{}))

```

THEN, we enter this result to an a js in my case it's called script.js

FINALLY, we execute the code by
```
node script.js
```

We have this ouput:
```
undefined:3
a=prompt('Entrez le mot de passe');if(a=='toto123lol'){alert('bravo');}else{alert('fail...');}
^
[more errors...]
```

SO, we see the credentials in the output !
