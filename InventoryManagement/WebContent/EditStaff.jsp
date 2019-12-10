<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*,db.*" %>
<html>
<head>
    <title>Edit Staff Account</title>    
<link rel="stylesheet" type="text/css" href="css/EditStaff.css">
</head>    
    <body>
    <div id="nav">
    <a class="navbutton" id="home" href="homeOwner.jsp">Home</a>
    <div id="dropdown">
    <a id="profile"><img src="images/profileicon.png" height="31px" width="31px"></a>
    <div id="dropdown-content"><a id="link1" href="signout.jsp">Signout</a></div>
    </div>    
</div> <h1 id="firsthead">Update Staff Info</h1>       
<%
String id=request.getParameter("radio");
String query="select * from staff where id=?";
String s[]=new String[15];   
try
{
  Connection con=DBInfo.con;
  PreparedStatement ps=con.prepareStatement(query);
  ps.setString(1,id);
  ResultSet rs=ps.executeQuery();
  ResultSetMetaData rsmd=rs.getMetaData();
  int total=rsmd.getColumnCount(); 
  while(rs.next())
  {
     for(int i=1;i<=total;i++)
    {
        s[i]=rs.getString(i);
    }
  }        
 }        
 catch(SQLException e)
 {
    System.out.println(e.toString());  
 }
%>      
<form name="addst" onsubmit="return validateForm()" action="UpdateStaff" method="post">
<table>
<tr>
    <td width="132">    
    <p class="label" id="name">Staff Member Name</p>    </td>
    <td width="308">
<%    out.println("<input type='text' placeholder='Name' name='name' id='nametx' value='"+s[1]+"' required></td>");
%>   
</tr>
<tr>
    <td>
        <p class="label" id="email">Email</p>    </td>
    <td>    
<%        out.println("<input type='email' placeholder='Staff Email' value='"+s[2]+"' name='email' required id='emailtx' required></td>");
%>   
</tr>
<tr>
    <td>
        <p class="label" id="mobile">Mobile Number</p>    </td>
    <td>
<%    out.println("<input type='text' placeholder='Phone' name='phone' value='"+s[3]+"' id='phonetx' required></td>");
%>   
</tr>
<tr>
    <td>
        <p class="label" id="dob">Date Of Birth</p>    </td>
    <td>
<%        out.println("<input type='date' placeholder='DD/MM/YYYY' value='"+s[4]+"' name='dob' id='dobtx' required></td>");
%>   
</tr>
<tr>
    <td>
        <p class="label" id="doj">Date Of Joining</p>    </td>
    <td>
<%        out.println("<input type='date' placeholder='DD/MM/YYYY' value='"+s[5]+"' name='doj' id='dojtx' required></td>");
%>   
</tr>
<tr>
    <td><p class="label" id="time">Working Hours</p>    </td>
    <td>
    <select id="from" name="from">
    <option value="0">Select</option>
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
      <option value="0">Select</option>
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
<%        out.println("<input type='text' placeholder='Monthly (in K)' name='salary' id='salarytx' value='"+s[8]+"'></td>");
%>   
</tr>
<tr>
    <td>
       <p>Organisation</p> 
    </td>
    <td>
<%       out.println("<input type='text' name='org' value='"+s[10]+"' readonly='readonly'/>");
%>   
    </td>
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
<%        out.println("<input type='text' placeholder='Organisation Branch' name='branch' id='branchtx' value='"+s[11]+"' required></td>");
%>   
</tr>
<tr>
    <td>
        <p class="label" id="pass">Password</p>    </td>
    <td>
<%        out.println("<input type='password' placeholder='Password' name='pass' id='passtx' required></td>");
%>   
</tr>
<tr>
    <td>
        <p class="label" id="cnfpass">Confirm Password</p>    </td>
    <td>
<%        out.println("<input type='password' placeholder='Password' name='cnfpass' id='cnfpasstx'></td>");
%>   
</tr>
</table>
<p id="alert"></p>      
<%  out.println("<input type='text' name='id' value='"+s[13]+"' hidden>");
%>   
<input name="submit" type="submit" id="submit" value="Submit">
    </form>
<script>
    function validateForm()
    {
        var x=document.forms["addst"]["pass"].value;
        var y=document.forms["addst"]["cnfpass"].value;
        var e=document.getElementById("from");
        var str1=e.options[e.selectedIndex].value;
        var f=document.getElementById("totime");
        var str2=f.options[f.selectedIndex].value;
        if((x==y)&&(str1!="0")&&(str2!="0"))
        {
            return true;
        }
        else if(x!=y)
        {
        document.getElementById("alert").innerHTML="Passwords do not match";
            return false;
        }
        else if((str1!="0")&&(str2!="0"))
        {
        document.getElementById("alert").innerHTML="Please select Working hours";
            return false;
        }
    }
</script>    
    </body>
    </html>