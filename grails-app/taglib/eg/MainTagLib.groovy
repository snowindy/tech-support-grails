package eg

import org.grails.plugins.springsecurity.service.AuthenticateService
import eg.AuthService

class MainTagLib {

    static namespace = "my"

    def authenticateService

    def isAdmin = { attrs, body ->
        if(authenticateService
            .ifAnyGranted("ROLE_ADMIN")) {
            out << body()
        }
    }

    def isTechSpec = { attrs, body ->
        if(authService.isTechSpec()) {
            out << body()
        }
    }


    def isClient = { attrs, body ->
        if(authService.isClient()) {
            out << body()
            return true
        }
        return false
    }

    def isProblemManager = { attrs, body ->
        if(authService.isProblemManager()) {
            out << body()
        }
    }

    def isIncidentManager = { attrs, body ->
        if(authService.isIncidentManager()) {
            out << body()
        }
    }
    static returnObjectForTags = ['isLoggedIn', 'isClient','obtainAuthenticateService','getThisHibernateUser','getUser']
    
   

    def authService

    def ifLoggedIn = { attrs, body ->
        if(authenticateService.isLoggedIn()) {
            out << body()
        }

    }

    def isLoggedIn = { attrs, body ->
      authenticateService.isLoggedIn()
    }

    def isEntityAssignedToUser = { attrs, body ->
        if (authService.isIncedentManager() || authService.isProblemManager()){

            def user = getThisUser()
            if (attrs.ent.assignedSpec == user){
                out << body()
            }
        }
    }



    def dateFormat = { attrs, body ->
        out << new java.text.SimpleDateFormat('dd-MM-yyyy HH:mm').format(attrs.date)
    }

    def obtainAuthenticateService =  {attrs, body ->
        return authenticateService
    }

    def getThisHibernateUser = {
        return authService.getThisHibernateUser()
    }

    def getUser = {
        return authService.getThisUser()
    }

}
