<g:if test="${entity.files}">

  <g:if test="${style == 'tableRow'}">
    <tr>
      <td>Прикрепленные файлы:</td>
      <td>

        <ul>
          <g:each in="${entity.files}" var="f">
            <li>
            <g:link controller="storedFile" action="download" id="${f.id}">
${f.filename}
            </g:link>

            </li>
          </g:each>
        </ul>

      </td>
    </tr>
  </g:if>
  <g:else>
    <div class="attached-files">
      Прикрепленные файлы
      <ul>
        <g:each in="${entity.files}" var="f">
          <li>
          <g:link controller="storedFile" action="download" id="${f.id}">
${f.filename}
          </g:link>

          </li>
        </g:each>
      </ul>
    </div>
  </g:else>



</g:if>