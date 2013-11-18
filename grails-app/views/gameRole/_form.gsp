<%@ page import="org.stevegood.game.GameRole" %>



<div class="fieldcontain ${hasErrors(bean: gameRoleInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="gameRole.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${gameRoleInstance?.name}"/>
</div>

<div class="form-group">
    <label class="control-label col-lg-3" for="icon">Icon</label>
    <div class="col-lg-9">
        <input type="file" name="icon" id="icon" class="form-control" accept="image/*"/>
        <p class="help-block">Select an image to use as an icon. (optional)</p>
    </div>
</div>

