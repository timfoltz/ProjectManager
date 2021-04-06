package com.tim.beltexam.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tim.beltexam.models.User;
import com.tim.beltexam.repos.UserRepo;

@Service
public class UserService {
	@Autowired
	private UserRepo userRepo;
	
	// register user and hash their password
    public User registerUser(User user) {
        String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        user.setPassword(hashed);
        if(userRepo.findAll().size()<2) {
        	user.setRoles("ADMIN");
        	return userRepo.save(user);
        	
        }else {	return userRepo.save(user); }
    }
    
    // find user by email
    public User findByEmail(String email) {
        return userRepo.findByEmail(email);
    }
    
    // find user by id
    public User findUserById(Long id) {
    	Optional<User> u = userRepo.findById(id);
    	
    	if(u.isPresent()) {
            return u.get();
    	} else {
    	    return null;
    	}
    }
    public List<User> findAll(){
    	return userRepo.findAll();
    }
    
    // authenticate user
    public boolean authenticateUser(String email, String password) {
        // first find the user by email
        User user = userRepo.findByEmail(email);
        // if we can't find it by email, return false
        if(user == null) {
            return false;
        } else {
            // if the passwords match, return true, else, return false
            if(BCrypt.checkpw(password, user.getPassword())) {
                return true;
            } else {
                return false;
            }
        }
    }
    
    public List<String> emailList(){
    	List<User> userList = (List<User>) userRepo.findAll();
    	List<String> userEmail = new ArrayList<String>();
    	for(User u : userList) {
    		userEmail.add(u.getEmail());
    	}
    	
    	return userEmail;
    }
}
