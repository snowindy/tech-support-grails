
<%@ page import="eg.UserGroup" %>

<head>
  <meta name="layout" content="main" />
  <title>Редактирование пользователя</title>
</head>

<body>

<g:render template="navbar" model="[showUsers:true]"/>

<div class="body">
  <h1>Редактирование пользователя</h1>
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <g:hasErrors bean="${person}">
    <div class="errors">
      <g:renderErrors bean="${person}" as="list" />
    </div>
  </g:hasErrors>

  <g:form>
    <input type="hidden" name="id" value="${person.id}" />
    <input type="hidden" name="version" value="${person.version}" />
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
            <td valign="top" class="name"><label for="enabled">Разблокирован:</label></td>
            <td valign="top" class="value ${hasErrors(bean:person,field:'enabled','errors')}">
        <g:checkBox name="enabled" value="${person.enabled}"/>
        </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><label for="email">Почта:</label></td>
          <td valign="top" class="value ${hasErrors(bean:person,field:'email','errors')}">
            <input type="text" id="email" name="email" value="${person?.email?.encodeAsHTML()}"/>
          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">Группа:</td>
          <td valign="top" class="value">
        <g:select id="group" name='group.id' value="${person?.group?.id}"
                  noSelection="${['null':'Не установлено...']}"
                  from='${UserGroup.list()}'
                  optionKey="id" optionValue="name"></g:select>
        </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name"><label for="authorities">Роли:</label></td>
          <td valign="top" class="value ${hasErrors(bean:person,field:'authorities','errors')}">
            <ul>
              <g:each var="entry" in="${roleMap}">
                <li>${entry.key.description.encodeAsHTML()}
                <g:checkBox name="${entry.key.authority}" value="${entry.value}"/>
                </li>
              </g:each>
            </ul>
          </td>
        </tr>

        </tbody>
      </table>
    </div>

    <div class="buttons">
      <span class="button"><g:actionSubmit class="save" action="update" value="Обновить" /></span>
      <span class="button"><g:actionSubmit class="delete" action="show" value="Отмена" /></span>
      <span class="button">
        <g:actionSubmit class="delete" action="delete"
                        onclick="return confirm('Вы уверены?');" value="Удалить" /></span>
    </div>

  </g:form>

</div>
</body>
