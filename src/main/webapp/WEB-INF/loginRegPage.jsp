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
    <title>Get it done</title>
</head>
<body>
	<div class="container">
	<div class="bg-image p-3"
			style="	background-image:url('https://focus.flokk.com/hubfs/Blogs/2021/Zoom%20Meeting%20BAckgrounds/Flokk_Teams-Zoom-Background_work_01.jpg');
					background-repeat: no-repeat;
				    background-attachment: fixed;
				    background-size: cover;
				    height:100vh;
				    background-position: center;">
		<h1 class="display-1 text-center" style="text-shadow: 1px 1px 1px gray; font-weight: 400;" >Get it done!</h1>
		<div class="row"> 
		    <div class="col-lg-4 mt-4 p-5 mx-auto">
		    <div style="background-color: rgb(67 139 211 / 52%)" class="card">
		    <div class="card-body">
		    <p class="card-title display-4">Login</p>
		    <p style="color:red;"><c:out value="${error}" /></p>
		    <form method="post" action="/login">
		        <p>
		            <input class="form-control"  
		            		placeholder="Email" 
		            		aria-label=".form-control-lg example"
		            		required 
		            		type="text" 
		            		id="email" 
		            		name="email"/>
		        </p>
		        <p>
		            <input class="form-control"  
		            		placeholder="Password" 
		            		aria-label=".form-control-lg example" 
		            		required 
		            		type="password" 
		            		id="password" 
		            		name="password"/>
		        </p>
		        <input style="background-color: rgb(32 61 43)" type="submit" class="btn text-white" value="Login!"/>
		    </form>
		    </div>
		    </div>
		    </div>
		    </div>
		    <div class="row "> 
		    <div class="col-lg-4 mt-2 p-5 mx-auto">
		    <div style="background-color: rgb(67 139 211 / 52%)" class="card">
		    <div class="card-body">
		    <p class="card-title display-4">Register</p>
		    
		    <p style="color:red;"><form:errors path="user.*"/></p>
		    
		    <form:form method="POST" action="/registration" modelAttribute="user">
		        
		        <p>
		            <form:input class="form-control" 
		            			required="true" 
		            			type="text" 
		            			path="name"
		            			placeholder="Name" 
		            			aria-label=".form-control-lg example"/>
		        </p>
		        <p>
		            <form:input class="form-control" 
		            			required="true" 
		            			type="email" 
		            			path="email"
		            			placeholder="Email" 
		            			aria-label=".form-control-lg example"/>
		        </p>
		        
		        <p>
		            <form:password class="form-control" 
		            				required="true" 
		            				path="password"
		            				placeholder="Password" 
		            				aria-label=".form-control-lg example"/>
		        </p>
		        <p>
		            <form:password class="form-control" 
		            				required="true" 
		            				path="passwordConfirmation"
		            				placeholder="Password" 
		            				aria-label=".form-control-lg example"/>
		        </p>
		        <input type="submit" class="btn text-white" value="Register!" style="background-color: rgb(32 61 43)"/>
		    </form:form>
		    </div>
		    </div>
		    </div>
	    </div>
	    </div>
    </div>   
</body>
</html>