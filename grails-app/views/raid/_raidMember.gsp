<div class="row highlight-on-hover">
    <div class="col-lg-8">
        <g:link controller="playerCharacter" action="show" id="${raidMember.character.id}">
            ${raidMember.character.name}
        </g:link>
    </div>
    <div class="col-lg-1">
        <g:if test="${canManage && last}">
            <g:link class="btn btn-warning btn-xs move-to-bottom-btn"
                    controller="raidMember" action="moveToBottom"
                    params="${[raid_member_id: raidMember.id]}">
                <span class="glyphicon glyphicon-arrow-down"></span>
            </g:link>
        </g:if>
    </div>
    <div class="col-lg-1">
        <g:if test="${canManage}">
            <g:link class="btn btn-danger btn-xs" controller="raidMember" action="removeFromRaid"
                    params="${[raid_member_id: raidMember.id]}">
                <span class="glyphicon glyphicon-trash"></span>
            </g:link>
        </g:if>
    </div>
</div>