package com.me.controller;

import org.hibernate.Session;

import com.me.dao.EventDao;
import com.me.dao.HibernateUtil;
import com.me.dao.UserDao;
import com.me.pojo.Comment;
import com.me.pojo.Contact;
import com.me.pojo.Event;
import com.me.pojo.JoinEvent;
import com.me.pojo.User;

public class Test {

	public static void main(String args[])
	{
	
	//Session session = HibernateUtil.getSessionFactory().openSession();
	//session.beginTransaction();
	//User u = new User();
	//u.setUsername("j");
//	p.setName("kunal");
//	p.setDetailDescription("mast");
//	p.setGender("male");
//	p.setUsername("k");
//	p.setPassword("k");
//	session.save(p);
//	//session.save(p);
////	
//	Event e = new Event();
//	e.setName("a");
//	e.setCategory("a");
//	e.setDate("a");
//	e.setDetailDescription("a");
//	e.setLocation("a");
//	e.setUsername("kunal");
	//e.setUser(p);
//	Comment e = new Comment();
//	e.setEventName("Sky Diving");
//	e.setComment("Looks Amazing");
//	e.setUsername("kunal");
//	EventDao eventDao = new EventDao();
//	eventDao.commentOnEvent(e);
	//eventDao.listOfUserEvents(u);
	//p.getEventList().add(e);
	//session.save(e);
//	JoinEvent je = new JoinEvent();
//	je.setUsername("mamta");
//	je.setEventName("k");
//	eventDao.joinEvent(je);
	//session.getTransaction().commit();
	Contact c = new Contact();
	UserDao u = new UserDao();
	c.setUsername("kunal");
	c.setContactName("dhawal");
	u.addContact(c);
	}
}
