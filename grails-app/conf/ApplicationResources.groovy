modules = {
    application {
        resource url:'js/application.js'
    }

    cosmo {
        resource url: 'css/bootstrap-cosmo.min.css'
    }

    main {
        dependsOn 'cosmo'
        resource url: 'css/main.css'
    }

    bootstrap_js {
        dependsOn 'jquery'
        resource url: 'js/bootstrap.min.js'
    }

    user_registration {
        dependsOn 'jquery'
        resource url: 'js/user/registration.js'
    }
}
