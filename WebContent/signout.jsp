<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*,db.*" %>
<%@ page import="java.time.format.DateTimeFormatter,java.time.LocalDateTime" %>
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
        String query="update users set state='false' where ID=?";
        String query1="select UserName,Organisation from users where ID=?";
        PreparedStatement ps=con.prepareStatement(query);
        PreparedStatement ps1=con.prepareStatement(query1);
        ps.setString(1,id);
        ps1.setString(1,id);
        int n=ps.executeUpdate();
        ResultSet rs=ps1.executeQuery();
        while(rs.next())
        {
        	uname=rs.getString(1);
        	org=rs.getString(2);
        	break;
        }
        rs.close();
        ps.close();
        ps1.close();
        
     	System.out.println(n+"records updated with status false");
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
       		pw.println(uname+":-----Sign Out At---->"+dtf.format(now));
       		pw.close();
       	}
       	catch(IOException e)
       	{
       		e.printStackTrace();
       	}
       
    }
    catch(SQLException e)
    {
        System.out.println(e.toString());
    }    
  Cookie killMyCookie = new Cookie("userid", null);
  killMyCookie.setMaxAge(0);
  response.addCookie(killMyCookie);
  response.sendRedirect("index.jsp");
}
else
{
    response.sendRedirect("index.jsp");
}
     
%>