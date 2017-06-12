$(function () {
    $('#modalDelete').on("show.bs.modal",
        function (event) {
            $(this).fadeIn("fast");
            var button = $(event.relatedTarget);
            var type = button.attr("data-type-id");
            var item = button.attr("data-item-id");
            var name = button.attr("data-name");

            var modal = $(this)
            modal.find("#deleteForm").attr("action", "/Catalog/Delete/" + type+"?item="+item);
            modal.find(".modal-title").html("Delete " + name);
        });

    $('#modalActivar').on("show.bs.modal",
        function (event) {
            $(this).fadeIn("fast");
            var button = $(event.relatedTarget);
            var type = button.attr("data-type-id");
            var item = button.attr("data-item-id");
            var name = button.attr("data-name");

            var modal = $(this)
            modal.find("#activarForm").attr("action", "/Catalog/Activate/" + type + "?item=" + item);
            modal.find(".modal-title").html("Activate " + name);
        });


    $('#modalAgregar').on("show.bs.modal",
        function (event) {
            $(this).fadeIn("fast");
            var button = $(event.relatedTarget);
            var type = button.attr("data-type-id");
            var modal = $(this);
            modal.find("#createForm").attr("action", "/Catalog/Create/" + type);
        });


    $('#modalEditar').on("show.bs.modal",
        function (event) {
            $(this).fadeIn("fast");
            var button = $(event.relatedTarget);
            var type = button.attr("data-type-id");
            var item = button.attr("data-item-id");
            var name = button.attr("data-name");

            $('#itemNameEdit').val(name);
            var modal = $(this);
            modal.find("#editForm").attr("action", "/Catalog/Edit/" + type + "?item=" + item);
        });

});