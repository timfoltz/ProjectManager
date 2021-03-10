package com.tim.beltexam.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.tim.beltexam.models.Task;
import com.tim.beltexam.models.User;
import com.tim.beltexam.repos.UserRepo;
import com.tim.beltexam.services.TaskService;
import com.tim.beltexam.services.TeamService;
import com.tim.beltexam.services.UserService;

@Controller
public class UserController {

	@Autowired
	private UserService userService;
	@Autowired
	private UserRepo userRepo;
	
	@Autowired
	private TaskService taskService;
	
	@Autowired
	private TeamService teamService;
	
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
