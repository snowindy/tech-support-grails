
<%@ page import="eg.Problem" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
    <title>Редактирование проблемы</title>
  </head>
  <body>
  <g:render template="navbar"/>
  <div class="body">
    <h1>Редактирование проблемы</h1>

    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${problemInstance}">
      <div class="errors">
        <g:renderErrors bean="${problemInstance}" as="list" />
      </div>
    </g:hasErrors>
    <g:form method="post" >
      <g:hiddenField name="id" value="${problemInstance?.id}" />
      <g:hiddenField name="version" value="${problemInstance?.version}" />
      <div class="dialog">
        <table>
          <tbody>

                  <tr class="prop">
            <td valign="top" class="name">
              <label for="title">Тема</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: problemInstance, field: 'title', 'errors')}">
          <g:textField name="title" value="${problemInstance?.title}" />
          </td>
          </tr>


            <tr class="prop">
              <td valign="top" class="name">
                <label for="descr">Описание</label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: problemInstance, field: 'descr', 'errors')}">
          <g:textArea name="descr" cols="40" rows="5" value="${problemInstance?.descr}" />
          </td>
          </tr>

                 <tr class="prop">
          <td valign="top" class="name">
            <label for="descr">Приоритет</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: problemInstance, field: 'priority', 'errors')}">
        <g:select name="priority"
                  from="${1..3}"
                  value="${problemInstance?.priority}"
                  valueMessagePrefix="priority" />

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
