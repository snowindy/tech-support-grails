package eg

import org.codehaus.groovy.grails.commons.*


class InitDbService {

    static transactional = true

    def authenticateService
    def config = ConfigurationHolder.config

    def loadGroups() {

        def admRole = Role.findByAuthority(Role.ROLE_ADMIN)
        if (admRole){
            log.info "Roles have already been added to DB. Doing nothing."
        }else{
            log.info "Roles have not been added to DB yet. Adding."

            
            def auths = ['ROLE_ADMIN':'Администратор','ROLE_TECHSPEC':"Специалист",'ROLE_CLIENT':"Клиент",'ROLE_INCIDENT_MANAGER':"Координатор инцидентов",'ROLE_PROBLEM_MANAGER':"Координатор проблем"]
            auths.each{k,v ->
                def role = new Role()
                role.authority = k
                role.description = v
                role.save(flush:true)
                log.info "Role '${k}' added."
            }
        }
    }

    def loadUsers(){
        log.debug "config.initDb.admin.password = ${config.initDb.admin.password}"

        def adm = User.findByUsername('admin')
        if (adm){
            log.info "Admin user exists. Doing nothing."
        }else{
            log.info "Admin user does not exist. Creating"
            adm = new User()
            adm.username = "admin"
            adm.userRealName = "Администраторы"
            adm.pass = config.initDb.admin.password
            adm.email = 'changeme@localhost'
            adm.passwd = authenticateService.encodePassword(adm.pass)
            adm.save(flush: true)

            Role.findByAuthority(Role.ROLE_ADMIN).addToPeople(adm)
        }
    }
}
