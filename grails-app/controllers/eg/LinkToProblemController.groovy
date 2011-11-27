package eg

class LinkToProblemController {

    def linkToProblem = { LinkToProblemCommand cmd ->

        if (cmd.hasErrors()){
            
            render(view: "index", model: [cmd: cmd])
        }else{
            def problemInstance = Problem.get(cmd.problemId)
            def incidentInstance = Incident.get(cmd.incidentId)

            if (incidentInstance && problemInstance){
                incidentInstance.problem = problemInstance;
                problemInstance.save(flush: true)

                redirect(controller:'incident', action: "show", id:incidentInstance.id)
            }
        }

    }

    def index = {
        def cmd = new LinkToProblemCommand()
        cmd.incidentId = params.id as int

        [cmd:cmd]
    }

}
