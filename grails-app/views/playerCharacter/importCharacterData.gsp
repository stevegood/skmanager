<%--
  Created by IntelliJ IDEA.
  User: steve
  Date: 10/22/13
  Time: 1:33 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Import Character Data</title>
    <meta name="layout" content="main" />
</head>

<body>

<skm:pageHeader class="col-lg-9 col-lg-offset-3">
    <h1>Import Character Data</h1>
</skm:pageHeader>

<div class="container">
    <div class="row">
        <div class="col-lg-6 col-lg-offset-3">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Choose Data to Import</h3>
                </div>
                <div class="panel-body">
                    <g:uploadForm class="form form-horizontal" controller="playerCharacter" action="saveImportCharacterdata" role="form">
                        <div class="form-group">
                            <label class="control-label col-lg-3" for="game">Game</label>
                            <div class="col-lg-9">
                                <select class="form-control" name="game" id="game">
                                    <option value="rift" selected>Rift</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-lg-3" for="characterDataFile">Data File</label>
                            <div class="col-lg-9">
                                <input type="file" name="characterDataFile" id="characterDataFile" class="form-control">
                                <p class="help-block">Select the file containing your character data.</p>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-lg-9 col-lg-offset-3">
                                <button type="submit" class="btn btn-primary">Upload and Import</button>
                            </div>
                        </div>
                    </g:uploadForm>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>