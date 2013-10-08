<g:set var="theme" value="cosmo" />
<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="Grails"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
		<link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
		<link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
		<link rel="stylesheet" href="${resource(dir: 'css/themes', file: "bootstrap-${theme.toLowerCase()}.min.css")}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
		<g:layoutHead/>
		<r:layoutResources />
	</head>
	<body>

        %{-- navigation --}%
        <div class="navbar navbar-inverse navbar-fixed-top">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <g:link class="navbar-brand" controller="dashboard" action="index">SKManager</g:link>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <sec:ifLoggedIn>
                        <li>
                            <g:link controller="dashboard" action="index">Dashboard</g:link>
                        </li>
                        <li>
                            <g:link controller="raid" action="create">Create Raid</g:link>
                        </li>
                        <sec:ifAllGranted roles="ROLE_ADMIN">
                            <li>
                                <g:link controller="admin" action="index">Admin</g:link>
                            </li>
                        </sec:ifAllGranted>
                    </sec:ifLoggedIn>
                </ul>
            </div>
        </div>
        </div>

        %{-- body --}%
		<g:layoutBody/>
        %{-- footer --}%
		<r:layoutResources />
	</body>
</html>
