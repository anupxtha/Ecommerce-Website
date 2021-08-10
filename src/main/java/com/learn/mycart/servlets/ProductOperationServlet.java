/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.learn.mycart.servlets;

import com.learn.mycart.dao.CategoryDao;
import com.learn.mycart.dao.ProductDao;
import com.learn.mycart.entities.Category;
import com.learn.mycart.entities.Product;
import com.learn.mycart.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

/**
 *
 * @author Anup-Xtha
 */
@MultipartConfig
public class ProductOperationServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            // Doing add Category and add Product part with one servlet
            String op = request.getParameter("operation");

            if (op.trim().equals("addcategory")) {
                // Add Category
                // Fetching Category Data from admin.jsp

                String title = request.getParameter("catTitle");
                String Description = request.getParameter("catDescription");

                Category category = new Category();

                category.setCategoryTitle(title);
                category.setCategoryDescription(Description);

                //Saving Category Object to database
                CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());

                int catId = categoryDao.saveCategory(category);

                HttpSession httpSession = request.getSession();

                httpSession.setAttribute("check", "success");

                httpSession.setAttribute("message", "Category Successfully Saved " + catId);

                response.sendRedirect("admin.jsp");
                return;

            } else if (op.trim().equals("addproduct")) {
                // Add Product
                // Fetching Product Data from admin.jsp

                String pName = request.getParameter("pName");
                String pDesc = request.getParameter("pDescription");
                int pPrice = Integer.parseInt(request.getParameter("pPrice"));
                int pDiscount = Integer.parseInt(request.getParameter("pDiscount"));
                int pQuantity = Integer.parseInt(request.getParameter("pQuantity"));
                int catId = Integer.parseInt(request.getParameter("pCategories"));
                Part part = request.getPart("pPhoto");

                Product p = new Product();

                p.setpName(pName);
                p.setpDesc(pDesc);
                p.setpPrice(pPrice);
                p.setpQuantity(pQuantity);
                p.setpDiscount(pDiscount);
                p.setpPhoto(part.getSubmittedFileName());

                // get Category by Id
                CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());

                Category cat = cdao.getCategoryById(catId);

                p.setCategory(cat);

                ProductDao productDao = new ProductDao(FactoryProvider.getFactory());
                productDao.saveProduct(p);

                // Uploading product photo in folder (img/products)
                try {

                    // step-1 : finding path to upload photo
                    // request.getContextPath("img");
                    String path = "C:\\Users\\Anup-Xtha\\Documents\\NetBeansProjects\\mycart\\src\\main\\webapp\\img\\products" + File.separator + part.getSubmittedFileName();

                    System.out.println(path);

                    // step-2 : Reading part(image file) 
                    InputStream is = part.getInputStream();

                    // step-3 : reading file from InputStream and passing to byte array object
                    byte data[] = new byte[is.available()];

                    is.read(data);

                    // write in the path
                    FileOutputStream fos = new FileOutputStream(path);

                    // Writing byte data to FileOutputStream
                    fos.write(data);

                    fos.flush();

                    fos.close();

                } catch (Exception e) {
                    e.printStackTrace();
                }

                HttpSession httpSession = request.getSession();

                httpSession.setAttribute("check", "success");

                httpSession.setAttribute("message", "Product added successfully");

                response.sendRedirect("admin.jsp");
                return;
            }

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
