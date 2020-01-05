<html>
<head>
    <title>Add Staff</title>
<link rel="stylesheet" type="text/css" href="css/AddStaff.css">    
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
</head>
<body>
<div id="nav">
    <a class="navbutton" id="home" href="homeOwner.jsp">Home</a>
    <a class="navbutton" id="managest" href="ManageStaff.jsp">Manage Staff</a>
    <div id="dropdown">
    <a id="profile"><img src="images/profileicon.png" height="31px" width="31px"></a>
    <div id="dropdown-content"><a id="link1" href="signout.jsp">Signout</a></div>
    </div>    
</div> <h1 id="firsthead">Add Staff</h1>    
<h2 id="enterdets">Enter Staff Member Details</h2> 
<form name="addst" onsubmit="return validateForm()" action="Add" method="post">
<table>
<tr>
    <td width="132">    
    <p class="label" id="name">Staff Member Name</p>    </td>
    <td width="308">
    <input type="text" placeholder="Name" name="name" id="nametx" required>    </td>
<tr>
    <td>
        <p class="label" id="email">Email</p>    </td>
    <td>    <input type="email" placeholder="Staff Email" name="email" required id="emailtx" required>    </td>
</tr>
<tr>
    <td>
        <p class="label" id="mobile">Mobile Number</p>    </td>
    <td>
    <input type="text" placeholder="Phone" name="phone" id="phonetx" maxlength="10" required>    </td>
<tr>
    <td>
        <p class="label" id="dob">Date Of Birth</p>    </td>
    <td>
        <input type="date" placeholder="DD/MM/YYYY" name="dob" id="dobtx" required>    </td>
</tr>
<tr>
    <td>
        <p class="label" id="doj">Date Of Joining</p>    </td>
    <td>
        <input type="date" placeholder="DD/MM/YYYY" name="doj" id="dojtx" required>    </td>
</tr>
<tr>
    <td><p class="label" id="time">Working Hours</p>    </td>
    <td>
    <select id="from" name="from">
    <option value="Select">Select</option>
    <option value="1">1</option>
    <option value="2">2</option>
    <option value="3">3</option>
    <option value="4">4</option>
    <option value="5">5</option>
    <option value="6">6</option>
    <option value="7">7</option>
    <option value="8">8</option>
    <option value="10">10</option>
    <option value="11">11</option>
    <option value="12">12</option>    
    </select>    
    <select id="fromtype" name="fromtype">
    <option value="AM">AM</option>
    <option value="PM">PM</option>    
    </select> 
    to
    <select id="totime" name="totime">
      <option value="Select">Select</option>
      <option value="1">1</option>
      <option value="2">2</option>
      <option value="3">3</option>
      <option value="4">4</option>
      <option value="5">5</option>
      <option value="6">6</option>
      <option value="7">7</option>
      <option value="8">8</option>
      <option value="10">10</option>
      <option value="11">11</option>
      <option value="12">12</option>
    </select>
     <select id="totimetype" name="totimetype">
      <option value="AM">AM</option>
      <option value="PM">PM</option>
    </select>
    </td>
</tr>
<tr>
    <td> 
        <p class="label" id="salary">Salary</p>    </td>
    <td>
        <input type="text" placeholder="Monthly (in K)" name="salary" id="salarytx">    </td>
</tr>
<tr>
    <td>
       <p>Organisation</p> 
    </td>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="db.*" %>
<%
   //Check cookie and redirect to home
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
        }
        else
        {
            response.sendRedirect("index.jsp");
        }
    out.println("<td>");
    out.println("<input type='text' name='org' value='"+org+"' readonly='readonly'/>"); 
    out.println("</td>");
%>   
    
</tr>    
<tr>
    <td>
        <p class="label" id="gender">Gender</p>    </td>
    <td>
    <select id="gender" name="gender">
        <option value="Select">Select</option>    
    <option value="Male">Male</option>
        <option value="Female">Female</option> </select>    </td>
</tr>
<tr>
    <td>
        <p class="label" id="branch">Branch</p>    </td>
    <td>
        <input type="text" placeholder="Organisation Branch" name="branch" id="branchtx" maxlength="20" required>    </td>
</tr>
<tr>
    <td>
        <p class="label" id="pass">Password</p>    </td>
    <td>
        <input type="password" placeholder="Password" name="pass" id="passtx" maxlength="20" required>    </td>
</tr>
<tr>
    <td>
        <p class="label" id="cnfpass">Confirm Password</p>    </td>
    <td>
        <input type="password" placeholder="Password" name="cnfpass" id="cnfpasstx" required>    </td>
</tr>
</table>
<p id="alert"></p>        
<input name="submit" type="submit" id="submit" value="Submit">
    </form>
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
    function validateForm()
    {
        var x=document.forms["addst"]["pass"].value;
        var y=document.forms["addst"]["cnfpass"].value;
        if(x!=y)
        {
        	document.getElementById("alert").innerHTML="Passwords do not match";
            return false;
        }
        if(em.indexOf(document.forms["addst"]["email"].value)==0){ 
   		 document.getElementById("alert").innerHTML="Email account already registered with inventory"; 
        	 return false;
   	 }
    }
</script>    
</body>
</html>