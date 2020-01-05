<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/email.css">
<title>Insert title here</title>
</head>
<body>
<%
//action='recoverpass.jsp'
String s=request.getParameter("check");
out.println("<div id='box'>");
out.println("<h1 id='head'>Enter verification code sent to your email</h1>");
out.println("<form onSubmit='return validateForm();' name='myForm' >");
out.println("<input type='text' name='vcode' id='vcode' maxlength='4' required>");
out.println("<p id='al'></p>");
out.println("<input type='submit' id='sub' value='Recover Password'>");
out.println("</form>");
out.println("</div>");    
	out.println("<h1>code is:"+s+"</h1>");
	out.println("<button id='myButton'>Home</button>");

%>
<script>
    function validateForm()
    {
    	<%
    		out.println("var ch="+s+";");
    	%>
        if((document.forms["myForm"]["vcode"].value).localeCompare(ch)!=0)
        {
        	document.getElementById("al").innerHTML="Code Incorrect";
        	return false;
        }   
    }
    document.getElementById("myButton").onclick = function () {
        location.href = "index.jsp";
    };
    </script>
</body>
</html>