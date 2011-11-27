package eg

class ProblemController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def authService
    def filterService
    def fileService

    def attachFile = {
        def problemInstance = Problem.get(params.id)
        fileService.attachFile(request, problemInstance)
        problemInstance.save(flush: true)
        redirect(action: "show", id: problemInstance.id)

    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 20, 100)

        def allowedStatuses = filterService.getAllowedStatuses(params, session,'problFilters', ['0':true,
                '1':true,
                '2':true,
                '3':false])
        
        def problems, problemsCount;

        problems =  Problem.createCriteria().list {
            if (params.filters != null){
                or{
                    allowedStatuses.each{
                        eq('status', Integer.parseInt(it))
                    }
                }
            }

            order("dateCreated", "desc")
            maxResults(params.max)
            firstResult(params.offset)
        }

        problemsCount =  Problem.createCriteria().count {
            if (params.filters != null){
                or{
                    allowedStatuses.each{
                        eq('status', Integer.parseInt(it))
                    }
                }
            }
        }

        [problems: problems, problemsCount: problemsCount]
    }

    def create = {
        def problemInstance = new Problem()
        problemInstance.properties = params
        return [problemInstance: problemInstance]
    }

    def save = {

        params['author.id'] = authService.getThisUser().id
        def problemInstance = new Problem(params)
        if (problemInstance.save(flush: true)) {
            flash.message = "Проблема зарегистрирована"
            redirect(action: "show", id: problemInstance.id)
        }
        else {
            render(view: "create", model: [problemInstance: problemInstance])
        }

    }

    def linkArticles = {
        def problemInstance = Problem.get(params.id)

        [problemInstance: problemInstance]
    }

    def show = {
        def problemInstance = Problem.get(params.id)
        if (!problemInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'problem.label', default: 'Problem'), params.id])}"
            redirect(action: "list")
        }
        else {
            def comments = Comment.findAll("from Comment as com where com.problem = ? order by com.dateCreated desc", [problemInstance])

            [problemInstance: problemInstance, commentInstance:flash.commentInstance,
                comments:comments, assigned: (problemInstance.assignedSpec != null),
                assignedToMe:(problemInstance?.assignedSpec?.id == authService.getThisUser().id)]
        }
    }

    def edit = {

        def problemInstance = Problem.get(params.id)
        if (!problemInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'problem.label', default: 'Problem'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [problemInstance: problemInstance]
        }
    }

    def update = {
        def problemInstance = Problem.get(params.id)
        if (problemInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (problemInstance.version > version) {
                    
                    problemInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'problem.label', default: 'Problem')] as Object[], "Another user has updated this Problem while you were editing")
                    render(view: "edit", model: [problemInstance: problemInstance])
                    return
                }
            }
            problemInstance.properties = params
            if ('updateLinkedArticles' == params.reqType && !params.articles){
                incidentInstance.articles = null
            }

            if (!problemInstance.hasErrors() && problemInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'problem.label', default: 'Problem'), problemInstance.id])}"
                redirect(action: "show", id: problemInstance.id)
            }
            else {
                render(view: "edit", model: [problemInstance: problemInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'problem.label', default: 'Problem'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def problemInstance = Problem.get(params.id)
        if (problemInstance) {
            try {
                problemInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'problem.label', default: 'Problem'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'problem.label', default: 'Problem'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'problem.label', default: 'Problem'), params.id])}"
            redirect(action: "list")
        }
    }

    def assign = {
        def prob = Problem.get(params.id)

        if (prob) {
            prob.assignedSpec = authService.getThisUser()
            prob.status = SupportEntity.STATUS_OPEN
            prob.save(flush: true)

            redirect(controller:'problem', action: "show", id:params.id)
        }else{
            flash.message = "Не могу найти проблему с таким id: ${params.id}"
            redirect(controller:'problem', action: "show", id: params.id)
        }

    }


    def unAssign = {
        def prob = Problem.get(params.id)
        if (prob) {
            prob.assignedSpec = null
            prob.save(flush: true)

            redirect(action: "show", id:prob.id)
        }
    }
}
