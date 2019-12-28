<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*,db.*" %>
<%
    String s1=request.getParameter("pid");
    String s2=request.getParameter("qty");
    String query="select * from products where ProductID=?";
    String pname,price;
    int i=0;
    try
    {
        Connection con=DBInfo.con;
        PreparedStatement ps=con.prepareStatement(query);
        ps.setString(1,s1);
        ResultSet rs=ps.executeQuery();
        while(rs.next())
        {
        	pname=rs.getString("ProductName");
        	price=rs.getString("Price");
        }
    }
    catch(SQLException e)
    {
        System.out.println(e.toString());
    }
    response.sendRedirect("check.jsp");
%>   