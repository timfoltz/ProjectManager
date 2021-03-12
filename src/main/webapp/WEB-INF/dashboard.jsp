<%@ page isErrorPage="true" %>    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>

<title>Dashboard</title>
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
						<a class="nav-link active" aria-current="page"  href="/logout">Logout</a>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	<h1><c:out value="${user.name}" /></h1>
	<a class="list-group-item list-group-item-action" style="width: 130px; border-radius: 10px"href="/tasks/new">Create Task</a> 
	<a class="list-group-item list-group-item-action" style="width: 130px; border-radius: 10px" href="/teams/new">Create Team</a>
	
	
	<h2>Teams</h2>
			<c:forEach items="${teams}" var="team">
			<h4><a class="list-group-item-action" 
						style="max-width: 300px; border-radius: 10px" 
						href="/teams/${team.id }"><c:out value="${team.name}"/></a><span style="font-size: 15px; font-weight: normal;"> Assigned Tasks:<c:out value="${team.assignedTasks.size()}"/></span><span style="font-size: 15px; font-weight: normal;"> Team Size:<c:out value="${team.teamMembers.size()}"/></span></h4>
			<ul class="list-group">

				<c:forEach items="${team.assignedTasks}" var="task">
				<li class="list-group-item">
				<c:if test="${task.subTaskFor == null}">
					<a class="list-group-item list-group-item-action" 
						style="max-width: 300px; border-radius: 10px" 
						href="/tasks/${task.id }"> 
						<c:out value="${task.name }"/>
					</a>
					</c:if>
						<ul>
							<c:forEach items="${task.subTasks}" var="s">
								<li><c:out value="${s.name}"/>
							</c:forEach>
						</ul>
				</li>
				</c:forEach>
			</ul>
			</c:forEach>
	
<!-- 	<table class="table table-hover"> -->
<!-- 		<thead> -->
<!-- 			<tr> -->
<!-- 				<th scope="col">Name</th> -->
<!-- 				<th scope="col">Creator</th> -->
<!-- 				<th scope="col">Creator ID</th> -->
<!-- 				<th scope="col">Assigned Team</th> -->
<!-- 				<th scope="col">Priority</th> -->
<!-- 			</tr> -->
<!-- 		</thead> -->
<!-- 		<tbody> -->
<%-- 			<c:forEach items="${allTasks}" var="task"> --%>
<!-- 				<tr> -->
<%-- 					<td> <a class="list-group-item list-group-item-action" style="max-width: 300px; border-radius: 10px" href="/tasks/${task.id }"> <c:out value="${task.name }"/></a></td> --%>
<%-- 					<td><c:out value="${task.creator.name}"/></td> --%>
<%-- 					<td><c:out value="${task.creator.id}"/></td> --%>
<%-- 					<td><c:out value="${task.assignedTeam.name}"/></td> --%>
<%-- 					<c:if test="${task.priority == 1}"> --%>
<!-- 						<td>Low</td> -->
<%-- 					</c:if> --%>
<%-- 					<c:if test="${task.priority == 5}"> --%>
<!-- 						<td>Medium</td> -->
<%-- 					</c:if> --%>
<%-- 					<c:if test="${task.priority == 9}"> --%>
<!-- 						<td>High</td> -->
<%-- 					</c:if> --%>
<!-- 				</tr> -->
<%-- 			</c:forEach> --%>
<!-- 		</tbody> -->
<!-- 	</table> -->

	
</body>
</html>