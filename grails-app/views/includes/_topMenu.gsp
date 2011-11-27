<div class="nav main-nav">


  <my:ifLoggedIn>
    <span class="pre-in-out">
      <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Запросы</a></span>
      <my:isTechSpec>
        <span class="menuButton"><g:link class="list" controller="problem">Проблемы</g:link></span>
      </my:isTechSpec>
      <span class="menuButton"><g:link class="list" controller="article">База знаний</g:link></span>
      <my:isAdmin>
        <span class="menuButton"><g:link class="list" controller="user">Пользователи / Группы</g:link></span>
      </my:isAdmin>

      <my:isTechSpec>
        <g:form url='[controller: "searchable", action: "index"]' class="searchableForm" name="searchableForm" method="get">
          <g:textField name="q" value="${params.q}" size="20"/> 
          <g:hiddenField name="suggestQuery" value="true" />
          <input type="submit" value="Поиск по сайту" />
        </g:form>
      </my:isTechSpec>

    </span>




  </my:ifLoggedIn>

  <span class="">
    <g:if test="${my.isLoggedIn()}">

      Вход выполнен для ${my.getThisHibernateUser()}
      <g:if test="${my.isClient()}">
        [${my.getThisHibernateUser().group.name}]
      </g:if>. <g:link controller="logout">Выйти</g:link>


    </g:if>
    <g:if test="${!my.isLoggedIn()}">
      <g:link controller="login">Войти</g:link>
    </g:if>
  </span>

</div>
