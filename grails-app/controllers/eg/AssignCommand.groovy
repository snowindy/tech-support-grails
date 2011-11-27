/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package eg

/**
 *
 * @author eg
 */
class AssignCommand {
	int type = Incident.TYPE_INFO
        int priority = Incident.PRIORITY_MEDIUM
        int id

    static constraints = {
           type(blank:false)
           priority(blank:false)
           id(blank:false)
   }

    String toString(){
        "AssignCommand: ${id}, ${priority}, ${type}"
    }

}

