package com.me.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.hibernate.Query;
import org.hibernate.Session;

import com.me.pojo.Comment;
import com.me.pojo.Contact;
import com.me.pojo.Event;
import com.me.pojo.JoinEvent;
import com.me.pojo.User;

public class EventDao extends DAO{


	public Event createEvent(Event event) {
		// TODO Auto-generated method stub
		System.out.println("insert into Event table");
		Session session = getSession();
		session.beginTransaction();
		
		Query query = session.createQuery("from User where name=:name");
		query.setString("name", event.getUsername());
		User u = (User) query.uniqueResult();
		//System.out.println(u.getName());
		u.getEventList().add(event);
		
		session.save(event);
		session.update(u);
		session.getTransaction().commit();
		return event;

		
	}
	
	public String joinEvent(JoinEvent joinEvent)
	{
		Session session = getSession();
		session.beginTransaction();
		session.save(joinEvent);
		session.getTransaction().commit();
		return "success";
		
	}

	public List listOfAllEvents(User user) {
		// TODO Auto-generated method stub
		Query query = getSession().createQuery("from Event");
		List list = query.list();
		return list;
	
	}

	public List listOfUserEvents(User user) {
		// TODO Auto-generated method stub
		Query query = getSession().createQuery("from JoinEvent where username=:username");
		query.setString("username", user.getUsername());		
		List<JoinEvent> list = query.list();
		List<Event> eventList = new ArrayList<Event>();
		for(JoinEvent je : list)
		{
			Query query1 = getSession().createQuery("from Event where name=:name");
			query1.setString("name",je.getEventName());		
			Event event = (Event) query1.uniqueResult();
			eventList.add(event);
			
		}
		return eventList;
	}

	public List eventDetails(Event event) {
		Query query = getSession().createQuery("from JoinEvent where eventName=:eventName");
		query.setString("eventName", event.getName());		
		List<JoinEvent> list = query.list();
		return list;
	}
	
	
	public List commentOnEvent(Comment comment) {
		// TODO Auto-generated method stub
		//System.out.println("insert into Event table");
		Session session = getSession();
		session.beginTransaction();
		

		
		Query query = session.createQuery("from Event where name=:name");
		query.setString("name", comment.getEventName());
		Event e = (Event) query.uniqueResult();
		//System.out.println(u.getName());
		
		e.getCommentList().add(comment);
		
		session.save(comment);
		session.update(e);
		session.getTransaction().commit();
		
		Query commentQuery = getSession().createQuery("from Comment where eventName=:eventName");
		commentQuery.setString("eventName", comment.getEventName());
		List list = commentQuery.list();
		return list;

		
	}

	
}
