package sources;
import java.io.*;import java.sql.*;
import javax.servlet.http.*;import db.*;
@SuppressWarnings("serial")
public class UpdateStaff extends HttpServlet{
	public void service(HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		String s1=request.getParameter("name");
		String s2=request.getParameter("email");
		String s3=request.getParameter("phone");
		String s4=request.getParameter("dob");
		String s5=request.getParameter("doj");
		String s6=request.getParameter("from");
		String s7=request.getParameter("fromtype");
		String s8=request.getParameter("totime");
		String s9=request.getParameter("totimetype");
		String s10=request.getParameter("salary");   
		String s11=request.getParameter("gender");
		String s12=request.getParameter("org");
		String s13=request.getParameter("branch");
		String s14=request.getParameter("pass");
		String s15=request.getParameter("id");   
		   
		String query1="update staff set Name=?, Email=?, Mobile=?, DOB=?, DOJ=?, WHS=?,WHE=?,Salary=?,Gender=?,Organisation=?,Branch=?,Password=? where ID=?";
		String query2="update users set UserName=?, Email=?, Password=? where ID=?";   
		Connection con=DBInfo.con;
		try
		{
		   
		   PreparedStatement ps=con.prepareStatement(query1);
		   ps.setString(1,s1);
		   ps.setString(2,s2);
		   ps.setString(3,s3);
		   ps.setString(4,s4);
		   ps.setString(5,s5);
		   ps.setString(6,s6+s7);
		   ps.setString(7,s8+s9);
		   ps.setString(8,s10);
		   ps.setString(9,s11);
		   ps.setString(10,s12);
		   ps.setString(11,s13);
		   ps.setString(12,s14);
		   ps.setString(13,s15);
		   int n=ps.executeUpdate();
		   System.out.println(n+" Record updated in the staff table");
		}
		catch(SQLException e)
		   {
		    System.out.println(e.toString());
		   }
		   try
		   {
		   PreparedStatement ps=con.prepareStatement(query2);
		   ps.setString(1,s1);
		   ps.setString(2,s2);
		   ps.setString(3,s14);
		   ps.setString(4,s15);
		   int n=ps.executeUpdate();
		   System.out.println(n+" Record updated in users table");
		   }
		catch(SQLException e)
		   {
		    System.out.println(e.toString());
		   }   
		   response.sendRedirect("ManageStaff.jsp");
	}
}
