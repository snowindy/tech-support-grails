package eg

/**
 *
 * @author eg
 */
class AssignController {

    def authService

    def assign = { AssignCommand assignCmd ->
        
        if (assignCmd.hasErrors()){
            
            render(view: "assign", model: [assignCmd: assignCmd])
        }else{
            def incidentInstance = Incident.get(assignCmd.id)
            if (incidentInstance) {
                incidentInstance.assignedSpec = authService.getThisUser()
                incidentInstance.priority = assignCmd.priority
                incidentInstance.type = assignCmd.type
                incidentInstance.status = Incident.STATUS_OPEN
                incidentInstance.save(flush: true)

                redirect(controller:'incident', action: "show", id:incidentInstance.id)
            }
        }
        
    }

    def index = {
        def inc = Incident.get(params.id)
        render(view: "assign", model: [assignCmd: inc])
    }
}

