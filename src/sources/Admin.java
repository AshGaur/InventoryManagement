package sources;
import java.io.*;
import javax.servlet.http.*;
@SuppressWarnings("serial")
public class Admin extends HttpServlet{
	public void service(HttpServletRequest req,HttpServletResponse res)throws IOException
	{
		PrintWriter pw=res.getWriter();
		pw.println("<html><head><script src='js/validateAdmin.js'></script></head>");
		pw.println("<body><center><h1>Admin Panel</h1><br>");
		pw.println("<p style='color:red' id='alt'></p><br>");
		pw.println("<form name='adm' onsubmit='validateAdmin();'>");
		pw.println("<input type='text' name='eml' placeholder='Username' required /><br>");
		pw.println("<input type='password' name='pass' placeholder='Password' autocomplete='off' required><br>");
		pw.println("<input type='submit'>");
		pw.println("</form>");
		pw.println("</center></body></html>");
	}
}