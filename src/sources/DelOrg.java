package sources;
import java.sql.*;
import db.DBInfo;
import javax.servlet.http.*;
import java.io.*;
@SuppressWarnings("serial")
public class DelOrg extends HttpServlet{
	public void service(HttpServletRequest req,HttpServletResponse res)throws IOException
	{
		String org=req.getParameter("org");
		try
		{
			String tab=org.substring(0,4)+"bill";
			Connection con=DBInfo.con;
			String query="delete from users where Organisation=?";
			String query1="delete from staff where Organisation=?";
			String query2="delete from products where Organisation=?";
			String query3="DROP TABLE "+tab;
			String query4="delete from invoice where Org=?";
			PreparedStatement ps=con.prepareStatement(query);
			ps.setString(1, org);
			PreparedStatement ps1=con.prepareStatement(query1);
			ps1.setString(1, org);
			PreparedStatement ps2=con.prepareStatement(query2);
			ps2.setString(1, org);
			PreparedStatement ps3=con.prepareStatement(query3);
			PreparedStatement ps4=con.prepareStatement(query4);
			ps4.setString(1, org);
			int n=ps.executeUpdate();
			int n1=ps1.executeUpdate();
			int n2=ps2.executeUpdate();
			int n3=ps3.executeUpdate();
			int n4=ps4.executeUpdate();
			System.out.println(n+" rows deleted from users with org="+org);
			System.out.println(n1+" rows deleted from staff with org="+org);
			System.out.println(n2+" rows deleted from products with org="+org);
			System.out.println(n4+" rows deleted from invoice with org="+org);
			System.out.println(n3+" table deleted from database named="+tab);
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		res.sendRedirect("ManageOrg.jsp");
	}
}
