$(function () {
        $('.pagination a').live("click", function (e) {
                $.get(this.href, null, null, 'script');
                return false;
        });
});