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
                    org=rs.getString(6);
                    if(rs.getString(7).equals("false"))
                    {
                    	response.sendRedirect("signout.jsp");
                    }
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
<h3 id="headalert"></h3> 
<div id="nav">
    <a onClick="sendHome();" id="home" onMouseOver="document.getElementById('home').style.cursor='pointer'">Home</a>
    <a class="navbutton" id="managest" href="ManageProducts.jsp">Manage Products</a>
    <a id="viewinv" href="ViewInvoices.jsp">View Invoices</a>
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
     <input type="text" name="pid" id="sID" value=""  placeholder="CLICK TO SCAN:" maxlength="7" autofocus/>
     <input type="hidden" name="lane" value="1" />
     <input id="subHere"type="submit" value="Submit"  />
</form>
</div>
<a href="InitBill" id="nb">New Bill</a>

<div id="manual">    
<form name="myForm" action="BillEntry" method="post" autocomplete="off" onSubmit="return validateForm()">  
<h3 id="manualhead">Manual Entry</h3>   
<input type="text" name="pid" id="pid" placeholder="ProductID" required>
<input type="text" name="qty" id="qty" placeholder="Quantity" required>
<input type="submit" id="sub">
</form>
</div>

 <button id="print" onClick="saveCanvas();">Print Bill and Complete Order</button> 
 
<div id="bill" style="border:0.5px solid lightblue;clear:both;">    
  	<input type="text" id="billcusname" placeholder="Customer Name" required/>
	<input type="text" id="billcusmob" placeholder="Customer Mobile" maxlength="10" required/>
  <p style="text-align:left" id="date">Date</p>
    <p id="time" style="text-align:right">Time</p>
	<br>
 	
<%     
out.println("<p id='org' style='font-family:book antiqua;font-weight:bold;text-align:center'>"+org+"</p>");
%>
<br>
    <table style="border:1px solid black">
    <col width="30">
    <col width="30">
    <col width="250">
    <col width="40">
    <col width="70">
    <col width="100">
    <tr><th><input type="checkbox"></th><th>S.No.</th><th>Product Name</th><th>Qty</th><th>Price</th><th>Amount</th></tr>

<%
String s=null;
//Retrieving values from bill database
try
{
	String query="select PName,Qty,Price,Amount,PID from "+org.substring(0,4)+"bill";
	String query1="select sum(Amount) from "+org.substring(0,4)+"bill";
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
		s=rs1.getString(1);
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
//Also get Product info to check qty
ArrayList<Integer> ar=new ArrayList<Integer>();
ArrayList<Integer> qt=new ArrayList<Integer>();
try
{
	String query="select ProductID,Qty from products where Organisation=?";
	Connection con=DBInfo.con;
	PreparedStatement ps=con.prepareStatement(query);
	ps.setString(1,org);
	ResultSet rs=ps.executeQuery();
	while(rs.next())
	{
		ar.add(Integer.parseInt(rs.getString(1)));	
		qt.add(Integer.parseInt(rs.getString(2)));	
	}
}
catch(SQLException e)
{
	e.printStackTrace();
}
%> 
  </tr></table></body></html>  
</div>

<!-------------------Modal Starts--------------------------------->

<!-- The Modal -->
<div id="myModal" class="modal">

  <!-- Modal content -->
  <div class="modal-content">
    <button id="save" onClick="PrintElem('billcap')">Print & Save</button>
	<button  id="close">Cancel</button>
	<br>
    <img id="billcap">
  </div>
</div>
<!-------------------Modal Ends--------------------------------->

<!-- save invoice to db -->
<form action="InvoiceToDB" name="savetoDB" method="post" >
        <input type="hidden" id="inp" name="blob"/>
  <%      out.println("<input type='hidden' name='uid' value='"+id+"'>");
  		  out.println("<input type='hidden' name='amt' value='"+s+"'>");
  		out.println("<input type='hidden' name='org' value='"+org+"'>");
  		  out.println("<input type='hidden' name='customer' id='customer'>");
  		  out.println("<input type='hidden' name='cusmob' id='cusmob'>");
  %>
</form> 
<!-- end of invoice form -->



<script src="js/html2canvas.min.js"></script>
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

//-----------Modal Starts JS-----------------------------------------------

//Get the modal
var modal = document.getElementById("myModal");

//When the user clicks on <button> (Cancel), close the modal
document.getElementById("close").onclick = function() {
modal.style.display = "none";
}

//-----------Modal Ends JS-----------------------------------------------

// onClick="PrintElem('bill')"

//Screenshot bill
function saveCanvas(){    
html2canvas(document.querySelector("#bill")).then(canvas => {
    var img= canvas.toDataURL("image/png").replace("image/png","image/octet-stream");
    document.getElementById("inp").value=img;
 	document.getElementById("billcap").src=img;
	});	
	modal.style.display = "block";
	document.getElementById("customer").value=document.getElementById("billcusname").value;
	document.getElementById("cusmob").value=document.getElementById("billcusmob").value;
}  


//To print div
function PrintElem(elem)
{
	var url=document.getElementById(elem).getAttribute('src');
    var mywindow = window.open('', 'PRINT', 'height=400,width=600');
    document.forms['savetoDB'].submit();
    mywindow.document.write('<html><body>');
    mywindow.document.write('<img src='+url+'>');
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
    //making array pid(in js) from backend received database values
	out.println("var pid=new Array(");
    int sz=ar.size();
    if(sz>0)
    {	
	    for(int i=0;i<sz-1;i++)
	    {
	        out.println(ar.get(i)+",");
	    }
	    out.println(ar.get(sz-1)+");");
		
	    //making array pid(in js) from backend received database values
		out.println("var qty=new Array(");
	    for(int i=0;i<sz-1;i++)
	    {
	        out.println(qt.get(i)+",");//because comma doesnt have to be entered after last element
	    }
	    out.println(qt.get(sz-1)+");");
    }
	
%>
	var i;var flag=false;
	var pid1=document.getElementById("pid").value;
	var pid2=document.getElementById("sID").value;
	var valch;
	var q;
	if(pid2!="")
	{
		valch=pid2;
		q=1;
	}
	else if(pid1!="")
	{
		valch=pid1;
		q=parseInt(document.getElementById("qty").value);
	}
	var ind=pid.indexOf(parseInt(valch));//index of entered id returned to compare with quantity index
	
	if(ind!=-1)
	{
		
		if(q>qty[ind])
		{
			document.getElementById("headalert").innerHTML="Invalid Qty entered Qty available="+qty[ind]+" for ProductID="+valch;
			flag= false;
		}
		else
		{
			document.getElementById("headalert").innerHTML="Qty entered is available loading bill......";
			flag= true;
		}
	}
	else
	{
		document.getElementById("headalert").innerHTML="Unknown Product ID";
		flag=false;
	}
	
	//return flag;
	return flag;
}

//Date and time on the bill
n=new Date();
y=n.getFullYear();
m=n.getMonth() + 1;
d=n.getDate();  
var ampm=n.getHours>=12 ? 'am':'pm';
h=n.getHours()>12?(n.getHours()-12):n.getHours();    
document.getElementById("date").innerHTML=d+"/"+m+"/"+y; 
document.getElementById("time").innerHTML=h+":"+n.getMinutes()+" "+ampm; 
 
    </script>    

</body>    
    </html>    