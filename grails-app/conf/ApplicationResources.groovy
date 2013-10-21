modules = {
    application {
        resource url: 'css/bootstrap-cosmo.min.css'
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
