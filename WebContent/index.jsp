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
    <title>My Inventory</title>
   <script src="js/login.js"></script>
</head>
<body>
<h1 id="credit">Developed and Maintained By: <span id="crename">Ashutosh Gaur</span></h1>    
<a onClick="window.location.reload();" id="uslogin">User Login</a>
<a onClick="enGuest();" id="guestlogin">Login as Guest</a>
<div class="first">
    <h1 class="fhead">Enter Your Credentials</h1>
	
    <form action="checkcred.jsp" onSubmit="return validateForm()" method="post" name="myForm">
		
		<input type="email" id="guestem" placeholder="Please Enter Your Email" name="guestemail" required />
        <input type="email" class="email" name="email" placeholder="Email" id="email" autocomplete="off" />
        <p id="emalert"></p>
        <br> <input type="password" class="pass" name="pass" placeholder="Password" id="pass">
        <p id="passalert"></p>    
        <br><a href="ForgotPassword.jsp" class="forgot" id="forg">Forgot Password ?</a>
        <br> <input type="submit" class="sub" value="Login" id="sub">
    </form>
</div>
</body>
</html>