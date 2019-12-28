package sources;
import java.io.*;
import java.util.*;
import javax.servlet.http.*;
@SuppressWarnings("serial")
public class ReadBill extends HttpServlet{
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
			while(sc.hasNextLine())
			{
				System.out.println(sc.nextLine());
			}
			sc.close();
		}
		catch(IOException e)
		{
			e.printStackTrace();
		}
	}
}
