// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery 
//= require rails-ujs
//= require bootstrap
//= require moment 
//= require fullcalendar 
//= require chartkick
//= require Chart.bundle
//= require_tree .


$(function () {
  //JSON形式でオブジェクトの情報をindexに渡している
  $('#calendar').fullCalendar({
    events: '/index.json',
    eventRender: function (event, element) {
                if(!event.calss && event.name == "income")
                  element.addClass("bluecolor");
                else
                  element.addClass("redcolor");
    },
    monthNames: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],
        // 月略称
    monthNamesShort: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],
        // 曜日名称
    dayNames: ['日曜日', '月曜日', '火曜日', '水曜日', '木曜日', '金曜日', '土曜日'],
        // 曜日略称
    dayNamesShort: ['日', '月', '火', '水', '木', '金', '土'],
    firstDay : 1,
    
}); 
});