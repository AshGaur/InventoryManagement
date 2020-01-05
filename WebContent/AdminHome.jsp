<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.io.*,java.sql.*,db.DBInfo"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin</title>
	<link rel="stylesheet" type="text/css" href="css/admin.css"> 
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
	<div id="crtown">
	<h2 id="headcrown">Create Owner</h2>
		<form>
			<select id="org" name="org">
			<option value="Select">Select</option>
			<%
				try
				{
					Connection con=DBInfo.con;
					String query="SELECT DISTINCT Organisation FROM users";
					PreparedStatement ps=con.prepareStatement(query);
					ResultSet rs=ps.executeQuery();
					while(rs.next())
					{
						out.println("<option value='"+rs.getString(1)+"'>"+rs.getString(1)+"</option>");
					}
				}
				catch(SQLException e)
				{
					e.printStackTrace();	
				}
			
			%>	
			</select>
			<input type="text" id="oname" name="oname" placeholder="Owner Name" required/>
			<input type="email" id="eml" name="email" placeholder="Email" required />
			<input type="password" id="pass" name="pass" placeholder="Create Password" required />
			<input type="password" id="cnfpass" placeholder="Confirm Password" required />
			<input type="submit" value="Create Owner" id="sub"/>
		</form>
	</div>	
	<table id="showtab">	
	<tr><th width="159">UserName</th>
	<th width="149">Email</th>
	<th width="168">Organisation</th>
	</tr>
	<%
		try
		{
			Connection con=DBInfo.con;
			String query="select UserName,Email,Organisation from users where UserType='Owner'";
			PreparedStatement ps=con.prepareStatement(query);
			ResultSet rs=ps.executeQuery();
			while(rs.next())
			{
				out.println("<tr>");
				out.println("<td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td>"+rs.getString(3)+"</td>");
				out.println("</tr>");
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();	
		}
	%>
	</table>	
</div>
	
</body>
</html>