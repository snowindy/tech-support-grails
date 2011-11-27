<g:form>
    <g:hiddenField name="filtersApplied" value="1"/>
  <fieldset  class="filters">
    <legend>Фильтры</legend>
    <g:each in="${params.filters}" status="i" var="entry">
      <span><g:checkBox name="filters.${entry.key}" value="${entry.value}"/>
        <g:message code="${entityName}.status.${entry.key}"/></span>
    </g:each>
    <br/>
    <span class="button"><g:actionSubmit class="list" action="list" value="Применить фильтры" /></span>

  </fieldset>
</g:form>
