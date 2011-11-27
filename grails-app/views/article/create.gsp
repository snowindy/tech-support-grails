
<%@ page import="eg.Article" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Создание статьи базы знаний</title>
    </head>
    <body>
        <g:render template="navbar"/>
        <div class="body">
            <h1>Создание статьи базы знаний</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${articleInstance}">
            <div class="errors">
                <g:renderErrors bean="${articleInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
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
                        
                        </tbody>
                    </table>
                </div>
              <g:render template="/includes/buttonsCreateCancel"/>
            </g:form>
        </div>
    </body>
</html>
