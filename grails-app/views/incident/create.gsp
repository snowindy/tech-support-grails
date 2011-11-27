
<%@ page import="eg.Incident" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
    <title>Регистрация нового запроса</title>
  </head>
  <body>
  <g:render template="navbar"/>
  <div class="body">
    <h1>Регистрация нового запроса</h1>
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${incidentInstance}">
      <div class="errors">
        <g:renderErrors bean="${incidentInstance}" as="list" />
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
              <td valign="top" class="value ${hasErrors(bean: incidentInstance, field: 'title', 'errors')}">
          <g:textField name="title" value="${incidentInstance?.title}" />
          </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="descr"><g:message code="incident.descr.label" default="Описание" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: incidentInstance, field: 'descr', 'errors')}">
          <gui:richEditor id='editor' name="descr" value="${incidentInstance?.descr}" width="500" height="180"/>
          </td>
          </tr>

          <my:isTechSpec>

            <tr class="prop">
              <td valign="top" class="name">
                <label for="priority">Приоритет</label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: incidentInstance, field: 'priority', 'errors')}">
            <g:select name="priority"
                      from="${[1,2,3]}"
                      value="${incidentInstance?.priority}"
                      valueMessagePrefix="priority" />
            </td>
            </tr>

            <tr class="prop">
              <td valign="top" class="name">
                <label for="author">Присвоить авторство пользователю:</label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: incidentInstance, field: 'author', 'errors')}">
            <g:select name="author.id"
                      optionKey="id"
                      from="${authorUsers}"
                      noSelection="${[0:'Я - автор']}"
                      value="${incidentInstance?.author}" />
            </td>
            </tr>

          </my:isTechSpec>


          </tbody>
        </table>
      </div>
      <g:render template="/includes/buttonsCreateCancel"/>
    </g:form>
  </div>
</body>
</html>
