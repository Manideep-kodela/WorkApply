<%@ page session="true" %>
<%
    session.invalidate();
    response.sendRedirect("client_login.jsp");
%>
