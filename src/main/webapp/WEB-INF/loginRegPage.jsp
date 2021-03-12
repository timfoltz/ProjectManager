<%@ page isErrorPage="true" %>    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>

    <meta charset="UTF-8">
    <title>Login Page</title>
</head>
<body>
	<div class="container">
		<div class="row"> 
		    <div class="col-sm-3 mt-4 p-5 mx-auto">
		    <div class="card text-white bg-secondary">
		    <div class="card-body">
		    <p class="card-title display-4">Login</p>
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
		        <input type="submit" class="btn btn-primary" value="Login!"/>
		    </form>
		    </div>
		    </div>
		    </div>
		    </div>
		    <div class="row "> 
		    <div class="col-lg-3 mt-2 p-5 mx-auto">
		    <div class="card text-white bg-secondary">
		    <div class="card-body">
		    <p class="card-title display-4">Register</p>
		    
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
		        <input type="submit" class="btn btn-primary" value="Register!"/>
		    </form:form>
		    </div>
		    </div>
		    </div>
	    </div>
    </div>   
</body>
</html>