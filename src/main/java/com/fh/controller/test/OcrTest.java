package com.fh.controller.test;



import com.fh.controller.common.SystemConstants;
import com.fh.util.Signs;
import net.sf.json.JSONObject;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import java.util.HashMap;
import java.util.Map;

public class OcrTest extends SystemConstants{

    public static Map<String,Object> recognizelmage(String [] arrUser) throws Exception {
        Map<String,Object> map = new HashMap();
        //创建httpclient
        CloseableHttpClient httpClient = HttpClients.createDefault();
        //创建连接/创建一个post请求
        HttpPost httpPost = new HttpPost(SystemConstants.TARGETURL);
        //创建头部信息
        httpPost.setHeader("host",SystemConstants.HOST);
        httpPost.setHeader("content-type","application/json");
        httpPost.setHeader("authorization",Signs.appSign(APPID,SECRET_ID,SECRET_KEY,"",2582000));
        //组装ocr接口需要的参数
        JSONObject json = new JSONObject();
        json.put("appid",APPID);
        json.put("cart_type",0);//0代表身份证的正面，1代表反面
        json.put("user_List",arrUser);//用户信息
        //转换格式
        StringEntity stringEntity = new StringEntity(json.toString(),"utf-8");
        httpPost.setEntity(stringEntity);
        CloseableHttpResponse response  = httpClient.execute(httpPost);
        //获取状态码
        int code =  response.getStatusLine().getStatusCode();
        HttpEntity httpEntity = response.getEntity();
        String entityString = EntityUtils.toString(httpEntity);

        //放到map里面
        map.put("code",code);
        map.put("result",entityString);
        return map;
    }

    public static void main(String[] args) throws Exception {
        String url = "https://ajhuplload-1258868025.cos.ap-beijing.myqcloud.com/upload/IMG_20190321_145054.jpg?q-sign-algorithm=sha1&q-ak=AKIDA05zCt7Ylrev2VGXWpORr57dYuEtX8FS&q-sign-time=1553152694;1553154494&q-key-time=1553152694;1553154494&q-header-list=&q-url-param-list=&q-signature=46fe08f10850652b7dbba24d34e3ceb42bc0a1f8&x-cos-security-token=92cd548dfed728dd4675c3f038c9dec2fa3d1a5610001";//路径
        String [] strings = url.split(",");
        Map<String, Object> recognizelmage = recognizelmage(strings);
        Object object = recognizelmage.get("result");
        System.out.println(object);
        System.out.println(recognizelmage.get("code"));
    }
}
