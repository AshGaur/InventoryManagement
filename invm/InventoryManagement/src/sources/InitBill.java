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
		File file=new File("bill.txt");
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
			String query="delete from bill";
			PreparedStatement ps=con.prepareStatement(query);
			int n=ps.executeUpdate();
			System.out.println(n+" records deleted from bill");
			ps.close();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		res.sendRedirect("NewIssue.jsp");
	}
}
