package sources;
import java.io.*;
import javax.servlet.http.*;
import java.sql.*;
import db.DBInfo;
@SuppressWarnings("serial")
public class ClearUserLogs extends HttpServlet{
	public void service(HttpServletRequest req,HttpServletResponse res)throws IOException
	{
		PrintWriter pw=res.getWriter();
		String id=null,org=null;
        Cookie[] c=req.getCookies();
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
                String query="select * from users where ID=?";
                PreparedStatement ps=con.prepareStatement(query);
                ps.setString(1,id);
                ResultSet rs=ps.executeQuery();
                while(rs.next())
                {
					org=rs.getString(6);
                    break;
                }
               
            }
            catch(SQLException e)
            {
                System.out.println(e.toString());
            }
            try
    		{
            	File file=new File(System.getProperty("FILE_PATH")+org+"userlog.txt");
    			if(file.exists()==false)
    			{
    				pw.println("<h1>No logs available</h1>");
    			}
    			else
    			{	
	    			PrintWriter p=new PrintWriter(file);
	    			p.println("");
	    			p.close();
	    			pw.println("<h1>User Logs Cleared for Organisation: "+org+"</h1>");  
    			}
    		}
            catch(IOException e)
            {
            	e.printStackTrace();
            }  
        }
        else
        {
        	pw.println("<h1>No cookie found Please Login</h1>");
        }
	}
}
