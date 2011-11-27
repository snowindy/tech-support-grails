
<%@ page import="eg.Comment" %>

<g:hasErrors bean="${commentInstance}">
  <div class="errors">
    <g:renderErrors bean="${commentInstance}" as="list" />
  </div>
</g:hasErrors>
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
<g:uploadForm action="save" controller="comment" method="post" >
  <g:hiddenField name="entityId" value="${entity?.id}" />
  <g:hiddenField name="entityType" value="${entity?.class?.getSimpleName()?.toLowerCase()}" />
  <div class="comment-dialog">
    <table>
      <tbody>
        <tr class="prop">
          <td valign="top" class="add-comment">
            Добавление комментария:
          </td>
      </tr>

      <tr class="prop">
        <td valign="top" class="value ${hasErrors(bean: commentInstance, field: 'descr', 'errors')}">
          <div class="yui-skin-sam">
       <gui:richEditor id='editor' name="descr" value="${commentInstance?.descr}" width="500" height="180"/>
          </div>
          <div class="add-file">
            Также прикрепить файл: <input type="file" name="attachedFile" />
          </div>


       
    
      </td>
      </tr>


      </tbody>
    </table>
  </div>
  <div class="buttons">
    <span class="button"><g:submitButton name="create" class="save" value="Добавить комментарий" /></span>
    
  </div>
</g:uploadForm>
