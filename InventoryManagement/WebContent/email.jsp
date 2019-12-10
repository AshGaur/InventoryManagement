<%@ page import = "java.io.*,java.util.*,javax.mail.*"%>
<%@ page import = "javax.mail.internet.*,javax.activation.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*,db.*" %>

<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/email.css">
</head>    
<%!
    public static class SMTPAuthenticator extends Authenticator
    {
            public PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("invmmyinventory", "myinventoryforproject");
            }
    }
%>
    <body>    
<%
    String host="smtp.gmail.com";
    String port="465";
    String userName="invmmyinventory";
    String toAddress=request.getParameter("email");
    String subject="Recover your password for INVM"; 
    Random rand = new Random();
    int  n = rand.nextInt(9999) + 1000;
    String message="Code is "+Integer.toString(n);
    
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
           
            out.println("<div id='box'>");
            out.println("<h1 id='head'>Enter verification code sent to your email</h1>");
            out.println("<form action='recoverpass.jsp' name='myForm' >");
            out.println("<input type='text' name='vcode' id='vcode' maxlength='4' required>");
            out.println("<input='hidden' name='check' value="+n+">");
            out.println("<p id='al'>ggggg̱jjjjj</p>");
            out.println("<button id='sub' onclick='validateForm()'>Recover Password</button>");
            out.println("</form>");
            out.println("</div>");    
        } 
            catch (Exception ex) {
            ex.printStackTrace();
            out.println("<h1>There was an error: " + ex.getMessage()+"</h1>");
            }
%>    
    <script>
    function validateForm()
    {
        var x=document.forms["myForm"]["vcode"].value;
        var y=document.forms["myForm"]["check"].value;
    document.getElementById("al").innerHTML="x="+document.forms["myForm"]["vcode"].value+" y="+document.forms["myForm"]["check"].value";
           
    }
    </script>
   </body>
</html>