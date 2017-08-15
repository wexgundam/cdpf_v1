package com.critc.common.controller;

import com.critc.sys.vo.AvatarScale;
import com.critc.util.image.ImageCutUtil;
import com.critc.util.json.JsonUtil;
import com.critc.util.web.WebUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.Random;

/**
 * 图片文件上传Controller
 *
 * @autho 孔垂云
 * @date 2017/7/18.
 */
@RequestMapping("/")
@Controller
public class UploadController {
    @RequestMapping(value = "/uploadAvatar", method = RequestMethod.POST, produces = "text/html;charset=utf-8")
    @ResponseBody
    public String uploadAvatar(MultipartFile formData, String avatar_src, String avatar_data, HttpServletRequest request, Model model) {
        String dir = "D:\\upload\\image";
        String path = dir;//request.getSession().getServletContext().getRealPath(dir);

        String name = formData.getOriginalFilename();
        //判断文件的MIMEtype
        String type = formData.getContentType();
        if (type == null || !type.toLowerCase().startsWith("image/"))
            return JsonUtil.createOperaStr(false, "不支持的文件类型，仅支持图片！");
        System.out.println("file type:" + type);
        String fileName = new Date().getTime() + "" + new Random().nextInt(10000) + "_" + name.substring(name.lastIndexOf('.'));
        System.out.println("文件路径：" + path + ":" + fileName);
        /*Map<String,String> map=JsonUtil.toObject(avatar_data, HashMap.class);
        // 用户经过剪辑后的图片的大小
        float x = Float.parseFloat(map.get("x"));
        float y =Float.parseFloat(map.get("y"));
        float w = Float.parseFloat(map.get("width"));
        float h = Float.parseFloat(map.get("height"));*/
        //开始上传
        File targetFile = new File(path, fileName);
        //保存
        try {
            if (!targetFile.exists()) {
                targetFile.mkdirs();
                formData.transferTo(targetFile);
//                InputStream is = formData.getInputStream();
//                ImageCutUtil.cut(is, targetFile, (int) x, (int) y, (int) w, (int) h);
//                is.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return JsonUtil.createOperaStr(false, "上传失败，出现异常：" + e.getMessage());
        }
        return JsonUtil.createOperaStr(true, "上传成功!");//, request.getSession().getServletContext().getContextPath() + dir + fileName));
    }

    private int formartScale(Double d) {
        DecimalFormat df = new DecimalFormat("######0"); //四色五入转换成整数
        return Integer.parseInt(df.format(d));
    }

    @RequestMapping("/cutImg")
    public void cutImg(MultipartFile avatar_file, String avatar_data, HttpServletRequest request, HttpServletResponse response) {
        String dir = "D:\\upload\\image";
        String path = dir + "\\avatar.jpg";//request.getSession().getServletContext().getRealPath(dir);

        String fileName = new Date().getTime() + "" + new Random().nextInt(10000) + ".jpg";
        System.out.println("文件路径：" + path + ":" + fileName);
        AvatarScale avatarScale = JsonUtil.toObject(avatar_data, AvatarScale.class);
        // 用户经过剪辑后的图片的大小
        int x = (int) avatarScale.getX();
        int y = (int) avatarScale.getY();
        int w = (int) avatarScale.getWidth();
        int h = (int) avatarScale.getHeight();
        //开始上传
        File targetFile = new File(dir, fileName);
        //保存
        try {
            if (!targetFile.exists()) {
                targetFile.mkdirs();
                InputStream is = avatar_file.getInputStream();
                ImageCutUtil.cut(is, targetFile, x, y, w, h);
                is.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            WebUtil.out(response, JsonUtil.createOperaStr(false, "上传失败，出现异常：" + e.getMessage()));
        }
        WebUtil.out(response, "{\"result\":" + true + ",\"message\":\"" + "上传成功" + "\",\"url\":\"" + "http://localhost:8080/manage/assets/cropper3.0/avatar.jpg" + "\"}");
    }
}


