package com.example.demo.pages;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.pagehelper.PageInfo;

/**
 * 作者：张风捷特烈
 * 时间：2018/8/17 0017:8:55
 * 邮箱：1981462002@qq.com
 * 说明：剑的控制层
 */
@RestController
public class SwordController {
 
    @Autowired
    private SwordService mSwordService;
 
    @GetMapping("/insert")
    public String insertSword(String name, Integer atk,
                              Integer hit,
                              Integer crit,
                              Integer attr_id,
                              Integer type_id) {
        mSwordService.insertSword(name, atk, hit, crit, attr_id, type_id);
 
        return "OK";
        //http://localhost:8080/insert?name=%E8%B5%A4%E5%87%B0&atk=3000&hit=100&crit=5&attr_id=1&type_id=2 添加数据
        //http://localhost:8080/findByName?name=赤凰 查询数据
    }
 
    @GetMapping("/findByName")
    public Sword findByName(String name) {
        return mSwordService.findByName(name);
    }
    //http://localhost:8080/findAllByPage?page=1&pageSize=3
    @GetMapping("/findAllByPage")
    public PageInfo<Sword> findAll(int page, int pageSize) {
        return mSwordService.findAll(page, pageSize);
    }//http://localhost:8080/findAllByPage?page=1&pageSize=3
}