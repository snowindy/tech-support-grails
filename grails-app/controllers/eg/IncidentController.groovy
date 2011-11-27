package eg

class IncidentController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def filterService
    def fileService

    def attachFile = {
        def incidentInstance = Incident.get(params.id)
        fileService.attachFile(request, incidentInstance)
        incidentInstance.save(flush: true)
        redirect(action: "show", id: incidentInstance.id)

    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 20, 100)

        def allowedStatuses = filterService.getAllowedStatuses(params, session,'incFilters', ['0':true,
                '1':true,
                '2':true,
                '3':false,
                '4':false])

        def incidentInstanceList, incidentInstanceTotal;
        def user = authService.getThisHibernateUser()

        incidentInstanceList =  Incident.createCriteria().list {
            if (authService.isClient()){
                author{
                    eq("group", user.group)
                }
            }
            if (params.filters != null){
                or{
                    allowedStatuses.each{
                        eq('status', Integer.parseInt(it))
                    }
                }
            }
            order("priority", "asc")
            order("status", "asc")
            order("dateCreated", "desc")
            maxResults(params.max)
            firstResult(params.offset)
        }

        incidentInstanceTotal =  Incident.createCriteria().count {
            if (authService.isClient()){
                author{
                    eq("group", user.group)
                }
            }
            if (params.filters != null){
                or{
                    allowedStatuses.each{
                        eq('status', Integer.parseInt(it))
                    }
                }
            }
        }



        [incidentInstanceList: incidentInstanceList, incidentInstanceTotal: incidentInstanceTotal]
    }

    def userService

    def create = {
        //        def cRole = Role.findByAuthority(Role.ROLE_CLIENT)
        //        def authors = cRole.people;

        def incidentInstance = new Incident()
        incidentInstance.properties = params
        return [incidentInstance: incidentInstance,authorUsers:userService.getUsersWithAuthorPriveleges()]
    }

    def save = {
        if (!params['author.id'] || params.author.id as int == 0){
            params['author.id'] = authService.getThisUser().id
        }
        
        def incidentInstance = new Incident(params)
        if (incidentInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'incident.label', default: 'Incident'), incidentInstance.id])}"
            redirect(action: "show", id: incidentInstance.id)
        }
        else {
            render(view: "create", model: [incidentInstance: incidentInstance])
        }
    }

    def authService

    def linkArticles = {
        def incidentInstance = Incident.get(params.id)
        
        [incidentInstance: incidentInstance]
    }

    def show = {

        def incidentInstance = Incident.get(params.id)

        if (!incidentInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'incident.label', default: 'Incident'), params.id])}"
            redirect(action: "list")
        }
        else {

            def comments = Comment.findAll("from Comment as com where com.incident = ? order by com.dateCreated desc", [incidentInstance])

            [incidentInstance: incidentInstance,commentInstance:flash.commentInstance,
                comments:comments, assigned: (incidentInstance.assignedSpec != null),
                assignedToMe:(incidentInstance?.assignedSpec?.id == authService.getThisUser().id)]
        }
    }

    def unlinkProblem = {
        def incidentInstance = Incident.get(params.id)

        if (incidentInstance) {
            incidentInstance.problem = null
            incidentInstance.save(flush:true)
            redirect(action: "show", id: incidentInstance.id)
        }
    }

    def statusService

    def edit = {
        def incidentInstance = Incident.get(params.id)
        if (!incidentInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'incident.label', default: 'Incident'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [incidentInstance: incidentInstance]
        }
    }

    def update = {
        def incidentInstance = Incident.get(params.id)
        if (incidentInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (incidentInstance.version > version) {
                    
                    incidentInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'incident.label', default: 'Incident')] as Object[], "Another user has updated this Incident while you were editing")
                    render(view: "edit", model: [incidentInstance: incidentInstance])
                    return
                }
            }
            incidentInstance.properties = params
            if ('updateLinkedArticles' == params.reqType && !params.articles){
                incidentInstance.articles = null
            }

            if (!incidentInstance.hasErrors() && incidentInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'incident.label', default: 'Incident'), incidentInstance.id])}"
                redirect(action: "show", id: incidentInstance.id)
            }
            else {
                render(view: "edit", model: [incidentInstance: incidentInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'incident.label', default: 'Incident'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def incidentInstance = Incident.get(params.id)
        if (incidentInstance) {
            try {
                incidentInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'incident.label', default: 'Incident'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'incident.label', default: 'Incident'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'incident.label', default: 'Incident'), params.id])}"
            redirect(action: "list")
        }
    }

    def unAssign = {
        def incidentInstance = Incident.get(params.id)
        if (incidentInstance) {
            incidentInstance.assignedSpec = null
            incidentInstance.save(flush: true)

            redirect(action: "show", id:incidentInstance.id)
        }
    }


}
