package com.example.demo.pages;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.transaction.annotation.Transactional;

/**
 * 作者：张风捷特烈
 * 时间：2018/8/17 0017:8:41
 * 邮箱：1981462002@qq.com
 * 说明：剑的数据映射类
 */
public interface SwordMapper {
    /**
     * 查询
     *
     * @param name
     * @return
     */
    @Select("SELECT*FROM sword WHERE NAME=#{name}")
    Sword findByName(@Param("name") String name);
    /**
     * 查询所有
     *
     * @return
     */
    @Select("SELECT*FROM sword")
    List<Sword> findALL();
    /**
     * 添加
     *
     * @param name
     * @param atk
     * @param hit
     * @param crit
     * @param attr_id
     * @param type_id
     * @return
     */
    @Select("INSERT sword VALUES(DEFAULT,#{name},#{atk},#{hit},#{crit},#{attr_id},#{type_id})")
    void insert(@Param("name") String name,
                @Param("atk") Integer atk,
                @Param("hit") Integer hit,
                @Param("crit") Integer crit,
                @Param("attr_id") Integer attr_id,
                @Param("type_id") Integer type_id
    );

}