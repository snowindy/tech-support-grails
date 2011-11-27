<head>
  <meta name="layout" content="main" />
  <title>Просмотр пользователя</title>
</head>

<body>

  <g:render template="navbar" model="[showUsers:true]"/>

  <div class="body">
    <h1>Просмотр пользователя</h1>
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    <div class="dialog">
      <table>
        <tbody>

          <tr class="prop">
            <td valign="top" class="name">ID:</td>
            <td valign="top" class="value">${person.id}</td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">Логин:</td>
            <td valign="top" class="value">${person.username?.encodeAsHTML()}</td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">Имя:</td>
            <td valign="top" class="value">${person.userRealName?.encodeAsHTML()}</td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">Разблокирован:</td>
            <td valign="top" class="value">${person.enabled?"Да":"Нет"}</td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">Почта:</td>
            <td valign="top" class="value">${person.email?.encodeAsHTML()}</td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">Группа:</td>
            <td valign="top" class="value">${person.group?.encodeAsHTML()}</td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">Роли:</td>
          <td valign="top" class="value">
            <ul>
              <g:each in="${roleNames}" var='name'>
                <li>${name}</li>
              </g:each>
            </ul>
          </td>
        </tr>

        </tbody>
      </table>
    </div>

    <div class="buttons">
      <g:form>
        <input type="hidden" name="id" value="${person.id}" />
        <span class="button"><g:actionSubmit class="edit" action="edit" value="Редактировать" /></span>
        <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Вы уверены?');" value="Удалить" /></span>
      </g:form>
    </div>

  </div>
</body>
