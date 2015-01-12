<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="hua.User"%>
<jsp:useBean id="users" class="hua.UserManager" scope="session"/>
<jsp:useBean id="usr" class="hua.User" scope="session"/>
<jsp:setProperty name="usr" property="*"/>

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
        <link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">

        <!-- Optional theme -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap-theme.min.css">

        <!-- Latest compiled and minified JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.10.2.js"></script>
        <script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
        <script>
            $(function () {
                $("#registeredon").datepicker({dateFormat: "yy/mm/dd"});
            });
        </script>
                <title>Add new user</title>
            </head>
        <body>
        <c:import url="menu.jsp">
        </c:import>

        <%
            String uid = request.getParameter("userid");
            out.println(uid);
        %>

        <c:set var="userid" value="${param.userid}" />
        <c:set var="user" value="${users.getUserById(userid)}" />
        <c:out value="USERID = ${userid}" />
        <c:set var="action" value="${param.action}" />
        <c:out value="${action} - out"/>

        <c:choose>
            <c:when test="${action == 'edit'}">  
                <div class="container">
                    <form action="update_user.jsp" method="post" role="form">
                          <div class="form-group">
                            <label for="uname">User Name :</label>
                            <input class="form-control" type="text" name="uname" value="<c:out value="${user.uname}" />" readonly="readonly"/> (You Can't Change this)<br /> 
                        </div>       
                        <div class="form-group">
                            <label for="password">Password :</label> 
                            <input class="form-control" type="password" name="password" value="<c:out value="${user.password}" />" /> <br /> 
                        </div> 
                        <div class="form-group">
                            <label for="email">Email :</label> 
                            <input type="email" name="email" value="<c:out value="${user.email}" />" /> <br />             
                        </div>
                        <div class="form-group">
                            <label for="registeredon">Registration :</label> 
                            <input type="text" name="registeredon" id="registeredon" value="<fmt:formatDate pattern="yyyy/MM/dd" value="${user.registeredon}" />" />(yyyy/MM/dd)  <br /> 
                        </div>
                        <button type="submit" class="btn btn-default">Submit</button>

                    </form>   
                </div>
            </c:when>
            <c:when test="${action == 'delete'}"> 
                <c:if test="${not empty param.action}">
                    ${users.deleteUser(param.userid)}   
                    <jsp:forward page="listusers.jsp">
                        <jsp:param name="message" value="Sucessfully Deleted! ${param.userid}"/> 
                    </jsp:forward> 
                </c:if> 
            </c:when>

            <c:when test="${action == 'insert'}">
                <div class="container">
                    <form action="save_user.jsp" method="post">
                        <div class="form-group">
                            <label for="uname">User Name :</label>    
                            <input type="text" name="uname" placeholder="username" class="form-control"/>   
                        </div>       
                        <div class="form-group">
                            <label for="password">Password :</label> 
                            <input type="password" name="password" />    
                        </div> 
                        <div class="form-group">
                            <label for="email">Email :</label>       
                            <input type="text" name="email" placeholder="email" class="form-control" />  
                        </div>
                        <div class="form-group">
                            <label for="registeredon">Registration :</label>                    
                            <input type="text" name="registeredon" id="registeredon" placeholder="yyyy/MM/dd" class="form-control"/>            
                        </div>   
                        <input type="submit" name="submit" value="save" class="btn btn-default"/>        
                    </form>
                </div>
            </c:when>
        </c:choose>

            </body>
</html>
