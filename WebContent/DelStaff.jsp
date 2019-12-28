<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*,db.*" %>
<%
String s[]=request.getParameterValues("check");
int r=s.length;
System.out.println("Number of deletions="+r);   
String query="delete from staff where id=?";
String query1="delete from users where ID=?";   
Connection con=DBInfo.con;
for(int i=0;i<r;i++)
{
    try
    {
    //delte entry from staff	
    PreparedStatement ps=con.prepareStatement(query);
    ps.setString(1,s[i]);
    int n=ps.executeUpdate();
    System.out.println(n+"rows for staff account"+i+" deleted from staff");
    
    //delete entry from users
    PreparedStatement ps1=con.prepareStatement(query1);
    ps1.setString(1,s[i]);
    int n1=ps1.executeUpdate();
    System.out.println(n1+"rows for staff account"+i+" deleted from users");		
    }
	catch(SQLException e)
   	{
   	 System.out.println(e.toString());
   	}
}

response.sendRedirect("ManageStaff.jsp");    
%>    