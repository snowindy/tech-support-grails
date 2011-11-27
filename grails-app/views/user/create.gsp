<head>
  <meta name="layout" content="main" />
  <title>Создание пользователя</title>
</head>

<body>

  <g:render template="navbar" model="[showUsers:true]"/>

  <div class="body">
    <h1>Создание пользователя</h1>
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${person}">
      <div class="errors">
        <g:renderErrors bean="${person}" as="list" />
      </div>
    </g:hasErrors>
    <g:form action="save">
      <div class="dialog">
        <table>
          <tbody>

            <tr class="prop">
              <td valign="top" class="name"><label for="username">Логин:</label></td>
              <td valign="top" class="value ${hasErrors(bean:person,field:'username','errors')}">
                <input type="text" id="username" name="username" value="${person.username?.encodeAsHTML()}"/>
              </td>
            </tr>

            <tr class="prop">
              <td valign="top" class="name"><label for="userRealName">Имя:</label></td>
              <td valign="top" class="value ${hasErrors(bean:person,field:'userRealName','errors')}">
                <input type="text" id="userRealName" name="userRealName" value="${person.userRealName?.encodeAsHTML()}"/>
              </td>
            </tr>

            <tr class="prop">
              <td valign="top" class="name"><label for="passwd">Пароль:</label></td>
              <td valign="top" class="value ${hasErrors(bean:person,field:'passwd','errors')}">
                <input type="password" id="passwd" name="passwd" value="${person.passwd?.encodeAsHTML()}"/>
              </td>
            </tr>

            <tr class="prop">
              <td valign="top" class="name"><label for="enabled">Разблокирован:</label></td>
              <td valign="top" class="value ${hasErrors(bean:person,field:'enabled','errors')}">
          <g:checkBox name="enabled" value="${person.enabled}" ></g:checkBox>
          </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name"><label for="email">Почта:</label></td>
            <td valign="top" class="value ${hasErrors(bean:person,field:'email','errors')}">
              <input type="text" id="email" name="email" value="${person.email?.encodeAsHTML()}"/>
            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">Группа:</td>
            <td valign="top" class="value">
              <g:select id="group" name='group.id' value="${person?.group?.id}"
    noSelection="${['null':'Не установлено...']}"
    from='${groupList}'
    optionKey="id" optionValue="name"></g:select>
          </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name" align="left">Присвоенные роли:</td>
          </tr>

          <g:each in="${authorityList}">
            <tr>
              <td valign="top" class="name" align="left">${it.description.encodeAsHTML()}</td>
              <td align="left"><g:checkBox name="${it.authority}"/></td>
            </tr>
          </g:each>

          </tbody>
        </table>
      </div>

      <div class="buttons">
        <span class="button"><input class="save" type="submit" value="Создать" /></span>
      </div>

    </g:form>

  </div>
</body>
