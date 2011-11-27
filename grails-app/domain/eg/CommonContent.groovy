package eg

abstract class CommonContent {
    String title, descr
    Date dateCreated = new Date()

     List files
    static hasMany = [files: StoredFile]

    static constraints = {
        title(blank:false)
        descr(blank:false, nullable: false, size:1..500000)
        author(nullable:false)
    }

    static mapping = {
        batchSize 10
    }

    static searchable = {
         mapping {
          spellCheck "include"
         }
    }


    static belongsTo = [author: User]
}
