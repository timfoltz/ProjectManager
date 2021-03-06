package com.tim.beltexam.models;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

@Entity
@Table(name="teams")
public class Team {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@NotNull()
	private String name;
	
	@Column(updatable=false)
	private Date createdAt;
	
	private Date updatedAt;
	
	@OneToMany(mappedBy="assignedTeam", fetch=FetchType.LAZY)
	private List<Task> assignedTasks;
	
	@OneToMany(mappedBy="assignedTeam", fetch=FetchType.LAZY)
	private List<User> teamMembers;

	public Team() {
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

	public List<Task> getAssignedTasks() {
		return assignedTasks;
	}

	public void setAssignedTasks(List<Task> assignedTasks) {
		this.assignedTasks = assignedTasks;
	}

	public List<User> getTeamMembers() {
		return teamMembers;
	}

	public void setTeamMembers(List<User> teamMembers) {
		this.teamMembers = teamMembers;
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
