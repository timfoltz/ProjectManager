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
	
	@RequestMapping("/")
    public String registerForm(@ModelAttribute("user") User user, HttpSession session) {
    	Long id = (Long) session.getAttribute("userId");
    	if(id != null) {
    		return "redirect:/dashboard";
    	}
        return "loginRegPage.jsp";
    }
	
	
	
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
	
		

}
