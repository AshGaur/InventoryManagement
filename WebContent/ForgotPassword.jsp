<%@page import="java.sql.*,db.DBInfo,java.util.ArrayList" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/forgotpass.css">
</head>    
 <body>
 <%
 	ArrayList<String> ar=new ArrayList<String>();
 	String query="select Email from users";
 	try
 	{
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
 	out.println("var em=new Array('");
     int sz=ar.size();
     for(int i=0;i<sz-1;i++)
     {
         out.println(ar.get(i)+"','");
     }
     out.println(ar.get(sz-1)+"');");
 	%>
         function validateForm()
         {
             var x=document.forms["myForm"]["email"].value;
             var flag=false;
          	 
             if(x.length>0) 
             {
            	 if(em.indexOf(x)!=-1)
            	 { 
                 flag=true;
            	 }
            	 else
            	 {
            		 document.getElementById("emalert").innerHTML="Email account not registered with inventory";
            		 flag=false;
            	 }	 
             }
             return flag;
            // return false;
         }
     </script>     
 </body>
</html>