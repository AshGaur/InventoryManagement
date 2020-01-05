package sources;
import java.io.IOException;
import javax.servlet.http.*;
@SuppressWarnings("serial")
public class AdminSignout extends HttpServlet{
	public void service(HttpServletRequest request,HttpServletResponse response)throws IOException
	{
		Cookie[] c=request.getCookies();
		boolean foundCookie=false;
		if(c!=null)
		{
			for(int i=0; i<c.length; i++)
			{
				Cookie c1= c[i];
				if(c1.getName().equals("adminCookie"))
				{
					foundCookie=true;
				}
			}
		}
		if(foundCookie)
		{
		  Cookie killMyCookie = new Cookie("adminCookie", null);
		  killMyCookie.setMaxAge(0);
		  response.addCookie(killMyCookie);
		  response.sendRedirect("admin.html");
		}
		else
		{
		    response.sendRedirect("index.jsp");
		} 
	}
}
