package eg

import eg.Role

/**
 * User domain class.
 */
class User {
    static transients = ['pass']
    static hasMany = [authorities: Role, assignedProblems: Problem, assignedIncidents: Incident]
        
    UserGroup group


    String username

    String userRealName
    /** MD5 Password */
    String passwd
	
    boolean enabled = true

    String email

    /** plain password to create a MD5 password */
    String pass = '[secret]'

    static constraints = {
        username(blank: false, unique: true)
        userRealName(blank: false)
        passwd(blank: false)
        group(nullable:true)
    }

    static belongsTo = [Role]

    String toString(){
        "$userRealName($username)"
    }

    static mappedBy = [assignedIncidents:'assignedSpec', assignedProblems:'assignedSpec']
}
