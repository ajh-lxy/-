<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2019/3/15
  Time: 9:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery/jquery-3.3.1.min.js"></script>
<!-- 新 datatable 核心 CSS 文件 -->
<link href="<%=request.getContextPath()%>/js/media/css/jquery.dataTables.css" rel="stylesheet">
<!-- datatable  js -->
<script src="<%=request.getContextPath()%>/js/media/js/jquery.dataTables.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/bootbox/bootbox.all.min.js"></script>

<%--添加弹框--%>
<script src="<%=request.getContextPath()%>/js/bootstrap/jss/bootstrap.js"></script>
<link href="<%=request.getContextPath()%>/js/bootstrap/css/bootstrap.css" rel="stylesheet">
<%--添加验证--%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/validate/jquery.validate.min.js"></script>

<%--时间插件--%>
<link href="<%=request.getContextPath()%>/js/datetimepicker/css/bootstrap-datetimepicker.css"/>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/datetimepicker/js/bootstrap-datetimepicker.js"></script>
<%--zree--%>
<%--<link href="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet">--%>
<link href="<%=request.getContextPath()%>/js/bootstrap/css/bootstrap-treeview.css"/>
<script src="<%=request.getContextPath()%>/js/bootstrap/jss/bootstrap-treeview.js"></script>

<%--添加图片--%>
<link href="<%=request.getContextPath()%>/js/kartik-v-bootstrap-fileinput-d3cf23c/css/fileinput.css" rel="stylesheet" type="text/css" media="all"/>
<link href="<%=request.getContextPath()%>/js/kartik-v-bootstrap-fileinput-d3cf23c/themes/explorer/theme.css" rel="stylesheet" type="text/css" media="all"/>
<link href="<%=request.getContextPath()%>/js/kartik-v-bootstrap-fileinput-d3cf23c/css/fileinput-rtl.css"/>
<script src="<%=request.getContextPath()%>/js/kartik-v-bootstrap-fileinput-d3cf23c/js/fileinput.min.js"></script>
<script src="<%=request.getContextPath()%>/js/kartik-v-bootstrap-fileinput-d3cf23c/themes/explorer/theme.js"></script>
<script src="<%=request.getContextPath()%>/js/kartik-v-bootstrap-fileinput-d3cf23c/js/locales/zh.js"></script>
<html>
<head>
    <title>员工列表展示</title>

</head>

<body>
    <!-- /. ROW  -->


    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading">员工列表</div>
                <div class="box">
                     &nbsp;<button type="button" class="btn btn-success"  onclick="addEmpl()">添加</button>
               </div>

                <div class="panel-body">
                    <div class="table-responsive">
                        <table class="table table-bordered responsive" id="table" cellspacing="0" width="100%">
                            <thead>
                            <tr>
                                <th width="8%" class="min-mobile-l">员工编号</th>
                                <th width="3%" class="min-mobile-l">员工姓名</th>
                                <th width="2%" class="min-mobile-l">员工性别</th>
                                <th width="4%" class="min-mobile-l">录入时间</th>
                                <th width="4%" class="min-mobile-l">修改时间</th>
                                <th width="4%" class="min-mobile-l">员工头像</th>
                                <th width="2%" class="min-mobile-l">员工部门</th>
                                <th width="4%" class="min-mobile-l">操作</th>
                            </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /. ROW  -->

    </div>
    <!-- /. PAGE INNER  -->
    </div>
