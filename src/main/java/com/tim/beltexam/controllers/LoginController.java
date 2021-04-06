package com.tim.beltexam.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tim.beltexam.models.User;
import com.tim.beltexam.services.UserService;
import com.tim.beltexam.validators.UserValidator;

@Controller
public class LoginController {
	
	@Autowired
	private UserService userService;
	@Autowired
	private UserValidator userValidator;
	
    
    @GetMapping("/login")
    public String loginRouter() {
    	return "redirect:/";
    }
	
    @GetMapping("/registration")
    public String regRouter() {
    	return "redirect:/";
    }
    @GetMapping("/register")
    public String registerRouter() {
    	return "redirect:/";
    }
    
    
    @RequestMapping(value="/registration", method=RequestMethod.POST)
    public String registerUser(@Valid 
							   @ModelAttribute("user") User user, 
							   BindingResult result, HttpSession session) {
    	
    	userValidator.validate(user,result);
    	userValidator.emailValidate(user, result);
    	
    	if(result.hasErrors()) {
    		return"loginRegPage.jsp";
    	} else {
    		User u = userService.registerUser(user);
    		session.setAttribute("userId", u.getId());
    		
    		return "redirect:/dashboard";
    	}
    }

    
    @RequestMapping(value="/login", method=RequestMethod.POST)
    public String loginUser(
	    						@RequestParam("email") String email, 
	    						@RequestParam("password") String password, 
	    						Model model, 
	    						HttpSession session,
	    						RedirectAttributes redirectAttributes
    						) {
        if(userService.authenticateUser(email, password)) {
        	User thisUser = userService.findByEmail(email);
        	session.setAttribute("userId", thisUser.getId());
        	return "redirect:/dashboard";
        } else {
        	redirectAttributes.addFlashAttribute("error", "Login Failed");
        	return "redirect:/";
        }
    }

    
    @RequestMapping("/logout")
    public String logout(HttpSession session) {
       session.invalidate();
    	return "redirect:/";
    }
}
