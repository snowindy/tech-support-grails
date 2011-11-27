<div class="buttons">
  <span class="button"><g:actionSubmit class="save" action="update" value="Обновить" /></span>
  <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Удалить')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Вы уверены?')}');" /></span>
  <span class="button"><g:actionSubmit class="delete" action="show" value="Отмена" /></span>
</div>