</body>
<script type="text/html" id="addHtml">
    <form  id="signupForm">
        <table>
            <tr>
                <td>员工姓名:<input type="hidden" name="id"/></td>
                <td><input type="text" name="staffName1"/></td>
            </tr>
            <tr>
                <td>员工性别:</td>
                <td><input type="radio" value="1" name="staffSex11"/>男<input type="radio" value="2" name="staffSex11"/>女</td>
            </tr>
            <tr>
                <td>录入时间:</td>
                <td>
                        <input type="text" id="insertTime" name="insertTime" data-date-format="yyyy-mm-dd"/>
                </td>
            </tr>
            <tr>
                <td>修改时间:</td>

                <td><input type="text" id="updateTime" name="updateTime" data-date-format="yyyy-mm-dd"/></td>
            </tr>
            <tr>
                <td>员工头像:<span name="staffImg"></span></td>
                <td>
                    <%--<input type="text" id="staffUpload" name="staffUpload"/>--%>
                        <div class="form-group">
                            <div class="col-sm-6" >
                                <input type="file" name="empImg" id="txt_file" multiple class="file-loading" />
                            </div>
                        </div>
                        <%--新头像--%>
                        <input type="hidden" name="imgUrl" id="imgUrl">
                        <%--老头像--%>
                        <input type="hidden" name="oldImgUrl" id="oldImgUrl">
                </td>
            </tr>
            <tr>
                <td>员工部门:</td>
                <td>
                    <%--&lt;%&ndash;zree&ndash;%&gt;--%>
                        <%--存部门id--%>
                    <input type="hidden" name="sectId" id="sectId"/>
                    <input type="text" name="sectname" id="sectname"/>
                    <input type="button" value="选择部门" onclick="getTree()"/>
                </td>
            </tr>
        </table>
    </form>
</script>
<%--zree --%>
<script>
   /* $(function(){
        getTree();
    })*/

    function getTree(){
        $.ajax({
            url:"<%=request.getContextPath()%>/zree/getTreeList.jhtml",
            data:{},
            type:"post",
            dataType:"json",
            success:function(res) {
                var testdata = res;


                (function ($) {
                    //使用js的严格模式
                    'use strict';

                    $.fn.jqtree = function (options) {
                        //合并默认参数和用户传过来的参数
                        options = $.extend({}, $.fn.jqtree.defaults, options || {});

                        var that = $(this);
                        var strHtml = "";
                        //如果用户传了data的值，则直接使用data，否则发送ajax请求去取data
                        if (options.data) {
                            strHtml = initTree(options.data);
                            that.html(strHtml);
                            initClickNode();
                        }
                        else {
                            //在发送请求之前执行事件
                            options.onBeforeLoad.call(that, options.param);
                            if (!options.url)
                                return;
                            //发送远程请求获得data
                            $.getJSON(options.url, options.param, function (data) {
                                strHtml = initTree(data);
                                alert(data.id+":"+data.text)
                                that.html(strHtml);
                                initClickNode();

                                //请求完成之后执行事件
                                options.onLoadSuccess.call(that, data);
                            });
                        }

                        //注册节点的点击事件
                        function initClickNode() {
                            $('.tree li').addClass('parent_li').find(' > span').attr('title', '收起');

                            //设置节点默认关闭状态
                            $('.tree li.parent_li > span').parent('li.parent_li').find(' > ul > li').hide('fast');
                            $('.tree li.parent_li > span').on('click', function (e) {
                                //选择id
                                var sid = this.id.substring(5);
                                $("#sectId").val(sid);

                                //查询部门名称
                                quertByIdList(this)
                                var children = $(this).parent('li.parent_li').find(' > ul > li');
                                if (children.is(":visible")) {
                                    children.hide('fast');
                                    $(this).attr('title', '展开').find(' > i').addClass('icon-plus-sign').removeClass('icon-minus-sign');
                                } else {
                                    children.show('fast');
                                    $(this).attr('title', '收起').find(' > i').addClass('icon-minus-sign').removeClass('icon-plus-sign');
                                }

                                $('.tree li[class="parent_li"]').find("span").css("background-color", "transparent");
                                $(this).css("background-color", "#428bca");

                                options.onClickNode.call($(this), $(this));

                            });

                        };
                        //查询部门名称
                        function quertByIdList(obj) {
                            var v_sid = obj.id.substring(5);
                            $.ajax({
                                url:"<%=request.getContextPath()%>/zree/queryByidList.jhtml",
                                data:{
                                    "id":v_sid
                                },
                                type:"post",
                                success:function (res) {
                                    var v_sectList = res.data;
                                    for (var i=0;i<v_sectList.length;i++) {
                                        $("[name='sectname']").val(v_sectList[i].name);
                                    }

                                }
                            })
                        }
                        //递归拼接html构造树形子节点
                        function initTree(data) {
                            var strHtml = "";
                            for (var i = 0; i < data.length; i++) {
                                var arrChild = data[i].nodes;
                                var strHtmlUL = "";
                                var strIconStyle = "icon-leaf";
                                if (arrChild && arrChild.length > 0) {
                                    strHtmlUL = "<ul>";
                                    strHtmlUL += initTree(arrChild) + "</ul>";
                                    strIconStyle = "icon-minus-sign";
                                }

                                strHtml += "<li style='list-style-type:none;' id=\"li_" + data[i].id + "\"><span id=\"span_" + data[i].id + "\"><i class=\"" + strIconStyle + "\"></i>" + data[i].text + "</span>" + strHtmlUL + "</li>";

                            }
                            return strHtml;
                        };
                    };

                    //默认参数
                    $.fn.jqtree.defaults = {
                        url: null,
                        param: null,
                        data: null,
                        onBeforeLoad: function (param) { },
                        onLoadSuccess: function (data) { },
                        onClickNode: function (selector) { }
                    };

                })(jQuery);
                $(function () {
                    $("#ul_tree").jqtree({
                        data: testdata,
                        param: {},
                        onBeforeLoad: function (param) {
                        },
                        onLoadSuccess: function (data) {
                        },
                        onClickNode: function (selector) {
                        }
                    });
                });

            }

        })
        //弹出部门
        bootbox.alert({
            size:"small",
            title:"部门列表",
            message:' <div class="tree well">\n' +
            '                        <ul id="ul_tree"></ul>\n' +
            '                    </div>',
            callback:function () {

            }
        })
    }



