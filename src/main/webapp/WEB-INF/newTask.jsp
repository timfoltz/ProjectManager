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

<meta charset="ISO-8859-1">
<title>Add new Task</title>
</head>
<body>
<div class="container mt-3">
<div class="bg-image p-3"
			style="	background-image:url('https://focus.flokk.com/hubfs/Blogs/2021/Zoom%20Meeting%20BAckgrounds/Flokk_Teams-Zoom-Background_work_01.jpg');
					background-repeat: no-repeat;
				    background-attachment: fixed;
				    background-size: cover;
				    min-height: 100vh;
				    background-position: center;">
		    <nav class="navbar 
		    			navbar-expand-lg 
		    			navbar-light 
		    			rounded 
		    			m-3"style="background-color: rgb(67 139 211 / 52%);">
			<div class="container-fluid">
				<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
			      <span class="navbar-toggler-icon"></span>
			    </button>
			    <div class="collapse navbar-collapse" id="navbarNav">
				    <ul class="navbar-nav">
				    	
				    	<li class="nav-item">	
							<a class="nav-link active" aria-current="page"  href="/dashboard">Dashboard</a>
						</li>
						<li class="nav-item">	
							<a class="nav-link active" aria-current="page"  href="/logout">Logout</a>
						</li>
					</ul>
				</div>
				<div>
					<p>User:<c:out value="${user.name}" /> Role: <c:out value="${user.roles}"/></p>
				</div>
			</div>
		</nav>
		<div >
<h1 style="text-align: center;">Create a new task</h1>
	<div class="d-flex justify-content-center">
		<form:form 	class="p-3" 
					method="POST" 
					action="/tasks/new" 
					modelAttribute="task" 
					style=	"background-color: rgb(67 139 211 / 52%);
							border-radius: 5px;">
		 	<form:input type="hidden" value="${user.id}" path="creator"/>
		        <p>
		           	
		            <form:input class="form-control"
		            			placeholder="Name" 
		            			aria-label=".form-control-lg example" 
		            			required="true" 
		            			type="text" 
		            			path="name"
		            			style="border-radius:5px; border:none;padding:4px;" />
		        </p>
		        <p>
		            <select class="form-select" 
		            		aria-label="Default select example"
		            		name="assignedTeam">
		            		<option selected>Assigned team</option>
				        <c:forEach items="${teams}" var="team">
				        	<option value="${team.id}"><c:out value="${team.name }"/></option>
				        </c:forEach>
			       </select>
		        </p>
		        <p>
		            <select class="form-select" 
		            		aria-label="Default select example" 
		            		name="priority"
		            		style="max-width: fit-content;">
		            		<option selected>Priority</option>
		            	<option value ="9">High</option>
		            	<option value ="5">Medium</option>
		            	<option value ="1">Low</option>
		            </select>
		        </p>
			        
		        <input style="border-radius: 10px; 
	        				background-color:rgb(67 139 211 / 80%); 
	        				text-align: center" 
	        				type="submit" 
	        				class="btn text-white" 
	        				value="Create"/>
	    </form:form>
	    </div>
    </div>
    </div>
    </div>
		    
</body>
</html>