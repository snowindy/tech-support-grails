<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

  <td class="priority priority-${prob.priority}">
      <g:message code="priority.${prob.priority}"/>
   </td>

  <td><g:link action="show" id="${prob.id}">${prob.title}</g:link></td>

<td>${prob?.author}</td>

<td><g:message code="problem.status.${prob.status}"/></td>

<td><my:dateFormat date="${prob.dateCreated}" /></td>

</tr>