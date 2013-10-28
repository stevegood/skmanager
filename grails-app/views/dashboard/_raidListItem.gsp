<li class="list-group-item">
    <g:link controller="raid" action="show" id="${raid.id}">${raid.name}</g:link>
    <span class="pull-right text-muted">
        M <span class="badge">${raid.memberCount}</span>&nbsp; S <span class="badge">${raid.substituteCount}</span>
    </span>
</li>