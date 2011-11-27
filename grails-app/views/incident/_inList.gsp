<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

  <td class="priority priority-${incidentInstance.priority}">
      <g:message code="priority.${incidentInstance.priority}"/>
   </td>

   <td><g:link action="show" id="${incidentInstance.id}">${incidentInstance.title}</g:link></td>
   <td><g:message code="incident.type.${incidentInstance.type}" /></td>
  

<td>${incidentInstance?.author} - ${incidentInstance?.author?.group?.name}</td>

<td><g:message code="incident.status.${incidentInstance.status}"/></td>

<td><g:formatDate format="dd-MM-yyyy hh:mm" date="${incidentInstance.dateCreated}" /></td>

</tr>