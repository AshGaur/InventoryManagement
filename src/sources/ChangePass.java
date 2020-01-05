package sources;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import db.DBInfo;
@SuppressWarnings("serial")
public class ChangePass extends HttpServlet{
	public void service(HttpServletRequest req,HttpServletResponse res) throws IOException
	{
		String id=req.getParameter("id");
		String pass=req.getParameter("newpass");
		try
		{
			Connection con=DBInfo.con;
			String query="update users set Password=? where ID=?";
			PreparedStatement ps=con.prepareStatement(query);
			ps.setString(1,pass);
			ps.setString(2,id);
			int n=ps.executeUpdate();
			System.out.println("Password changed in "+n+" rows");
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		res.sendRedirect("Profile.jsp");
	}
}
