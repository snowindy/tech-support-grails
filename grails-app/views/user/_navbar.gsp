<div class="before-sub-navbar">
  <h1>
    Управление <g:if test="${showUsers}">пользователями</g:if>
        <g:else>группами</g:else>

  </h1>
</div>
<div class="nav sub-nav"
  <span class="menuButton"><g:link controller="user" class="list" action="list">Пользователи</g:link></span>
  <g:if test="${showUsers}">
    <span class="menuButton"><g:link class="create" action="create">Создать пользователя</g:link></span>
  </g:if>
  &nbsp;|&nbsp;
  
  <span class="menuButton"><g:link controller="userGroup" class="list" action="list">Пользовательские группы</g:link></span>
  <g:if test="${showGroups}">
    <span class="menuButton"><g:link  class="create" action="create">Создать группу</g:link></span>
  </g:if>
</div>