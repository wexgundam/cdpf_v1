//设置弹出框为中文
bootbox.setLocale("zh_CN");

//设置菜单选中
$(".sub-menu li").find("a").click(function () {
    console.log($(this).parent().attr("id"))
    //移除a里面的样式
    //$("#footer").find("a").removeClass("active");
    //当前选择的下标
    var index = $(this).parent().attr("id");
    //记录下标
    Cookies.set('current', index, {expires: 10, path: '/'});
});
var current = Cookies.get('current');
if (current != null && current != '') {
    $('.nav-item .active').removeClass('active');
    var $current = $("#" + current);
    $current.addClass("active");
    $current.parent().parent().addClass("active open");
}