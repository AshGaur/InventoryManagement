<html>
<head>
    <title>Add Products</title>
<link rel="stylesheet" type="text/css" href="css/AddProduct.css">    
</head>
<body>
<div id="nav">
    <a class="navbutton" id="home" href="homeOwner.jsp">Home</a>
    <a class="navbutton" id="managest" href="ManageStaff.jsp">Manage Staff</a>
    <div id="dropdown">
    <a id="profile"><img src="images/profileicon.png" height="31px" width="31px"></a>
    <div id="dropdown-content"><a id="link1" href="signout.jsp">Signout</a></div>
    </div>    
</div> <h1 id="firsthead">Add Product</h1>    
 <form  action="addpro.jsp" method="post">
<table>
<tr>
    <td width="132">    
    <p class="label" id="name">Product Name</p>    </td>
    <td width="308">
    <input type="text" placeholder="Name" name="name" id="nametx" required>    </td>
<tr>
    <td>
        <p class="label" id="email">Product Price</p>    </td>
    <td>    <input type="text" placeholder="Price" name="price" required id="emailtx" required>    </td>
</tr>
<tr>
    <td>
        <p class="label" id="mobile">Manufacturing Date</p>    </td>
    <td>
    <input type="date" placeholder="DD/MM/YYYY" name="mfg" id="phonetx" required>    </td>
<tr>
    <td>
        <p class="label" id="dob">Expiry Date</p>    </td>
    <td>
        <input type="date" placeholder="DD/MM/YYYY" name="expiry" id="dobtx" required>    </td>
</tr>
<tr>
    <td>
        <p class="label" id="doj">Category</p>    </td>
    <td>
        <input type="text" placeholder="Category" name="cat" id="dojtx" required>    </td>
</tr>
<tr>
    <td>
       <p>Organisation</p> 
    </td>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="db.*" %>
<%
   Cookie[] c=request.getCookies();
		boolean foundCookie=false;
        String id=null;
        String org=null;
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
            String query="select * from users where id=?";
            try
            {
                Connection con=DBInfo.con;
                PreparedStatement ps=con.prepareStatement(query);
                ps.setString(1,id);
                ResultSet rs=ps.executeQuery();
                while(rs.next())
                {
                    org=rs.getString(6);
                    break;
                }
            }
            catch(SQLException e)
            {
                System.out.println(e.toString());
            }
        }
        else
        {
            response.sendRedirect("index.jsp");
        }
    out.println("<td>");
    out.println("<input type='text' name='org' value='"+org+"' readonly='readonly'/>"); 
    out.println("</td>");
%>      
    <tr>
    <td>
        <p class="label" id="branch">Quantity</p>    </td>
    <td>
        <input type="text" placeholder="Qty" name="qty" id="branchtx" required>    </td>
</tr>
<tr>
    <td>
        <p class="label" id="pass">Branch</p>    </td>
    <td>
        <input type="text" placeholder="Branch" name="branch" id="passtx" required>    </td>
</tr>    
    </table>
<p id="alert"></p>        
<input name="submit" type="submit" id="submit" value="Submit">
    </form>
    </body>
</html>