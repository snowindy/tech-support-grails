<my:isTechSpec>
  <span class="cb-separator">|</span>
  <span class="button"><g:actionSubmit class="edit" action="update" value="Изменить статус" /> &rarr;</span>
  <g:select name="status"
            from="${statuses}"
            value="${entity?.status}"
            valueMessagePrefix="${entityName}.status" />
</my:isTechSpec>