
<%@ page import="eg.Incident" %>
<%@ page import="eg.Comment" %>

<div class="incident">
  <h1><g:message code="incident.type.${incidentInstance.type}" />: ${incidentInstance.title}</h1>
  <div class="entity-wrapper">
    <table class="entity-metadata">

      <g:render template="/includes/detailsPriority" model="[entity:incidentInstance]"/>
      <tr>
        <td>Статус: <g:message code="incident.status.${incidentInstance.status}"/></td>
      <td>Прикреплен к специалисту: ${incidentInstance.assignedSpec?:'Пока не прикреплен'}</td>
      </tr>
      <tr>
        <td>Автор: ${incidentInstance.author}</td>
        <td>Создан: <my:dateFormat date="${incidentInstance.dateCreated}"/></td>
      </tr>
      <my:isTechSpec>
        <g:if test="${incidentInstance.problem}">
          <tr>
            <td>Прикреплен к проблеме:</td>
            <td>
          <g:link controller="problem" action="show" id="${incidentInstance?.problem?.id}" >${incidentInstance?.problem?.title}</g:link>

          </td>
          </tr>
        </g:if>
      </my:isTechSpec>


      <g:render template="/includes/detailsLinkedArticles" model="[entity:incidentInstance]"/>

      <g:render template="/includes/detailsAttachedFiles" model="[entity:incidentInstance, style:'tableRow']"/>


    </table>
    <div class="descr">
${incidentInstance.descr}
    </div>

    <div class="buttons">
      <g:uploadForm>
        <g:hiddenField name="id" value="${incidentInstance?.id}" />
        <my:isTechSpec>
          <span class="button"><g:actionSubmit class="edit" action="edit" value="Редактировать" /></span>
        </my:isTechSpec>
        <my:isAdmin>
          <span class="button"><g:actionSubmit class="delete" action="delete" value="Удалить" onclick="return confirm('Вы уверены?');" /></span>
          <span class="cb-separator">|</span>
        </my:isAdmin>
        <my:isIncidentManager>
          <g:if test="${incidentInstance?.status == Incident.STATUS_NEW  ||incidentInstance?.status == Incident.STATUS_OPEN  || incidentInstance?.status == Incident.STATUS_SUSPENDED}">
            <g:if test="${!assigned}">
              <span class="control-link">
                <g:link controller="assign" params="[id:incidentInstance?.id]" >Взять в обработку</g:link>
              </span>

            </g:if>

            <g:if test="${assignedToMe}">
              <span class="button"><g:actionSubmit class="edit" action="unAssign" value="Снять с обработки"/></span>
            </g:if>
            <span class="cb-separator">|</span>
            <g:if test="${!incidentInstance.problem}">
              <span class="control-link">
                <g:link controller="linkToProblem" params="[id:incidentInstance?.id]" >Прикрепить к проблеме</g:link>
              </span>

            </g:if>
            <g:else>
              <g:actionSubmit class="delete" action="unlinkProblem" value="Открепить от проблемы" />
            </g:else>
          </g:if>

        </my:isIncidentManager>

        <g:render template="/includes/detailsLinkArticles" model="[entity:incidentInstance]"/>

        <g:render template="/includes/changeStatus" model="[entity:incidentInstance,statuses:0..4,entityName:'incident']"/>

        <div class="add-file">
          Прикрепить файл: <input type="file" name="attachedFile" />
          <g:actionSubmit value="Загрузить" action="attachFile" />
        </div>
      </g:uploadForm>

    </div>
  </div>
  <g:render template="/includes/detailsComments" model="[comments:comments]"/>


</div>
