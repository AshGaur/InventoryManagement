<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*,db.*" %>

<html>
<head>
<title>View Invoices</title>   
    <link rel="stylesheet" type="text/css" href="css/ViewInvoices.css"> 
<body>
<div id="nav">
    <a onClick="sendHome();" id="home" onMouseOver="document.getElementById('home').style.cursor='pointer'">Home</a>
	 <a id="manage" href="ManageProducts.jsp">Manage Products</a>
    <a id="issue" href="NewIssue.jsp">Issue Product</a>
    <a id="profile" ><img src="images/profileicon.png" height="31px" width="31px"></a>
    <div id="dropdown-content"><a id="link2" href="Profile.jsp">Profile</a><a id="link1" href="signout.jsp">Signout</a></div>
  
</div>
<h1 id="firsthead">View Invoices</h1> 
   
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
<input type="hidden" id="valimg"/>

<table id="invtable">

<%
	try
	{
		Connection con=DBInfo.con;
		String query="select * from invoice where Org=?";
		PreparedStatement ps=con.prepareStatement(query);
		ps.setString(1,org);
		ResultSet rs=ps.executeQuery();
		ResultSetMetaData rsmd=rs.getMetaData();
		int ncol=rsmd.getColumnCount();
		out.println("<tr>");
		out.println("<th>InvoiceID</th>");
		for(int i=2;i<ncol-2;i++)
		{
			out.println("<th>"+rsmd.getColumnName(i)+"</th>");
		}
		out.println("<th>Customer Name</th><th>Customer Phone</th>");
		out.println("</tr>");
		int j=0;
		while(rs.next())
		{
			out.println("<tr>");
			for(int i=1;i<ncol;i++)
			{	
				out.println("<td>"+rs.getString(i)+"</td>");
			}
			out.println("<td><button onclick=viewInv('"+rs.getString(9)+"')>View Invoice</button></td>");
			out.println("</tr>");
		}
	}
	catch(SQLException e)
	{
		e.printStackTrace();
	}

%>

</table>
<!-------------------Modal Starts--------------------------------->

<!-- The Modal -->
<div id="myModal" class="modal">

  <!-- Modal content -->
  <div class="modal-content">
    <button  onClick="PrintElem('valimg')">Print</button>
	<button  id="close">Cancel</button>
	<br>
    <img id="billcap">
  </div>
</div>
<!-------------------Modal Ends--------------------------------->

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

function viewInv(imgval){
	document.getElementById("valimg").value=imgval;
	document.getElementById("billcap").src=imgval;
	 modal.style.display = "block";
}

//To print div
function PrintElem(elem)
{
	var url=document.getElementById(elem).value;
    var mywindow = window.open('', 'PRINT', 'height=400,width=600');
    mywindow.document.write('<html><body>');
    mywindow.document.write('<img src='+url+'>');
    mywindow.document.write('</body></html>');
    mywindow.document.close(); // necessary for IE >= 10
    mywindow.focus(); // necessary for IE >= 10*/
    mywindow.print();
    mywindow.close();
    return true;
}

</script>
</body>
</html>