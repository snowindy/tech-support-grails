
<%@ page import="eg.Comment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'comment.label', default: 'Comment')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav sub-nav">
             
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="comment.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: commentInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="comment.descr.label" default="Описание" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: commentInstance, field: "descr")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="comment.author.label" default="Автор" /></td>
                            
                            <td valign="top" class="value"><g:link controller="user" action="show" id="${commentInstance?.author?.id}">${commentInstance?.author?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="comment.title.label" default="Title" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: commentInstance, field: "title")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="comment.dateCreated.label" default="Дата создания" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${commentInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="comment.problem.label" default="Problem" /></td>
                            
                            <td valign="top" class="value"><g:link controller="problem" action="show" id="${commentInstance?.problem?.id}">${commentInstance?.problem?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="comment.incident.label" default="Incident" /></td>
                            
                            <td valign="top" class="value"><g:link controller="incident" action="show" id="${commentInstance?.incident?.id}">${commentInstance?.incident?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${commentInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Редактировать')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Удалить')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Вы уверены?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
