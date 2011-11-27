
<%@ page import="eg.Problem" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Просмотр проблем</title>
    </head>
    <body>
      <g:render template="navbar"/>

      <div class="body">
  <g:render template="/includes/filters" model="[entityName:'problem']" />

  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <div class="list">
    <table>
      <thead>
        <tr>

      <g:sortableColumn property="priority" title="Приоритет" />

      <g:sortableColumn property="title" title="Тема" />

      <th>Автор</th>

      <g:sortableColumn property="status" title="Статус" />

      <g:sortableColumn property="dateCreated" title="Дата создания" />

      </tr>
      </thead>
      <tbody>

      <g:each in="${problems}" status="i" var="prob">
        <g:render template="inList" model="[prob:prob,i:i]" />
      </g:each>
      </tbody>
    </table>
  </div>
  <div class="paginateButtons">
    <g:paginate max="20" total="${problemsCount}" />
  </div>

</div>

    </body>
</html>
