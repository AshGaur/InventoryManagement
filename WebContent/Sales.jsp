<html>
    <head>
    <title>Issue Product</title>
<link rel="stylesheet" type="text/css" href="IssueProduct.css">        
<script src="js/jquery-3.3.1.min.js">
</script>
<script>
$(function() {
      var $id = $('#sID');
      $id.keyup(function(e) {
        if ($id.val().length >= 7) {
          $(this.form).submit();
        }
      });
    });
$(document).ready(function(){
    $("#man").click(function(){
        $("#manual").show();
        $("#man").hide();
        $("#scan").hide();
        $("#sc").show();
    });  
    $("#sc").click(function(){
        $("#scan").show();
        $("#sc").hide();
        $("#manual").hide();
        $("#man").show();
        $("#sID").focus();
    });      
});
</script>
    </head>
<body>
<div id="nav">
    <a class="navbutton" id="home" href="homeOwner.jsp">Home</a>
    <a class="navbutton" id="managest" href="ManageStaff.jsp">Manage Staff</a>
    <div id="dropdown">
    <a id="profile"><img src="profileicon.png" height="31px" width="31px"></a>
    <div id="dropdown-content"><a id="link1" href="signout.jsp">Signout</a></div>
    </div>    
</div> <h1 id="firsthead">View Sales</h1>
<table>
    <tr><th>OrderID</th><th>ProductID1</th><th>ProductID2</th><th>ProductID3</th><th>ProductID4</th><th>Date and Time</th></tr>
    <tr><td>00001</td><td>123</td><td>46</td><td>234</td><td>344</td><td>27-10-2000 12:44</td></tr>
    <tr><td>00002</td><td>123</td><td>46</td><td>234</td><td>344</td><td>27-10-2000 12:44</td></tr>
    <tr><td>00003</td><td>123</td><td>46</td><td>234</td><td>344</td><td>27-10-2000 12:44</td></tr>
    <tr><td>00004</td><td>123</td><td>46</td><td>234</td><td>344</td><td>27-10-2000 12:44</td></tr>
    <tr><td>00005</td><td>123</td><td>46</td><td>234</td><td>344</td><td>27-10-2000 12:44</td></tr>
</table>    
    </body>
</html>
    