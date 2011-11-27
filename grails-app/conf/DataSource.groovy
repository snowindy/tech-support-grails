dataSource {
    pooled = true
    driverClassName = "com.mysql.jdbc.Driver"
    username = "root1"
    password = ""
}
hibernate {
    cache.use_second_level_cache=true
    cache.use_query_cache=true
    cache.provider_class='net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "update"
            url = "jdbc:mysql://localhost:3306/diploma1?useUnicode=true&characterEncoding=UTF-8"
            //loggingSql = true
        }
    }
    test {
        dataSource {

            dataSource {
                dbCreate = "update"
                url = "jdbc:hsqldb:mem:testDb"
            }
        }
        production {
            dataSource {
                dbCreate = "update"
                url = "jdbc:hsqldb:file:prodDb;shutdown=true"
            }
        }
    }
}