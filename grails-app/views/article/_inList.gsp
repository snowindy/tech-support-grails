<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

  <td>
<g:link action="show" id="${articleInstance.id}">
${fieldValue(bean: articleInstance, field: "title")}

</g:link>
</td>

<td>${articleInstance?.author}</td>

<td><g:formatDate date="${articleInstance.dateCreated}" /></td>

</tr>