
<%@ page import="eg.Article" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
  
  <title>Статьи базы знаний</title>
</head>
<body>
<g:render template="navbar"/>
<div class="body">
  <h1>Статьи базы знаний</h1>
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <div class="list">
    <table>
      <thead>
        <tr>
      <g:sortableColumn property="title" title="Тема" />

      <th>Автор</th>

      <g:sortableColumn property="dateCreated" title="Дата создания" />

      </tr>
      </thead>
      <tbody>
      <g:each in="${articleInstanceList}" status="i" var="articleInstance">
        <g:render template="inList" model="[articleInstance:articleInstance,i:i]" />
      </g:each>

      </tbody>
    </table>
  </div>
  <div class="paginateButtons">
    <g:paginate total="${articleInstanceTotal}" />
  </div>
</div>
</body>
</html>
