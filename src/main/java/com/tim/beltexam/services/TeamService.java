package com.tim.beltexam.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tim.beltexam.models.Team;
import com.tim.beltexam.models.User;
import com.tim.beltexam.repos.TeamRepo;
import com.tim.beltexam.repos.UserRepo;

@Service
public class TeamService {
	
	@Autowired
	private TeamRepo teamRepo;
	@Autowired
	private UserRepo userRepo;
	@Autowired
	private UserService userService;
//	******Create******
	public Team createTeam(Team team) {
		return teamRepo.save(team);
	}
//	******Read ONE******
	public Team findTeam(Long id) {
		Optional<Team> optionalTeam = teamRepo.findById(id);
		return optionalTeam !=null ? optionalTeam.get() : null;
	}
//	******Read ALL******
	public List<Team> allTeams()	{
		return teamRepo.findAll();
	}
//	******Read SOME******
//	public List<Team> teamsNotUser(User user){
//		return teamRepo.findByCreatorIsNot(user);
//	}
//	******Update******
	public void addUserToTeam(Long userId, Team team) {
//		List<User> teamMemebers = team.getTeamMembers();
		User assigned = userService.findUserById(userId);
		assigned.setAssignedTeam(team);
		userRepo.save(assigned);
;
//		teamMemebers.add(assigned);
//
//		teamRepo.save(team);

	}
	public void leaveTeam(Long userId, Team team) {
		List<User> goers = team.getTeamMembers();
		User going = userService.findUserById(userId);
		goers.remove(going);
		teamRepo.save(team);
	}
	public void editTeam(Team team) {
		teamRepo.save(team);
	}
//	******Destroy/Delete******
	public void deleteTeam(Long id) {
		 
		teamRepo.deleteById(id);
	}


}
