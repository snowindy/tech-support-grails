
<%@ page import="eg.Incident" %>
<%@ page import="eg.Comment" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'incident.label', default: 'Incident')}" />
        <title>Просмотр запроса</title>
    </head>
    <body>
    <g:render template="navbar"/>
        <div class="body">

          <g:render template="details" model="[incidentInstance:incidentInstance]"/>

          <g:if test="${incidentInstance?.status == Incident.STATUS_OPEN}">
            <g:render template="/comment/createComment" model="[entity:incidentInstance, commentInstance: commentInstance]" />
          </g:if>
            
        </div>
    </body>
</html>
