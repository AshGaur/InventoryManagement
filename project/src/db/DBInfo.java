package db;
import java.sql.*;
public class DBInfo
{
	public static Connection con;
	static
	{
		  try {
			    System.out.println("Loading driver...");
			    Class.forName("com.mysql.jdbc.Driver");
			    System.out.println("Driver loaded!");
			  } catch (ClassNotFoundException e) {
			    throw new RuntimeException("Cannot find the driver in the classpath!", e);
			  }
			  String dbName = System.getProperty("RDS_DB_NAME");
			  String userName = System.getProperty("RDS_USERNAME");
			  String password = System.getProperty("RDS_PASSWORD");
			  String hostname = System.getProperty("RDS_HOSTNAME");
			  String port = System.getProperty("RDS_PORT");
			  String jdbcUrl = "jdbc:mysql://" + hostname + ":" + port + "/" + dbName + "?user=" + userName + "&password=" + password;
		
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
		
			con=DriverManager.getConnection(jdbcUrl);
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
}