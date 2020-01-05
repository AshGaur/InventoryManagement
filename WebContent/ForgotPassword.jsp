<%@page import="java.sql.*,db.DBInfo,java.util.ArrayList" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/forgotpass.css">
</head>    
 <body>
 <%
 	ArrayList<String> ar=new ArrayList<String>();
 	try
 	{
 		String query="select Email from users";
 		Connection con=DBInfo.con;
 		PreparedStatement ps=con.prepareStatement(query);
 		ResultSet rs=ps.executeQuery();
 		while(rs.next())
 		{
 			ar.add(rs.getString(1));
 		}
 	}
 	catch(SQLException e)
 	{
 		e.printStackTrace();
 	}
 System.out.println("Database values received");
 %>

  <div id="area">
    <h1 id="fphead">Enter email to recover password</h1>
    <form action="email.jsp" name="myForm" onsubmit="return validateForm()" method="post"> 
    <input type="email" id="em" placeholder="Email" name="email">
        <p id="emalert"></p>
    <input type="submit" value="Recover Password" id="sub">
    </form>
  </div>
     <script>
     <%
     //making array em(in js) from backend received database values
 	out.print("var em=new Array('");
     int sz=ar.size();
     for(int i=0;i<sz-1;i++)
     {
         out.print(ar.get(i)+"','");
     }
     out.print(ar.get(sz-1)+"');");
 	%>
 	 var i;
         function validateForm(){
            	 if(em.indexOf(document.forms["myForm"]["email"].value)==-1){ 
            		 document.getElementById("emalert").innerHTML="Email account not registered with inventory"; 
                 	 return false;
            	 }
            	document.getElementById("emalert").innerHTML="Please Wait...";
         }
     </script>     
 </body>
</html>