package com.tim.beltexam.validators;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.tim.beltexam.models.User;
import com.tim.beltexam.services.UserService;


@Component
public class UserValidator implements Validator {
	@Autowired UserService userService;
    
    // 1
    @Override
    public boolean supports(Class<?> clazz) {
        return User.class.equals(clazz);
    }
    
    // 2
    @Override
    public void validate(Object target, Errors errors) {
        User user = (User) target;
        
        if (!user.getPasswordConfirmation().equals(user.getPassword())) {
            // 3
            errors.rejectValue("passwordConfirmation", "Match");
        }         
    }
    
    public void emailValidate(Object target, Errors errors) {
    	User user = (User) target;
    	List<String> emailList = (List<String>) userService.emailList();
    	
    	if(emailList.contains(user.getEmail())) {
    		errors.rejectValue("email","Match");
    		System.out.println("Found a match");
    	}
    }
}
