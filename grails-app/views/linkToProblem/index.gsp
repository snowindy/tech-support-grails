
<%@ page import="eg.Incident" %>
<%@ page import="eg.Problem" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'incident.label', default: 'Incident')}" />

  <title>
    Прикрепить к проблеме
  </title>

</head>
<body>

<g:render template="/incident/navbar"/>
<div class="body">
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <g:hasErrors bean="${cmd}">
    <div class="errors">
      <g:renderErrors bean="${cmd}" as="list" />
    </div>
  </g:hasErrors>

  <g:form action="linkToProblem" method="post" >
    
    <div class="dialog">
      <table>
        <tbody>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="title">Проблема</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: cmd, field: 'problemId', 'errors')}">
              <g:select name="problemId"
                    from="${Problem.list()}"
                    value="${cmd?.problemId}"
                    optionKey="id" optionValue="title"
                    noSelection="${['0':'Не выбрана...']}" />
        </td>
        </tr>

        </tbody>
      </table>
    </div>
    <div class="buttons">
      <span class="button"><g:submitButton name="linkToProblem" class="edit" value="Далее" /></span>
      <g:link controller="incident" action="show" params="[id:cmd?.incidentId]">Назад</g:link>
    </div>
    <g:hiddenField name="incidentId" value="${cmd?.incidentId}"/>
  </g:form>

  
  
</div>
</body>
</html>
