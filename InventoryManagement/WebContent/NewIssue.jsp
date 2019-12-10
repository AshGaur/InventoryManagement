<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*,db.*" %>   
<html>
    <head>
    <style>
    	
    </style>
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
                ps.close();
                rs.close();
                //con.close();
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
<form action="BillEntry" id="my_form" method="get" autocomplete="off">
     <label for="text-1"></label>
     <input type="text" autofocus name="pid" id="sID" value="" id="my_button" placeholder="CLICK TO SCAN:" maxlength="7" />
     <input type="hidden" name="lane" value="1" />
     <input id="subHere"type="submit" value="Submit"  />
</form>
</div> 
<a href="InitBill" id="nb">New Bill</a>
<div id="manual">    
<form name="myForm" action="BillEntry" method="post" autocomplete="off" onsubmit="return validateForm()">  
<h3 id="manualhead">Manual Entry</h3>    
<input type="text" name="pid" id="pid" placeholder="ProductID" required>
<input type="text" name="qty" id="qty" placeholder="Quantity" required>
<input type="submit" id="sub">
</form>
</div> 
  
<div id="bill">    
  <p id="date"></p>
    <p id="time"></p>
<%     
out.println("<p id='org' style='font-family:book antiqua;font-weight:bold;text-align:center'>"+org+"</p>");
%>
    <table style="border:1px solid black">
    <col width="30">
    <col width="30">
    <col width="250">
    <col width="40">
    <col width="70">
    <col width="100">
    <tr><th><input type="checkbox"></th><th>S.No.</th><th>Product Name</th><th>Qty</th><th>Price</th><th>Amount</th></tr>

<%
//Retrieving values from bill database
try
{
	String query="select PName,Qty,Price,Amount,PID from bill";
	String query1="select sum(Amount) from bill";
	Connection con=DBInfo.con;
	PreparedStatement ps=con.prepareStatement(query);
	PreparedStatement ps1=con.prepareStatement(query1);
	ResultSet rs=ps.executeQuery();
	ResultSet rs1=ps1.executeQuery();
	int i=1;//To print Serial No.
	while(rs.next())
	{
		out.println("<tr><td style='text-align:center'></td><td style='text-align:center'>"+i+"</td><td style='text-align:center'>"+rs.getString(1)+"</td><td style='text-align:center'>"+rs.getString(2)+"</td><td style='text-align:center'>"+rs.getString(3)+"</td><td style='text-align:center'>"+rs.getString(4)+"</td></tr>");
		i++;
	}
	out.println("</table>");
	out.println("<table style='border:1px solid black'> <col width='30'><col width='30'><col width='250'><col width='40'><col width='70'><col width='100'><tr><td></td><td></td><td></td><td></td><td style='text-align:center'>Total</td>");
	while(rs1.next())
	{
		String s=rs1.getString(1);
		s=(s==null)?"0":s;	//To print zero not null when no entries are entered
		out.println("<td style='text-align:center'>"+s+"</td>");
	}
	rs.close();
	rs1.close();
}
catch(SQLException e)
{
	e.printStackTrace();
}
%>

<%
//Check if entered product id exists in database
ArrayList<Integer> ar=new ArrayList<Integer>();
try
{
	String query="select ProductID from products";
	Connection con=DBInfo.con;
	PreparedStatement ps=con.prepareStatement(query);
	ResultSet rs=ps.executeQuery();
	while(rs.next())
	{
		ar.add(Integer.parseInt(rs.getString(1)));	
	}
}
catch(SQLException e)
{
	e.printStackTrace();
}
%> 
  </tr></table></body></html> 
 </div>
 
 <button id="print" onclick="PrintElem('bill')">Print</button>
 
<script>

//To print div
function PrintElem(elem)
{
    var mywindow = window.open('', 'PRINT', 'height=400,width=600');

    mywindow.document.write('<html><head><title>' + document.title  + '</title>');
    mywindow.document.write('</head><body >');
    mywindow.document.write('<h1>' + document.title  + '</h1>');
    mywindow.document.write(document.getElementById(elem).innerHTML);
    mywindow.document.write('</body></html>');

    mywindow.document.close(); // necessary for IE >= 10
    mywindow.focus(); // necessary for IE >= 10*/

    mywindow.print();
    mywindow.close();

    return true;
}


//To validate entered product id is present in the database for manual entry
function validateForm()
{
	<%
    out.println("var pid=new Array(");
    int sz=ar.size();
    for(int i=0;i<sz-1;i++)
    {
        out.println(ar.get(i)+",");
    }
    out.println(ar.get(sz-1)+");");
%>
	var i;var flag=false;
	for(i=0;i<pid.length;i++)
	{
		if(pid[i]==document.getElementById('pid').value)
		{
			flag=true;
		}
	}
	return flag;
}

//Date and time on the bill
n=new Date();
y=n.getFullYear();
m=n.getMonth() + 1;
d=n.getDate();  
var ampm=n.getHours>=12 ? 'pm':'am';
h=n.getHours()>12?(n.getHours()-12):n.getHours();    
document.getElementById("date").innerHTML=d+"/"+m+"/"+y; 
document.getElementById("time").innerHTML=h+":"+n.getMinutes()+" "+ampm;    
    </script>    

</body>    
    </html>    