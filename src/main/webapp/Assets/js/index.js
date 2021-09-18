var showImgHeight = 600,
    xli = null, //图片宽缩放比例
    yli = null; //图片高缩放比例
var layer;
$(document).ready(function () {		//文档加载后激活函数
    var img = new Image()
    img.src = $('#topImg').attr('src')
    img.onload = function () {
        xli = deletePx($('#topImg').css('width')) / img.width
        yli = deletePx($('#topImg').css('height')) / img.height
        console.log("图片加载完成", xli, yli)
    }
    layui.use('layer', function () {
        layer = layui.layer;
    })
})
/**
* 显示是第几张切割图片
* */
var name = document.getElementById('ChangePhotoName').value.slice(-4)
function changebackground(id){
	$('#'+id).css({color: "#f16f20"});
	$('#'+id+'-t').css({color: "#f16f20"});
};
function show() {
    if (name[3] == '1'||name[3] == '2'||name[3] == '3'|| name[3] == '4')
        $('#li_pn').css({display:"block"})
    if (name[3] == '2'){
        changebackground('li6')
    }
    else if (name[3] == '3'){
        changebackground('li6')
        changebackground('li7')
    }
    else if (name[3] == '4'){
        changebackground('li6')
        changebackground('li7')
        changebackground('li8')
    }
}
// show()
if(name[0] == '/')
	show() ;


/**
 * 监测浏览器屏幕高度
 * */
function getMaxHeight() {
    var height = $(window).outerHeight() - $('.header').outerHeight();
    $('.maxHeight').css("height", height + "px");
    showImgHeight = height - $('.center_img_div').find('.col-xs-12').outerHeight() - $('#saveBtn').outerHeight() - 30;
}

getMaxHeight();
$(window).resize(function () {
    getMaxHeight()
})

/**
 * 鼠标点击位置记录，拖动画框，离开结束
 * isStartPaint: 点击开始画
 * isFirstMove：区分框是否存在，不存在添加，存在就改变宽度高度。
 * rectangleArr：所有框id数组
 * rectangleId：当前画框id
 * curRectangle：点击当前框id
 * x:当前框x坐标
 * y:当前框y坐标
 */
var isStartPaint = false,
    isFirstMove = true;
var rectangleArr = [];
var rectangleId = 0;
var x = 0, y = 0;
var curRectangle = 0;

/**
 * 绑定鼠标画矩形事件
 */
function painting() {
    //在绑定之前先解绑，解决了事件多次触发的问题。
    $(document).off('mousedown', '.biaoDiv').on('mousedown', '.biaoDiv', function (event) {
        x = event.pageX - $('#topImg').offset().left
        y = event.pageY - $('#topImg').offset().top
        x = x.toFixed(2)
        y = y.toFixed(2)
        isStartPaint = true;
        if (rectangleArr.length == 0) {
            rectangleArr.push(0)
        } else {
            rectangleArr.push((rectangleArr[rectangleArr.length - 1] + 1));
        }
        rectangleId = rectangleArr[rectangleArr.length - 1]
        console.log(rectangleId)
    })
    $(document).off('mousemove', '.biaoDiv').on('mousemove', '.biaoDiv', function (event) {
        if (isStartPaint) {
            if (isFirstMove) {
                var rectangleView = "<div id='" + rectangleId + "' class='line' x='" + x + "' y='" + y + "' style='left: " + x + "px;top:" + y + "px'><img draggable='false' class='change_size'><div class='glyphicon glyphicon-remove delete_line'></div></div>";
                $('.biaoDiv').append(rectangleView);
                isFirstMove = false;
                //console.log(rectangleId + "first")
                $("#rightContentbody").append('<tr id="' + rectangleId + '"><td></td><td></td><td>' + (x * xli).toFixed(2) + '</td><td>' + (y * yli).toFixed(2) + '</td></tr>')
                $('#rightContentbody tr').each(function () {
                    $(this).click(function () {
                        $(this).siblings().removeClass('table_selected')
                        $(this).addClass('table_selected');
                        var id = $(this).attr('id');
                        $('.biaoDiv .line').removeClass('line_select');
                        $('.biaoDiv #' + id).addClass('line_select');
                        //滚动效果
                        var scrollTop = $('.center_img').scrollTop();
                        var dotop = $('.biaoDiv #' + id).offset().top;
                        hei = $('.center_img').offset().top;
                        $('.center_img').animate({
                            scrollTop: scrollTop + dotop - hei - 50
                        }, 500);
                    })
                })
            }
            var width = event.pageX - $('#topImg').offset().left - x
            var height = event.pageY - $('#topImg').offset().top - y
            $('#rightContentbody #' + rectangleId + " td").eq(0).html((width * xli).toFixed(2))
            $('#rightContentbody #' + rectangleId + " td").eq(1).html((height * yli).toFixed(2))
            width = width.toFixed(2)
            height = height.toFixed(2)
			//在右边画出框起来的字
            var img = new Image()
            img.src = $('#topImg').attr('src')
            var c1 = document.getElementById("c1");
            var context1 = c1.getContext("2d");
            context1.drawImage(img, x / xli, y / yli, width / xli, height / yli, x, y, width, height);

            $('#' + rectangleId).css({"width": width + 'px', "height": height + 'px'});
            $('#' + rectangleId).attr("w", width)
            $('#' + rectangleId).attr("h", height)
        }
    })
    $(document).off('mouseup', '.biaoDiv').on('mouseup', '.biaoDiv', function (event) {
//            rectangleId = rectangleId + 1;
        isStartPaint = false;
        isFirstMove = true;
        console.log("图片-----up")
    })
}

