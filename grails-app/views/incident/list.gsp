
<%@ page import="eg.Incident" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />

  <title>
    <g:if test="${my.isClient()}">
      Мои инциденты
    </g:if>
    <g:else>
      Просмотр инцидентов
    </g:else>

  </title>

</head>
<body>

<g:render template="navbar"/>
<div class="body">
  <g:render template="/includes/filters" model="[entityName:'incident']" />

  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <div class="list">
    <table>
      <thead>
        <tr>

      <g:sortableColumn property="priority" title="Приоритет" />
      <g:sortableColumn property="title" title="Тема" />
      <g:sortableColumn property="type" title="Тип" />

      <th>Автор / Группа</th>

      <g:sortableColumn property="status" title="Статус" />

      <g:sortableColumn property="dateCreated" title="Дата создания" />

      </tr>
      </thead>
      <tbody>
      <g:each in="${incidentInstanceList}" status="i" var="incidentInstance">
        <g:render template="inList" model="[incidentInstance:incidentInstance,i:i]" />
      </g:each>
      </tbody>
    </table>
  </div>
  <div class="paginateButtons">
    <g:paginate max="20" total="${incidentInstanceTotal}" />
  </div>

</div>
</body>
</html>
