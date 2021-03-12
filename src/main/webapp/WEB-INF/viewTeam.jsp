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
<title>Team <c:out value="${thisTeam.name}"></c:out> </title>
</head>
<body style="background-color: rgb(214 214 214)">
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
		      <span class="navbar-toggler-icon"></span>
		    </button>
		    <div class="collapse navbar-collapse" id="navbarNav">
			    <ul class="navbar-nav">
			    	<li class="nav-item">	
						<a class="nav-link active" aria-current="page"  href="/dashboard">Dashboard</a>
					</li>
					
				</ul>
			</div>
		</div>
	</nav>
	<h1>Team: <c:out value="${thisTeam.name}"/></h1><a class="list-group-item-action" 
						style="max-width: 300px; border-radius: 10px" 
						href="/manage/${thisTeam.id }">Manage Team</a>
	<h3>Assigned to team:</h3>
	<ul class="list-group">
		<c:forEach items="${thisTeam.teamMembers}" var="tm">
			<li class="list-group-item">
				<a class="list-group-item list-group-item-action" 
					style="max-width: 300px; border-radius: 10px" 
					href="/users/${tm.id }"> 
					<c:out value="${tm.name}"/>
				</a>
			</li>
		</c:forEach>
	</ul>
	<h3>Tasks for the team:</h3>
	<ul class="list-group">
		<c:forEach items="${thisTeam.assignedTasks}" var="task">
			<c:if test="${task.subTaskFor ==null }">
				<li class="list-group-item">
					<a class="list-group-item list-group-item-action" 
						style="max-width: 300px; border-radius: 10px" 
						href="/tasks/${task.id }"> 
						<c:out value="${task.name}"/>
					</a>
						<ul>
							<c:forEach items="${task.subTasks}" var="s">
								<li><c:out value="${s.name}"/>
							</c:forEach>
						</ul>
				</li>
				</c:if>
		</c:forEach>
	</ul>
	

		 
	
						 
	
</body>
</html>