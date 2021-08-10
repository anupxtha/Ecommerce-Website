/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.learn.mycart.dao;

import com.learn.mycart.entities.Product;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

/**
 *
 * @author Anup-Xtha
 */
public class ProductDao {
    private SessionFactory factory;

    public ProductDao(SessionFactory factory) {
        this.factory = factory;
    }

    public boolean saveProduct(Product product){
        
        boolean f = false;
        
        try {
            
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();
            
            session.save(product);
            
            tx.commit();
            
            session.close();
            
            f = true;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return f;
    }
    
    
    public List<Product> getAllProducts(){
        
        Session session = this.factory.openSession();
        
        Query query = session.createQuery("from Product");
        
        List<Product> list = query.list();
        
        return list;
        
    }
    
    public List<Product> getAllProducts(int page){
        
        Session session = this.factory.openSession();
        
        Query query = session.createQuery("from Product");
        
        query.setFirstResult(page); 
        
        query.setMaxResults(6); 
        
        List<Product> list = query.list();
        
        return list;
        
    }
    
    
    // Get product of given category
    public List<Product> getAllProductsByCatId(int cid){
        
        Session session = this.factory.openSession();
        
        Query query = session.createQuery("from Product as p where p.category.categoryId=: id");
        
        query.setParameter("id", cid);
        
        List<Product> list = query.list();
        
        return list;
        
    }
    
}
