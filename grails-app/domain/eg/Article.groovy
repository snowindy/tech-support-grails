package eg

class Article extends CommonContent{
    static hasMany = [userGroups: UserGroup]
   
}