</script>
<%--data 套插件--%>
<script type="">

    var array = [];
    $(function(){
        refreshTable();//刷新列表数据内容
        clickEvent();//绑定表格中的按钮事件
        asd()//表格变色  并选中Id
    })

    //点击删除按钮时执行的方法
    function clickEvent(){
        //给删除按钮绑定点击事件
        $('#table').on('click','.js-delete',function(){
            var id = $(this).attr("data-id")
            //bootBox 确认框
            bootbox.confirm({
                message: "确定要删除吗？",
                buttons: {
                    confirm: {
                        label: '确定',
                        className: 'btn-success'
                    },
                    cancel: {
                        label: '再想想',
                        className: 'btn-danger'
                    }
                },
                callback: function (result) {
                    if(result){

                        //请求删除方法
                        $.get('<%=request.getContextPath()%>/sta/deleteStaff.jhtml?id='+id+'', function(result){
                            if(result.code == 200){
                                bootbox.alert({
                                    message: "删除成功！ ",
                                    size: 'small'
                                });
                            }else{
                                bootbox.alert({
                                    message: "删除失败! ",
                                    size: 'small'
                                });
                            }
                            refreshTable();//刷新列表数据内容
                        })
                    }
                }
            });
        }).on('click','.js-edit',function(){
            var id = $(this).attr('data-id');
            <%--location.href = '<%=request.getContextPath()%>sta/queryDataTables.jhtml?id='+id+'';--%>
            toUpdateStaff(id);
        })
    }
    //加载表格
    function refreshTable(){
        var $dt = $('#table').dataTable({
            "columns" : [
                {
                    "data" : "id",
                    "class" : "text-center"
                },
                {
                    "data" : "staffName",
                    "class" : "text-center"
                },
                {
                    "data" : "staffSex",
                    "class" : "text-center",
                    "render" : function(data, type, row) {
                        if(data=="2"){
                            return "女";
                        }else if(data=="1"){
                            return "男";
                        }
                        return "";
                    }
                },
                {
                  "data" : "insertTime",
                  "class" : "text-center",
                  "render" : function(data, type, row) {
                      return new Date(data).Format("yyyy-MM-dd");
                  }
                },
                {
                    "data" : "updateTime",
                    "class" : "text-center",
                    "render" : function(data, type, row) {
                        return new Date(data).Format("yyyy-MM-dd");
                    }
                },
                {
                    "sTitle": "员工头像",
                    "data" : "imgUrl",
                    "render":function(data, type, row){
                        return "<img src='" + data + "' width='100'/>";
                    }
                },

                {
                    "data" : "sectionInfo.name",
                    "class" : "text-center"
                },
                {
                    "data" : "id",
                    "class" : "text-center",
                    "render" : function(data, type, row) {
                        return '<span class="btn btn-primary btn-xs ml-5 js-edit" data-id="'+data+'">编辑</span> <span class="btn btn-danger btn-xs ml-5 js-delete" data-id="'+data+'">删除</span>';
                    }
                },

            ],
            ajax : {//类似jquery的ajax参数，基本都可以用。
                type : "post",//后台指定了方式，默认get，外加datatable默认构造的参数很长，有可能超过get的最大长度。
                url : "<%=request.getContextPath()%>/sta/queryDataTables.jhtml",
                dataSrc : "data",//默认data，也可以写其他的，格式化table的时候取里面的数据
                cache: false, //在每次请求之后ajax不被请求
                data : function(d) {//d 是原始的发送给服务器的数据，默认很长。
                    var param = {};//因为服务端排序，可以新建一个参数对象
                    param.start = d.start;//开始的序号
                    param.length = d.length;//要取的数据的
                    return param;//自定义需要传递的参数。
                },
            },
            //"ajax": $.fn.dataTable.pagerAjax({url: "/listData"}),
            bJQueryUI : true, //使用DataTables提供的Themes，界面比较美观
            lengthMenu: [ //自定义分页长度
                [ 3, 5, 7 ],
                [ '3 条', '5 条', '7条' ]
            ],
            bPaginate:true,
            sPaginationType : "full_numbers",          // 分页

            /*
             * 默认为true
             * 是否允许终端用户从一个选择列表中选择分页的页数，页数为10，25，50和100，需要分页组件bPaginate的支持
             * 开关，是否显示一个每页长度的选择条（需要分页器支持）
             */

            bLengthChange:true,
            /*
               * 默认为true
               * 是否开启分页功能,即使设置为false,仍然会有一个默认的<前进,后退>分页组件
               */

            bPaginate:true,
            processing : true,//载入数据的时候是否显示“载入中”
            bDestroy : true, //用于当要在同一个元素上执行新的dataTable绑定时，将之前的那个数据对象清除掉，换以新的对象设置
            ordering : false,//排序操作在服务端进行，所以可以关了。


            language : {
                processing : "载入中",//处理页面数据的时候的显示
                paginate : {//分页的样式文本内容。
                    previous : "上一页 ",
                    next : " 下一页",
                    first : "第一页",
                    last : "最后一页"
                },
                zeroRecords : "没有内容",//table tbody内容为空时，tbody的内容。
                //下面三者构成了总体的左下角的内容。
                info : "第 _PAGE_/_PAGES_页 共 _TOTAL_条记录",//左下角的信息显示，大写的词为关键字。
                infoEmpty : "第 _PAGE_/_PAGES_页 共 _TOTAL_条记录",//筛选为空时左下角的显示。
                infoFiltered : ""//筛选之后的左下角筛选提示(另一个是分页信息显示，在上面的info中已经设置，所以可以不显示)，
            },
            "columnDefs": [{
                "defaultContent": "",
                "sInfo": "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 条简历",
                "targets": "_all"
            }]
        }).on('click', 'a[row-index]', function () {
        });
    }


    //对Date的扩展，将 Date 转化为指定格式的String
    //月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，
    //年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)
    //例子：
    //(new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423
    //(new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18
    Date.prototype.Format = function (fmt) { //author: meizz
        var o = {
            "M+": this.getMonth() + 1, //月份
            "d+": this.getDate(), //日
            "h+": this.getHours(), //小时
            "m+": this.getMinutes(), //分
            "s+": this.getSeconds(), //秒
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度
            "S": this.getMilliseconds() //毫秒
        };
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    }




    function asd(){
        //获取datatable的表格
        var table = $('#table').DataTable();
        //给 tbody 中的 每一行添加  一个点击事件
        $('#table tbody').on( 'click', 'tr', function () {
            //当点击的时候如果当前行的class  属性 不是selected
            if(!$(this).hasClass("selected")){
                //将当前tr 的class属性 改为selected
                $(this).toggleClass('selected');
                //获取每一行的数据
                var tableData = table.rows('.selected').data();
                //循环  每行的数据
                for (var i = 0; i < tableData.length; i++) {
                    //当数组为空的时候
                    if(array.length==0){
                        //直接将Id存到数组里边
                        array.push(tableData[i].id)
                    }else{//否则 循环得到的数据
                        for (var j = 0; j < array.length; j++) {
                            //当数组里边没有跟 此次获取到的数据匹配的话
                            if(tableData[i].id != array[i]){
                                //将不匹配的数据 放入array
                                array.push(tableData[i].id)
                            }
                            //当数据匹配的时候  break 跳出
                            break;
                        }
                    }
                }
            }else{//当class 为selected时 取消选中
                $(this).toggleClass('selected');
                var t_idi = $(this).find('td').eq(0).text();
                array = $.grep(array, function(value) {
                    return value != t_idi;
                });
            }
        } );
    }

