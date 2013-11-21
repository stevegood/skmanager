class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.${format})?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(controller: 'dashboard', action: 'index')
        "/login"(controller: 'login', action: 'auth')
        "/register"(controller: 'user', action: 'register')
        "/users"(controller: 'user', action: 'index')
        "/users/$username/edit"(controller: 'user', action: 'edit')
        "/users/$username"(controller: 'user', action: 'show')
        "/register/submit"(controller: 'user', action: 'saveRegistration')
        "/raids/$action?/$id?"(controller: 'raid')
        "/characters/$action?/$id?"(controller: 'playerCharacter')
        "/characters/import"(controller: 'playerCharacter', action: 'importCharacterData')
        "500"(view:'/error')
	}
}
