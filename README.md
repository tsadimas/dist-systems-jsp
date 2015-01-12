# dist-systems-jsp

Θεωρήστε ότι έχουμε μια βάση με ένα πίνακα και δεδομένα, τα οποία παράγονται από το sql query


θέλουμε να φτιάξουμε μια jsp σελίδα, όπου θα εμφανίζονται οι χρήστες (uname,password, email, registeredon) σε έναν πίνακα

Δημιουργία beans

δημιουργήστε 3 κλάσεις:
User, ώστε να τη χρησιμοποιούμε για να φέρνουμε και να αποθηκεύουμε δεδομένα για τους χρήστες (με getters και setters)
UserManager, ώστε να κάνουμε βασικές ενέργειες στους χρήστες, με μεθόδους addUser(), deleteUser, updateUser(), getallUsers(), getUserbyId()
Database, η οποία να συνδέεται με τη βάση σας

Ονομάστε την πρώτη σελίδα listusers.jsp και φτιάξτε τη να μοιάζει σαν και αυτή:



Χρησιμοποιήστε <c:set> και το <c:foreach> για να πάρετε τα στοιχεία από τη βάση και να τα εμφανίσετε.

Στην περίπτωση του deleteφροντίστε να διαγάψετε το χρήστη και στη συνέχεια να βγάλετε το αντίστοιχο μήνυμα.

Στην περίπτωση του edit εμφανίστε την ίδια φόρμα με τα πεδία editable εκτός από το username
και με το που πατήσει κάποιος το submit τότε να αποθηκεύονται οι αλλαγές.
Χρησιμοποιήστε <c:when> tag.

Ενδεικτική Λύση:


H database class, για σύνδεση με τη βάση: 

package hua;

import java.sql.Connection;
import java.sql.DriverManager;

public class Database {
   
     public static Connection getConnection() {
          try  {
              Class.forName("com.mysql.jdbc.Driver");
              Connection con = DriverManager.getConnection
                      ("jdbc:mysql://database-server-ip:port/database-name",
                      "user","password");
              return con;
          }
          catch(Exception ex) {
              System.out.println("Database.getConnection() Error -->" + ex.getMessage());
              return null;
          }
      }
 
       public static void close(Connection con) {
          try  {
              con.close();
          }
          catch(Exception ex) {
          }
      }
}

H User class για να χειρίζόμαστε τα δεδομένα από τις φόρμες:



package hua;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.validation.constraints.*;

public class User {
	@NotNull
	private String uname;
	private String password;
	private String email;
	private Date registeredon;

	/**
 	* @return the uname
 	*/
	public String getUname() {
    	return uname;
	}

	/**
 	* @param uname the uname to set
 	*/
	public void setUname(String uname) {
    	this.uname = uname;
	}
    
    

	/**
 	* @return the password
 	*/
	public String getPassword() {
    	return password;
	}

	/**
 	* @param password the password to set
 	*/
	public void setPassword(String password) {
    	this.password = password;
	}

	/**
 	* @return the email
 	*/
	public String getEmail() {
    	return email;
	}

	/**
 	* @param email the email to set
 	*/
	public void setEmail(String email) {
    	this.email = email;
	}

	/**
 	* @return the registeredon
 	*/
	public Date getRegisteredon() {
    	return registeredon;
	}

	/**
 	* @param registeredon the registeredon to set
 	*/
	public void setRegisteredon(Date registeredon) {
   	 
    	this.registeredon = registeredon;
	}

	public void setregdate(String regdate){
   	 
        	try {
            	Date reg = new SimpleDateFormat("yyyy/MM/dd").parse(regdate);
            	System.out.println("regdate" + reg);
            	this.registeredon=reg;
        	} catch (ParseException e) {
            	e.printStackTrace();
        	}

	}
}





Δημιουργούμε μια νέα κλάση για τον χειρισμό των users στη βάση.

