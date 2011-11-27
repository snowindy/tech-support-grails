package eg

class Comment  extends CommonContent{

    static constraints = {
        problem(nullable:true)
        incident(nullable:true)
        title(nullable:true)
    }

    Problem problem
    Incident incident

    static belongsTo = [problem:Problem,
        incident:Incident]
}
