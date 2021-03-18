package com.tim.beltexam.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tim.beltexam.models.Task;
import com.tim.beltexam.models.User;
import com.tim.beltexam.repos.TaskRepo;

@Service
public class TaskService {
	
	@Autowired
	private TaskRepo taskRepo;
	@Autowired
	private UserService userService;
//	******Create******
	public Task createTask(Task task) {
		return taskRepo.save(task);
	}
//	******Read ONE******
	public Task findTask(Long id) {
		Optional<Task> optionalTask = taskRepo.findById(id);
		return optionalTask !=null ? optionalTask.get() : null;
	}
//	******Read ALL******
	public List<Task> allTasks()	{
		return taskRepo.findAll();
	}
//	******Read SOME******
	public List<Task> notSubTask(){
		return taskRepo.findBySubTaskForNull();
	}
//	******Update******
//	public void updateTask(Long userId, Task task) {
//		List<User> goers = task.getAssignee();
//		User going = userService.findUserById(userId);
//		goers.add(going);
//		taskRepo.save(task);
//	}
//	public void leaveTask(Long userId, Task task) {
//		List<User> goers = task.getAssignee();
//		User going = userService.findUserById(userId);
//		goers.remove(going);
//		taskRepo.save(task);
//	}
//	public void completeTask(Long taskId) {
//		Optional<Task> thisTask = taskRepo.findById(taskId);		
//	}
	public void editTask(Task task) {
		taskRepo.save(task);
	}
//	******Destroy/Delete******
	public void deleteTask(Long id) {
		 
		taskRepo.deleteById(id);
	}


}
