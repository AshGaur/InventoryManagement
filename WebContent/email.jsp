<%@ page import = "java.io.*,java.util.*,javax.mail.*"%>
<%@ page import = "javax.mail.internet.*,javax.activation.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*,db.*,sources.SMTPAuthenticator" %>

<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/email.css">
</head>    
    <body>    
<%
    String host="smtp.gmail.com";
    String port="465";
    String userName=System.getProperty("UNAME_CRED");
    String toAddress=request.getParameter("email");
    String subject="Recover your password for My Inventory System"; 
    Random rand = new Random();
    int  n = rand.nextInt(9999) + 1000;
    String s=Integer.toString(n);
    String message="Code is "+s;
    
    Properties properties = new Properties();
    properties.put("mail.smtp.host", host);      
    properties.put("mail.smtp.socketFactory.port", port);
    properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
    properties.put("mail.smtp.auth", "true");
    properties.put("mail.smtp.port", "465"); 
    try {
        
        Authenticator auth = new SMTPAuthenticator();
        Session sess = Session.getInstance(properties, auth);
        Message msg = new MimeMessage(sess);
        msg.setFrom(new InternetAddress(userName));
        InternetAddress[] toAddresses = { new InternetAddress(toAddress) };
        msg.setRecipients(Message.RecipientType.TO, toAddresses);
        msg.setSubject(subject);
        msg.setSentDate(new Date());
        msg.setText(message);
        Transport.send(msg);
        } 
            catch (Exception ex) {
            ex.printStackTrace();
            out.println("<h1>There was an error: " + ex.getMessage()+"</h1>");
            }
    out.println("<div id='box'>");
    out.println("<h1 id='head'>Enter verification code sent to your email</h1>");
    out.println("<form onSubmit='return validateForm();' name='myForm' action='recoverpass.jsp'>");
    out.println("<input type='hidden' value='"+toAddress+"' name='eml'>");
    out.println("<input type='text' name='vcode' id='vcode' maxlength='4' required>");
    out.println("<p id='al'></p>");
    out.println("<input type='submit' id='sub' value='Recover Password'>");
    out.println("</form>");
    out.println("</div>");  
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