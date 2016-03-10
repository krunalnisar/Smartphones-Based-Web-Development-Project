package com.me.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.me.dao.EventDao;
import com.me.dao.UserDao;
import com.me.pojo.Comment;
import com.me.pojo.Contact;
import com.me.pojo.Event;
import com.me.pojo.JoinEvent;
import com.me.pojo.User;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	UserDao userDao;
	
	@Autowired
	EventDao eventDao;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	@ResponseBody
	public String createProfile(@RequestBody User user){
		return userDao.registerUser(user);
	}
	
	@RequestMapping(value = "/authenticateUser", method = RequestMethod.POST)
	@ResponseBody
	public User loginUser(@RequestBody User user){
		return userDao.authentictaeUser(user);
	}
	
	@RequestMapping(value = "/createEvent", method = RequestMethod.POST)
	@ResponseBody
	public Event eventCreation(@RequestBody Event event){
		return eventDao.createEvent(event);
	}
	
	@RequestMapping(value = "/joinEvent", method = RequestMethod.POST)
	@ResponseBody
	public String joinEvent(@RequestBody JoinEvent joinEvent){
		return eventDao.joinEvent(joinEvent);
	}
	

	@RequestMapping(value = "/listOfAllEvents", method = RequestMethod.POST)
	@ResponseBody
	public List listOfAllEvents(@RequestBody User user){
		return eventDao.listOfAllEvents(user);
	}
	
	@RequestMapping(value = "/listOfUserEvents", method = RequestMethod.POST)
	@ResponseBody
	public List listOfUserEvents(@RequestBody User user){
		return eventDao.listOfUserEvents(user);
	}
	

	@RequestMapping(value = "/eventDetails", method = RequestMethod.POST)
	@ResponseBody
	public List eventDetails(@RequestBody Event event){
		return eventDao.eventDetails(event);
	}
	

	@RequestMapping(value = "/loadUser", method = RequestMethod.POST)
	@ResponseBody
	public User loadUser(@RequestBody User user){
		return userDao.loadUser(user);
	}
	

	@RequestMapping(value = "/commentOnEvent", method = RequestMethod.POST)
	@ResponseBody
	public List commentOnEvent(@RequestBody Comment comment){
		return eventDao.commentOnEvent(comment);
	}
	
	@RequestMapping(value = "/addContact", method = RequestMethod.POST)
	@ResponseBody
	public String addContact(@RequestBody Contact contact){
		return userDao.addContact(contact);
	}
	
	@RequestMapping(value = "/loadContact", method = RequestMethod.POST)
	@ResponseBody
	public List loadContact(@RequestBody Contact contact){
		return userDao.loadContact(contact);
	}
	
	
}
