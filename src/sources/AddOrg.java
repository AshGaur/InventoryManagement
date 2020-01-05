package sources;
import javax.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import db.DBInfo;
@SuppressWarnings("serial")
public class AddOrg extends HttpServlet{
	public void service(HttpServletRequest req,HttpServletResponse res)throws IOException
	{
		String org=req.getParameter("org");
		String oname=req.getParameter("oname");
		String email=req.getParameter("email");
		String pass=req.getParameter("pass");
		try
		{
			String tab=org.substring(0,4)+"bill";
			Connection con=DBInfo.con;
			String query="insert into users(UserType,UserName,Email,Password,Organisation) values(?,?,?,?,?)";
			String query1="CREATE TABLE "+tab+" (PID int,PName varchar(50),Qty int,Price double,Amount double)";
			PreparedStatement ps=con.prepareStatement(query);
			ps.setString(1, "Owner");
			ps.setString(2, oname);
			ps.setString(3, email);
			ps.setString(4, pass);
			ps.setString(5, org);
			PreparedStatement ps1=con.prepareStatement(query1);
			int n=ps.executeUpdate();
			int n1=ps1.executeUpdate();
			System.out.println(n+" Owner added");
			System.out.println(n1+" Table added named="+tab);
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		res.sendRedirect("AdminHome.jsp");
	}
}
