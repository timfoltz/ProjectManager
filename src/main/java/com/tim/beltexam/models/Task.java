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
import javax.validation.constraints.NotNull;

import net.bytebuddy.implementation.bind.annotation.Default;

@Entity
@Table(name="tasks")
public class Task {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@NotNull()
	private String name;
		
	@NotNull
	private Integer priority;
	
	private Boolean complete;
	
	@Column(columnDefinition = "integer default 0")
	private Integer numComplete;
	
	@Column(updatable=false)
	private Date createdAt;
	
	private Date updatedAt;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="user_id")
	private User creator;
	
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(
			name="users_tasks",
			joinColumns = @JoinColumn(name="task_id"),
			inverseJoinColumns = @JoinColumn(name="user_id")
			)
	private List<User> assignee;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="team_id")
	private Team assignedTeam;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="task_id")
	private Task subTaskFor;
	
	@OneToMany(mappedBy="subTaskFor", fetch=FetchType.LAZY)
	private List<Task> subTasks;

	public Task() {
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

	public Integer getPriority() {
		return priority;
	}

	public void setPriority(Integer priority) {
		this.priority = priority;
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

	public User getCreator() {
		return creator;
	}

	public void setCreator(User creator) {
		this.creator = creator;
	}

	public List<User> getAssignee() {
		return assignee;
	}

	public void setAssignee(List<User> assignee) {
		this.assignee = assignee;
	}
	
	 public Team getAssignedTeam() {
		return assignedTeam;
	}

	public void setAssignedTeam(Team assignedTeam) {
		this.assignedTeam = assignedTeam;
	}

	public Boolean getComplete() {
		return complete;
	}

	public void setComplete(Boolean complete) {
		this.complete = complete;
	}

	public Integer getNumComplete() {
		return numComplete;
	}

	public void setNumComplete(Integer completed) {
		this.numComplete = completed;
	}

	public Task getSubTaskFor() {
		return subTaskFor;
	}

	public void setSubTaskFor(Task subTaskFor) {
		this.subTaskFor = subTaskFor;
	}

	public List<Task> getSubTasks() {
		return subTasks;
	}

	public void setSubTasks(List<Task> subTasks) {
		this.subTasks = subTasks;
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
