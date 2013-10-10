modules = {
    application {
        resource url:'js/application.js'
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