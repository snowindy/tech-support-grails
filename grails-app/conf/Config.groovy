// locations to search for config files that get merged into the main config
// config files can either be Java properties files or ConfigSlurper scripts

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if(System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }


//-----------------------------CUSTOM CONFIG LOAD------------------------------------
def ENV_NAME = "${appName}.config.location"
if (!grails.config.locations || !(grails.config.locations instanceof List)) {
    grails.config.locations = []
}
println "--------------------------------------------------------"
// 1: A command line option should override everything.
// Test by running:
// grails -Ddivr.config.location=C:\temp\divr-config.groovy run-app
// or
// grails -Ddivr.config.location=C:\temp\divr-config.properties run-app
if (System.getProperty(ENV_NAME) && new File(System.getProperty(ENV_NAME)).exists()) {
    println "Including configuration file specified on command line: " + System.getProperty(ENV_NAME)
    grails.config.locations << "file:" + System.getProperty(ENV_NAME)
}
// 2: If this is a developer machine, then they will have their own config and
//    I should use that.
else if (new File("${userHome}/.grails/${appName}-config.groovy").exists()) {
        println "*** User defined config: file:${userHome}/.grails/${appName}-config.groovy. ***"
        grails.config.locations = ["file:${userHome}/.grails/${appName}-config.groovy"]
}
// 3: Most QA and PROD machines should define a System Environment variable
//    that will define where we should look.
else if (System.getenv(ENV_NAME) && new File(System.getenv(ENV_NAME)).exists()) {
    println("Including System Environment configuration file: " + System.getenv(ENV_NAME))
    grails.config.locations << "file:" + System.getenv(ENV_NAME)
}
// 4: Last resort is looking for a properties based configuration on the developer
//    machine.
else if (new File("${userHome}/.grails/${appName}-config.properties").exists()) {
        println "*** User defined config: file:${userHome}/.grails/${appName}-config.properties. ***"
        grails.config.locations = ["file:${userHome}/.grails/${appName}-config.properties"]
}
// 5: Houston, we have a problem!
else {
        println "*** No external configuration file defined. ***"
        println "*** No external configuration file defined. ***"
        println "*** No external configuration file defined. ***"
}

println "(*) grails.config.locations = ${grails.config.locations}"
println "--------------------------------------------------------"
//-----------------------------CUSTOM CONFIG LOAD------------------------------------




grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [ html: ['text/html','application/xhtml+xml'],
    xml: ['text/xml', 'application/xml'],
    text: 'text/plain',
    js: 'text/javascript',
    rss: 'application/rss+xml',
    atom: 'application/atom+xml',
    css: 'text/css',
    csv: 'text/csv',
    all: '*/*',
    json: ['application/json','text/json'],
    form: 'application/x-www-form-urlencoded',
    multipartForm: 'multipart/form-data'
]
// The default codec used to encode data with ${}
grails.views.default.codec="none" // none, html, base64
grails.views.gsp.encoding="UTF-8"
grails.converters.encoding="UTF-8"
// enable Sitemesh preprocessing of GSP pages
grails.views.gsp.sitemesh.preprocess = true
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder=false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// whether to install the java.util.logging bridge for sl4j. Disable fo AppEngine!
grails.logging.jul.usebridge = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []

// set per-environment serverURL stem for creating absolute links
environments {
    production {
        grails.serverURL = "http://www.changeme.com"
    }
    development {
        grails.serverURL = "http://localhost:8080/${appName}"
    }
    test {
        grails.serverURL = "http://localhost:8080/${appName}"
    }

}



// log4j configuration
log4j = {
    // Example of changing the log pattern for the default console
    // appender:
    //
    //appenders {
    //    console name:'stdout', layout:pattern(conversionPattern: '%c{2} %m%n')
    //}


     debug 'grails.app.controller',
                   'grails.app.service',
                   'grails.app.filters',
                   'grails.app.task'



    error  'org.codehaus.groovy.grails.web.servlet',  //  controllers
	       'org.codehaus.groovy.grails.web.pages', //  GSP
	       'org.codehaus.groovy.grails.web.sitemesh', //  layouts
	       'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
	       'org.codehaus.groovy.grails.web.mapping', // URL mapping
	       'org.codehaus.groovy.grails.commons', // core / classloading
	       'org.codehaus.groovy.grails.plugins', // plugins
	       'org.codehaus.groovy.grails.orm.hibernate', // hibernate integration
	       'org.springframework',
	       'org.hibernate',
           'net.sf.ehcache.hibernate'

    warn   'org.mortbay.log'

    debug 'log4j.logger.org.hibernate.SQL'
}

log4j.logger.org.hibernate.SQL='stdout'


//log4j.logger.org.springframework.security='off,stdout'