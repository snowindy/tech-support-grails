
<%@ page import="eg.Comment" %>

<g:if test="${flash.message}">
  <div class="message">${flash.message}</div>
</g:if>
<g:hasErrors bean="${commentInstance}">
  <div class="errors">
    <g:renderErrors bean="${commentInstance}" as="list" />
  </div>
</g:hasErrors>
<g:form action="save" method="post" >
  <div class="dialog">
    <table>
      <tbody>
        <tr class="prop">
          <td valign="top" class="name">
            <label for="title"><g:message code="comment.title.label" default="Title" /></label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: commentInstance, field: 'title', 'errors')}">
      <g:textField name="title" value="${commentInstance?.title}" />
      </td>
      </tr>

      <tr class="prop">
        <td valign="top" class="name">
          <label for="descr"><g:message code="comment.descr.label" default="Описание" /></label>
        </td>
        <td valign="top" class="value ${hasErrors(bean: commentInstance, field: 'descr', 'errors')}">
      <g:textArea name="descr" cols="40" rows="5" value="${commentInstance?.descr}" />
      </td>
      </tr>


      </tbody>
    </table>
  </div>
  <div class="buttons">
    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Создать')}" /></span>
  </div>
</g:form>
