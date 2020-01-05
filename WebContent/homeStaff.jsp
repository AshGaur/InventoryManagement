<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*,db.*" %>

<html>
<head>
<title>Staff Home</title>   
    <link rel="stylesheet" type="text/css" href="css/homeOwner.css"> 
<body>
<div id="nav">
    <a class="navbutton" id="home" href="homeOwner.jsp">Home</a>
	 <a id="manage" href="ManageProducts.jsp">Manage Products</a>
    <a id="issue" href="NewIssue.jsp">Issue Product</a>
	<a class="navbutton" id="viewinv" href="ViewInvoices.jsp">View Invoices</a>
    <a id="profile" ><img src="images/profileicon.png" height="31px" width="31px"></a>
    <div id="dropdown-content"><a id="link2" href="Profile.jsp">Profile</a><a id="link1" href="signout.jsp">Signout</a></div>
  
</div>
<h1 id="firsthead">Staff Home</h1>   
   
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
<div id="qtycheck" style="overflow:scroll;">
 <p id="qtycheckhead">Products with Qty less than 10</p>
 <table id="qtytable">
 
<%
	try
	{
		Connection con=DBInfo.con;
		String query="select ProductID,ProductName,Qty from products where Organisation=? and Qty<=? order by Qty";
		PreparedStatement ps=con.prepareStatement(query);
		ps.setString(1,org);
		ps.setString(2,"5");
		ResultSet rs=ps.executeQuery();
		ResultSetMetaData rsmd=rs.getMetaData();
		int colcount=rsmd.getColumnCount();
		out.println("<tr id='headlist'>");
		for(int i=1;i<=colcount;i++)
		{
			out.println("<th>"+rsmd.getColumnName(i)+"</th>");
		}
		out.println("</th>");
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
<div id="expirepros">
	<p id="exphead">Products going to Expire this month / Already Expired</p>
    <table  id="exptable">
      
      <%
		try
		{
			Connection con=DBInfo.con;
			String query="SELECT ProductID,ProductName,Qty,DATE_FORMAT(Expiry, '%d %M %Y') FROM products WHERE Organisation=? AND MONTH(Expiry)<=MONTH(SYSDATE()) AND YEAR(Expiry)<=YEAR(SYSDATE()) order by Expiry";
			PreparedStatement ps=con.prepareStatement(query);
			ps.setString(1,org);
			ResultSet rs=ps.executeQuery();
			out.println("<tr><th>ProductID</th><th>ProductName</th><th>Qty</th><th>Expiry Date</th></tr>");
			while(rs.next())
			{
				out.println("<tr>");
					out.println("<td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td>"+rs.getString(3)+"</td><td>"+rs.getString(4)+"</td>");
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
