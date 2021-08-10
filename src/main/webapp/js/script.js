function add_to_cart(id, name, price, quantity) {

    let cart = localStorage.getItem("cart");
//    let message = document.querySelector("#Pmsg");
    let products = [];

    if (cart == null) {
        if (quantity > 0) {

            let product = {productId: id, productName: name, productQuantity: 1, productPrice: price};
            products.push(product);

            localStorage.setItem("cart", JSON.stringify(products));
            result("product added in cart");
        } else {
            result("Product Out of Stock");
        }
    } else {
        let pcart = JSON.parse(cart);

        let oldproduct = pcart.find((item) => item.productId == id);

        if (oldproduct) {
            if (quantity > 0) {
                oldproduct.productQuantity = oldproduct.productQuantity + 1;

                pcart.map((items) => {
                    if (items.productId == oldproduct.productId) {
                        items.productQuantity = oldproduct.productQuantity;
                    }
                });

                localStorage.setItem("cart", JSON.stringify(pcart));

                result(`One More ${oldproduct.productName} is added`);
            } else {
                result("Product Out of Stock");
            }
        } else {
            if (quantity > 0) {
                let product = {productId: id, productName: name, productQuantity: 1, productPrice: price};
                pcart.push(product);

                localStorage.setItem("cart", JSON.stringify(pcart));
                result("product added in cart");
            } else {
                result("Product Out of Stock");

            }
        }
    }



    updateCart();

}

function result(msg) {
    var tag = document.createElement("h3");
    var text = document.createTextNode(msg);
    tag.appendChild(text);
    swal(tag)
            .then(() => {
                tag.remove();
                text.remove();
            });
//        message.appendChild(tag);
//        message.hidden = false;
//        let id = setTimeout(function () {
//            message.hidden = true;
//            tag.remove();
//            text.remove();
//        }, 5000);
}

//Update Cart

function updateCart() {
    let cartString = localStorage.getItem("cart");

    let cart = JSON.parse(cartString);

    if (cart == null || cart.length == 0) {
        console.log("Cart is Empty");
        $(".cart-items").html("( 0 )");
        $(".cart-body").html("<h3>Cart does not have any items !!</h3>");
        $(".checkout-btn").addClass('disabled');
//        $(".checkout-btn").attr('disabled',true);
    } else {
        console.log(cart);
        $(".cart-items").html(`( ${cart.length} )`);
        $(".checkout-btn").removeClass('disabled');

        let table = `
            <table class='table'>
                <thead class='thead-light'>
                    <tr>
                        <th>Item Name</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Final Price</th>
                        <th>Action</th>
                    </tr>
                </thead>
        `;

        let totalprice = 0;
        cart.map((item) => {
            table += `
                <tr>
                    <td>${item.productName}</td>
                    <td>${item.productPrice}</td>
                    <td>${item.productQuantity}</td>
                    <td>${item.productQuantity * item.productPrice}</td>
                    <td><button class='btn btn-danger btn-sm' onclick='deleteItemFromCart(${item.productId})'>Remove</button></td>
                </tr>
            `;

            totalprice += item.productQuantity * item.productPrice;

        });

        table = table + `
                <tr>
                    <td colspan='5' class='text-right font-weight-bold m-5'>
                        Total Price : ${totalprice}
                    </td>
                </tr>
            </table>`;

        $(".cart-body").html(table);


    }

}


//Delete Item
function deleteItemFromCart(pid) {
    let cart = JSON.parse(localStorage.getItem("cart"));

    let newcart = cart.filter((item) => item.productId != pid);

    localStorage.setItem("cart", JSON.stringify(newcart));
    let matchcart = cart.filter((item) => item.productId == pid);
    result(matchcart[0].productName + ' is removed');
    updateCart();
}


$(document).ready(function () {
    updateCart();
});


function goToCheckout() {
    window.location = "checkout.jsp";
}

function clearLocalStorage() {
    localStorage.clear();
    window.location = "LogoutServlet";
}

//href="LogoutServlet"

