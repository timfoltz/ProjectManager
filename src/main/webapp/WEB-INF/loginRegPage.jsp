<%@ page isErrorPage="true" %>    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
</head>
<body>
	<div style = "display:flex; justify-content: space-evenly;">
		<div>
		    <h1>Login</h1>
		    <p style="color:red;"><c:out value="${error}" /></p>
		    <form method="post" action="/login">
		        <p>
		            <label for="email">Email</label>
		            <input required type="text" id="email" name="email"/>
		        </p>
		        <p>
		            <label for="password">Password</label>
		            <input required type="password" id="password" name="password"/>
		        </p>
		        <input type="submit" value="Login!"/>
		    </form>
		    </div>
		    <div> 
		    <h1>Register!</h1>
		    
		    <p style="color:red;"><form:errors path="user.*"/></p>
		    
		    <form:form method="POST" action="/registration" modelAttribute="user">
		        
		        <p>
		            <form:label path="name">Name:</form:label>
		            <form:input required="true" type="text" path="name"/>
		        </p>
		        <p>
		            <form:label path="email">Email:</form:label>
		            <form:input required="true" type="email" path="email"/>
		        </p>
		        
		        <p>
		            <form:label path="password">Password:</form:label>
		            <form:password required="true" path="password"/>
		        </p>
		        <p>
		            <form:label path="passwordConfirmation">Password Confirmation:</form:label>
		            <form:password required="true" path="passwordConfirmation"/>
		        </p>
		        <input type="submit" value="Register!"/>
		    </form:form>
	    </div>
    </div>   
</body>
</html>