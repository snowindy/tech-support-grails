import eg.*;

class BootStrap {

    def initDbService

    def init = { servletContext ->
        //def initDbService = new InitDbService();

        initDbService.loadGroups();
        initDbService.loadUsers();

    }
    def destroy = {
    }
} 