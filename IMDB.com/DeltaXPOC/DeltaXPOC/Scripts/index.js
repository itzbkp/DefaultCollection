$(document).ready(function () {

	//Close icon configuration
    $('#close').on('click', function(e){
        e.stopPropagation();
        $('#updMovies').modal('hide');
    });

	
	//Datetime selector configuration
    $('#mYear, #umYear').datetimepicker({
        format: "yyyy",
        autoclose: "true",
        startView: 4,
        minView: 4,
        todayBtn: true,
        endDate: new Date()
    });
    $('.datepicker').datetimepicker({
        format: "dd-mm-yyyy",
        autoclose: "true",
        minView: 2,
        todayHighlight: true,
        todayBtn: true,
        endDate: new Date()
    });
    $('.dropdown-menu').css('width', '17%');
    $('.datetimepicker-days table, .datetimepicker-months table, .datetimepicker-years table').attr('width', '200');

	
	//Select input configuration
    $('#cName').select2({
        dropdownParent: $('#castings')
    });
    $('.select2-selection__rendered').css({
        'padding-left': '10px',
        'margin-top': '1px'
    });
    $('.select2-selection').css('height', '35px');
    $('.select2-selection__arrow b').css({
        height: "10px",
        width: "10px",
        left: "2px",
        "margin-top": "0px"
    });

	
	//Image upload configuration
    $('#mPoster').on('change', function () {
        if (this.files && this.files[0]) {
            var fileReader = new FileReader();
            fileReader.onload = function (e) {
                $('#mImg').attr('src', e.target.result);
            }
            fileReader.readAsDataURL(this.files[0]);
        }
    });
    $('#umPosterfile').on('change', function () {
        if (this.files && this.files[0]) {
            var fileReader = new FileReader();
            fileReader.onload = function (e) {
                $('#umPoster').css('background-image', 'url("' + e.target.result + '")');
            }
            fileReader.readAsDataURL(this.files[0]);
        }
    });


	//Role selection configuration
    $('#cRole').on('change', function () {
        if ($('#cRole').val() == '1') {
            $('#toggleRole').html('Actor <span style="margin-left: 52px" />');
            $('#dropRole').html('Producer');
        }
        else {
            $('#toggleRole').html('Producer <span style="margin-left: 26px" />');
            $('#dropRole').html('Actor');
        }
    });
    $('#dropRole').on('click', function () {
        if ($('#dropRole').html() == 'Actor')
            $('#cRole').val('1').change();
        else
            $('#cRole').val('2').change();
    });


	//Gender option configuration
    $('#cGender').on('change', function () {
        if ($('#cGender').val() == 'false') {
            $('#maleBtn').removeClass('btn-default');
            $('#maleBtn').addClass('btn-primary');
            $('#femaleBtn').removeClass('btn-primary');
            $('#femaleBtn').addClass('btn-default');
        }
        else {
            $('#maleBtn').removeClass('btn-primary');
            $('#maleBtn').addClass('btn-default');
            $('#femaleBtn').removeClass('btn-default');
            $('#femaleBtn').addClass('btn-primary');
        }
    });
    $('#maleBtn').on('click', function () {
        $('#cGender').val('false').change();
    });
    $('#femaleBtn').on('click', function () {
        $('#cGender').val('true').change();
    });
});