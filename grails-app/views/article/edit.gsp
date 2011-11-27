
<%@ page import="eg.Article" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'article.label', default: 'Article')}" />
        <title>Редактирование статьи</title>
    </head>
    <body>
        <g:render template="navbar"/>
        <div class="body">
            <h1>Редактирование статьи</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${articleInstance}">
            <div class="errors">
                <g:renderErrors bean="${articleInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${articleInstance?.id}" />
                <g:hiddenField name="version" value="${articleInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="title">Тема</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: articleInstance, field: 'title', 'errors')}">
                                    <g:textField name="title" value="${articleInstance?.title}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="descr">Содержимое</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: articleInstance, field: 'descr', 'errors')}">
                                    <gui:richEditor id='editor' name="descr" value="${articleInstance?.descr}" width="500" height="180"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="userGroups">Прикреплена к группам пользователей</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: articleInstance, field: 'userGroups', 'errors')}">
                                    <g:select name="userGroups" from="${eg.UserGroup.list()}" multiple="yes" optionKey="id" size="5" value="${articleInstance?.userGroups*.id}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <g:render template="/includes/buttonsUpdateDeleteCancel"/>
            </g:form>
        </div>
    </body>
</html>
