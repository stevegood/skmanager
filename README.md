skmanager
=========

Suicide Kings loot list manager

Cloud Foundry Setup
-------------------

Start by setting up your account on [Pivotal's Cloud Foundry](http://run.pivotal.io). Deploy the application once (following the directions below) to setup the environment then create your datasource service (postgres by default) and bind it to the app.  Make sure to note the service name as you'll need it later.

Edit ```build.gradle```


    def cf_username = 'user@example.com' // <--- CHANGE THIS!!
    def cf_password = 's3cr3t'           // <--- CHANGE THIS!!
    def cf_space = 'development' // Change this to your space name (optional)


Edit ```grails-app/conf/DataSource.groovy```

    def dbInfo = cloud.getServiceInfo('skmanager-db-postgres') // CHANGE THIS TO MATCH YOUR SERVICE NAME
    
Then execute the build script: ```./gradlew grails-clean grails-war cfPush```

