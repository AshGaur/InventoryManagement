<html>
<head>
    <title>Manage Products</title>    
<link rel="stylesheet" type="text/css" href="css/ManageProducts.css">    
<script src="js/jquery-3.3.1.min.js"> 
</script>
<script>
$(document).ready(function(){
    $("#edit").click(function(){
        $(".rd").show();
        $(".ck").hide();
        $(".check").show();
        $(".latercan").show();
        $("#ed").show();
        $("#edit").hide();
        $("#rmv").hide();
        $("#addst").hide();  
    });
     $(".latercan").click(function(){
        $(".check").hide();
        $(".rd").hide();
        $(".ck").hide(); 
        $("#del").hide();
        $("#ed").hide(); 
        $("#edit").show();
        $("#rmv").show();
        $(".latercan").hide();
        $("#addst").show();
        $(".ck").prop("checked", false);
        $(".rd").prop("checked", false); 
    });
    $("#rmv").click(function(){
        $(".ck").show();
        $(".rd").hide();
        $(".check").show();
        $(".latercan").show();
        $("#del").show();
        $("#edit").hide();
        $("#rmv").hide();
        $("#addst").hide();   
    });
});
</script>        
</head>    
<body>    
<div id="nav">
    <a onclick="sendHome();" id="home" onmouseover="document.getElementById('home').style.cursor='pointer'">Home</a>
    <div id="dropdown">
    <a id="profile"><img src="images/profileicon.png" height="31px" width="31px"></a>
    <div id="dropdown-content"><a id="link1" href="signout.jsp">Signout</a></div>
    </div>    
</div> <h1 id="firsthead">Manage Products</h1>       
<button id="edit" class="manage" ><img src="images/editpro.png" height="30px" width="40px">Edit Product</button>
<button id="rmv" class="manage" ><img src="images/delpro.png" height="30px" width="40px">Remove Products</button>    
<button class="latercan">Cancel</button>
<form method="post">        
<a id="addst" href="AddProduct.jsp"><img src="images/addpro.png" height="30px" width="40px">Add Product</a>
 <%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*,db.*" %> 
<%   Cookie[] c=request.getCookies();
		boolean foundCookie=false;
        String id=null;
        String org=null;
        String utype=null;
		if(c!=null)
		{
			for(int i=0; i<c.length; i++)
			{
				Cookie c1= c[i];
				if(c1.getName().equals("userid"))
				{
					foundCookie=true;
                    id=c1.getValue();
				}
			}
		}
		if(foundCookie)
		{
           
               out.println("<table><tr>");
            String query="select * from users where id=?";
            try
            {
                Connection con=DBInfo.con;
                PreparedStatement ps=con.prepareStatement(query);
                ps.setString(1,id);
                ResultSet rs=ps.executeQuery();
                while(rs.next())
                {
                	utype=rs.getString(2);
                    org=rs.getString(6);
                    if(rs.getString(7).equals("false"))
                    {
                    	response.sendRedirect("signout.jsp");
                    }
                    break;
                }
            }
            catch(SQLException e)
            {
                System.out.println(e.toString());
            }
            try
            {
                Connection con=DBInfo.con;
                query="select * from products where Organisation=?";
                PreparedStatement ps=con.prepareStatement(query);
                ps.setString(1,org);
                ResultSet rs=ps.executeQuery();
                ResultSetMetaData rsmd=rs.getMetaData();
                int total=rsmd.getColumnCount();
                out.println("<th>S. No.</th>");
                for(int i=1;i<=total;i++)
                {
                    out.println("<th>"+rsmd.getColumnName(i)+"</th>");  
                }
                    out.println("<th class='check'>Selector</th>");                             
                    out.println("</tr>");
                    int i=1;                             
                    while(rs.next())
	               {
	                   out.println("<tr><td>"+i+"</td><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td>"+rs.getString(3)+"</td><td>"+rs.getString(4)+"</td><td>"+rs.getString(5)+"</td><td>"+rs.getString(6)+"</td><td>"+rs.getString(7)+"</td><td>"+rs.getString(8)+"</td><td>"+rs.getString(9)+"</td><td class='check'><input class='ck' type='checkbox' name='check' value="+rs.getString(1)+"><input class='rd' type='radio' name='radio' value="+rs.getString(1)+"></td></tr>");
                        i++;                         
                    }                       out.println("</table>");  
                
             }
             catch(SQLException e)
             {
                   System.out.println(e.toString());
             }   
                out.println("<button type='submit' class='latersel' id='del' formaction='DelPro.jsp'>Delete Products</button>");   
                out.println("<button type='submit' class='latersel' id='ed' formaction='EditPro.jsp'>Edit Product</button>");                                 
               out.println("</form>");                                 
        }
        else
        {
            response.sendRedirect("index.jsp");                                     
        }                                             
%>               
<script>
function sendHome()
{
	<% out.println("var ut='"+utype+"';"); %>
		
		if(ut.localeCompare("Staff")==0)
		{
			window.location.href = "homeStaff.jsp";
		}
		else
		{
			window.location.href = "homeOwner.jsp";
		}
	
}
</script>
</body>
</html>    
   
    