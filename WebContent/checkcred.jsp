<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="db.*,java.time.format.DateTimeFormatter,java.time.LocalDateTime" %>
<html>    
<body>
<% 
    String s1=request.getParameter("email");
    String s2=request.getParameter("pass");
    String utype=null,uname=null;
    String org=null;
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
            uname=rs.getString(3);
            org=rs.getString(6);
            break;
        }
    
    ps.close();
    rs.close();
    }
    catch(SQLException e)
    {
        System.out.println(e.toString());
    }
    if(flag==1)
    {
    	Connection con=DBInfo.con;
        System.out.println("records found in the database");
        DateTimeFormatter dtf=DateTimeFormatter.ofPattern("dd/MM/yyyy hh:mm:ss");
    	LocalDateTime now=LocalDateTime.now();
        File file=new File(org+"userlog.txt");
       	try
       	{
       		if(!file.exists())
            {
            	file.createNewFile();
            }
       		PrintWriter pw=new PrintWriter(new FileWriter(file,true));
       		pw.println(uname+":-----Sign In At---->"+dtf.format(now));
       		pw.close();
       	}
       	catch(IOException e)
       	{
       		e.printStackTrace();
       	}
        
        
        
        String query1="update users set state='true' where id=?";
        PreparedStatement ps1=con.prepareStatement(query1);
        ps1.setString(1,Integer.toString(id));
        int n=ps1.executeUpdate();
        System.out.println(n+"records updated with status true");
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