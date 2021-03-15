package com.tim.beltexam.repos;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.tim.beltexam.models.Task;

public interface TaskRepo extends CrudRepository<Task, Long> {
	List<Task> findAll();
	List<Task> findBySubTaskForNull();

}
