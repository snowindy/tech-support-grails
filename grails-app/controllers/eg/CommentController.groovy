package eg
import org.codehaus.groovy.grails.plugins.springsecurity.Secured

@Secured(['ROLE_ADMIN','ROLE_TECHSPEC','ROLE_PROBLEM_MANAGER','ROLE_INCIDENT_MANAGER','ROLE_CLIENT'])
class CommentController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [commentInstanceList: Comment.list(params), commentInstanceTotal: Comment.count()]
    }
    @Secured(['ROLE_TECHSPEC','ROLE_CLIENT'])
    def create = {
        def commentInstance = new Comment()
        commentInstance.properties = params
        return [commentInstance: commentInstance]
    }

    AuthService authService

    def servletContext

    def fileService

    @Secured(['ROLE_TECHSPEC','ROLE_CLIENT'])
    def save = {

        params['author.id'] = authService.getThisUser().id
        params[params.entityType+'.id'] = params.entityId

        def commentInstance = new Comment(params)
        fileService.attachFile(request, commentInstance)
        
        if (commentInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'comment.label', default: 'Comment'), commentInstance.id])}"

            try{
                def entity = commentInstance.incident?:commentInstance.problem

                sendMail {
                    to entity.author.email
                    subject "Добавлен комментарий к \"${entity.title}\""
                    html g.render(template:"/mail/commentAdded",
                        g.createLink(controller:params.entityType, action:'show', params:[id:params.entityId]),
                        model:[entity:entity,commentInstance:commentInstance])
                }
            }catch (Exception e){
                //log.error e
                e.printStackTrace()
            }

            redirect(controller:params.entityType, action:"show", id:params.entityId, commentInstance:commentInstance)
        }
        else {
            //render(view:"incident/show", id:params.entityId, model:[commentInstance: commentInstance])
            flash.commentInstance = commentInstance
            redirect(controller:params.entityType, action:"show", id:params.entityId)
        }
    }

    def show = {
        def commentInstance = Comment.get(params.id)
        if (!commentInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'comment.label', default: 'Comment'), params.id])}"
            redirect(action: "list")
        }
        else {
            [commentInstance: commentInstance]
        }
    }
    @Secured(['ROLE_TECHSPEC','ROLE_CLIENT'])
    def edit = {
        def commentInstance = Comment.get(params.id)
        if (!commentInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'comment.label', default: 'Comment'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [commentInstance: commentInstance]
        }
    }

    @Secured(['ROLE_TECHSPEC','ROLE_CLIENT'])
    def update = {
        def commentInstance = Comment.get(params.id)
        if (commentInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (commentInstance.version > version) {
                    
                    commentInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'comment.label', default: 'Comment')] as Object[], "Another user has updated this Comment while you were editing")
                    render(view: "edit", model: [commentInstance: commentInstance])
                    return
                }
            }
            commentInstance.properties = params
            if (!commentInstance.hasErrors() && commentInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'comment.label', default: 'Comment'), commentInstance.id])}"
                redirect(action: "show", id: commentInstance.id)
            }
            else {
                render(view: "edit", model: [commentInstance: commentInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'comment.label', default: 'Comment'), params.id])}"
            redirect(action: "list")
        }
    }

    @Secured(['ROLE_ADMIN'])
    def delete = {
        def commentInstance = Comment.get(params.id)
        if (commentInstance) {
            try {
                commentInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'comment.label', default: 'Comment'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'comment.label', default: 'Comment'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'comment.label', default: 'Comment'), params.id])}"
            redirect(action: "list")
        }
    }
}
