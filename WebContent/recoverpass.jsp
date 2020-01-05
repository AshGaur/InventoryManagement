<%@page import="java.sql.*,db.DBInfo,java.io.*"%>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/recoverpass.css">
</head>     
  <body>
  <%
  String eml=request.getParameter("eml");
  String id=null;
  try
  {
	  Connection con=DBInfo.con;
	  String query="select ID from users where Email=?";
	  PreparedStatement ps=con.prepareStatement(query);
	  ps.setString(1,eml);
	  ResultSet rs=ps.executeQuery();
	  while(rs.next())
	  {
		  id=rs.getString(1);
		  break;
	  }
  }
  catch(SQLException e)
  {
	  e.printStackTrace();
  }
  %>
    <div id="box">
    <h1>Recover your Password</h1>  
    <p id='fir' style='color:red'></p>  
     <form name="myForm" onSubmit="return myFunc();" action="ChangePass" method="post">
     <% 
     	out.println("<input type='hidden' name='id' value='"+id+"'>");
     %>   
     	<input type="password" name="newpass" id="newpass" placeholder="New Password" required/>
        <input type="password" name="cnfpass" id="cnfpass" placeholder="Confirm Password" required>
        <input type="submit" value="Reset Password" id="sub"/>
    </form>
  </div>  
 <script>

	function myFunc(){
		if(document.forms['myForm']['newpass'].value!=document.forms['myForm']['cnfpass'].value){
			document.getElementById("fir").innerHTML="Bad Credentials";
		return false;
		}
	
	document.getElementById("fir").innerHTML="Password Changed";
	}
</script>  

   