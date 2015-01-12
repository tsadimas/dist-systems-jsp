<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : response
    Created on : Nov 27, 2014, 1:43:03 PM
    Author     : rg
--%>


<sql:query var="actorQuery" dataSource="${sakila}">
    SELECT f.title, f.description, f.release_year
    FROM `film_actor` AS fa, `actor` AS a, `film` AS f
    WHERE fa.actor_id = a.actor_id
    AND f.film_id = fa.film_id
    AND a.actor_id = ? 
    ORDER BY f.release_year
    LIMIT 0 , 30000
    <sql:param value="${param.actor_id_p}"/>
</sql:query>
    
<sql:query var="actorIdQuery" dataSource="${sakila}">
    SELECT a.first_name, a.last_name
    FROM `actor` AS a
    WHERE a.actor_id = ? <sql:param value="${param.actor_id_p}"/>
</sql:query>
                 
   actor id =    ${actor_id_p}  
    <c:set var="films" value="${actorQuery.rows}"/>
    <c:set var="actor" value="${actorIdQuery.rows[0]}"/>
    
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
      <title>${actor.first_name} ${actor.last_name}</title>
    </head>
    <body>
        ${param.actor_id_param}
        <c:forEach var="row" items="${actorQuery.rows}">          
                ${row.title} -  ${row.description} -  ${row.release_year}  <br/>        
        </c:forEach> 
        
       <table border="0">
    <thead>
        <tr>
            <th colspan="2">${actor.first_name} ${actor.last_name}</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="row" items="${actorQuery.rows}">
        <tr>
            <td><strong>Title: </strong></td>
            <td><span style="font-size:smaller; font-style:normal;">${row.title}</span></td>
        </tr>
        <tr>
            <td><strong>Description: </strong></td>
            <td><span style="font-size:smaller; font-style:italic;">${row.description}</span>              
            </td>
        </tr>
        <tr>
            <td><strong>Year: </strong></td>
            <td>
               <span style="font-size:small; font-style:italic;">${row.release_year}</span>                
            </td>
        </tr>
        </c:forEach>
    </tbody>
</table>
    </body>
</html>
