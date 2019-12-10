<%
     Cookie killMyCookie = new Cookie("userid", null);
     killMyCookie.setMaxAge(0);
     response.addCookie(killMyCookie);
     response.sendRedirect("index.jsp");
     
%>