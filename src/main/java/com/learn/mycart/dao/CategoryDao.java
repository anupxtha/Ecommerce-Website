/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.learn.mycart.dao;

import com.learn.mycart.entities.Category;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

/**
 *
 * @author Anup-Xtha
 */
public class CategoryDao {
     private SessionFactory factory;

    public CategoryDao(SessionFactory factory) {
        this.factory = factory;
    }

    // Save category to db
    public int saveCategory(Category cat){
        
        int catId = 0;
        
        try{
         Session session = this.factory.openSession();
         
         Transaction tx = session.beginTransaction();
         
         catId = (int)session.save(cat);
         
         tx.commit();
         
         session.close();
         
         
        }
        catch(Exception e){
            e.printStackTrace();
        }
         
        return catId;
    }
    
    public List<Category> getAllCategorys(){
        List<Category> list = new ArrayList<>();
        
        try {
             String query = "from Category";
            
            Session session = this.factory.openSession();
            
            Query q = session.createQuery(query);
            
            list = q.list();
            
            session.close();

            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return list;
    }
    
    
    public Category getCategoryById(int cid){
        
        Category cat = null;
        
        try {
            Session session = this.factory.openSession();
            
            cat = session.get(Category.class, cid);
            
            session.close();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return cat;
    }
    
    
    
}
