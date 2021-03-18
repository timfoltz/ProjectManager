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
<title>Task <c:out value="${thisTask.name}"></c:out> </title>
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
					<li class="nav-item">
						<a class="nav-link active"
							aria-current="page"  
							href="/teams/${thisTask.assignedTeam.id}">
							Assigned Team: 
							<c:out value="${thisTask.assignedTeam.name}"/>
							</a>
					</li>
				</ul>
			</div>
			<div>
					<p>User:<c:out value="${user.name}" /> Role: <c:out value="${user.roles}"/></p>
				</div>
		</div>
	</nav>
	<h1>Task: <c:out value="${thisTask.name}"/></h1>
	
	<p>Creator:    <c:out value="${thisTask.creator.name}"/></p>
	
	<c:forEach items="${thisTask.assignee}" var="a">
		<p>Assignee: <c:out value="${a.name}"/></p>
	</c:forEach>
	<p>Priority: <c:if test="${thisTask.priority == 1}">
						<td>Low</td>
					</c:if>
					<c:if test="${thisTask.priority == 5}">
						<td>Medium</td>
					</c:if>
					<c:if test="${thisTask.priority == 9}">
						<td>High</td>
					</c:if>
	
	 <c:if test="${user.id == thisTask.creator.id}">
		  <a href="/tasks/${thisTask.id}/edit">Edit</a> |  
		 <c:if test="${thisTask.subTasks ==null}">
		 <form action="/deleteTask/${thisTask.id }" method="POST">
	 	<input type="hidden" name="_method" value="delete"> 
		 <input type="submit" value="Delete"> </form>
		 </c:if>
		 
	 </c:if>
	 <c:if test="${thisTask.assignee.contains(user)}">
	 <c:if test="${!thisTask.complete}">
	 	<c:if test="${thisTask.subTasks.size()<1}">
	   		<a href="/completed/${thisTask.id }">Complete</a>
	   	</c:if>
	   	</c:if>
	 </c:if>
	 <c:if test="${thisTask.complete}">
		 COMPLETE
	 </c:if>
	 <c:if test="${user.roles.equalsIgnoreCase('admin')}">
	 	<c:if test="${!thisTask.complete}">
	   		<a href="/completed/${thisTask.id }">Complete</a>
	   	</c:if>
   	</c:if>
 	<h3>Associated subtasks</h3>
 	<c:if test="${thisTask.subTasks.size() <1}">
	 	<p>NONE ASSIGNED</p>
	</c:if>	
	<c:if test="${thisTask.subTasks.size() >0}">
		 <table class="table table-hover">
			<thead>
				<tr>
					<th scope="col">Name</th>
					<th scope="col">Creator</th>
					<th scope="col">Assigned TeamMember</th>
					<th scope="col">Priority</th>
					<th scope="col">Complete</th>
				</tr>
			</thead>
	 
			<tbody>
				<c:forEach items="${subTasks}" var="task">
					<tr>
						<td> <a class="list-group-item list-group-item-action" 
								style="max-width: 300px; border-radius: 10px" 
								href="/tasks/${task.id }"> <c:out value="${task.name }"/>
							 </a>
							 <ul>
							<c:forEach items="${task.subTasks}" var="s">
								<li><c:out value="${s.name}"/>
							</c:forEach>
						</ul>
						</td>
						<td><c:out value="${task.creator.name}"/></td>
							<c:if test="${task.assignee.size()<1}">
								<td>Not Assigned</td>
							</c:if>
							
								<c:forEach items="${task.assignee}" var="a">
										<td><c:out value="${a.name}"/></td>
								</c:forEach>
						<c:if test="${task.priority == 1}">
							<td>Low</td>
						</c:if>
						<c:if test="${task.priority == 5}">
							<td>Medium</td>
						</c:if>
						<c:if test="${task.priority == 9}">
							<td>High</td>
						</c:if>
						<td>
							<c:if test="${!task.complete}">
							In progress
							</c:if>
							<c:if test="${task.complete}">
							COMPLETE
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
	
	
	</table>
	</c:if>
	 <c:if test="${!thisTask.complete}">
	 <h3>Add a new SUBTASK for this task</h3>
	<form:form method="POST" action="/subtask/new" modelAttribute="task">
	 <form:input type="hidden" value="${user.id}" path="creator"/>
	 <form:input type="hidden" value="${thisTask.id}" path="subTaskFor"/>
	 <form:input type="hidden" value="${thisTask.assignedTeam.id}" path="assignedTeam"/>
		        <p>
		            <form:label path="name">Name:</form:label>
		            <form:input required="true" type="text" path="name"/>
		        </p>
		        
		        <p>Priority: 
		            <select name="priority">
		            	<option value ="9">High</option>
		            	<option value ="5">Medium</option>
		            	<option value ="1">Low</option>
		            </select>
		        </p>
		        
		        <input type="submit" class="btn btn-outline-primary" value="Add"/>
		    </form:form>
	    </c:if>
	     <c:if test="${thisTask.complete}">
		 <h1 class="display-1">This Task is Complete</h1>
		 <p>No other task can be assigned</p>
	 </c:if>
		 
	
						 
	
</body>
</html>