/**
 * 解除鼠标画矩形事件
 */
function offPainting() {
    isStartPaint = false;
    isFirstMove = true;
    x = 0;
    y = 0;
    $(document).off('mousedown', '.biaoDiv')
    $(document).off('mousemove', '.biaoDiv')
    $(document).off('mouseup', '.biaoDiv')
}

$(document).on('mouseenter', '.biaoDiv', function () {
//        console.log("图片---enter")
    painting()
})
$(document).on('click', '.biaoDiv .line .delete_line', function () {
    var id = $(this).parent().attr('id')
    id = parseInt(id)

    var rec_x = deletePx($('.biaoDiv #' + id).css('left'))
    var rec_y = deletePx($('.biaoDiv #' + id).css('top'))
    var rec_w = deletePx($('.biaoDiv #' + id).css('width'))
    var rec_h = deletePx($('.biaoDiv #' + id).css('height'))
    var img = new Image()
    img.src = $('#topImg').attr('src')
    var c1 = document.getElementById("c1");
    var context1 = c1.getContext("2d");
    rec_x = (rec_x * xli).toFixed(2)
    rec_y = (rec_y * yli).toFixed(2)
    rec_w = (rec_w * xli).toFixed(2)
    rec_h = (rec_h * yli).toFixed(2)
    context1.clearRect(rec_x / xli, rec_y / yli, rec_w / xli, rec_h / yli);


    console.log("line---delete")
    rectangleArr.splice($.inArray(id, rectangleArr), 1)
    $('#rightContentbody #' + id).remove()
    console.log(rectangleArr)
    $(this).parent().remove()
})
$(document).on('mouseenter', '.biaoDiv .line .change_size', function (event) {
    event.stopPropagation()
//        console.log("size---change")
})
$(document).on('mousedown', '.biaoDiv .line .change_size', function (event) {
    event.stopPropagation()
    console.log("size---down")
    x = $(this).parent().attr('x')
    y = $(this).parent().attr('y')
    var id = $(this).parent().attr('id')
    changeSize(id)
})
$(document).on('mouseup', '.biaoDiv .line .change_size', function (event) {
//        console.log("size---leave")
    offPainting()
})
$(document).on('mouseenter', '.biaoDiv .line', function () {
//        console.log("line---enter")
    curRectangle = $(this).attr('id')
    $(this).find('.change_size').css("display", "block");
    $(this).siblings().find('.change_size').css("display", "none");
    $(this).find('.delete_line').css("display", "block");
    $(this).siblings().find('.delete_line').css("display", "none");
})
$(document).on('mousedown', '.biaoDiv .line', function (event) {
    //阻止子元素向父元素传递这个事件
    event.stopPropagation()
//        console.log("line---down")
    $(this).addClass('line_select')
    $(this).siblings().removeClass('line_select')
    curRectangle = $(this).attr('id')
    $('#rightContentbody tr').removeClass('table_selected')
    $('#rightContentbody #' + curRectangle).addClass('table_selected')
    //滚动效果
    var scrollTop = $('#rightScroll').scrollTop();
    var dotop = $('#rightContentbody #' + curRectangle).offset().top;
    hei = $('#rightScroll').offset().top;
    $('#rightScroll').animate({
        scrollTop: scrollTop + dotop - hei - 50
    }, 500);
    offPainting()
})
$(document).on('mouseleave', '.biaoDiv .line', function () {
//        console.log("line---leave")
    $(this).find('.change_size').css("display", "none");
    $(this).siblings().find('.change_size').css("display", "none");
    $(this).find('.delete_line').css("display", "none");
    $(this).siblings().find('.delete_line').css("display", "none");
    painting()
})

/**
 * 改变大小
 */
function changeSize(id) {
    $(document).off('mousemove', '.biaoDiv').on('mousemove', '.biaoDiv', function (event) {
        var width = event.pageX - $('#topImg').offset().left - x
        var height = event.pageY - $('#topImg').offset().top - y
        width = width.toFixed(2)
        height = height.toFixed(2)
        $('.biaoDiv #' + id).css({"width": width + 'px', "height": height + 'px'});
        refreshTableData(id)
    })
    $(document).off('mouseup', '.biaoDiv').on('mouseup', '.biaoDiv', function (event) {
        isStartPaint = false;
        isFirstMove = true;
        console.log("图片size-----up")
    })
}

/**
 * 刷新右侧框数据
 * */
