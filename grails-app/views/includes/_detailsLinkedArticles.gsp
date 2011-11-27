<g:if test="${entity.articles}">
  <tr>
    <td>Прикрепленные статьи базы знаний:</td>
    <td>
      <ul>
        <g:each in="${entity.articles}" var="art">
          <li>
          <g:link controller="article" action="show" id="${art.id}">
${art.title}
          </g:link>
          </li>
        </g:each>
      </ul>
    </td>
  </tr>
</g:if>