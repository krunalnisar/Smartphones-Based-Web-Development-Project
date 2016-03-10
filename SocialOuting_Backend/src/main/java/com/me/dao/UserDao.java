package com.me.dao;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Restrictions;

import com.me.dao.DAO;
import com.me.pojo.Contact;
import com.me.pojo.Event;
import com.me.pojo.User;

public class UserDao extends DAO{
	
	public String registerUser(User user)
	{
		System.out.println("insert into User table");
		Session session = getSession();
		session.beginTransaction();
		
		session.save(user);
		
		session.getTransaction().commit();
		return "success";
	}
	
	public User authentictaeUser (User user)
	{
		
		Session session = getSession();
		Query query = session.createQuery("from User where username =:username and password =:password");
		query.setString("username",user.getUsername());
		query.setString("password",user.getPassword());
		User currentUser = (User) query.uniqueResult();
		return currentUser;
		
	}

	public User loadUser(User user) {
		// TODO Auto-generated method stub
		Session session = getSession();
		Query query = session.createQuery("from User where name =:name");
		query.setString("name",user.getName());
		User currentUser = (User) query.uniqueResult();
		return currentUser;
	}

	public String addContact(Contact contact) {
		// TODO Auto-generated method stub
		Session session = getSession();
		session.beginTransaction();
		

		
		Query query = session.createQuery("from User where name=:name");
		query.setString("name", contact.getUsername());
		User u = (User) query.uniqueResult();
		//System.out.println(u.getName());
		
		u.getContactList().add(contact);		
		session.save(contact);
		session.update(u);
		session.getTransaction().commit();
		
		return "success";
	}

	public List loadContact(Contact contact) {
		// TODO Auto-generated method stub
		Session session = getSession();
		Query query = session.createQuery("from Contact where username =:username");
		query.setString("username",contact.getUsername());
		List list = query.list();
		return list;
	}
	
	
}
