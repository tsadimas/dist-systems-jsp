<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="hua.User"%>
<jsp:useBean id="users" class="hua.UserManager" scope="session"/>
<%@ page import="hua.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Show All Users</title>
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
        <!-- Optional theme -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap-theme.min.css">
        <!-- Latest compiled and minified JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
    </head>
    <body>
        <c:import url="menu.jsp">
        </c:import>

        <c:if test="${not empty param.message}">
            <c:out value="Message = ${param.message}"/>           
        </c:if>

        <c:set var="users" value="${users.allUsers}" />
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>User Name</th>
                    <th>Email</th>
                    <th>Registration Date</th>
                    <th colspan=2>Action</th>
                </tr>
            </thead>
            <tbody>

                <c:forEach items="${users}" var="user">
                    <tr>
                        <td><c:out value="${user.uname}" /></td>
                        <td><c:out value="${user.email}" /></td>
                        <td><fmt:formatDate pattern="yyyy/MM/dd" value="${user.registeredon}" /></td>
                        <td><a href="user.jsp?action=edit&userid=<c:out value="${user.uname}"/>">Edit</a></td>
                        <td><a href="user.jsp?action=delete&userid=<c:out value="${user.uname}"/>">Delete</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <p><a href="user.jsp?action=insert">Add User</a></p>
    </body>
</html>