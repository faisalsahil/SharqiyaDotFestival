(function ($) {
    $(document).ready(function () {

        $('.listing_table').DataTable({
            "pageLength": 10,
            "aaSorting": [[0, "asc"]]
        });
    });
}(jQuery));
