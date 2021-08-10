<%

    String message = (String) session.getAttribute("message");
    String checking = (String)session.getAttribute("check");
    
    if (message != null && checking.equals("success")) {


%>

<div id="msg" class="alert alert-success alert-dismissible fade show" role="alert">
    <strong><%= message %></strong> 
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>

<%             
    session.removeAttribute("message");
    session.removeAttribute("checking");
    }
else if (message != null && checking.equals("error")) {
       

%>
<div id="msg" class="alert alert-warning alert-dismissible fade show" role="alert">
    <strong><%= message %></strong> 
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<%

        session.removeAttribute("message");
        session.removeAttribute("checking");
    
    }


%>