<div class="before-sub-navbar">
  <h1>
    <g:if test="${!my.isClient()}">
      Мои запросы
    </g:if>
    <g:else>
      Просмотр запросов
    </g:else>
  </h1>
</div>
<div class="nav sub-nav">
  <span class="menuButton"><g:link controller="incident" class="list" action="list">Запросы</g:link></span>
  <span class="menuButton"><g:link controller="incident" class="create" action="create">Зарегистрировать запрос</g:link></span>

</div>