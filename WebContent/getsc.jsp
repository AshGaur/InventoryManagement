<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*,db.*" %>
<%
    String s2=request.getParameter("sID");
    int s1=Integer.parseInt(s2);
    String query="insert into present(ProductName,Price,Qty,Amount) select ProductName,Price,1,Price from products where ProductID=?";
    try
    {
        Connection con=DBInfo.con;
        PreparedStatement ps=con.prepareStatement(query);
        ps.setString(1,Integer.toString(s1));
        int n=ps.executeUpdate();
        System.out.println(n+" records added to the bill");
    }
    catch(SQLException e)
    {
        System.out.println(e.toString());
    }
    response.sendRedirect("check.jsp");
%>   