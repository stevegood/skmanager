<%--
  Created by IntelliJ IDEA.
  User: steve
  Date: 10/21/13
  Time: 11:58 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>My Raids</title>
    <meta name="layout" content="main" />
</head>

<body>

<skm:pageHeader class="col-lg-12">
    <h1>
        My Raids
        <sec:ifLoggedIn>
            <span class="pull-right">
                <g:link controller="raid" action="create" class="btn btn-primary">
                    <span class="glyphicon glyphicon-plus"></span>
                </g:link>
            </span>
        </sec:ifLoggedIn>
    </h1>
</skm:pageHeader>

<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <g:render template="raidList"
                      model="${[raidInstanceList: raidInstanceList, raidInstanceCount: raidInstanceCount]}"/>
        </div>
    </div>
</div>
</body>
</html>