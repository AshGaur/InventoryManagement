package sources;
import java.io.*;import java.util.*;import java.sql.*;
import javax.servlet.http.*;import db.*;
@SuppressWarnings("serial")
public class BillEntry extends HttpServlet{
	
	public void Entry(String pid,String pname,String price,String qt)
	{
		File file=new File("bill.txt");
		String product=null,pprice=null,qty=null,amt=null,proid=null;
		try
		{
			if(!file.exists())
			{
				file.createNewFile();
			}
			
			Scanner sc=new Scanner(file);
			proid=sc.nextLine();
			product=sc.nextLine();
			qty=sc.nextLine();
			pprice=sc.nextLine();
			amt=sc.nextLine();
			sc.close();
			//appending new data to old String variables
			Double d=Double.parseDouble(qt)*Double.parseDouble(price);
			//Getting Serial Numbers
			proid=proid+pid+",";
			product=product+pname+",";
			qty=qty+qt+",";
			pprice=pprice+price+",";
			amt=amt+String.valueOf(d)+",";
			//Adding new data to bill
			PrintWriter pw=new PrintWriter(file);
			pw.println(proid);
			pw.println(product);
			pw.println(qty);
			pw.println(pprice);
			pw.println(amt);
			pw.close();
			
		}
		catch(IOException e)
		{
			e.printStackTrace();
		}
	}
	
	public void BillInit()
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
	}
	
	public void service(HttpServletRequest request,HttpServletResponse response) throws IOException{

	    BillInit();
		String s1=request.getParameter("pid");
	    String s2=request.getParameter("qty");
	    if(s2==null)
	    {
	    	s2="1";
	    }
	    String query="select * from products where ProductID=?";
	    String pname=null,price=null;
	    try
	    {
	        Connection con=DBInfo.con;
	        PreparedStatement ps=con.prepareStatement(query);
	        ps.setString(1,s1);
	        ResultSet rs=ps.executeQuery();
	        while(rs.next())
	        {
	        	pname=rs.getString("ProductName");
	        	price=rs.getString("Price");
	        }
	        Entry(s1,pname,price,s2);
	    }
	    catch(SQLException e)
	    {
	        System.out.println(e.toString());
	    }
	    response.sendRedirect("BillToDB");  
	}
}	