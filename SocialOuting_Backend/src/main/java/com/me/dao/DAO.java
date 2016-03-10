package com.me.dao;

import org.hibernate.Session;

public abstract class DAO {
	
	public Session getSession()
	{
		return HibernateUtil.getSessionFactory().openSession();
	}
	
	protected void begin()
	{
		getSession().getTransaction().begin();
	}
	
	protected void commit()
	{
		getSession().getTransaction().commit();;
	}
	
	
	protected void rollback()
	{
		getSession().getTransaction().rollback();;
	}
	
	protected void close()
	{
		getSession().close();
	}
	
	
	
}
