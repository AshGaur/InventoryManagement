<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,db.DBInfo" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/Profile.css"> 
<title>Profile</title>
</head>
<body bgcolor="#FFFFFF">
<div id="nav">
   <a onclick="sendHome();" id="home" onmouseover="document.getElementById('home').style.cursor='pointer'">Home</a>
	<a href="NewIssue.jsp" id="issue">Issue Product</a>
	<a href="ManageProducts.jsp" id="manp">Manage Products</a><a id="profile"><img src="images/profileicon.png" height="31px" width="31px"></a>
    <div id="dropdown-content"><a id="link2">Profile</a><a id="link1" href="signout.jsp">Signout</a></div>
  
</div>    
 <h1 id="firsthead">Profile</h1>
<%
        String uname=null,id=null,org=null,pass=null,em=null,utype=null;
        Cookie[] c=request.getCookies();
		boolean foundCookie=false;
		if(c!=null)
		{
			for(int i=0; i<c.length; i++)
			{
				Cookie c1= c[i];
				if(c1.getName().equals("userid"))
				{
					foundCookie=true;
                    id=c1.getValue();
				}
			}
		}
		if(foundCookie)
		{
			
            try
            {
                Connection con=DBInfo.con;
                String query="select * from users where ID=?";
                PreparedStatement ps=con.prepareStatement(query);
                ps.setString(1,id);
                ResultSet rs=ps.executeQuery();
                while(rs.next())
                {
					utype=rs.getString(2);
					uname=rs.getString(3);
					em=rs.getString(4);
                    pass=rs.getString(5);
					org=rs.getString(6);
					if(rs.getString(7).equals("false"))
                    {
                    	response.sendRedirect("signout.jsp");
                    }
                    break;
                }
               
            }
            catch(SQLException e)
            {
                System.out.println(e.toString());
            }
          out.println("<h2>Welcome "+uname+"</h2>");    
        }
        else
        {
            response.sendRedirect("index.jsp");
        }
%> 
<div id="maindiv">
	<table id="tablefir">
  <%
  	out.println("<tr><th>Name:</th><td>"+uname+"</td></tr>");
  	out.println("<tr><th>Organisation:</th><td>"+org+"</td></tr>");
	out.println("<tr><th>Email:</th><td>"+em+"</td></tr>");
	out.println("<tr><th>UserType:</th><td>"+utype+"</td></tr>");
	out.println("<tr><th>UserID:</th><td>"+id+"</td></tr>");
	out.println("</table>");
	out.println("<table id='tablesec'>");
	out.println("<form name='myForm' onSubmit='return myFunc();' action='ChangePass' method='post'>");
	out.println("<tr><td><input type='hidden' name='id' value='"+id+"'></td></tr>");
	out.println("<tr><td><p id='fir' style='color:red'></p></td></tr>");
	out.println("<tr><td><input type='password' name='oldpass' placeholder='Current Password' required autocomplete='new-password'></td></tr>");
	out.println("<tr><td><input type='password' name='newpass' placeholder='New Password' maxlength='20' required></td></tr>");
	out.println("<tr><td><input type='password' name='cnfpass' placeholder='Confirm Password' required></td></tr>");
	out.println("<tr><td><input type='submit' value='Change Password'></td></tr>");
	out.println("</form>");
  %>
  </table>
<script>
function sendHome()
{
	<% out.println("var ut='"+utype+"';"); %>
		
		if(ut.localeCompare("Staff")==0)
		{
			window.location.href = "homeStaff.jsp";
		}
		else
		{
			window.location.href = "homeOwner.jsp";
		}
	
}

	function myFunc(){
		if(document.forms['myForm']['newpass'].value!=document.forms['myForm']['cnfpass'].value){
			document.getElementById("fir").innerHTML="Bad Creds";
		return false;
		}
	<%
	out.println("if(document.forms['myForm']['newpass'].value!="+pass+"){");
	out.println("document.getElementById('fir').innerHTML='Bad Creds';");
	%>
		return false;
		}
	document.getElementById("fir").innerHTML="Password Changed";
	}
</script>
</div>
</body>
</html>