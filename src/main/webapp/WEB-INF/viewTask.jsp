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
						<a class="nav-link active" aria-current="page"  href="/teams/${thisTask.assignedTeam.id}">Team <c:out value="${thisTask.assignedTeam.name}"></c:out> </a>
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
	<h1 class="mt-3 rounded" style="max-width:fit-content; background-color: rgb(67 139 211 / 52%)"><c:out value="${thisTask.name}"/></h1>
	

	<c:forEach items="${thisTask.assignee}" var="a">
		<p>Assigned to: <c:out value="${a.name}"/></p>
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
   	<div class="container  p-2 mt-2 rounded text-center" style="background-color: transparent; max-width: fit-content; min-width: 50%; border-radius: 5px;">
 	<h3>Associated subtasks</h3>
 	<c:if test="${thisTask.subTasks.size() <1}">
	 	<p>NONE ASSIGNED</p>
	</c:if>	
	<c:if test="${thisTask.subTasks.size() >0}">
		 <table class="table table-hover rounded">
			<thead>
				<tr style="background-color: rgb(67 139 211 / 52%);">
					<th scope="col">Name</th>
					<th scope="col">Assigned TeamMember</th>
					<th scope="col">Priority</th>
					<th scope="col">Complete</th>
				</tr>
			</thead>
	 
			<tbody style="text-shadow: 0px 0px 20px white; font-weight: bold">
				<c:forEach items="${subTasks}" var="task">
					<tr style="margin:3px; <c:if test="${task.complete}">background-color:rgb(32 117 32 / 60%);</c:if><c:if test="${!task.complete}">background-color:rgb(150 13 16 / 60%);</c:if>">
						<td> <a class="list-group-item list-group-item-action text-white" 
								style="border-radius: 10px;  background-color:rgb(67 139 211 / 80%); text-align: center" 
								href="/tasks/${task.id }"> <c:out value="${task.name }"/>
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
							 <ul class="list-unstyled">
							<c:forEach items="${task.subTasks}" var="s">
								<li><c:out value="${s.name}"/>
							</c:forEach>
						</ul>
						</td>
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
			</div>
	
	
	</table>
	</c:if>
	 <c:if test="${!thisTask.complete}">
	 <h3>Add a new SUBTASK for this task</h3>
	 <div class="d-flex justify-content-center">
	<form:form method="POST" action="/subtask/new" modelAttribute="task">
	 <form:input type="hidden" value="${user.id}" path="creator"/>
	 <form:input type="hidden" value="${thisTask.id}" path="subTaskFor"/>
	 <form:input type="hidden" value="${thisTask.assignedTeam.id}" path="assignedTeam"/>
		        <p>
		            <form:input placeholder="Name" 
		            			aria-label=".form-control-lg example" 
		            			required="true"  
		            			type="text" 
		            			path="name"
		            			style="border-radius:5px; border:none;padding:4px;" />
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
	        				value="Add"/>
		    </form:form>
		    </c:if>
		    <div class="rounded" style="background-color:rgb(32 117 32 / 75%);" >
		     <c:if test="${thisTask.complete}">
				 <h1 class="display-1" style="">This Task is Complete</h1>
				 <p>No other task can be assigned</p>
		 	</c:if>
		    </div>
		 
			</div>
		</div>				 
	</div>
</body>
</html>