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
	
	@GetMapping("tasks/{id}")
	public String viewTask(@PathVariable("id")Long taskId, HttpSession session, Model model) {
		Long id = (Long)session.getAttribute("userId");
		if(id !=null) {
			Task thisTask = taskService.findTask(taskId);
			User thisUser = userService.findUserById(id);
			model.addAttribute("user", thisUser);
			model.addAttribute("thisTask", thisTask);
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
		System.out.println(id);
		System.out.println(taskId);
		
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
			System.out.println(result);
			return "editTask.jsp";
		}else{
			taskService.editTask(task);
			return "redirect:/tasks/"+taskId;
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
//		Long id = (Long)session.getAttribute("userId");
//		Task thisTask = taskService.findTask(taskId);
		
			taskService.deleteTask(taskId);
			return "redirect:/dashboard";
		
	}
	
}
