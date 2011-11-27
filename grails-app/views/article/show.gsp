
<%@ page import="eg.Article" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
  
  <title>Просмотр статьи</title>
</head>
<body>

<g:render template="navbar"/>
<div class="body">

  <g:render template="details" model="[prob:problemInstance]"/>
</div>

</body>
</html>
