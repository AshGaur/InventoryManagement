<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*,db.*" %>
<%
 String s1=request.getParameter("name");
 String s2=request.getParameter("price");
 String s3=request.getParameter("mfg");
 String s4=request.getParameter("expiry"); 
 String s5=request.getParameter("cat");  
 String s6=request.getParameter("qty");
 String s7=request.getParameter("org"); 
 String s8=request.getParameter("branch");  
 
 String query="insert into Products(ProductName,Price,Mfg,Expiry,Category,Qty,Organisation,Branch) values(?,?,?,?,?,?,?,?)";
 try
 {
 Connection con=DBInfo.con;
 PreparedStatement ps=con.prepareStatement(query);
 ps.setString(1,s1);
 ps.setString(2,s2);
 ps.setString(3,s3);
 ps.setString(4,s4); 
 ps.setString(5,s5);
 ps.setString(6,s6);
 ps.setString(7,s7);
 ps.setString(8,s8);  
 int n=ps.executeUpdate();
 System.out.println(n+" Records added to the database");
 }
catch(SQLException e)
 {
    System.out.println(e.toString());
 }
 response.sendRedirect("ManageProducts.jsp");  
%>   
   
   