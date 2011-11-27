<g:if test="${comments}">
  <hr/>
  <table class="attached-comments">
    <thead>
      <tr>
        <td class="attached-comments-head">Прикрепленные комментарии:</td>
      </tr>
    </thead>
    <tbody>

    <g:each in="${comments}" var="c">
      <tr>

        <td>
          <div class="single-comment">
            <table class="comment-metadata">
              <tr>
                <td>Добавлен: ${c.author}</td>
                <td>Дата публикации: <my:dateFormat date="${c.dateCreated}"/></td>
              </tr>
            </table>
            <div class="comment-descr">${c.descr}</div>
            <g:render template="/includes/detailsAttachedFiles" model="[entity:c]"/>
          </div>

        </td>
      </tr>

    </g:each>
    </tbody>



  </table>
</g:if>