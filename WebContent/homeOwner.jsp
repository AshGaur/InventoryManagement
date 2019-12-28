<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*,db.*" %>

<html>
<head>
<title>Owner Home</title>   
    <link rel="stylesheet" type="text/css" href="css/homeOwner.css"> 
<body>
<div id="nav">
    <a class="navbutton" id="home" href="homeOwner.jsp">Home</a>
	<a href="NewIssue.jsp" id="issue">Issue Product</a>
	<a href="ManageProducts.jsp" id="manp">Manage Products</a>
    <a class="navbutton" id="managest" href="ManageStaff.jsp">Manage Staff</a>
    <div id="dropdown">
    <a id="profile"><img src="images/profileicon.png" height="31px" width="31px"></a>
    <div id="dropdown-content"><a id="link1" href="signout.jsp">Signout</a></div>
  </div>    
</div> <h1 id="firsthead">Owner Home</h1>         
<%
        String uname=null,id=null,org=null;
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
                    uname=rs.getString(3);
					org=rs.getString(6);
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
	
	<div id="activest">
	<p id="activehead">Staff Online</p>
	<table width="330">
<!--	<tr bgcolor='#FFFF99'><td width='240' height='40'>Vipul Jain</td><td><button id=onclick=disconnect()>Disconnect</button></td></tr> -->
	<%
	String discid=null;
	try
	{
		Connection con=DBInfo.con;
		String query="SELECT UserName,ID FROM users WHERE UserType='Staff' AND State='true' AND Organisation=?";
	 	PreparedStatement ps=con.prepareStatement(query);
        ps.setString(1,org);
		ResultSet rs=ps.executeQuery();
		int i=1;
		while(rs.next())
		{
			discid=rs.getString(2);
			out.println("<tr bgcolor='#FFFF99'><td width='240' height='40'>"+rs.getString(1)+"</td><td><button id='"+i+"'  onclick='disconnect("+discid+");'>Disconnect</button></td></tr>");	
			i++;
		}
	}
	catch(SQLException e)
	{
		e.printStackTrace();
	}
	
   
   %>
   </table >
   <form id="disconnecting" action="Disconnect">
   <input type="hidden" name="discid">
   </form>
</div>
<script>
function disconnect(valch)
{
	var did=valch;
	document.getElementsByName("discid")[0].value=did;
	document.getElementById("disconnecting").submit();
}
</script>
</body>
</html>    
