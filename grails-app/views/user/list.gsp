<head>
  <meta name="layout" content="main" />
  <title>Список пользователей</title>
</head>

<body>

<g:render template="navbar" model="[showUsers:true]"/>

<div class="body">
  <h1>Список пользователей</h1>
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <div class="list">
    <table>
      <thead>
        <tr>
      <g:sortableColumn property="id" title="Id" />
      <g:sortableColumn property="username" title="Логин" />
      <g:sortableColumn property="userRealName" title="Имя" />
      <g:sortableColumn property="enabled" title="Статус" />
      </tr>
      </thead>
      <tbody>
      <g:each in="${personList}" status="i" var="person">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
          <td>${person.id}</td>

          <td>
        <g:link action="show" id="${person.id}">${person.username?.encodeAsHTML()}</g:link></td>
        <td>
        <g:link action="show" id="${person.id}">${person.userRealName?.encodeAsHTML()}</g:link>

        </td>
        <td>
        <g:message code="user.enabled.${person.enabled?.encodeAsHTML()}"/></td>
        </tr>
      </g:each>
      </tbody>
    </table>
  </div>

  <div class="paginateButtons">
    <g:paginate total="${eg.User.count()}" />
  </div>

</div>
</body>
