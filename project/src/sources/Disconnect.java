package sources;
import java.io.*;
import java.sql.*;
import db.DBInfo;
import javax.servlet.http.*;
@SuppressWarnings("serial")
public class Disconnect extends HttpServlet{
	public void service(HttpServletRequest req,HttpServletResponse res) throws IOException
	{
		String id=req.getParameter("discid");
		String query="update users set State='false' where ID=?";
		try
		{
			Connection con=DBInfo.con;
			PreparedStatement ps=con.prepareStatement(query);
			ps.setString(1, id);
			int n=ps.executeUpdate();
			System.out.println(n+"staff member disconnected");
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		res.sendRedirect("homeOwner.jsp");
	}
}
