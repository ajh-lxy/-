/**
 * 用户类型下拉
 * @param element
 * @param tid
 */
function initType(element,id){
    $.ajax({
        url:contextPath+"/type/userTypeList.jhtml",
        type:"post",
        success:function (result) {
            if (result.code==200){
                var v_userTypeList = result.data;
                for (var i=0; i<v_userTypeList.length;i++){
                    $("#"+element).append("<option value='"+v_userTypeList[i].tid+"'>"+v_userTypeList[i].typeName+"</option>");
                }
                if(id!=null){
                    $("#"+element).val(id);
                }
            }
        }
    })
}