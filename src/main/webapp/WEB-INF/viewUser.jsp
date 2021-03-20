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
<title><c:out value="${thisUser.name}"></c:out> </title>
</head>
<body>
<div class="container mt-2" style="min-height:100vh;">
<div class="bg-image"
			style="	background-image:url('https://focus.flokk.com/hubfs/Blogs/2021/Zoom%20Meeting%20BAckgrounds/Flokk_Teams-Zoom-Background_work_01.jpg');
					background-repeat: no-repeat;
				    background-attachment: fixed;
				    background-size: cover;
				    min-height:100vh;
				    background-position: center;">
	<nav class="navbar navbar-expand-lg navbar-light rounded" style="background-color: rgb(67 139 211 / 52%);">
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
						<a class="nav-link active" aria-current="page"  href="/teams/${thisUser.assignedTeam.id}">Team <c:out value="${thisUser.assignedTeam.name}"></c:out> </a>
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
	<h1><c:out value="${thisUser.name}"/></h1>
	<h3>Assigned Tasks:</h3>
	<div class="container  p-2 mt-2 rounded text-center" style="background-color: transparent; max-width: fit-content; min-width: 50%">
	<ul class="list-group list-group d-flex justify-content-center">
		<c:forEach items="${thisUser.assignedToTask}" var="task">
			<li style="<c:if test="${task.complete}">background-color:rgb(32 117 32 / 36%);</c:if><c:if test="${!task.complete}">background-color:rgb(150 13 16 / 40%);</c:if>" class="m-3 list-group-item rounded  ">
				<a class="list-group-item text-white list-group-item-action" 
						style="border-radius: 10px;  background-color:rgb(67 139 211 / 80%); text-align: center" 
						href="/tasks/${task.id }"> 
						<c:out value="${task.name}"/>
					</a>
				<c:if test="${task.complete}">
					<div class="progress m-2">
							  <div class="progress-bar progress-bar" 
						  				role="progressbar" 
						  				aria-valuenow="75" 
						  				aria-valuemin="0" 
						  				aria-valuemax="100" 
						  				style="width: 100%;
						  				background-color:rgb(67 139 211 / 80%)">Complete</div>
							</div>
					</c:if>
					<c:if test="${!task.complete}">
						<div class="progress m-2">
							  <div class="progress-bar progress-bar" 
					  				role="progressbar" 
					  				aria-valuenow="75" 
					  				aria-valuemin="0" 
					  				aria-valuemax="100" 
					  				style=" width: <c:out value='${Math.round(task.numComplete/task.subTasks.size()*100)}%;'></c:out>
					  				background-color:rgb(67 139 211 / 80%)">
					  				<c:out value='${Math.round(task.numComplete/task.subTasks.size()*100)}%'/>
					  				</div>
								</div>
							</c:if>
				<c:if test="${task.subTasks.size() > 0 }">
								<ul class="list-unstyled">
									<c:forEach items="${task.subTasks}" var="s">
										<c:if test="${s.complete}">
											<li style="font-weight:bold; text-shadow: 0px 0px 20px white"><del><c:out value="${s.name}"/></del>
										</c:if>
										<c:if test="${!s.complete}">
											<li style="font-weight:bold; text-shadow: 0px 0px 20px white"><c:out value="${s.name}"/>
										</c:if>
									</c:forEach>
								</ul>
							</c:if>
							<c:if test="${task.subTasks.size() < 1 }">
								<ul class="list-unstyled">
									<li style="font-weight:bold; text-shadow: 0px 0px 20px white">NONE</li>
								</ul>
							</c:if>
						</li>
			
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>