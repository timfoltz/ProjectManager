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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.tim.beltexam.models.Task;
import com.tim.beltexam.models.Team;
import com.tim.beltexam.models.User;
import com.tim.beltexam.repos.UserRepo;
import com.tim.beltexam.services.TaskService;
import com.tim.beltexam.services.TeamService;
import com.tim.beltexam.services.UserService;

@Controller
public class MainController {
	
	@Autowired
	private UserService userService;
	@Autowired
	private UserRepo userRepo;
	
	@Autowired
	private TaskService taskService;
	
	@Autowired
	private TeamService teamService;
	
	@RequestMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
    	Long id = (Long) session.getAttribute("userId");
    	if(id != null) {
    		List<Task> allTasks = taskService.allTasks();
    		User thisUser = userService.findUserById(id);
    		List<Team> allTeams = teamService.allTeams();
    		model.addAttribute("teams", allTeams);
    		model.addAttribute("user", thisUser);
    		model.addAttribute("allTasks", allTasks);
    		return "dashboard.jsp";
    	} else {
    		return "redirect:/";
    	}
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
		@GetMapping("teams/new")
		public String newTeam(@ModelAttribute("team")Team team, 
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
				return "newTeam.jsp";
			}return "redirect:/";
		}
		@PostMapping("teams/new")
		public String addNewTeam(@Valid @ModelAttribute("team")Team team,
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
				return "newTeam.jsp";
				
			} else{
				teamService.createTeam(team);
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
	@GetMapping("teams/{id}")
	public String viewTeam(@PathVariable("id")Long teamId, HttpSession session, Model model) {
		Long id = (Long)session.getAttribute("userId");
		if(id !=null) {
			Team thisTeam = teamService.findTeam(teamId);
			User thisUser = userService.findUserById(id);
			model.addAttribute("user", thisUser);
			model.addAttribute("thisTeam", thisTeam);
			return "viewTeam.jsp";
		}return "redirect:/";
	}
	@GetMapping("manage/{id}")
	public String manageTeam(@PathVariable("id")Long teamId, HttpSession session, Model model) {
		Long id = (Long)session.getAttribute("userId");
		if(id !=null) {
			Team thisTeam = teamService.findTeam(teamId);
			User thisUser = userService.findUserById(id);
			List<User> allUsers = userService.findAll();
			
			model.addAttribute("allUsers", allUsers);
			model.addAttribute("user", thisUser);
			model.addAttribute("thisTeam", thisTeam);
			return "manageTeam.jsp";
		}return "redirect:/";
	}
	@PutMapping("/manage/{id}")
	public String addTeamMember(@RequestParam(value="teamMembers")Long member,
			@PathVariable("id") Long teamId,
			HttpSession session,
			Model model) {
		Long id = (Long)session.getAttribute("userId");
		Team thisTeam = teamService.findTeam(teamId);
		System.out.println(userService.findUserById(member).getName());
		System.out.println(thisTeam);
		
		teamService.addUserToTeam(member, thisTeam);
		
			return "redirect:/teams/"+teamId;
		
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
	@GetMapping("users/{id}")
	public String viewUser(@PathVariable("id")Long userId, HttpSession session, Model model) {
		Long id = (Long)session.getAttribute("userId");
		if(id !=null) {
			User thisUser = userService.findUserById(userId);
			model.addAttribute("thisUser", thisUser);
			return "viewUser.jsp";
		}return "redirect:/";
		
	}
		@GetMapping("offTeam/{userId}/{taskId}")
		public String offTeam(
							@PathVariable("userId")Long userId,
							@PathVariable("taskId")Long taskId, 
							HttpSession session) {
			Long loggedIn = (Long)session.getAttribute("userId");
			System.out.println("inside remove from team");
			if(loggedIn !=null) {
				System.out.println("inside remove from team if");
				User thisUser = userService.findUserById(userId);
				System.out.println(thisUser);
				List<Task> thisTaskList = thisUser.getAssignedToTask();
				System.out.println(thisTaskList);
				thisTaskList.clear();
				System.out.println(thisTaskList);
				System.out.println(thisUser.getAssignedToTask());
				thisUser.setAssignedTeam(null);
				userRepo.save(thisUser);
				
				
				return "redirect:/users/"+thisUser.getId();
			}return "redirect:/";
	}
	
	
}
