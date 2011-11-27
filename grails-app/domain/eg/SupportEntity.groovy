/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package eg

/**
 *
 * @author eg
 */
abstract class SupportEntity extends CommonContent {
    static int STATUS_NEW = 0
    static int STATUS_OPEN = 1
    static int STATUS_SUSPENDED = 2
    static int STATUS_CLOSED = 3

    int status = STATUS_NEW


    static constraints = {
        assignedSpec(nullable:true)
    }

    static hasMany = [comments: Comment, articles: Article]

    static int PRIORITY_HIGH = 1
    static int PRIORITY_MEDIUM = 2
    static int PRIORITY_LOW = 3

    int priority = PRIORITY_MEDIUM

    User assignedSpec
}

