package com.fh.service.user.loginmember;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;


@Service("loginmemberService")
public class LoginMemberService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/*
	* 新增
	*/
	public void save(PageData pd)throws Exception{
		dao.save("LoginMemberMapper.save", pd);
	}
	
	/*
	* 删除
	*/
	public void delete(PageData pd)throws Exception{
		dao.delete("LoginMemberMapper.delete", pd);
	}
	
	/*
	* 修改
	*/
	public void edit(PageData pd)throws Exception{
		dao.update("LoginMemberMapper.edit", pd);
	}
	
	/*
	*列表
	*/
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("LoginMemberMapper.datalistPage", page);
	}
	
	/*
	*列表(全部)
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("LoginMemberMapper.listAll", pd);
	}
	
	/*
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("LoginMemberMapper.findById", pd);
	}
	
	/*
	* 批量删除
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("LoginMemberMapper.deleteAll", ArrayDATA_IDS);
	}

	/*
	* 重设登陆密码
	*/
	public void resetLoginPassword(PageData pd)throws Exception{
		dao.update("LoginMemberMapper.resetLoginPassword", pd);
	}
	
	/*
	* 通过id获取数据
	*/
	public PageData findByUserName(PageData pd)throws Exception{
		return (PageData)dao.findForObject("LoginMemberMapper.findByUserName", pd);
	}
}

