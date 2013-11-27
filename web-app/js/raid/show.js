/**
 * User: steve
 * Date: 10/10/13
 * Time: 11:49 AM
 */

var skmanager = skmanager || {};

skmanager.buildModal = function(playerCharacters, $modal, $select, $note) {
    if (playerCharacters.length > 0) {
        $select.html('');
        $note.val('');
        // insert items into dropdown
        $select.append('<option value="0">Select character...</option>');
        $.each(playerCharacters, function(i, it){
            $select.append('<option value="' + it.id + '">' + it.name + '</option>');
        });
        // open modal
        $modal.modal();
    } else {
        alert('No available characters');
    }
};

skmanager.addCharacterToRaid = function($select, $note, $substitute, $modal) {
    $.getJSON('/raid/addCharacter', {raid_id: skmanager.raid.id, pc_id: $select.val(), substitute: $substitute.is(':checked'), note: $note.val()}, function(result){
        // handle the result by reloading the page
        $modal.modal('hide');
        window.location = window.location;
    });
};

jQuery(function($){
    var $addCharacterBtn = $('#add-character-btn'),
        $addCharacterModal = $('#add-character-modal'),
        $addCharacterSelect = $('#add-character-select'),
        $modalAddCharacterBtn = $('#modal-add-character-btn'),
        $addCharacterForm = $('#add-character-form'),
        $addCharacterNote = $('#add-character-note'),
        $search = $('#search'),
        $substituteCheckBox = $('#substitute'),
        $lists = $('#lists'),
        $progressBar = $('#progress-bar'),
        $raidStringModal = $('#raidStringModal'),
        $raidStringMenuItem = $('#raidStringMenuItem'),
        $raidStringImportBtn = $('#raidStringImportBtn'),
        $raidStringImportModal = $('#raidStringImportModal');

    $progressBar.hide();

    $addCharacterBtn.on('click', function(){
        // todo: get the PCs
        $.getJSON('/playerCharacter/availableForRaid', {raid_id: skmanager.raid.id}, function(result){
            // make $search a typeahead field
            $search.typeahead({
                name: 'characterSearch',
                local: result.playerCharacters,
                valueKey: 'name'
            }).on('typeahead:selected', function(){
                $addCharacterSelect.children('option').filter(function(){
                    return ($(this).text() === $search.val());
                }).prop('selected', true);
                $addCharacterSelect.trigger('change');
            });
            skmanager.buildModal(result.playerCharacters, $addCharacterModal, $addCharacterSelect, $addCharacterNote);
        });
    });

    $addCharacterSelect.on('change', function(){
        if ($addCharacterSelect.val() > 0) {
            $modalAddCharacterBtn.attr('disabled', false);
        } else {
            $modalAddCharacterBtn.attr('disabled', true);
        }
    });

    $addCharacterForm.on('submit', function(e){
        // prevent the form from submitting, we only want to process this through ajax
        e.preventDefault();
        if ($addCharacterSelect.val() > 0) {
            skmanager.addCharacterToRaid($addCharacterSelect, $addCharacterNote, $substituteCheckBox, $addCharacterModal);
        }
        return false;
    });

    $modalAddCharacterBtn.on('click', function(){
        $addCharacterForm.submit();
    });

    $('.sortable').each(function(){
        var $this = $(this);
        $this.sortable({
            placeholder: "ui-state-highlight",
            stop: function(event, ui) {
                var item_ids = $this.sortable('toArray');
                if (item_ids.length) {
                    $.getJSON('/raidMember/repositionMembers', {raid_member_ids: item_ids.join(), raid_id: skmanager.raid.id}, function(result){
                        window.location = window.location
                    });
                }
            }
        });
    });

    $raidStringMenuItem.on('click', function(){
        $raidStringModal.modal();
    });

    $raidStringImportBtn.on('click', function(){
        $raidStringModal.modal('hide');
        $raidStringImportModal.modal();
    });

    $('#importRaidStringSubmitBtn').on('click', function(){
        if ($('#importString').val().trim() == '') {
            alert('Raid string cannot be blank!');
            return;
        }

        $raidStringImportModal.modal('hide');
        $.blockUI();
        $('#importRaidStringForm').submit();
    })
});
