package eg

class UserService {

    static transactional = true

    def getUsersWithAuthorPriveleges() {
        def c = User.createCriteria()
        def authorUsers = c.listDistinct {
            authorities{
                or{
                    eq("authority","ROLE_CLIENT")
                    eq("authority","ROLE_TECHSPEC")
                    eq("authority","ROLE_PROBLEM_MANAGER")
                    eq("authority","ROLE_INCIDENT_MANAGER")
                }
            }
        }

        authorUsers
    }


}
