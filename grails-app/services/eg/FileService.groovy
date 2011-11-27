/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package eg

/**
 *
 * @author eg
 */
class FileService {
    def downloadFile(def response, def storedFile){
        def file = new File(storedFile.relPath)
        response.setContentType("application/octet-stream")
        response.setHeader("Content-disposition", "attachment;filename=${storedFile.filename}")

        response.outputStream << file.newInputStream() // Performing a binary stream copy
    }

    def attachFile(def request, def entity){
         def f = request.getFile('attachedFile')

        if(!f.empty) {
            def storedFile = new StoredFile()
            String origFName = f.originalFilename
            origFName = origFName.replace(" ","_");
            storedFile.filename = origFName

            String[] extArr = origFName.split("\\.")
            String ext = "";
            println extArr
            if (extArr){
                ext = extArr[extArr.length - 1]
            }
            String serverFileName = (Math.floor(Math.random()*100000) as int)+"."+ext;
            def entName = entity.class.simpleName.toLowerCase()
            storedFile.relPath = "files/${entName}/"+serverFileName

           
            new File("files/${entName}").mkdirs()
            f.transferTo( new File(storedFile.relPath) )

            entity.addToFiles(storedFile)
        }
    }
}