</script>
<script>

    <%--添加弹框--%>

    function uploadImg() {
        $("#txt_file").fileinput({
            language: 'zh', //设置语言
            uploadUrl:"<%=request.getContextPath()%>/sta/uploadImg.jhtml", //上传的地址
            allowedFileExtensions: ['jpg', 'gif', 'png'],//接收的文件后缀
            uploadAsync: true, //默认异步上传
            showUpload:true, //是否显示上传按钮
            showRemove :true, //显示移除按钮
            showPreview :true, //是否显示预览
            showCaption:false,//是否显示标题
            dropZoneEnabled: false,//是否显示拖拽区域
            maxFileCount:1, //表示允许同时上传的最大文件个数
            enctype:'multipart/form-data',
            validateInitialCount:true,
            previewFileIcon: "<iclass='glyphicon glyphicon-king'></i>",
            msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
        }).on("fileuploaded", function (event, data, previewId, index){
            $("#imgUrl").val(data.response.fileName);
        });
    }

    function  addEmpl() {


        $.validator.setDefaults({
            submitHandler: function() {
                alert("提交事件!");
                submit;
            }
        });

        $().ready(function() {
// 在键盘按下并释放及提交后验证提交表单
            $("#signupForm").validate({
                rules: {    //验证规则

                    staffName1: {
                        required: true,
                        minlength: 2,
                        maxlength:10
                    },
                    staffSex11: {
                        required: true,
                        max:100,
                        digits:true,   //必须输入整数
                        number:true //输入必须是数字
                    },
                    staffImg: {
                        required: true,
                        max:100,

                    },


                    agree: "required"
                },
                messages: {// 错误信息，

                    staffName1: {
                        required: "请输入姓名",
                        minlength: "姓名至少由两个字字符组成",
                        maxlength:"最多十个"
                    },
                    staffSex11: {
                        required: "请输入年龄",
                        max:"年龄不能大于100",
                        digits:"必须为整数",   //必须输入整数
                        number:"请输入正确的数字"
                    },
                    staffImg: {
                        required: "必须上传图片",
                        max:"图片不能大于3000kb",

                    },


                }
            });
        });

        bootbox.dialog({

            size: "large",
            title: "添加员工信息",
            message: $("#addHtml").html() ,
            buttons: {
                cancel: {
                    label: "取消", // 自定义按钮名字
                    className: "btn-danger",  // 自定义类名
                    callback: function () {  // 自定义回调函数
                        // console.log("你点击了取消按钮")
                    }
                },
                ok: {
                    label: "保存",
                    className: "btn-danger",
                    callback: function () {
                        var  staffName1=$("[name='staffName1']").val();
                        var  staffSex11=$("[name='staffSex11']:checked").val();
                        var  insertTime=$("[name='insertTime']").val();
                        var  updateTime=$("[name='updateTime']").val();
                        var  imgUrl=$("[name='imgUrl']").val();
                        var  sectId=$("[name='sectId']").val();
                        $.ajax({
                            url:"<%=request.getContextPath()%>/sta/addStaff.jhtml",
                            type:"post",
                            data:{
                                "staffName":staffName1,
                                "insertTime":insertTime,
                                "updateTime":updateTime,
                                "staffSex":staffSex11,
                                "sectionInfo.id":sectId,
                                "imgUrl":imgUrl
                            },
                            datatype: "json",
                            success:function(){
                                refreshTable();
                            } ,
                            error:function(){

                            }
                        })
                    }
                },

            }
        })

        uploadImg();
        <!--时间插件-->
        $("#insertTime").datetimepicker({
            startView: 2,
            format: "yyyy-mm-dd",
            minView: "month",
            todayBtn: "linked",
            todayHighlight: true,
            language: "zh-CN",
            showMeridian: true,
            autoclose: true,
        }).on('changeDate', function (ev) {
            var insertTime = $("#insertTime").val();
            $("#insertTime").datetimepicker('insertTime', insertTime);
        });
        $("#updateTime").datetimepicker({
            startView: 2,
            format: "yyyy-mm-dd",
            minView: "month",
            todayBtn: "linked",
            todayHighlight: true,
            language: "zh-CN",
            showMeridian: true,
            autoclose: true,
        }).on('changeDate', function (ev) {
            var updateTime = $("#updateTime").val();
            $("#updateTime").datetimepicker('updateTime', updateTime);
        });

    }
    //修改
    function  toUpdateStaff(id) {
        bootbox.dialog({
            size: "large",
            title: "修改员工信息",
            message: $("#addHtml").html() ,
            buttons: {
                cancel: {
                    label: "取消", // 自定义按钮名字
                    className: "btn-danger",  // 自定义类名
                    callback: function () {  // 自定义回调函数
                        // console.log("你点击了取消按钮")
                    }
                },

                ok: {
                    label: "保存",
                    className: "btn-danger",
                    callback: function () {
                        var  v_id=$("[name='id']").val();
                        var  v_staffName=$("[name='staffName1']").val();
                        var  v_staffSex1=$("input[name='staffSex11']:checked").val();  var  insertTime=$("[name='insertTime']").val();
                        var  updateTime=$("[name='updateTime']").val();
                        var  imgUrl=$("[name='imgUrl']").val();
                        var  oldImgUrl=$("[name='oldImgUrl']").val();
                        var  sectId=$("[name='sectId']").val();
                        $.ajax({
                            url:"<%=request.getContextPath()%>/sta/updateStaff.jhtml",
                            type:"post",
                            data:{
                                "staffName":v_staffName,
                                "staffSex":v_staffSex1,
                                "insertTime":insertTime,
                                "updateTime":updateTime,
                                "imgUrl":imgUrl,
                                "oldImgUrl":oldImgUrl,
                                "sectionInfo.id":sectId,
                                "id":v_id
                            },
                            datatype: "json",
                            success:function(res){
                                refreshTable();
                            } ,
                            error:function(){

                            }
                        })
                    }
                },

            }
        })
        /**
         * 回现
         */
        $.ajax({
            url:"<%=request.getContextPath()%>/sta/toUpdateStaff.jhtml",
            type:"post",
            data:{
                "id":id
            },
            success:function (res) {
                var stsffInfo = res.data;
                $("[name='id']").val(stsffInfo.id)
                $("[name='staffName1']").val(stsffInfo.staffName)
                $("[name='insertTime']").val(showDate(stsffInfo.insertTime,1))
                $("[name='updateTime']").val(showDate(stsffInfo.updateTime,1))
                $("input[name=staffSex11][value="+stsffInfo.staffSex+"]").attr("checked",true);
                $("[name='staffImg']").html("<img src='" + stsffInfo.imgUrl + "' width='100'/>");
                $("[name='oldImgUrl']").val(stsffInfo.imgUrl);
                $("[name='sectname']").val(stsffInfo.sectionInfo.name);
            },
        });
        uploadImg()
    }

    /* 转换时间数据类型 */
    function showDate(dateValue,status){
        var date = new Date(dateValue);
        var year = date.getFullYear();
        var month = date.getMonth()+1;
        var day = date.getDate();
        var newDate="";
        if(status==1){
            newDate = year+"-"+month+"-"+day;
        }
        if(status==2){
            newDate = year+"年"+month+"月"+day+"日";
        }
        return newDate;
    }
</script>
</html>
