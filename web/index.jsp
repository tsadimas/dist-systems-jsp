
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : index
    Created on : Nov 27, 2014, 1:34:25 PM
    Author     : rg
--%>


<sql:setDataSource var="sakila" driver="com.mysql.jdbc.Driver" scope="session"
     url="jdbc:mysql://83.212.105.20/sakila"
     user="sakila"  password="sakila"/>

<sql:query var="actors" dataSource="${sakila}">
    SELECT actor_id, first_name, last_name FROM actor LIMIT 0, 300
</sql:query>
   

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1> Select Actor </h1>
        <form action="response.jsp">
            <strong>Select a subject:</strong><select name="actor_id_p">
               <c:forEach var="row" items="${actors.rows}">
                <option value="<c:out value="${row.actor_id}"/>"><c:out value="${row.actor_id} ${row.first_name} ${row.last_name}"/></option>
               </c:forEach>              
            </select>
            <input type="submit" value="submit" name="submit" />
        </form>
    </body>
</html>
