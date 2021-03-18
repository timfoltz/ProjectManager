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
<div class="container mt-2">
	<nav class="navbar navbar-expand-lg navbar-light bg-success rounded">
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
	<p>Assigned to team:
		
			<c:if test="${thisUser.assignedTeam != null}">  
				<c:out value="${thisUser.assignedTeam.name}"/> 
			</c:if>
			<c:if test="${thisUser.assignedTeam == null}">  
				Not Assigned 
			</c:if>
				<c:if test="${user.roles.equalsIgnoreCase('admin') || user.roles.equalsIgnoreCase('lead')}">
					<c:if test="${thisUser.assignedTeam.id!=null}">
					<a href="/offTeam/${thisUser.id}/${thisUser.assignedTeam.id}">Remove</a>
					</c:if>
					<c:if test="${thisUser.assignedTeam.id==null}">
						<form method="POST" action="/manage/fromuser">
					       	<input type="hidden" name="_method" value="put">
					       	<input type="hidden" name="user" value="${thisUser.id}">
					        <p>Assign to team:
					            <select name="team">
							        <c:forEach items="${allTeams}" var="t">
							        	<option value="${t.id}"><c:out value="${t.name}"/></option>
							        </c:forEach>
			 			       </select>
				       		</p>
				        	<input type="submit" value="Add"/>
			    		</form>
						
					</c:if>
				</c:if></p>
	<h3>Assigned Tasks:</h3>
	<div class="container bg-success  p-2 mt-2 rounded text-center">
	<ul class="list-group list-group d-flex justify-content-center">
		<c:forEach items="${thisUser.assignedToTask}" var="task">
			<li class="list-group-item bg-warning">
				<a class="list-group-item text-white list-group-item-action bg-secondary" 
					style="max-width: 300px; border-radius: 10px" 
					href="/tasks/${task.id }"> 
					<c:out value="${task.name}"/>
				</a>
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
			
		</c:forEach>
		</ul>
	</div>
	</div>
</body>
</html>