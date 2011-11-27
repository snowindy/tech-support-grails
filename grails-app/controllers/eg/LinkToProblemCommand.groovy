/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package eg

/**
 *
 * @author eg
 */
class LinkToProblemCommand {
    int incidentId
    int problemId

    String toString(){
        "LinkToProblemCommand: ${incidentId}, ${problemId}"
    }



    static constraints = {
        incidentId(blank:false)
        problemId(validator: {
                return (it != 0)
            })
    }
}

