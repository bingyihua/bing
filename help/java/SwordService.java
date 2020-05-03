package com.example.demo.pages;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 作者：张风捷特烈
 * 时间：2018/8/17 0017:8:48
 * 邮箱：1981462002@qq.com
 * 说明：服务层
 */
@Service//坑点1别忘加Service注解
public class SwordService {
 
    @Autowired
    private SwordMapper mSwordMapper;
 
    @Transactional
    public void insertSword(String name, Integer atk,
                            Integer hit,
                            Integer crit,
                            Integer attr_id,
                            Integer type_id) {
        mSwordMapper.insert(name, atk, hit, crit, attr_id, type_id);
        
        //int i = 1 ;//异常处
    }
 
    public Sword findByName(String name) {
        return mSwordMapper.findByName(name);
    }
    /**
     * 分页查询
     * @param page 当前页数
     * @param pageSize 每页个数
     * @return
     */
    public PageInfo<Sword> findAll(int page,int pageSize) {
        PageHelper.startPage(page, pageSize);//改写语句实现分页查询
        List<Sword> all = mSwordMapper.findALL();
        PageInfo<Sword> info = new PageInfo<>(all);
        return info;
    }
}