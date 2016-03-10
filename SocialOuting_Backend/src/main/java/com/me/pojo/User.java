package com.me.pojo;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class User {

	String name;
	String detailDescription;
	String gender;
	String username;
	String password;
	String imagePath;
	String interestList;
	Set<Event> eventList;
	Set<Contact> contactList;
	
	public User()
	{
		eventList = new HashSet<Event>();
		contactList = new HashSet<Contact>();
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getDetailDescription() {
		return detailDescription;
	}
	public void setDetailDescription(String detailDescription) {
		this.detailDescription = detailDescription;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Set<Event> getEventList() {
		return eventList;
	}
	public void setEventList(Set<Event> eventList) {
		this.eventList = eventList;
	}
	public String getImagePath() {
		return imagePath;
	}
	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	public String getInterestList() {
		return interestList;
	}
	public void setInterestList(String interestList) {
		this.interestList = interestList;
	}
	public Set<Contact> getContactList() {
		return contactList;
	}
	public void setContactList(Set<Contact> contactList) {
		this.contactList = contactList;
	}

	

	
}
