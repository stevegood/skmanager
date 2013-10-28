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
                    <g:if test="${ownedRaidList?.size()}">
                        <h6>Owned</h6>
                        <ul class="list-group">
                            <g:each in="${ownedRaidList}" var="raid">
                                <g:render template="raidListItem" model="${[raid: raid]}" />
                            </g:each>
                        </ul>
                    </g:if>

                    <g:if test="${managedRaidList?.size()}">
                        <h6>Managing</h6>
                        <ul class="list-group">
                            <g:each in="${managedRaidList}" var="raid">
                                <g:render template="raidListItem" model="${[raid: raid]}" />
                            </g:each>
                        </ul>
                    </g:if>

                    <g:if test="${!ownedRaidList?.size() && !managedRaidList?.size()}">
                        <h6>No raids yet!</h6>
                    </g:if>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
