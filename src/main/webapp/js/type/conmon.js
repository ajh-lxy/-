//Tomcat下path的值，上下文路径
var contextPath="";


///表格变色公共提取部分
/* 定义数组。供翻页使用 */	
var   rowIds = [];
function initTable(tableId,checkName) {
	 /* 获取tr */
	 $("#"+tableId).each(function(){
		 /* 找到name为che的 checkbox框*/
	    var v_checkbox = $(this).find("input[name='"+checkName+"']:checkbox")[0];
		 /* 循环遍历数组 翻页被选中 */
		for(var i=0;i<rowIds.length;i++){
			if(rowIds[i]==v_checkbox.value){
				$(this).css("background","red");
				 v_checkbox.checked=true;
			}
		}                                                                
		 $(this).bind({
				click:function(){
			 if(v_checkbox.checked){
				 /* 如果处于选中的状态则让它不被选中 并且取消变色 */
				 $(this).css("background","");
				 v_checkbox.checked=false;
				 deleteRowId(v_checkbox.value);
				 //console.log(rowIds)
			 }else{
				 /* 如果不处于选中的状态则让它被选中 并且变色 */
				 $(this).css("background","red");
				 v_checkbox.checked=true;
				 rowIds.push(v_checkbox.value);
				// console.log(rowIds)
			 }
			},
			mouseover:function(){
		    	 if(v_checkbox.checked){
		    		//添加颜色
				 $(this).css("background","red"); 
		    		
		    	 }else {
		    		 $(this).css("background","blue");
				}
		     },  
			 mouseout:function(){
				 if(v_checkbox.checked){
			    		//添加颜色
					 $(this).css("background","red"); 
			    		
				 }else {
					 //离开变为黄色
		    		 $(this).css("background","yellow");
		    		 //正常店铺绿色关闭店铺红色
		    		 var v_status= $(this).attr("data-id-status");
						if(v_status){
							if(v_status==1){
								$(this).css("background","green");
							}else if(v_status==2){
								$(this).css("background","red");
							}
						}
						//库存低于10背景色为红
						var v_count = $(this).attr("data-count");
						if(v_count){
							if(v_count<10){
								$(this).css("background","red");
							}
						}
				}
			 }  	   
		 })
	 })
}
/* 删除数组对应的id */	
function deleteRowId(id){
	 for(var i=rowIds.length-1; i>=0;i--){
		 if(rowIds[i]==id){
			 rowIds.splice(i,1);
			 
		 }
	 }
}	