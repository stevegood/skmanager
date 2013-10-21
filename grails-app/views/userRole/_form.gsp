<%@ page import="org.stevegood.sec.UserRole" %>


<div class="form-group ${hasErrors(bean: userRoleInstance, field: 'user', 'error')} required">
    <label for="user" class="control-label col-lg-2">
        <g:message code="userRole.user.label" default="User" />
    </label>
    <div class="col-lg-10">
        <g:select id="user" name="user.id" from="${org.stevegood.sec.User.list()}" optionKey="id"
                  required="" value="${userRoleInstance?.user?.id}" class="form-control"/>
    </div>
</div>

<div class="form-group ${hasErrors(bean: userRoleInstance, field: 'role', 'error')} required">
	<label for="role" class="control-label col-lg-2">
		<g:message code="userRole.role.label" default="Role" />
	</label>
	<div class="col-lg-10">
        <g:select id="role" name="role.id" from="${org.stevegood.sec.Role.list()}" optionKey="id"
                  required="" value="${userRoleInstance?.role?.id}" class="form-control"/>
	</div>
</div>

