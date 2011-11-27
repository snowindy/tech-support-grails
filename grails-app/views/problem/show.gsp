
<%@ page import="eg.Problem" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Просмотр проблемы</title>
    </head>
    <body>
        <g:render template="navbar"/>
        <div class="body">

          <g:render template="details" model="[prob:problemInstance]"/>

          <g:if test="${problemInstance?.status == Problem.STATUS_OPEN}">
            <g:render template="/comment/createComment" model="[entity:problemInstance, commentInstance: commentInstance]" />
          </g:if>

        </div>
    </body>
</html>
