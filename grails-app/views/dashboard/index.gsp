<%--
  Created by IntelliJ IDEA.
  User: steve
  Date: 10/8/13
  Time: 2:16 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Dashboard</title>
    <meta name="layout" content="main" />
</head>
<body>

<div class="page-header">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <h1>SKManager Dashboard</h1>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <div id="controller-list" role="navigation">
                <h2>Available Controllers:</h2>
                <ul>
                    <g:each var="c" in="${grailsApplication.controllerClasses.sort { it.fullName } }">
                        <li class="controller"><g:link controller="${c.logicalPropertyName}">${c.fullName}</g:link></li>
                    </g:each>
                </ul>
            </div>
        </div>
    </div>
</div>

</body>
</html>