
<%@ page import="eg.UserGroup" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'userGroup.label', default: 'UserGroup')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <g:render template="/user/navbar" model="[showGroups:true]"/>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'userGroup.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'userGroup.name.label', default: 'Name')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${userGroupInstanceList}" status="i" var="userGroupInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${userGroupInstance.id}">${fieldValue(bean: userGroupInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: userGroupInstance, field: "name")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${userGroupInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
