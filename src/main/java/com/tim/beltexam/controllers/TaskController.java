package com.tim.beltexam.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;

import com.tim.beltexam.models.Task;
import com.tim.beltexam.models.Team;
import com.tim.beltexam.models.User;
import com.tim.beltexam.repos.UserRepo;
import com.tim.beltexam.services.TaskService;
import com.tim.beltexam.services.TeamService;
import com.tim.beltexam.services.UserService;

@Controller
public class TaskController {

	@Autowired
	private UserService userService;
	@Autowired
	private UserRepo userRepo;
	
	@Autowired
	private TaskService taskService;
	
	@Autowired
	private TeamService teamService;
	
	
	
	
	@PostMapping("tasks/new")
	public String addNewTask(@Valid @ModelAttribute("task")Task task,
			BindingResult result,
			HttpSession session, 
			Model model) {
		Long id = (Long)session.getAttribute("userId");
		
		if(result.hasErrors()) {
			List<User> allUsers = userService.findAll();
			User thisUser = userService.findUserById(id);
			List<Team> allTeams = teamService.allTeams();
			model.addAttribute("user", thisUser);
			model.addAttribute("allUsers", allUsers);
			model.addAttribute("teams", allTeams);
			return "newTask.jsp";
			
		} else{
			taskService.createTask(task);
			return "redirect:/dashboard";
		}
	
	}
	@PostMapping("subtask/new")
	public String newSubTask(@Valid @ModelAttribute("subtask")Task subtask,
			BindingResult result,
			HttpSession session, 
			Model model) {
		Long id = (Long)session.getAttribute("userId");
		
		if(result.hasErrors()) {
			List<User> allUsers = userService.findAll();
			User thisUser = userService.findUserById(id);
			List<Team> allTeams = teamService.allTeams();
			model.addAttribute("user", thisUser);
			model.addAttribute("allUsers", allUsers);
			model.addAttribute("teams", allTeams);
			return "viewTask.jsp";
		}else{
			taskService.createTask(subtask);
			Long taskId = subtask.getSubTaskFor().getId();
			return "redirect:/tasks/"+taskId;
		}
	}
	
	@GetMapping("tasks/{id}")
	public String viewTask(@ModelAttribute("task")Task task,
							@PathVariable("id")Long taskId, 
							HttpSession session, 
							Model model) {
		Long id = (Long)session.getAttribute("userId");
		if(id !=null) {
			Task thisTask = taskService.findTask(taskId);
			User thisUser = userService.findUserById(id);
			List<Task> subTasks = thisTask.getSubTasks();
			model.addAttribute("user", thisUser);
			model.addAttribute("thisTask", thisTask);
			model.addAttribute("subTasks", subTasks);
			return "viewTask.jsp";
		}return "redirect:/";
	}
	
	@GetMapping("tasks/new")
	public String newTask(@ModelAttribute("task")Task task, 
							HttpSession session, 
							Model model) {
		Long id = (Long)session.getAttribute("userId");
		
		if(id !=null) {
			List<User> allUsers = userService.findAll();
			User thisUser = userService.findUserById(id);
			List<Team> allTeams = teamService.allTeams();
			model.addAttribute("user", thisUser);
			model.addAttribute("allUsers", allUsers);
			model.addAttribute("teams", allTeams);
			return "newTask.jsp";
		}return "redirect:/";
	}
	
	
	@GetMapping("/tasks/{id}/edit")
	public String editTaskForm(
							@PathVariable("id") Long taskId,
							HttpSession session,
							Model model) {
		
		Long id = (Long)session.getAttribute("userId");
		Task thisTask = taskService.findTask(taskId);
		Team thisTeam = thisTask.getAssignedTeam();
		List<Team> allTeams = teamService.allTeams();
		
		
		if(id.equals(thisTask.getCreator().getId())) {
			List<User> allUsers = userService.findAll();
			User thisUser = userService.findUserById(id);
			
			model.addAttribute("thisTask", thisTask);
			model.addAttribute("user", thisUser);
			model.addAttribute("thisTeam", thisTeam);
			model.addAttribute("allTeams", allTeams);
			return "editTask.jsp";
		}return "redirect:/dashboard";
	}
	
	@PutMapping("/tasks/{id}")
	public String editTaskSubmit(@Valid
			@ModelAttribute("thisTask")Task task,
			BindingResult result,
			@PathVariable("id") Long taskId,
			HttpSession session,
			Model model) {
		Long id = (Long)session.getAttribute("userId");
		Task thisTask = taskService.findTask(taskId);
		Team thisTeam = thisTask.getAssignedTeam();
		List<Team> allTeams = teamService.allTeams();
		
		if(result.hasErrors()) {
			List<User> allUsers = userService.findAll();
			User thisUser = userService.findUserById(id);
			model.addAttribute("thisTask", thisTask);
			model.addAttribute("user", thisUser);
			model.addAttribute("thisTeam", thisTeam);
			model.addAttribute("allTeams", allTeams);
			return "editTask.jsp";
		}else{
			taskService.editTask(task);
			return "redirect:/teams/"+thisTeam.getId();
		}
	}
	
	@DeleteMapping("/deleteTask/{id}")
	public String deleteTask(
								@PathVariable("id")Long taskId,
								HttpSession session
			) {
		Long id = (Long)session.getAttribute("userId");
		Task thisTask = taskService.findTask(taskId);
		if(id.equals(thisTask.getCreator().getId())) {
			taskService.deleteTask(taskId);
		}return "redirect:/dashboard";
	}
	
	@GetMapping("/completed/{id}")
	public String completed(@PathVariable("id")Long taskId, HttpSession session) {
		Task thisTask = taskService.findTask(taskId);
		if(thisTask.getSubTaskFor()==null) {
			thisTask.setComplete(true);
			taskService.editTask(thisTask);
			return "redirect:/dashboard";
		}else {
		Task parent = taskService.findTask(thisTask.getSubTaskFor().getId());
		thisTask.setComplete(true);
		parent.setNumComplete(parent.getNumComplete()+1);
		taskService.editTask(thisTask);
		return "redirect:/dashboard";
		}
		
	}
	
}
