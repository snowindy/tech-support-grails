
<%@ page import="eg.Incident" %>
<%@ page import="eg.Comment" %>
<%@ page import="eg.Problem" %>

<div class="problem">
  <h1>Проблема: ${prob.title}</h1>
  <div class="entity-wrapper">
    <table class="entity-metadata">
      <g:render template="/includes/detailsPriority" model="[entity:prob]"/>
      <tr>
        <td>Статус: <g:message code="problem.status.${prob.status}"/></td>
      <td>Прикреплена к специалисту: ${prob.assignedSpec?:'Пока не прикреплен'}</td>
      </tr>
      <tr>
        <td>Автор: ${prob.author}</td>
        <td>Создана: <my:dateFormat date="${prob.dateCreated}"/></td>
      </tr>

      <g:if test="${prob.incidents}">
        <tr>
          <td>Прикрепленные запросы:</td>
          <td>
            <ul>
              <g:each in="${prob.incidents}" var="inc">
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

      <g:render template="/includes/detailsLinkedArticles" model="[entity:prob]"/>

      <g:render template="/includes/detailsAttachedFiles" model="[entity:prob, style:'tableRow']"/>


    </table>
    <div class="descr">
${prob.descr}
    </div>


    <div class="buttons">
      <g:uploadForm>
        <g:hiddenField name="id" value="${prob?.id}" />
        <my:isTechSpec>
          <span class="button"><g:actionSubmit class="edit" action="edit" value="Редактировать" /></span>
        </my:isTechSpec>
        <my:isAdmin>
          <span class="button"><g:actionSubmit class="delete" action="delete" value="Удалить" onclick="return confirm('Вы уверены?');" /></span>
          <span class="cb-separator">|</span>
        </my:isAdmin>
        <my:isProblemManager>
          <g:if test="${prob?.status == Problem.STATUS_NEW || prob?.status == Problem.STATUS_OPEN  || prob?.status == Problem.STATUS_SUSPENDED}">
            <g:if test="${!assigned}">
              <span class="button">
                <g:actionSubmit class="edit" action="assign" value="Взять в обработку"/>
              </span>

            </g:if>

            <g:if test="${assignedToMe}">
              <span class="button"><g:actionSubmit class="edit" action="unAssign" value="Снять с обработки"/></span>
            </g:if>
          </g:if>

        </my:isProblemManager>


        <g:render template="/includes/detailsLinkArticles" model="[entity:prob]"/>

        <g:render template="/includes/changeStatus" model="[entity:prob,statuses:0..3,entityName:'problem']"/>
        <div class="add-file">
          Прикрепить файл: <input type="file" name="attachedFile" />
          <g:actionSubmit value="Загрузить" action="attachFile" />
        </div>
      </g:uploadForm>
    </div>
  </div>

  <g:render template="/includes/detailsComments" model="[comments:comments]"/>


</div>
