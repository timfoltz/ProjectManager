package com.tim.beltexam.repos;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.tim.beltexam.models.Team;

public interface TeamRepo extends CrudRepository<Team, Long> {
	List<Team> findAll();
}
