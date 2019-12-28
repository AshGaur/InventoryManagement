package sources;
import java.util.Scanner;
import java.io.*;
import javax.servlet.http.*;
import db.DBInfo;
import java.sql.*;
@SuppressWarnings("serial")
public class ReadUserLog extends HttpServlet{
	public void service(HttpServletRequest req,HttpServletResponse res)throws IOException
	{
		//Get Organisation from cookie
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
                String query="select Organisation from users where ID=?";
                PreparedStatement ps=con.prepareStatement(query);
                ps.setString(1,id);
                ResultSet rs=ps.executeQuery();
                while(rs.next())
                {
					org=rs.getString(1);
                    break;
                }
               
            }
            catch(SQLException e)
            {
                System.out.println(e.toString());
            }
		}
		//ReadFile for respective organisation
		System.out.println("----------------------------------------------------------------");
		File file=new File(org+"userlog.txt");
		try
		{
			if(!file.exists())
			{
				file.createNewFile();
			}
			Scanner sc=new Scanner(file);
			while(sc.hasNextLine())
			{
				System.out.println(sc.nextLine());
			}
			sc.close();
		}
		catch(IOException e)
		{
			e.printStackTrace();
		}
		System.out.println("------------------------------------------------------------------");
	}
}
