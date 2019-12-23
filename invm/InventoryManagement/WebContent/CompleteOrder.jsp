<%
     Cookie killMyCookie = new Cookie("orderid", null);
     killMyCookie.setMaxAge(0);
     response.addCookie(killMyCookie);
     response.sendRedirect("IssueProduct.jsp");
%>