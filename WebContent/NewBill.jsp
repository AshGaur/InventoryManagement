<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*,db.*" %>
<%
    Cookie[] c=request.getCookies();
    int col=0;
		boolean foundProCookie=false;
        String oid=null;
        int qty=0;
		if(c!=null)
		{
			for(int i=0; i<c.length; i++)
			{
				Cookie c1= c[i];
				if(c1.getName().equals("orderid"))
				{
					foundProCookie=true;
                    oid=c1.getValue();
				}
			}
		}
		if(foundProCookie)
		{
            String query="delete orders where OrderID=?";
            try
            {
               Connection con=DBInfo.con;
               PreparedStatement ps=con.prepareStatement(query);
               ps.setString(1,oid);
               int n=ps.executeUpdate();
               out.println(n+"cookies deleted for new bill");
            }
            catch(SQLException e)
            {
                out.println(e.toString());
            }
        }
        response.sendRedirect("IssueProduct.jsp");
%>        