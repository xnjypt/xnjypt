package com.fh.service.user.userinfo;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;


@Service("userinfoService")
public class UserInfoService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/*
	* 新增
	*/
	public void save(PageData pd)throws Exception{
		dao.save("UserInfoMapper.save", pd);
	}
	
	/*
	* 删除
	*/
	public void delete(PageData pd)throws Exception{
		dao.delete("UserInfoMapper.delete", pd);
	}
	
	/*
	* 修改
	*/
	public void edit(PageData pd)throws Exception{
		dao.update("UserInfoMapper.edit", pd);
	}
	
	/*
	*列表
	*/
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("UserInfoMapper.datalistPage", page);
	}
	
	/*
	*列表(全部)
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("UserInfoMapper.listAll", pd);
	}
	
	/*
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("UserInfoMapper.findById", pd);
	}
	
	/*
	* 批量删除
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("UserInfoMapper.deleteAll", ArrayDATA_IDS);
	}
	
	/*
	* 修改状态
	*/
	public void editStatus(PageData pd)throws Exception{
		dao.update("UserInfoMapper.editStatus", pd);
	}
	
	/*
	 * 重置交易密码
	 */
	public void resetTradePassword(PageData pd)throws Exception{
		dao.update("UserInfoMapper.resetTradePassword", pd);
	}
	
	/*
	 * 重置GOOGLE
	 */
	public void resetGoogleCheckCode(PageData pd)throws Exception{
		dao.update("UserInfoMapper.resetGoogleCheckCode", pd);
	}
	
	/*
	 * 重置GOOGLE
	 */
	public void setMerchantsID(PageData pd)throws Exception{
		dao.update("UserInfoMapper.setMerchantsID", pd);
	}
	
}

