<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*,db.*" %>

<html>
<head>
<title>Owner Home</title>   
    <link rel="stylesheet" type="text/css" href="css/homeOwner.css"> 
<body>
<div id="nav">
    <a class="navbutton" id="home" href="homeOwner.jsp">Home</a>
    <a class="navbutton" id="managest" href="ManageStaff.jsp">Manage Staff</a>
    <div id="dropdown">
    <a id="profile"><img src="images/profileicon.png" height="31px" width="31px"></a>
    <div id="dropdown-content"><a id="link1" href="signout.jsp">Signout</a></div>
    </div>    
</div> <h1 id="firsthead">Owner Home</h1>         
<%
        String uname=null,id=null;
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
    <center>
    <div id="links">
    <h2>Important Links</h2><br> 
    <a id="manage" href="ManageProducts.jsp">Manage Products</a>
    <a id="addp" href="AddProduct.jsp">Add Product</a>
    <a id="issue" href="InitBill">Issue Product</a>
    <a  id="adds" href="AddStaff.jsp">Add Staff</a>
   </div>
    </center>    
    </body>
</html>    
