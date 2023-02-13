import $ from 'jquery'
import 'select2'


$(function () {
  $('.js-searchable-multiple').select2({
    dropdownAutoWidth: true,
    theme: 'bootstrap4',
    placeholder: "都道府県検索",
    allowClear: true,
    multiple: true
  });
});