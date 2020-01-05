package sources;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import db.DBInfo;
@SuppressWarnings("serial")
public class AddOwner extends HttpServlet{
	public void service(HttpServletRequest req,HttpServletResponse res)throws IOException
	{
		String org=req.getParameter("org");
		String oname=req.getParameter("oname");
		String email=req.getParameter("email");
		String pass=req.getParameter("pass");
		try
		{
			Connection con=DBInfo.con;
			String query="insert into users(UserType,UserName,Email,Password,Organisation) values(?,?,?,?,?)";
			PreparedStatement ps=con.prepareStatement(query);
			ps.setString(1, "Owner");
			ps.setString(2, oname);
			ps.setString(3, email);
			ps.setString(4, pass);
			ps.setString(5, org);
			int n=ps.executeUpdate();
			System.out.println(n+" Owner added");
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		res.sendRedirect("AdminHome.jsp");
	}
}
