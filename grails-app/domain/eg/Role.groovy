package eg

import eg.User

/**
 * Authority domain class.
 */
class Role {

    static String ROLE_ADMIN = 'ROLE_ADMIN'
    static String ROLE_TECHSPEC = 'ROLE_TECHSPEC'
    static String ROLE_CLIENT = 'ROLE_CLIENT'
    static String ROLE_INCIDENT_MANAGER = 'ROLE_INCIDENT_MANAGER'
    static String ROLE_PROBLEM_MANAGER = 'ROLE_PROBLEM_MANAGER'

	static hasMany = [people: User]

	/** description */
	String description
	/** ROLE String */
	String authority

	static constraints = {
		authority(blank: false, unique: true)
		description()
	}
}
