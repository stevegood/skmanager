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
        <div class="col-lg-4">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">My Raids</h3>
                </div>
                <div class="panel-body">
                    %{-- show my raids --}%
                    <ul class="list-group">
                        <g:each in="${raidList}" var="raid">
                            <li class="list-group-item">
                                <g:link controller="raid" action="show" id="${raid.id}">${raid.name}</g:link>
                                <span class="pull-right text-muted">
                                    M <span class="badge">${raid.memberCount}</span>&nbsp; S <span class="badge">${raid.substituteCount}</span>
                                </span>
                            </li>
                        </g:each>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
