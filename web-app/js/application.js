if (typeof jQuery !== 'undefined') {
	(function($) {

        $('[data-toggle=tooltip]').tooltip();
        $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);

	})(jQuery);
}
