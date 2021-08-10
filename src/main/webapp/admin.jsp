<%@page import="java.util.Map"%>
<%@page import="com.learn.mycart.helper.Helper"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.entities.Category"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="com.learn.mycart.entities.User"%>
<%

    User user = (User) session.getAttribute("current-user");

    if (user == null) {
        session.setAttribute("check", "error");
        session.setAttribute("message", "You are not login in !! Login First !!");
        response.sendRedirect("login.jsp");
        return;
    } else {
        if (user.getUserType().equals("normal")) {
            session.setAttribute("check", "error");
            session.setAttribute("message", "You are not admin!! Can't access this page !!");
            response.sendRedirect("login.jsp");
            return;
        }
    }

    CategoryDao cd = new CategoryDao(FactoryProvider.getFactory());

    List<Category> l = cd.getAllCategorys();
    
    Map<String, Long> m = Helper.getCounts(FactoryProvider.getFactory());

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Panel - My Cart</title>

        <%@include file="components/common_css_js.jsp" %>

    </head>
    <body>
        <%@include file="components/navbar.jsp" %>

        <div class="container admin">

            <div class="container-fluid mt-3">
                <%@include file="components/message.jsp" %>
            </div>

            <div class="row mt-4">
                <!--First Col-->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 150px;" class="img-fluid" src="img/teamwork.png" alt="user">
                            </div>
                            <h2>123</h2>
                            <h1 class="text-uppercase text-muted"><%= m.get("userCount") %></h1>
                        </div>
                    </div>
                </div>

                <!--Second Col-->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 150px;" class="img-fluid" src="img/categories.png" alt="categories">
                            </div>
                            <h2>123</h2>
                            <h1 class="text-uppercase text-muted"><%= l.size() %></h1>
                        </div>
                    </div>
                </div>

                <!--Third Col-->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 150px;" class="img-fluid" src="img/packaging.png" alt="products">
                            </div>
                            <h2>123</h2>
                            <h1 class="text-uppercase text-muted"><%= m.get("productCount") %></h1>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row mt-4">

                <div class="col-md-6">
                    <div class="card" data-toggle='modal' data-target="#add-category-modal">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 150px;" class="img-fluid" src="img/add-to-cart.png" alt="addcategories">
                            </div>
                            <h6 class="mt-2">Click here to add new Category</h6>
                            <h1 class="text-uppercase text-muted">Add Categories</h1>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card" data-toggle='modal' data-target="#add-product-modal">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 150px;" class="img-fluid" src="img/procurement.png" alt="addproduct">
                            </div>
                            <h6 class="mt-2">Click here to add new Product</h6>
                            <h1 class="text-uppercase text-muted">Add Products</h1>
                        </div>
                    </div>
                </div>


            </div>

        </div>


        <!--Add Category Modal-->

        <!-- Modal -->
        <div class="modal fade" id="add-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Fill Category Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <form action="ProductOperationServlet" method="post">

                            <input type="hidden" name="operation" value="addcategory" />

                            <div class="form-group">
                                <input type="text" class="form-control" name="catTitle" placeholder="Enter category Title" required />
                            </div>  

                            <div class="form-group">
                                <textarea style="height: 300px;" class="form-control" placeholder="Enter Category Description" name="catDescription" required></textarea>
                            </div> 

                            <div class="container text-center">
                                <button class="btn btn-outline-success">Add Category</button>&nbsp;&nbsp;&nbsp;
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </form>

                    </div>

                </div>
            </div>
        </div>

        <!--End Add Category Modal-->



        <!--Add Product Modal-->

        <!-- Modal -->
        <div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Fill Product Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <form action="ProductOperationServlet" method="post" enctype="multipart/form-data" >

                            <input type="hidden" name="operation" value="addproduct" />


                            <div class="form-group">
                                <select class="form-control" name="pCategories">
                                    <option selected disabled>***Select Categories***</option>

                                    <%                                        for (Category c : l) {
                                    %>

                                    <option value="<%= c.getCategoryId()%>"><%= c.getCategoryTitle()%></option>

                                    <%
                                        }
                                    %>
                                </select>
                            </div>

                            <div class="form-group">
                                <input type="text" class="form-control" name="pName" placeholder="Enter Product Name" required />
                            </div>  

                            <div class="form-group">
                                <textarea style="height: 150px;" class="form-control" placeholder="Enter Product Description" name="pDescription" required></textarea>
                            </div> 

                            <div class="form-group">
                                <label>Select Your Product Image</label>
                                <input name="pPhoto" type="file" class="form-control"  />
                            </div>

                            <div class="form-group">
                                <input type="number" class="form-control" name="pPrice" placeholder="Enter Price of Product" required />
                            </div> 

                            <div class="form-group-">
                                <select class="form-control" name="pDiscount">
                                    <option selected disabled>***Select Categories***</option>
                                    <%
                                        int b = 0;
                                        for (int i = 1; i <= 5; i++) {
                                    %>
                                    <option value="<%= i * 10%>"><%= i * 10%>%</option>
                                    <%
                                        }
                                    %>

                                </select>
                            </div>
                            <br>
                            <div class="form-group">
                                <input type="number" class="form-control" name="pQuantity" placeholder="Enter Quantity of Product" required />
                            </div> 

                            <div class="container text-center">
                                <button class="btn btn-outline-success">Add Product</button>&nbsp;&nbsp;&nbsp;
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </form>

                    </div>

                </div>
            </div>
        </div>

        <!--End Add Product Modal-->

    </body>
</html>
