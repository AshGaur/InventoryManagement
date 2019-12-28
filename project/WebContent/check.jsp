<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*,db.*" %>   
<html>
    <head>
    <title>Issue Product</title>
<link rel="stylesheet" type="text/css" href="css/IssueProduct.css">        
<script src="js/jquery-3.3.1.min.js">
</script>
<script>
$(function() {
      var $id = $('#sID');
      $id.keyup(function(e) {
        if ($id.val().length >= 7) {
          $(this.form).submit();
        }
      });
    });
$(document).ready(function(){
    $("#man").click(function(){
        $("#manual").show();
        $("#man").hide();
        $("#scan").hide();
        $("#sc").show();
    });  
    $("#sc").click(function(){
        $("#scan").show();
        $("#sc").hide();
        $("#manual").hide();
        $("#man").show();
        $("#sID").focus();
    });      
});
</script>
    </head>
<body>
<div id="nav">
    <a class="navbutton" id="home" href="homeOwner.jsp">Home</a>
    <a class="navbutton" id="managest" href="ManageStaff.jsp">Manage Staff</a>
    <div id="dropdown">
    <a id="profile"><img src="images/profileicon.png" height="31px" width="31px"></a>
    <div id="dropdown-content"><a id="link1" href="signout.jsp">Signout</a></div>
    </div>    
</div> <h1 id="firsthead">Issue Product</h1>
    <button class="btn" id="sc"><img src="images/scanQR.png" height="40px" width="40px">Scan QR</button>
    <button class="btn" id="man"><img src="images/manualb.png" height="40px" width="40px">Manual Entry</button>
<div id="scan">
<h2 id="divhead">Enter Product ID</h2>    
<form action="getsc.jsp" id="my_form" method="get">
     <label for="text-1"></label>
     <input type="text" autofocus name="sID" id="sID" value="" id="my_button" placeholder="CLICK TO SCAN" maxlength="7" />
     <input type="hidden" name="lane" value="1" />
     <input id="subHere"type="submit" value="Submit"  />
</form>
</div> 
<a id="newbill" href="newb.jsp">New bill</a>    
<div id="bill">    
<%    
Cookie[] c=request.getCookies();
		boolean foundCookie=false;
        String id=null;
        String org=null;
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
            String query="select * from users where id=?";
            try
            {
                Connection con=DBInfo.con;
                PreparedStatement ps=con.prepareStatement(query);
                ps.setString(1,id);
                ResultSet rs=ps.executeQuery();
                while(rs.next())
                {
                    org=rs.getString(6);
                    break;
                }
            }
            catch(SQLException e)
            {
                System.out.println(e.toString());
            }
                 String query1="select * from present ";    
                 try
                 {
                        Connection con=DBInfo.con;
                        PreparedStatement ps=con.prepareStatement(query1);
                        out.println("<table>");
                        out.println("<tr><th>ProductName</th><th>Qty</th><th>Price</th><th>Amount</th></tr>");
                                          
                        ResultSet rs=ps.executeQuery();
                        while(rs.next())
                        {
    out.println("<tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(3)+"</td><td>"+rs.getString(2)+"</td><td>"+rs.getString(4)+"</td></tr>");    
                        }
                
                out.println("</table>");
                }
                catch(SQLException e)
                    {
                        System.out.println(e.toString());                            
                    }
                    
        }
        else
        {
            response.sendRedirect("index.jsp");
        }
    
%>    
    </table>
    </div>    
<div id="manual">    
<form action="manb.jsp" method="post" >  
<h3 id="manualhead">Manual Entry</h3>    
<input type="text" name="pid" id="pid" placeholder="ProductID">
<input type="text" name="qty" id="qty" placeholder="Quantity">
<input type="submit" id="sub">
</form>
</div> 
<a id="complete" href="newb.jsp">Complete Order</a>    
</body>    
    </html>    