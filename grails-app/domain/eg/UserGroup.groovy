package eg

class UserGroup {
    String name

    static constraints = {
        name(blank:false)
    }

    static hasMany = [users:User]

    String toString(){
        name
    }
}
