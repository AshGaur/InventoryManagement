<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/forgotpass.css">
</head>    
 <body>
  <div id="area">
    <h1 id="fphead">Enter email to recover password</h1>
    <form action="email.jsp" name="myForm" onsubmit="return validateForm()"> 
    <input type="email" id="em" placeholder="Email" name="email">
        <p id="emalert"></p>
    <input type="submit" value="Recover Password" id="sub">
    </form>
  </div>
     <script>
         function validateForm()
         {
             var x=document.forms["myForm"]["email"].value;
             if(x.length==0)
             {
                 document.getElementById("emalert").innerHTML="Email must be entered";
                 document.getElementById("em").focus();
                 return false;
             }
             else if(x.length>0) 
             {
                 return true;
             }
         }
     </script>     
 </body>
</html>