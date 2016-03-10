package com.me.dao;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;



public class HibernateUtil {

	private static SessionFactory sessionFactory;
	
	static
	{
		try
		{
			sessionFactory = new Configuration().configure().buildSessionFactory();
		}
		catch(Throwable ex)
		{
			System.out.print(ex.getMessage());
		}
	}
	
	public static SessionFactory getSessionFactory()
	{
		return sessionFactory;
		
	}
}
