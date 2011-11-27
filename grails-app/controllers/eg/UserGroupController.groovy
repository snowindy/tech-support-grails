package eg

class UserGroupController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [userGroupInstanceList: UserGroup.list(params), userGroupInstanceTotal: UserGroup.count()]
    }

    def create = {
        def userGroupInstance = new UserGroup()
        userGroupInstance.properties = params
        return [userGroupInstance: userGroupInstance]
    }

    def save = {
        def userGroupInstance = new UserGroup(params)
        if (userGroupInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'userGroup.label', default: 'UserGroup'), userGroupInstance.id])}"
            redirect(action: "show", id: userGroupInstance.id)
        }
        else {
            render(view: "create", model: [userGroupInstance: userGroupInstance])
        }
    }

    def show = {
        def userGroupInstance = UserGroup.get(params.id)
        if (!userGroupInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'userGroup.label', default: 'UserGroup'), params.id])}"
            redirect(action: "list")
        }
        else {
            [userGroupInstance: userGroupInstance]
        }
    }

    def edit = {
        def userGroupInstance = UserGroup.get(params.id)
        if (!userGroupInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'userGroup.label', default: 'UserGroup'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [userGroupInstance: userGroupInstance]
        }
    }

    def update = {
        def userGroupInstance = UserGroup.get(params.id)
        if (userGroupInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (userGroupInstance.version > version) {
                    
                    userGroupInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'userGroup.label', default: 'UserGroup')] as Object[], "Another user has updated this UserGroup while you were editing")
                    render(view: "edit", model: [userGroupInstance: userGroupInstance])
                    return
                }
            }
            userGroupInstance.properties = params
            if (!userGroupInstance.hasErrors() && userGroupInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'userGroup.label', default: 'UserGroup'), userGroupInstance.id])}"
                redirect(action: "show", id: userGroupInstance.id)
            }
            else {
                render(view: "edit", model: [userGroupInstance: userGroupInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'userGroup.label', default: 'UserGroup'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def userGroupInstance = UserGroup.get(params.id)
        if (userGroupInstance) {
            try {
                userGroupInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'userGroup.label', default: 'UserGroup'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'userGroup.label', default: 'UserGroup'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'userGroup.label', default: 'UserGroup'), params.id])}"
            redirect(action: "list")
        }
    }
}
