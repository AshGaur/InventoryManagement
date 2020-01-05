<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.io.*,java.sql.*,db.DBInfo,java.util.ArrayList" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage Organisations</title>
	<link rel="stylesheet" type="text/css" href="css/ManageOrg.css">
</head>
<body>
<% 
//---------------------------------Cookie Check--------------------------------------
 String id=null;
        Cookie[] c=request.getCookies();
		boolean foundCookie=false;
		if(c!=null)
		{
			for(int i=0; i<c.length; i++)
			{
				Cookie c1= c[i];
				if(c1.getName().equals("adminCookie"))
				{
					foundCookie=true;
                    id=c1.getValue();
				}
			}
		}
		if(foundCookie)
		{   
          out.println("<h1 id='firsthead'> "+id+"</h1>");    
        }
        else
        {
            response.sendRedirect("index.jsp");
        }
//--------------------------------------------------------------------------------------
%>
<div id="nav">
    <a id="home" href="AdminHome.jsp">AdminHome</a>
	<a href="ManageOrg.jsp" id="issue">Manage Organisations</a>
<!-- 	<a href="ManageOwners.jsp" id="manp">Manage Owners</a>	 -->
    <a id="profile"><img src="images/profileicon.png" height="31px" width="31px"></a>
    <div id="dropdown-content"><a id="link2" href="Profile.jsp">Profile</a><a id="link1" href="AdminSignout">Signout</a></div>
</div>    
	<table id="taborg">
	<tr><th>Organisations</th></tr>
<%
	ArrayList<String> ar=new ArrayList<String>();
	try
	{
		Connection con=DBInfo.con;
		String query="select distinct Organisation from users";
		PreparedStatement ps=con.prepareStatement(query);
		ResultSet rs=ps.executeQuery();
		while(rs.next())
		{
			ar.add(rs.getString(1));
			out.println("<tr>");
			out.println("<td>"+rs.getString(1)+"</td>");
			out.println("</tr>");
		}
	}
	catch(SQLException e)
	{
		e.printStackTrace();	
	}

%>
</table>
<div id="delorg">
	<h3 id="delhead">Delete Organisation</h3>
	<p style="color:red;" id="delalt"></p>
	<form onSubmit="return checkDel();" action="DelOrg">
	<select id="delname" name="org">
	<option value="Select">Select</option>
	<%
	for(int i=0;i<ar.size();i++)
	{
		out.println("<option value='"+ar.get(i)+"'>"+ar.get(i)+"</option>");
	}
	%>
	</select>
	<input type="submit" value="Delete Org" id="delsub"/>
	</form>
</div>
<div id="addorgdiv">
	<h2 id="headcrown">Add Organisation</h2>
		<p style="color:red;" id="addalt"></p>
		<form onSubmit="return validateForm();" action="AddOrg">
			<input type="text" id="org" name="org" placeholder="Organisation Name" required />
			<input type="text" id="oname" name="oname" placeholder="Owner Name" required/>
			<input type="email" id="eml" name="email" placeholder="Email" required />
			<input type="password" id="pass" name="pass" placeholder="Create Password" maxlength="20" required />
			<input type="password" id="cnfpass" placeholder="Confirm Password" maxlength="20" required />
			<input type="submit" value="Add Organisation" id="sub"/>
		</form>
</div>
<script>
function checkDel()
{
	if(document.getElementById("delname").value.localeCompare('Select')==0){
		document.getElementById("delalt").innerHTML="Select an Organisation to Delete";
		return false;
	}	
}
function validateForm()
{
	if(document.getElementById("pass").value!=document.getElementById("cnfpass").value)
	{
		document.getElementById("addalt").innerHTML="Passwords don't match";
		return false;
	}	
}
</script>
</body>
</html>