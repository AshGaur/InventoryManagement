package sources;
import java.io.IOException;
import javax.servlet.http.*;
@SuppressWarnings("serial")
public class AdminCred extends HttpServlet{
	public void service(HttpServletRequest req,HttpServletResponse res)throws IOException
	{
		String uname=req.getParameter("uname");
		String pass=req.getParameter("pass");
		if((!uname.equals("AshGaur"))||(!pass.equals("iamtheadmin")))
		{
			res.sendRedirect("admin.html");
		}
		else
		{	
		 Cookie c1=new Cookie("adminCookie","Admin");
	        c1.setMaxAge(10*60);
	        res.addCookie(c1);
	        res.sendRedirect("AdminHome.jsp");
		}
	}
}