package hua;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class UserManager {
	private Connection connection;
 
	List<User> allusers;
    
	public UserManager() {
    	connection = Database.getConnection();
	}
 
	public void checkUser(User user) {
    	try {
        	PreparedStatement ps = connection.prepareStatement("select uname from users where uname = ?");
        	ps.setString(1, user.getUname());
        	ResultSet rs = ps.executeQuery();
        	if (rs.next()) // found
        	{
            	updateUser(user);
        	} else {
            	addUser(user);
        	}
    	} catch (Exception ex) {
        	System.out.println("Error in check() -->" + ex.getMessage());
    	}
	}
	public void addUser(User user) {
    	try {
        	System.out.println("add user start");
        	PreparedStatement preparedStatement = connection.prepareStatement("insert into users(uname, password, email, registeredon) values (?, ?, ?, ? )");
        	// Parameters start with 1
        	preparedStatement.setString(1, user.getUname());
        	preparedStatement.setString(2, user.getPassword());
        	preparedStatement.setString(3, user.getEmail());       	 
        	preparedStatement.setDate(4, new java.sql.Date(user.getRegisteredon().getTime()));
        	preparedStatement.executeUpdate();
         	System.out.println("add user end");

    	} catch (SQLException e) {
        	e.printStackTrace();
    	}
	}
 
	public void deleteUser(String userId) {
    	try {
        	PreparedStatement preparedStatement = connection.prepareStatement("delete from users where uname=?");
        	// Parameters start with 1
        	preparedStatement.setString(1, userId);
        	preparedStatement.executeUpdate();
 
    	} catch (SQLException e) {
        	e.printStackTrace();
    	}
	}
 
	public void updateUser(User user) {
    	try {
        	PreparedStatement preparedStatement = connection.prepareStatement("update users set password=?, email=?, registeredon=?"
                	+ "where uname=?");
        	// Parameters start with 1
        	System.out.println(new java.sql.Date(user.getRegisteredon().getTime()));
        	preparedStatement.setString(1, user.getPassword());
        	preparedStatement.setString(2, user.getEmail());
        	preparedStatement.setDate(3, new java.sql.Date(user.getRegisteredon().getTime()));
        	preparedStatement.setString(4, user.getUname());
        	preparedStatement.executeUpdate();
 
    	} catch (SQLException e) {
        	e.printStackTrace();
    	}
	}
 
	public List<User> getAllUsers() {
    	List<User> users = new ArrayList<User>();
    	try {
        	Statement statement = connection.createStatement();
        	ResultSet rs = statement.executeQuery("select * from users");
        	while (rs.next()) {
            	User user = new User();
            	user.setUname(rs.getString("uname"));
            	user.setPassword(rs.getString("password"));
            	user.setEmail(rs.getString("email"));
            	user.setRegisteredon(rs.getDate("registeredon"));
            	users.add(user);
        	}
    	} catch (SQLException e) {
        	e.printStackTrace();
    	}
 
    	this.allusers=users;
    	return users;
	}
 
	public User getUserById(String userId) {
    	User user = new User();
    	try {
        	PreparedStatement preparedStatement = connection.prepareStatement("select * from users where uname=?");
        	preparedStatement.setString(1, userId);
        	ResultSet rs = preparedStatement.executeQuery();
 
        	if (rs.next()) {
            	user.setUname(rs.getString("uname"));
            	user.setPassword(rs.getString("password"));
            	user.setEmail(rs.getString("email"));
            	user.setRegisteredon(rs.getDate("registeredon"));
        	}
    	} catch (SQLException e) {
        	e.printStackTrace();
    	}
 
    	return user;
	}
    
	public boolean isValidUname(String username) {
    	if (username.isEmpty()) {
        	return false;
    	}
    	else {
        	return true;
    	}
	}
}


Στη συνέχεια θα δημιουργήσουμε μια σελίδα για να παρουσιάσουμε τα δεδομένα, ας την πούμε listusers.jsp.

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


