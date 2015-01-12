<%-- 
    Document   : ave_user
    Created on : Nov 30, 2014, 9:36:06 PM
    Author     : rg
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.util.Date"%>
<jsp:useBean id="user" class="hua.User" scope="session"/>
<jsp:useBean id="users" class="hua.UserManager" scope="session"/>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
            /*   user= new hua.User();  
             
             */
            out.println(request.getParameter("uname"));
            out.println(request.getParameter("password"));
            out.println(request.getParameter("email"));
            out.println(request.getParameter("registeredon"));

            user.setUname((String) request.getParameter("uname"));
            user.setPassword((String) request.getParameter("password"));
            user.setEmail((String) request.getParameter("email"));

            out.println(user.getUname());
            out.println(user.getPassword());
            out.println(user.getEmail());

            try {
                Date reg = new SimpleDateFormat("yyyy/MM/dd").parse(request.getParameter("registeredon"));
                System.out.println("rrrrrrrrrrr" + reg);
                user.setRegisteredon(reg);
            } catch (ParseException e) {
                e.printStackTrace();
            }

            out.println(user.getRegisteredon());

            users.updateUser(user);
            out.println("Sucessfully updated!");
        %>    

        <jsp:forward page="listusers.jsp">
            <jsp:param name="message" value="Sucessfully updated!"/> 
        </jsp:forward> 
    </body>
</html>
