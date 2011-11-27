package eg

import org.codehaus.groovy.grails.plugins.springsecurity.Secured

@Secured(['ROLE_ADMIN','ROLE_TECHSPEC','ROLE_PROBLEM_MANAGER','ROLE_INCIDENT_MANAGER','ROLE_CLIENT'])
class ArticleController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }
    
    def fileService

    def attachFile = {
        def articleInstance = Article.get(params.id)
        fileService.attachFile(request, articleInstance)
        articleInstance.save(flush: true)
        redirect(action: "show", id: articleInstance.id)

    }

    def authService

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)

        params.offset = params.offset? params.offset as int : 0

        def user = authService.getThisHibernateUser()

        def articleInstanceList = Article.createCriteria().list{
            
            if (authService.isClient()){
                userGroups{
                    idEq(user.group.id)
                }
            }

            order("dateCreated", "desc")
            maxResults(params.max)
            firstResult(params.offset)
        }
        [articleInstanceList: articleInstanceList, articleInstanceTotal: Article.count()]
    }

    def create = {
        def articleInstance = new Article()
        articleInstance.properties = params
        return [articleInstance: articleInstance]
    }

    def save = {
        params['author.id'] = authService.getThisUser().id

        def articleInstance = new Article(params)
        if (articleInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'article.label', default: 'Article'), articleInstance.id])}"
            redirect(action: "show", id: articleInstance.id)
        }
        else {
            render(view: "create", model: [articleInstance: articleInstance])
        }
    }

    def show = {
        def articleInstance = Article.get(params.id)
        if (!articleInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'article.label', default: 'Article'), params.id])}"
            redirect(action: "list")
        }
        else {
            def incidents = Incident.createCriteria().list{
                articles{
                    idEq(articleInstance.id)                    
                }
            }

            def problems = Problem.createCriteria().list{
                articles{
                    idEq(articleInstance.id)                    
                }
            }
            
            [articleInstance: articleInstance
                ,incidents:incidents
                ,problems:problems]
        }
    }

    def edit = {
        def articleInstance = Article.get(params.id)
        if (!articleInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'article.label', default: 'Article'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [articleInstance: articleInstance]
        }
    }

    def update = {
        def articleInstance = Article.get(params.id)
        if (articleInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (articleInstance.version > version) {
                    
                    articleInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'article.label', default: 'Article')] as Object[], "Another user has updated this Article while you were editing")
                    render(view: "edit", model: [articleInstance: articleInstance])
                    return
                }
            }
            articleInstance.properties = params
            if (!articleInstance.hasErrors() && articleInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'article.label', default: 'Article'), articleInstance.id])}"
                redirect(action: "show", id: articleInstance.id)
            }
            else {
                render(view: "edit", model: [articleInstance: articleInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'article.label', default: 'Article'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def articleInstance = Article.get(params.id)
        if (articleInstance) {
            try {
                articleInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'article.label', default: 'Article'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'article.label', default: 'Article'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'article.label', default: 'Article'), params.id])}"
            redirect(action: "list")
        }
    }
}
