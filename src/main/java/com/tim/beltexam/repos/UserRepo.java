package com.tim.beltexam.repos;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.tim.beltexam.models.User;

public interface UserRepo extends CrudRepository<User, Long> {
	User findByEmail(String email);
	List<User> findAll();
}
