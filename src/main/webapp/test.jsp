<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2019/3/12
  Time: 23:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery/jquery-3.3.1.min.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/datetimepicker/js/bootstrap-datetimepicker.js"></script>
<link  rel="stylesheet" href="<%=request.getContextPath()%>/datetimepicker/css/bootstrap-datetimepicker.css"/>

<head>
    <title>Title</title>
</head>
<body>
<input type="text" id="staDate" data-date-format="yyyy-mm-dd" onclick="testx()"/>
<form id="uploadForm" enctype="multipart/form-data">
    <input id="file" type="file" name="file"/>
    <br><br><br>
    <button id="upload" type="button" onclick="uploadImg()" >测试上传图片到阿里云</button>
    <div id="imgDiv"></div>
</form>

</body>



<script>
    /*
      ajax文件上传教程：
      https://blog.csdn.net/inuyasha1121/article/details/51915742
      */
    function uploadImg() {
        debugger
        $.ajax({
            type: "post",
            url: '<%=request.getContextPath()%>/staUser/uploadFile.jhtml',
            data: new FormData($('#uploadForm')[0]),
            processData: false,
            contentType: false,
            success: function (data) {
                if (data.code==200){
                    alert("上传成功")
                    $("#imgDiv").html("<img src='" + data.fileName + "' width='100'/>")
                }else {
                    alert("上传失败")
                }
            },
            error:function (XMLHttpRequest, textStatus, errorThrown) {
                alert("请求失败！");
            }
        });
    }
</script>

<script>

    function uploadFile() {
        var form = new FormData();
        //$("#file").get(0)是获取节点元素，files[0]将节点元素转换为file文件
        form.append("file",$("#file").get(0).files[0]);
        $.ajax({
            url:"<%=request.getContextPath()%>/staUser/upload.jhtml",
            contentType:false,
            processData:false,
            data:form,
            type:"post",
            success:function (res) {
                if (res==200){
                    $("#statusDiv").html("<font style='color: lawngreen'>上传成功</font>")
                }else {
                    $("#statusDiv").html("<font style='color: red'>上传错误</font>")
                }
            },
            error:function (res) {
                alert("系统繁忙")
            }
        })
    }


    function testx() {
        $('#staDate').datetimepicker({
            Date:'yyyy-mm-dd',
            format: 'yyyy-mm-dd',
            language:'zh-CN',
            autoclose:true,
            minView:'month',
            maxView:1,
            todayBtn:'linked',
            showMeridian:false,
        });
    }

</script>
</html>
