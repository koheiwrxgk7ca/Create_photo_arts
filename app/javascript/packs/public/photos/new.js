import $ from 'jquery'
import 'select2'


$(function () {
  $('.js-searchable-multiple').select2({
    dropdownAutoWidth: true,
    theme: 'bootstrap4',
    placeholder: "タグ選択",
    allowClear: true,
    multiple: true
  });
});