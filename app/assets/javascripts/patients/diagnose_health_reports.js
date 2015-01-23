/**
 * Created by git on 15-1-22.
 */


//医嘱要依据的健康档案列表分页方法
$(function () {
    $('.pagination li a').click(function () {
        event.preventDefault();
        var url = '', href = $(this).context.href, arr = [], page;
        arr = href.split('//')[1].split('/');
        url = '/' + arr[1] + '/' + arr[2].split('?')[0]
        if ($(this).parent().hasClass('active') || url.indexOf('#') != -1) {

        } else {
            page = parseInt(href.split('page=')[1]);
            $.ajax({
                type: 'post',
                url: url,
                data: {
                    page: page
                },
                success: function (data) {
                    $('#diagnose_reports').html('');
                    $('#diagnose_reports').html(data);
                },
                error: function (data) {
                    console.log(data);
                }
            });
        }

    })
});

//翻页时，选中之前选过的checkbox
for(var ri in reportIds){
    var index=reportIds[ri]
    $("#up"+index).attr("checked",true);
}