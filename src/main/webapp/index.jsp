<%@page import="com.learn.mycart.helper.Helper"%>
<%@page import="com.learn.mycart.entities.Category"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.entities.Product"%>
<%@page import="com.learn.mycart.dao.ProductDao"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Cart - Home</title>

        <%@include file="components/common_css_js.jsp" %>

    </head>
    <body>

        <%@include file="components/navbar.jsp" %>

<!--        <div class="container-fluid mt-3 text-center" id="Pmsg" type="hidden">
            
        </div>-->


        <div class="row mt-4 mx-2">

            <%                String cat = request.getParameter("category");

                ProductDao pdao = new ProductDao(FactoryProvider.getFactory());

                List<Product> num = pdao.getAllProducts();

                String p = request.getParameter("page");
                int a = 0;
                if (p != null) {
                    int b = Integer.parseInt(p);
                    a = (b - 1) * 6;
                }
                List<Product> plist = null;
                if (cat == null || cat.trim().equals("all")) {

                    plist = pdao.getAllProducts(a);
                } else {
                    int cid = Integer.parseInt(cat.trim());
                    plist = pdao.getAllProductsByCatId(cid);
                }

                CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());

                List<Category> clist = cdao.getAllCategorys();
            %>

            <!--Show Categories-->
            <div class="col-md-2">

                <div class="list-group mt-4">
                    <a href="index.jsp?category=all" class="list-group-item list-group-item-action active">
                        All Products
                    </a>

                    <%
                        for (Category category : clist) {

                    %>
                    <a href="index.jsp?category=<%= category.getCategoryId()%>" class="list-group-item list-group-item-action">
                        <%= category.getCategoryTitle()%>
                    </a>
                    <%                            }

                    %>
                </div>


            </div>

            <!--Show Products-->
            <div class="col-md-10">
                <div class="row mt-4">
                    <div class="col-md-12">
                        <div class="card-columns">

                            <%                                for (Product product : plist) {
                            %>
                            <div class="card product-card">

                                <div class="container text-center">
                                    <img class="card-img-top m-2" src="img/products/<%= product.getpPhoto()%>" style="max-height: 270px; max-width: 100%;width: auto;" alt="<%= product.getpPhoto()%>">
                                </div>

                                <div class="card-body">
                                    <h5 class="card-title"><%= product.getpName()%></h5>

                                    <p class="card-text">
                                        <%= Helper.get10Words(product.getpDesc())%>
                                    </p>

                                </div>

                                <div class="card-footer text-center">
                                    <button id="addtocart" class="btn custom-bg text-white text-center" onclick="add_to_cart(<%= product.getPid()%>, '<%= product.getpName()%>', <%= product.getpPrice()%>, <%= product.getpQuantity()%>)">Add to Cart</button>
                                    <button class="btn btn-outline-success text-center">&#8377; <%= product.getPriceAfterDiscount()%> /- <Span class="real">&#8377;<%= product.getpPrice()%></Span><span class="text-secondary discount-label"> (<%= product.getpDiscount()%> % off)</span></button>
                                </div>
                            </div>
                            <%
                                }

                                if (plist.size() == 0) {
                                    out.println("<h3>No Items in this Category</h3>");
                                }
                            %>

                        </div>
                    </div>
                </div>

                <div class="container m-4">
                    <%
                        if (cat == null || cat.trim().equals("all")) {
                            for (int i = 1; i <= (num.size() / 3); i++) {
                    %>
                    <a href="index.jsp?page=<%= i%>" class="btn btn-outline-primary text-center"><%= i%></a>
                    <%
                            }
                        }
                    %>
                </div>      
            </div>

        </div>

    </body>
</html>