Στο συγκεκριμένο κώδικα, αξίζει να σταθούμε σε μερικά σημεία:
Για να δείξουμε τα δεδομένα, χρησιμοποιούμε το userManager bean με τη δήλωση  <jsp:useBean id="users" class="hua.UserManager" scope="session"/>
Κάνουμε Import το <%@page import="hua.User"%>  ούτως ώστε να καλέσουμε τη μέθοδο allUsers της userManager η οποία μας επιστρέφει αντικέιμενα τύπου user
Για να καλέσουμε μια μέθοδο μιας java class, χρησιμοποιούμε την Expression Language, π.χ. <c:set var="users" value="${users.allUsers}" /> είναι σα να δηλώνουμε στη java users=users.allUsers()
Το <c:if test="${not empty param.message}">  το χρησιμοποιούμε για να δείξουμε κάποιο μήνυμα από άλλη σελίδα την οποία την κάνουμε redirect σε αυτή, οπότε ελέγχουμε να δούμε αν υπάρχει κάποιο μήνυμα, το οποίο αποθηκεύεται στη μεταβλητή message.
Για την εμφάνιση του πίνακα χρησιμοποιούμε το bootrtrap και συγκεκριμένα την <table class="table table-striped">
Χρησιμοποιούμε την taglibrary fmt για το formatting της ημερομηνίας
Για κάθε εγγραφή του πίνακα εμγανίζουμε δύο links , το ένα για να μας κάνει edit την εγγραφή και το άλλο για να κάνει delete. Στο συγκεκριμένο παράδειγμα «περνάμε» την παράμετρο της ενέργειας me HTTP query string.   
<a href="user.jsp?action=delete&userid=<c:out value="${user.uname}"/>">Delete</a>. Περνάμε 2 παραμέτρους:action και userid. Αν κάποιος πατήσει το link θα ανακατευθυνθεί στη σελίδα user.jsp έχοντας τις δυο παραμέτρους στη διάθεσή του.

Η σελίδα listusers.jsp θα είναι κάπως έτσι:






Η σελίδα user.jsp είναι μια σελίδα στην οποία είτε θα πάμε πατώντας το action insert, είτε το delete είτε το edit. 
Συνεπώς πρέπει να ελέγξουμε με ποιό action πήγαμε για να εμφανίζουμε το αντίστοιχο output:
Στην περίπτωση του insert μια φόρμα με κενά πεδία για εισαγωγή δεδομένων
Στην περίπτωση του delete να καλέσουμε τη μέθοδο deleteUser του usersManager
Στην περίπτωση του edit να δείξουμε τη φόρμα με τα στοιχεία του χρήστη ώστε να τα αλλάξει. Στο συγκεκριμένο παράδειγμα ένα πεδίο το έχουμε σαν readonly.

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
                        	<input type="text" name="registeredon" id="registeredon" value="<fmt:formatDate pattern="yyyy/MM/dd" value="${user.registeredon}" />" />(yyyy/MM/dd)  <br />
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
  

Αξίζει να σημειώσουμε τα εξής:
Κάνουμε χρήση του <c:choose>  σε συνδυασμό με  <c:when> ούτως ώστε αναλόγως το action να δείξουμε τα αντίστοιχα
Για να κάνουμε πιο έυχρηστη την εφαρμογή χρησιμοποιούμε την jQuery για να εμφανίσουμε ημερολόγιο στο πεδίο registeredon.
Για τη μεταφορά της ημερομηνίας από και προς τη βάση και την εμφάνιση ή αποθήκευσή της πρέπει να ορίσουμε τη μορφή της. Στο συγκεκριμένο παράδειγμα χρησιμοποιήσαμε dateFormat: "yy/mm/dd"


Στην περίπτωση που κάνουμε save μετά από insert action, ανακατευθυνόμαστε στη σελίδα save_user.jsp όπου απλά θέτουμε τις τιμές του user java bean κατάλληλα. Σημειώστε ότι  μπορούμε να κάνουμε validation στα data μας, π.χ. στο συγκεκριμένο παράδειγμα δημιουργήσαμε μια μέθοδο isValidUname() όπου ελέγχει αν είναι άδειο το uname. Θα μπορούσαμε να δημιουργήσουμε οποιαδήποτε validation method και να την καλούμε πριν πάμε να αποθηκεύσουμε δεδομένα.


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



Αντίστοιχα, αν επιλεχθεί η edit action, οδηγούμαστε στη σελίδα update_user.jsp. Εδώ την αποθήκευση την κάνουμε με χρήση scriptlet.


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



αν θέλουμε να δημιουργήσουμε ένα υποτυπώδες μενού, δημιουργούμε μια σελίδα memnu.jsp 

<nav class="navbar navbar-default" role="navigation">
  <div class="container-fluid">
	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
  	<ul class="nav navbar-nav">
    	<li><a href="listusers.jsp">Home</a></li>
    	<li><a href="index.jsp">Show Actors</a></li>
  	</ul>
	</div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>

και την κάνουμε import σε μια άλλη σελίδα.

 <body>
    	<c:import url="menu.jsp">
    	</c:import>










             	



