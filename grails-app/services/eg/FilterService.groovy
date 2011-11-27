/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package eg

/**
 *
 * @author eg
 */
class FilterService {

    def session

    def getAllowedStatuses = {params, session, sesAttrName, initialStatusMap ->
        
        params.offset = params.offset ? params.int('offset'): 0

        params.filters = params.filters?.findAll{ !it.key.startsWith('_') }

        params.filters?.each{
            if ('on' == it.value){
                it.value = true
            }
        }

        if (params.filtersApplied){
            session[sesAttrName] = params.filters
        }else{
            session[sesAttrName] = session[sesAttrName] != null? session[sesAttrName]: initialStatusMap

            params.filters = session[sesAttrName]
        }

        def intKeys = initialStatusMap.keySet().each{it = it as int}.sort{it}


        if (params.filters != null){
            intKeys.each {
                if (!params.filters.containsKey(it as String)){
                    params.filters.put(it,false)
                }}
        }

        params.filters = params.filters.sort{ it.key as String }


        def allowedStatuses = (params.filters.findAll{ it.value == true }).keySet()

        return allowedStatuses
    }
}

