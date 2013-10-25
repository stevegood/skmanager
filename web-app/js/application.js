if (typeof jQuery !== 'undefined') {
	(function($) {

        $('[data-toggle=tooltip]').tooltip();
        $('.dropdown-toggle').dropdown();
        $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);

	})(jQuery);
}
