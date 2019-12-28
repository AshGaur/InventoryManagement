<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*,db.*" %>
<%
    String query="delete from present where OrderID IS NOT NULL";
    try
    {
    Connection con=DBInfo.con;
    PreparedStatement ps=con.prepareStatement(query);
    int n=ps.executeUpdate();
    System.out.println(n+"Records deleted from present bill");
    }
    catch(SQLException e)
    {
        System.out.println(e.toString());
    }
    response.sendRedirect("check.jsp");
%>    