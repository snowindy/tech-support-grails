
<%@ page import="eg.Problem" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
  <title>Регистрация проблемы</title>
</head>
<body>
<g:render template="navbar"/>
<div class="body">
  <h1>Регистрация проблемы</h1>
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <g:hasErrors bean="${problemInstance}">
    <div class="errors">
      <g:renderErrors bean="${problemInstance}" as="list" />
    </div>
  </g:hasErrors>
  <g:form action="save" method="post" >
    <div class="dialog">
      <table>
        <tbody>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="title"><g:message code="problem.title.label" default="Тема" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: problemInstance, field: 'title', 'errors')}">
        <g:textField name="title" value="${problemInstance?.title}" />
        </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="descr"><g:message code="problem.descr.label" default="Описание" /></label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: problemInstance, field: 'descr', 'errors')}">
        <gui:richEditor id='editor' name="descr" value="${problemInstance?.descr}" width="500" height="180"/>
        </td>
        </tr>

         <my:isTechSpec>
          <tr class="prop">
            <td valign="top" class="name">
              <label for="priority">Приоритет</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: problemInstance, field: 'priority', 'errors')}">
          <g:select name="priority"
                    from="${1..3}"
                    value="${problemInstance?.priority}"
                    valueMessagePrefix="priority" />
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
