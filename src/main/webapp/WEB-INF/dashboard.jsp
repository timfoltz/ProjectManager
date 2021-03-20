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
<body >
	<div class="container mt-3">
	<div class="bg-image"
			style="	background-image:url('https://focus.flokk.com/hubfs/Blogs/2021/Zoom%20Meeting%20BAckgrounds/Flokk_Teams-Zoom-Background_work_01.jpg');
					background-repeat: no-repeat;
				    background-attachment: fixed;
				    background-size: cover;
				    min-height: 100vh;
				    background-position: center;">
		<nav class="navbar navbar-expand-lg navbar-light rounded m-3"style="background-color: rgb(67 139 211 / 52%);">
			<div class="container-fluid">
				<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
			      <span class="navbar-toggler-icon"></span>
			    </button>
			    <div class="collapse navbar-collapse" id="navbarNav">
				    <ul class="navbar-nav">
				    	<li class="nav-item">	
							<a class="nav-link active" aria-current="page"  href="/logout">Logout</a>
						</li>
				    	<li class="nav-item">	
							<a class="nav-link active" aria-current="page"  href="/tasks/new">Create Task</a>
						</li>
				    	<li class="nav-item">	
							<a class="nav-link active" aria-current="page"  href="/teams/new">Create Team</a>
						</li>
						
					</ul>
				</div>
				
				<div>
		<p>User:<c:out value="${user.name}" /> Role: <c:out value="${user.roles}"/></p>
		</div>
			</div>
		</nav>
	

	
	<h1 class="display-3" style="text-align: center">Teams</h1>
		<c:forEach items="${teams}" var="team">
			<div class="container text-white p-2 mt-2 rounded text-center" style="background-color: rgb(67 139 211 / 75%); max-width: fit-content; min-width: 50%">
				<h4 class="display-6"><a class="nav-link text-white"  
							href="/teams/${team.id }"><c:out value="${team.name}"/></a><span style="font-size: 15px; font-weight: normal;"> Assigned Tasks:<c:out value="${team.assignedTasks.size()}"/></span><span style="font-size: 15px; font-weight: normal;"> Team Size:<c:out value="${team.teamMembers.size()}"/></span></h4>
				<ul class="list-group list-group-horizontal d-flex justify-content-center">
	
					<c:forEach items="${notSub}" var="task">
						<c:if test="${task.assignedTeam.id == team.id}">
						<li class="list-group-item"style="border: none;background-color: transparent;">
						<c:if test="${task.complete}">
									<div class="progress m-2">
								  		<div class="progress-bar bg-success" 
							  				role="progressbar" 
							  				aria-valuenow="75" 
							  				aria-valuemin="0" 
							  				aria-valuemax="100" 
							  				style="width: 100%">Complete</div>
									</div>
								</c:if>
						<c:if test="${!task.complete}">	
							<div class="progress m-2 bg-warning">
							  <div class="progress-bar bg-success" 
						  				role="progressbar" 
						  				aria-valuenow="75" 
						  				aria-valuemin="0" 
						  				aria-valuemax="100" 
						  				style="width: <c:out value='${Math.round(task.numComplete/task.subTasks.size()*100)}%'></c:out>"><c:out value='${Math.round(task.numComplete/task.subTasks.size()*100)}%'/></div>
							</div>
							</c:if>
							
							<c:if test="${task.subTaskFor == null}">
							
								<a class="list-group-item list-group-item-action text-white" 
									style="border-radius: 10px;  background-color:rgb(67 139 211 / 80%); text-align: center" 
									href="/tasks/${task.id }"> 
									<c:out value="${task.name }"/>
								</a>
							</c:if>
							<c:if test="${task.subTasks.size() > 0 }">
								<ul class="list-unstyled">
									<c:forEach items="${task.subTasks}" var="s">
										<c:if test="${s.complete}">
											<li><del><c:out value="${s.name}"/></del>
										</c:if>
										<c:if test="${!s.complete}">
											<li><c:out value="${s.name}"/>
										</c:if>
									</c:forEach>
								</ul>
							</c:if>
							<c:if test="${task.subTasks.size() < 1 }">
								<ul class="list-unstyled">
									<li>NONE</li>
								</ul>
							</c:if>
						</li>
						</c:if>
					</c:forEach>
					
				</ul>
			</div>
		</c:forEach>
		</div>
	</div>


	
</body>
</html>