function refreshTableData(id) {
    var td0 = $('#rightContentbody #' + id + " td").eq(0)
    var td1 = $('#rightContentbody #' + id + " td").eq(1)
    var td2 = $('#rightContentbody #' + id + " td").eq(2)
    var td3 = $('#rightContentbody #' + id + " td").eq(3)
    var rec_x = deletePx($('.biaoDiv #' + id).css('left'))
    var rec_y = deletePx($('.biaoDiv #' + id).css('top'))
    var rec_w = deletePx($('.biaoDiv #' + id).css('width'))
    var rec_h = deletePx($('.biaoDiv #' + id).css('height'))
    var img = new Image()
    img.src = $('#topImg').attr('src')
    var c1 = document.getElementById("c1");
    var context1 = c1.getContext("2d");
    rec_x = (rec_x * xli).toFixed(2)
    rec_y = (rec_y * yli).toFixed(2)
    rec_w = (rec_w * xli).toFixed(2)
    rec_h = (rec_h * yli).toFixed(2)
    context1.drawImage(img, rec_x / xli / xli, rec_y / yli / yli, rec_w / xli / xli, rec_h / yli / yli, rec_x / xli, rec_y / yli, rec_w / xli, rec_h / yli);
    td0.html(rec_w)
    td1.html(rec_h)
    td2.html(rec_x)
    td3.html(rec_y)
}

/**
 * 删除px
 * */
function deletePx(str) {
    var ret = 0;
    if (typeof (str) == 'undefined' || str == null || str.length == 0) {
        ret = 0;
    } else {
        ret = str.substring(0, str.indexOf('px'))
    }
    return ret;
}

/**
 * 保存数据
 * */
function save() {
    var url = "/update"
    var json = [];
    $('#rightContentbody tr').each(function (index) {
        var w = $(this).children('td').eq(0).html();
        var h = $(this).children('td').eq(1).html();
        var x = $(this).children('td').eq(2).html();
        var y = $(this).children('td').eq(3).html();
        var obj = {};
        obj.x = x;
        obj.y = y;
        obj.width = w;
        obj.height = h;
        json.push(obj);
    })
    /*if (json.length === 0) {
        alert("数据为空不能保存")
        return
    }*/
    json = JSON.stringify(json);
    $(fm.ss).val(json);
    $(fm.xli).val(xli);
    $(fm.yli).val(yli);
    $(fm).submit();
}

var x = new Array()

function c() {
    var img = new Image()
    img.src = $('#topImg').attr('src')
    var myArray = new Array()
    var data = document.getElementById("data1").value;
	console.log(data) ;
    var data1 = document.getElementById("data2").value;
    var data2 = document.getElementById("data3").value;
    var c1 = document.getElementById("c1");
    var context1 = c1.getContext("2d");
    var d1 = document.getElementById("d1");
    c1.width = d1.clientWidth;
    c1.height = d1.clientHeight;
    data = data.replace("[", "");
    data = data.replace("]", "");
    arr = data.split(" ");
    for (var i = 0, j = 0; i < arr.length; i++, j++)
        if (arr[i] != null)
            myArray[j] = arr[i];
    myArray = myArray.notempty();
    for (var i = 0; i < myArray.length - 1; i = i + 4) {
        x2 = myArray[i] * data2 * yli;
        x1 = myArray[i + 1] * data1 * xli;
        x4 = (myArray[i + 2] - myArray[i]) * data2 * yli;
        x3 = (myArray[i + 3] - myArray[i + 1]) * data1 * xli;
        if (rectangleArr.length == 0) {
            rectangleArr.push(0)
        } else {
            rectangleArr.push((rectangleArr[rectangleArr.length - 1] + 1));
        }
        rectangleId = rectangleArr[rectangleArr.length - 1]
        console.log(rectangleId)
        context1.drawImage(img, x1 / xli, x2 / yli, x3 / xli, x4 / yli, x1, x2, x3, x4);		//在右边画出剪切的字
        var rectangleView = "<div id='" + rectangleId + "' class='line' x='" + x1 + "' y='" + x2 + "' style='left: " + x1 + "px;top:" + x2 + "px;width:" + x3 + "px;height:" + x4 + "px'><div class='move_box'></div><img draggable='false' class='change_size'><div class='glyphicon glyphicon-remove delete_line'></div></div>";
        $('.biaoDiv').append(rectangleView);
        isFirstMove = true;
        //console.log(rectangleId + "first")
        $("#rightContentbody").append('<tr id="' + rectangleId + '"><td>' + (x3 * xli).toFixed(2) + '</td><td>' + (x4 * yli).toFixed(2) + '</td><td>' + (x1 * xli).toFixed(2) + '</td><td>' + (x2 * yli).toFixed(2) + '</td></tr>')
    }
}

Array.prototype.notempty = function () {
    var arr = [];
    this.map(function (val, index) {        //过滤规则为，不为空串、不为null、不为undefined，也可自行修改
        if (val !== "" && val != undefined) {
            arr.push(val);
        }
    });
    return arr;
}