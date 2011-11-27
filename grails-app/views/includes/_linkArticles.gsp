
<%@ page import="eg.Article" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Прикрепленные статьи базы знаний</title>
    </head>
    <body>
        <g:render template="/${entityName}/navbar"/>
        <div class="body">
            <h1>Прикрепленные статьи базы знаний</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${entity}">
            <div class="errors">
                <g:renderErrors bean="${entity}" as="list" />
            </div>
            </g:hasErrors>
            <h2>${entityTitle}: ${entity.title}</h2>
            <g:form method="post" >
                <g:hiddenField name="id" value="${entity?.id}" />
                <g:hiddenField name="reqType" value="updateLinkedArticles" />
                <g:hiddenField name="version" value="${entity?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="articles">Прикрепленные статьи</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: entity, field: 'articles', 'errors')}">
                                    <g:select name="articles"
                                              optionValue="title"
                                              from="${eg.Article.list()}" multiple="yes" optionKey="id" size="5" value="${entity?.articles*.id}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <g:render template="/includes/buttonsUpdateCancel"/>
            </g:form>
        </div>
    </body>
</html>
