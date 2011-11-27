package eg

class StoredFileController {

    def download = {
        def storedFileInstance = StoredFile.get(params.id)

        if (storedFileInstance){
            fileService.downloadFile(response, storedFileInstance);
        }
    }

    def fileService

}
