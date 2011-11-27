package eg

import org.grails.plugins.springsecurity.service.AuthenticateService

class AuthService {

    static transactional = true

    def authenticateService
    
    User getThisUser() {
        authenticateService.principal().getDomainClass()
    }

    User getThisHibernateUser() {
        User.get(getThisUser().id)
    }

    boolean isTechSpec(){
        authenticateService.ifAnyGranted("ROLE_TECHSPEC")
    }

    boolean isIncidentManager(){
        authenticateService.ifAnyGranted("ROLE_INCIDENT_MANAGER")
    }

    boolean isProblemManager(){
        authenticateService.ifAnyGranted("ROLE_PROBLEM_MANAGER")
    }

    boolean isClient(){
        authenticateService.ifAnyGranted("ROLE_CLIENT")
    }
}
