<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="db.*" %>
<html>    
<body>
<% 
    String s1=request.getParameter("email");
    String s2=request.getParameter("pass");
    String utype=null;
    int id=0;
    int flag=0;
    String query="select * from users where Email=? and Password=?";
    try
    {
    Connection con=DBInfo.con;
    PreparedStatement ps=con.prepareStatement(query);
    ps.setString(1,s1);
    ps.setString(2,s2);
    ResultSet rs=ps.executeQuery();
        while(rs.next())
        {
            flag=1;
            id=Integer.parseInt(rs.getString(1));
            utype=rs.getString(2);
            break;
        }
    
    
    }
    catch(SQLException e)
    {
        System.out.println(e.toString());
    }
    if(flag==1)
    {
        out.println("<h1>records found in the database</h1>");
        Cookie c1=new Cookie("userid",Integer.toString(id));
        c1.setMaxAge(10*60);
        response.addCookie(c1);
        if(utype.equals("Owner"))
        {
            response.sendRedirect("homeOwner.jsp");
        }
        if(utype.equals("Staff"))
        {
            response.sendRedirect("homeStaff.jsp");
        }
    }
    else
    {
        out.println("<h1>Unauthorised user</h1>");
    }  
%>
    
</body>
</html>