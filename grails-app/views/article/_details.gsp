
<div class="problem">
  <h1>Статья базы знаний: ${articleInstance.title}</h1>
  <div class="entity-wrapper">
    <table class="entity-metadata">
      <tr>
        <td>Автор: ${articleInstance.author}</td>
        <td>Создана: <my:dateFormat date="${articleInstance.dateCreated}"/></td>
      </tr>

      <g:if test="${!my.isClient()}">
        <g:if test="${incidents}">
          <tr>
            <td>Связанные запросы:</td>
            <td>
              <ul>
                <g:each in="${incidents}" var="inc">
                  <li>
                  <g:link controller="incident" action="show" id="${inc.id}">
${inc.title}
                  </g:link>
                  </li>
                </g:each>
              </ul>
            </td>
          </tr>
        </g:if>

        <g:if test="${problems}">
          <tr>
            <td>Проблемы запросы:</td>
            <td>
              <ul>
                <g:each in="${problems}" var="prob">
                  <li>
                  <g:link controller="problems" action="show" id="${prob.id}">
${prob.title}
                  </g:link>
                  </li>
                </g:each>
              </ul>
            </td>
          </tr>
        </g:if>


        <g:if test="${articleInstance.userGroups}">

          <tr>
            <td>Статья доступна группам:</td>
            <td>
              <ul>
                <g:each in="${articleInstance.userGroups.sort{it.name}}" var="gr">
                  <li>
                  <g:link controller="userGroup" action="show" id="${gr.id}">${gr.name}</g:link>
                  </li>
                </g:each>
              </ul>
            </td>
          </tr>
        </g:if>
      </g:if>

      <g:render template="/includes/detailsAttachedFiles" model="[entity:articleInstance, style:'tableRow']"/>


    </table>
    <div class="descr">
${articleInstance.descr}
    </div>


    <div class="buttons">
      <g:uploadForm>
        <g:hiddenField name="id" value="${articleInstance?.id}" />
        <my:isTechSpec>
          <span class="button"><g:actionSubmit class="edit" action="edit" value="Редактировать" /></span>
        </my:isTechSpec>
        <my:isAdmin>
          <span class="button"><g:actionSubmit class="delete" action="delete" value="Удалить" onclick="return confirm('Вы уверены?');" /></span>
        </my:isAdmin>

        <my:isTechSpec>
          <div class="add-file">
            Прикрепить файл: <input type="file" name="attachedFile" />
            <g:actionSubmit value="Загрузить" action="attachFile" />
          </div>
        </my:isTechSpec>
      </g:uploadForm>
    </div>
  </div>


</div>
