<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<%
	String s[]={"techgeniusashutosh@gmail.com","ashutosh@gmail.com","piyush@gmail.com","manibhai06@gmail.com","shubhammehta12b@gmail.com","hello@xyz.com"};
%>
</head>
<body>
<p id="ch">Hello</p>
<input type="text" id="tx">
<button onclick="myFunction();">Click</button>
<script>
<%
//making array em(in js) from backend received database values
out.println("var em=new Array(");
int sz=s.length;
for(int i=0;i<sz-1;i++)
{
    out.println(s[i]+",");
}
out.println(s[sz-1]+");");
%>

function myFunction()
{
	var b=em.indexOf(document.getElementById("tx").value);
	document.getElementById("ch").innerHTML=b;
}
</script>
</body>
</html>