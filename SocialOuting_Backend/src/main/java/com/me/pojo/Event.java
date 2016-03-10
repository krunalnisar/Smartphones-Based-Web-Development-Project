package com.me.pojo;

import java.util.HashSet;
import java.util.Set;

public class Event {

	String name;
	String detailDescription;
	String location;
	String category;
	String date;
	String username;
	String comment;
	//many-to-one
	//User user;
	Set<Comment> commentList;
	
	public Event(){
		commentList = new HashSet<Comment>();
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDetailDescription() {
		return detailDescription;
	}
	public void setDetailDescription(String detailDescription) {
		this.detailDescription = detailDescription;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public Set<Comment> getCommentList() {
		return commentList;
	}
	public void setCommentList(Set<Comment> commentList) {
		this.commentList = commentList;
	}
	
	
	
	
	
}
