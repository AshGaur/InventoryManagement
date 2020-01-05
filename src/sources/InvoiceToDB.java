package sources;
import java.io.*;
import db.DBInfo;
import java.sql.*;
import javax.servlet.http.*;
@SuppressWarnings("serial")
public class InvoiceToDB extends HttpServlet{
	public void service(HttpServletRequest req,HttpServletResponse res)throws IOException
	{
		String img=req.getParameter("blob");
		String uid=req.getParameter("uid");
		String amt=req.getParameter("amt");
		String org=req.getParameter("org");
		String customer=req.getParameter("customer");
		String cusmob=req.getParameter("cusmob");
		try
		{
			Connection con=DBInfo.con;
			String query="insert into invoice(UserID,Org,Date,Time,Amount,Person,Mob,Image) values(?,?,CURRENT_DATE,CURRENT_TIMESTAMP,?,?,?,?)";
			PreparedStatement ps=con.prepareStatement(query);
			ps.setString(1, uid);
			ps.setString(2, org);
			ps.setString(3, amt);
			ps.setString(4, customer);
			ps.setString(5, cusmob);
			ps.setString(6, img);
			int n=ps.executeUpdate();
			System.out.println(n+" invoice written to the database");
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		//Updating products table with quantities decreased
		String taborg=org.substring(0,4);
		try
		{
			Connection con=DBInfo.con;
			String query="SELECT "+taborg+"bill.PID,(products.Qty-"+taborg+"bill.Qty) FROM "+taborg+"bill INNER JOIN products ON "+taborg+"bill.PID=products.ProductID";
			String query1="update products set Qty=? where ProductID=?";
			PreparedStatement ps=con.prepareStatement(query);
			PreparedStatement ps1=con.prepareStatement(query1);
			ResultSet rs=ps.executeQuery();
			int n=0;
			while(rs.next())
			{
				ps1.setString(1, rs.getString(2));
				ps1.setString(2, rs.getString(1));
				int p=ps1.executeUpdate();
				n+=p;
			}
			System.out.println(n+" rows updated with new quantities in products table");
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		res.sendRedirect("InitBill");
	}
}
