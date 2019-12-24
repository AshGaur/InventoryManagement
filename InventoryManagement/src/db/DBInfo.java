package db;
import java.sql.*;
public class DBInfo
{
	public static Connection con;
	static
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/inventoryyy","user","password");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
}
