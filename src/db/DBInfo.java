package db;
import java.sql.*;
public class DBInfo
{
	public static Connection con;
	static
	{
		  try {
			    System.out.println("Loading driver...");
			    Class.forName("com.mysql.cj.jdbc.Driver");
			    System.out.println("Driver loaded!");
			  } catch (ClassNotFoundException e) {
			    throw new RuntimeException("Cannot find the driver in the classpath!", e);
			  }
		try
		{
			con=DriverManager.getConnection(System.getProperty("JDBC_CONNECTION_STRING"));
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
}