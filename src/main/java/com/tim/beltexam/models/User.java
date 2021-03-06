package com.tim.beltexam.models;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;



@Entity
@Table(name="users")
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@NotNull(message="Must provide name")
	private String name;
		
	@Email
	@NotNull(message="Must provide email")
	private String email;
	
	
	@Size(min=8, message="Password must be more than 7 characters")
	private String password;
	
	@Transient
	private String passwordConfirmation;
	
	@Column(updatable=false)
	private Date createdAt;
	
	private Date updatedAt;
	
	@OneToMany(mappedBy="creator", fetch=FetchType.LAZY)
	private List<Task> createdTasks;
	
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(
				name="users_tasks",
				joinColumns = @JoinColumn(name = "user_id"),
				inverseJoinColumns = @JoinColumn(name = "task_id")
			)
	private List<Task> assignedToTask;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="team_id")
	private Team assignedTeam;
	
	private String roles;
	
	public User() {
	}


	
	
	 public Long getId() {
		return id;
	}




	public void setId(Long id) {
		this.id = id;
	}




	public String getName() {
		return name;
	}




	public void setName(String name) {
		this.name = name;
	}




	public String getEmail() {
		return email;
	}




	public void setEmail(String email) {
		this.email = email;
	}




	public String getPassword() {
		return password;
	}




	public void setPassword(String password) {
		this.password = password;
	}




	public String getPasswordConfirmation() {
		return passwordConfirmation;
	}




	public void setPasswordConfirmation(String passwordConfirmation) {
		this.passwordConfirmation = passwordConfirmation;
	}




	public Date getCreatedAt() {
		return createdAt;
	}




	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}




	public Date getUpdatedAt() {
		return updatedAt;
	}




	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}




	public List<Task> getCreatedTasks() {
		return createdTasks;
	}




	public void setCreatedTasks(List<Task> createdTasks) {
		this.createdTasks = createdTasks;
	}




	public List<Task> getAssignedToTask() {
		return assignedToTask;
	}




	public void setAssignedToTask(List<Task> assignedToTask) {
		this.assignedToTask = assignedToTask;
	}




	public Team getAssignedTeam() {
		return assignedTeam;
	}




	public void setAssignedTeam(Team assignedTeam) {
		this.assignedTeam = assignedTeam;
	}




	public String getRoles() {
		return roles;
	}




	public void setRoles (String roles) {
		this.roles = roles;
	}




	@PrePersist
	 protected void onCreate(){
    	this.createdAt = new Date();
    }
    @PreUpdate
    protected void onUpdate(){
        this.updatedAt = new Date();
    }
	

}


