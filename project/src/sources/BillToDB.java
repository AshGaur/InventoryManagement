package sources;
import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.http.*;

import db.DBInfo;
@SuppressWarnings("serial")
public class BillToDB extends HttpServlet{
	public String SubStr(String str)
	{
		int start=0,end=str.length()-1;
		for(int i=0;i<str.length();i++)
		{
			 if(str.charAt(i)==':')
			 {
				 start=i+1;
				 break;
			 }
		}
		return str.substring(start,end);
	}
	public void EnterToDB(String pid,String pname,String qty,String price,String amt)
	{
		try
		{
		Connection con=DBInfo.con;
		String query="insert into bill values(?,?,?,?,?)";
		PreparedStatement ps=con.prepareStatement(query);
		ps.setString(1, SubStr(pid));
		ps.setString(2, SubStr(pname));
		ps.setString(3, SubStr(qty));
		ps.setString(4, SubStr(price));
		ps.setString(5, SubStr(amt));
		int n=ps.executeUpdate();
		System.out.println(n+" records entered");
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
	}
	public void service(HttpServletRequest req,HttpServletResponse res) throws IOException
	{
		File file=new File("bill.txt");
		try
		{
			if(!file.exists())
			{
				file.createNewFile();
			}
			Scanner sc=new Scanner(file);
			String pid=sc.nextLine();
			String pname=sc.nextLine();
			String qty=sc.nextLine();
			String price=sc.nextLine();
			String amt=sc.nextLine();
			sc.close();
			EnterToDB(pid,pname,qty,price,amt);
		}
		catch(IOException e)
		{
			e.printStackTrace();		
		}
		res.sendRedirect("NewIssue.jsp");
	}
}