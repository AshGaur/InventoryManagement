//Initializes Bill
package sources;
import java.io.*;
import java.sql.*;
import javax.servlet.http.*;

import db.DBInfo;
@SuppressWarnings("serial")
public class InitBill extends HttpServlet{
	public void service(HttpServletRequest req,HttpServletResponse res) throws IOException
	{
		//-------------------Get Organisation Name---------------------------------------
				Cookie[] c=req.getCookies();
				
				boolean foundCookie=false;
		        String id=null;
		        String org=null;
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
		            String query="select * from users where id=?";
		            try
		            {
		                Connection con=DBInfo.con;
		                PreparedStatement ps=con.prepareStatement(query);
		                ps.setString(1,id);
		                ResultSet rs=ps.executeQuery();
		                while(rs.next())
		                {
		                    org=rs.getString(6);
		                    if(rs.getString(7).equals("false"))
		                    {
		                    	res.sendRedirect("signout.jsp");
		                    }
		                    break;
		                }
		                ps.close();
		                rs.close();
		                //con.close();
		            }
		            catch(SQLException e)
		            {
		                System.out.println(e.toString());
		            }
				}
				else
		        {
		            res.sendRedirect("index.jsp");
		        }
				
				//--------------------------------------------------------------------------------
		
		File file=new File(System.getProperty("FILE_PATH")+"bill.txt");
		try
		{
			if(!file.exists())
			{
				file.createNewFile();
			}
			PrintWriter pw=new PrintWriter(file);
			pw.println("PID:");
			pw.println("Pname:");
			pw.println("Qty:");
			pw.println("Price:");
			pw.println("Amount:");
			pw.println("Org:"+org.substring(0,4)+",");
			pw.close();
			System.out.println("File Initials Written");
		}
		catch(IOException e)
		{
			e.printStackTrace();
		}
		try
		{
			Connection con=DBInfo.con;
			String query="delete from "+org.substring(0,4)+"bill";
			PreparedStatement ps=con.prepareStatement(query);
			int n=ps.executeUpdate();
			System.out.println(n+" records deleted from "+org.substring(0,4)+"bill");
			ps.close();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		res.sendRedirect("NewIssue.jsp");
	}
}
