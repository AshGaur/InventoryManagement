<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*,db.*" %>
<%
String s[]=request.getParameterValues("check");
int r=s.length;
System.out.println("Number of deletions="+r);   
String query="delete from Products where ProductID=?";   
for(int i=0;i<r;i++)
{
    try
    {
    Connection con=DBInfo.con;
    PreparedStatement ps=con.prepareStatement(query);
    ps.setString(1,s[i]);
    int n=ps.executeUpdate();
    System.out.println(n+"rows for staff account"+i+" updated in the database");
    }
catch(SQLException e)
   {
    System.out.println(e.toString());
   }
}
response.sendRedirect("ManageProducts.jsp");    
%>    