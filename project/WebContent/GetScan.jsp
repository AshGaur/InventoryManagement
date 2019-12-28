<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*,db.*" %>
<%
    String s2=request.getParameter("sID");
    int s1=Integer.parseInt(s2);
   	
    response.sendRedirect("IssueProduct.jsp");                             
%>    
   