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
        ${user.setregdate(param.registeredon)}
        ${user.setUname(param.uname)}
        ${user.setEmail(param.email)}
        ${user.setPassword(param.password)}
        
        <c:out value="${user.registeredon}"/>
 
        <c:choose>
            <c:when test="${users.isValidUname(param.uname)}">
                ${users.addUser(user)}
                <jsp:forward page="listusers.jsp">
                    <jsp:param name="message" value="Sucessfully inserted!"/> 
                </jsp:forward> 
            </c:when>
            <c:otherwise>
                <jsp:forward page="listusers.jsp">
                    <jsp:param name="message" value="Uname is not Valid!"/> 
                </jsp:forward> 
            </c:otherwise>
        </c:choose>    
       
   
    </body>
</html>
