package com.example.demo.pages;

import org.springframework.beans.factory.annotation.Autowired;

import lombok.Data;

/**
 * 作者：张风捷特烈
 * 时间：2018/8/17 0017:8:23
 * 邮箱：1981462002@qq.com
 * 说明：剑的实体类
 */
@Data //=@Getter +@Setter  //这里面没有生效所以还要get和set方法
public class Sword {


	private Integer id;
    private String name;
    private Integer atk;
    public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getHit() {
		return hit;
	}
	public void setHit(Integer hit) {
		this.hit = hit;
	}
	public Integer getCrit() {
		return crit;
	}
	public void setCrit(Integer crit) {
		this.crit = crit;
	}
	public Integer getAttr_id() {
		return attr_id;
	}
	public void setAttr_id(Integer attr_id) {
		this.attr_id = attr_id;
	}
	public Integer getType_id() {
		return type_id;
	}
	public void setType_id(Integer type_id) {
		this.type_id = type_id;
	}
	private Integer hit;
    private Integer crit;
    private Integer attr_id;
    private Integer type_id;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getAtk() {
		return atk;
	}
	public void setAtk(Integer atk) {
		this.atk = atk;
	}
}
