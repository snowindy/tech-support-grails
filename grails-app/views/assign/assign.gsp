
<%@ page import="eg.Incident" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />

  <title>
    Взять в обработку
  </title>

</head>
<body>

<g:render template="/incident/navbar"/>
<div class="body">
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <g:hasErrors bean="${assignCmd}">
    <div class="errors">
      <g:renderErrors bean="${assignCmd}" as="list" />
    </div>
  </g:hasErrors>

  <g:form action="assign" method="post" >
    <g:hiddenField name="id" value="${assignCmd.id}"/>
    <div class="dialog">
      <table>
        <tbody>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="title">Тип запроса</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: assignCmd, field: 'type', 'errors')}">
              <g:select name="type"
                    from="${[1,2,3]}"
                    value="${assignCmd?.type}"
                    valueMessagePrefix="incident.type" />
        </td>
        </tr>

        <tr class="prop">
            <td valign="top" class="name">
              <label for="title">Приоритет</label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: assignCmd, field: 'priority', 'errors')}">
              <g:select name="priority"
                    from="${[1,2,3]}"
                    value="${assignCmd?.priority}"
                    valueMessagePrefix="priority" />
        </td>
        </tr>



        </tbody>
      </table>
    </div>
    <div class="buttons">
      <span class="button"><g:submitButton name="assign" class="edit" value="Далее" /></span>
      <g:link controller="incident" action="show" params="[id:assignCmd?.id]">Назад</g:link>
    </div>
  </g:form>

  
  
</div>
</body>
</html>
