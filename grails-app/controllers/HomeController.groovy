
import org.grails.plugins.springsecurity.service.AuthenticateService

class HomeController {

    def authenticateService

    def index = {

        if (authenticateService.isLoggedIn()){
            redirect(controller: "incident", action: "list", params: params)
        }
    }

}
