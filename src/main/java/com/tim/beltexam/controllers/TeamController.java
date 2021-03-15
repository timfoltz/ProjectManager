package com.tim.beltexam.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.tim.beltexam.models.Team;
import com.tim.beltexam.models.User;
import com.tim.beltexam.repos.UserRepo;
import com.tim.beltexam.services.TaskService;
import com.tim.beltexam.services.TeamService;
import com.tim.beltexam.services.UserService;

@Controller
public class TeamController {
	
	@Autowired
	private UserService userService;
	@Autowired
	private UserRepo userRepo;
	
	@Autowired
	private TaskService taskService;
	
	@Autowired
	private TeamService teamService;
	
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


@GetMapping("teams/{id}")
public String viewTeam(@PathVariable("id")Long teamId, HttpSession session, Model model) {
	Long id = (Long)session.getAttribute("userId");
	if(id !=null) {
		Team thisTeam = teamService.findTeam(teamId);
		User thisUser = userService.findUserById(id);
		model.addAttribute("user", thisUser);
		model.addAttribute("thisTeam", thisTeam);
		System.out.println(thisUser.getRoles());
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

}
