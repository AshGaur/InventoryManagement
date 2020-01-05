<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*,db.*" %>
<html>
<head>
    <title>Edit Product</title>    
<link rel="stylesheet" type="text/css" href="css/EditPro.css">
</head>    
    <body>
    <div id="nav">
    <a class="navbutton" id="home" href="homeOwner.jsp">Home</a>
    <div id="dropdown">
    <a id="profile"><img src="images/profileicon.png" height="31px" width="31px"></a>
    <div id="dropdown-content"><a id="link1" href="signout.jsp">Signout</a></div>
    </div>    
</div> <h1 id="firsthead">Update Product Info</h1>       
<%
String id=request.getParameter("radio");
String query="select * from products where ProductID=?";
String s[]=new String[10];   
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
        <form name="addst"  action="UpdateProduct.jsp" method="post">
<table>
<tr>
    <td width="132">    
    <p class="label" id="name">Product Name</p>    </td>
    <td width="308">
<%    out.println("<input type='text' placeholder='Name' name='name' id='nametx' value='"+s[2]+"' required></td>");
%>   
</tr>
<tr>
    <td>
        <p class="label" id="email">Product Price</p>    </td>
    <td>    
<%        out.println("<input type='text' placeholder='Price' value='"+s[3]+"' name='price' required id='emailtx' required></td>");
%>   
</tr>
<tr>
    <td>
        <p class="label" id="mobile">Manufacturing Date</p>    </td>
    <td>
<%    out.println("<input type='date' placeholder='DD/MM/YYYY' name='mfg' value='"+s[4]+"' id='phonetx' required></td>");
%>   
</tr>
<tr>
    <td>
        <p class="label" id="dob">Expiry Date</p>    </td>
    <td>
<%        out.println("<input type='date' placeholder='DD/MM/YYYY' value='"+s[5]+"' name='expiry' id='dobtx' required></td>");
%>   
</tr>
<tr>
    <td>
        <p class="label" id="doj">Category</p>    </td>
    <td>
<%        out.println("<input type='text' placeholder='Category' value='"+s[6]+"' name='cat' id='dojtx' required></td>");
%>   
</tr>
<tr>
    <td> 
        <p class="label" id="salary">Quantity</p>    </td>
    <td>
<%        out.println("<input type='text' placeholder='Qty' name='qty' id='salarytx' value='"+s[7]+"'></td>");
%>   
</tr>
<tr>
    <td>
       <p>Organisation</p> 
    </td>
    <td>
<%       out.println("<input type='text' name='org' value='"+s[8]+"' readonly='readonly'/>");
%>   
    </td>
</tr>    
<tr>
    <td>
        <p class="label" id="branch">Branch</p>    </td>
    <td>
<%        out.println("<input type='text' placeholder='Organisation Branch' name='branch' id='branchtx' value='"+s[9]+"' required></td>");
%>   
</tr>
</table>
<%  out.println("<input type='text' name='id' value='"+s[1]+"' hidden>");
%>        
<input name="submit" type="submit" id="submit" value="Submit">
    </form>
    </body>
    </html>