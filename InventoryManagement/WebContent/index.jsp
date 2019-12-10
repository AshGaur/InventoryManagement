<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*,db.*" %>
<html>
<%
   Cookie[] c=request.getCookies();
		boolean foundCookie=false;
        String id=null;
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
                    break;
                }
                if(utype.equals("Owner"))
                {
                    response.sendRedirect("homeOwner.jsp");
                }
                if(utype.equals("Staff"))
                {
                    response.sendRedirect("homeStaff.jsp");
                }
            }
            catch(SQLException e)
            {
                System.out.println(e.toString());
            }
        }

%>
<head>
    <link rel="stylesheet" type="text/css" href="css/Login.css">
</head>
<body>    
<div class="first">
    
    <h1 class="fhead">Enter Your Credentials</h1>
    <form action="checkcred.jsp" onsubmit="return validateForm()" method="post" name="myForm">
        <input type="email" class="email" name="email" placeholder="Email" id="email">
        <p id="emalert"></p>
        <br> <input type="password" class="pass" name="pass" placeholder="Password" id="pass">
        <p id="passalert"></p>    
        <br><a href="ForgotPassword.jsp" class="forgot">Forgot Password ?</a>
        <br> <input type="submit" class="sub" value="Login" >
    </form>
</div>
    <script>
        function validateForm() 
        {
            var x = document.forms["myForm"]["email"].value;
            var y= document.forms["myForm"]["pass"].value;
            if (x.length==0) 
            {
            document.getElementById("emalert").innerHTML="Email must be entered"; 
            document.getElementById("email").focus();    
            
                return false;
            }
            if(y.length==0)
            {
        document.getElementById("passalert").innerHTML= "Password must be entered";
                document.getElementById("pass").focus();
                return false;
            }
            else
            {
                return true;
            }
    }
    </script>
</body>
</html>