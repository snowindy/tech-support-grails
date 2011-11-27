package eg

class Incident extends SupportEntity {
    static int STATUS_CLOSED_REJECTED = 4

    static int TYPE_INFO = 1
    static int TYPE_SERVICE = 2
    static int TYPE_INCIDENT = 3

    int type = TYPE_INFO

    Problem problem

    static constraints = {
        type(nullable:true)
        problem(nullable:true)
    }
}
