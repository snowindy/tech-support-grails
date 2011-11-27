
<%@ page import="eg.Incident" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'incident.label', default: 'Incident')}" />
  <title>Редактирование инцидента</title>
</head>
<body>
<g:render template="navbar"/>
<div class="body">
  <h1>Редактирование инцидента</h1>
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <g:hasErrors bean="${incidentInstance}">
    <div class="errors">
      <g:renderErrors bean="${incidentInstance}" as="list" />
    </div>
  </g:hasErrors>
  <g:form method="post" >
    <g:hiddenField name="id" value="${incidentInstance?.id}" />
    <g:hiddenField name="version" value="${incidentInstance?.version}" />
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
            <label for="descr">Описание</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: incidentInstance, field: 'descr', 'errors')}">
        <gui:richEditor id='editor' name="descr" value="${incidentInstance?.descr}" width="500" height="180"/>
        </td>
        </tr>


        <tr class="prop">
          <td valign="top" class="name">
            <label for="descr">Приоритет</label>
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
            <label for="descr">Тип</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: incidentInstance, field: 'type', 'errors')}">
        <g:select name="type"
                  from="${[1,2,3]}"
                  value="${incidentInstance?.type}"
                  valueMessagePrefix="incident.type" />

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
