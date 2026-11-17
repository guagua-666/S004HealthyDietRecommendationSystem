package com.daowen.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.daowen.service.ISiteSearch;
import com.daowen.util.BeansUtil;
import com.daowen.util.JsonResult;
import com.daowen.vo.SearchVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.daowen.ssm.simplecrud.SimpleController;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@RestController
public class SitesearchController extends SimpleController {

	


	@PostMapping("/admin/search")
	public JsonResult search() {
		String title = request.getParameter("title");
		if(title==null)
			return JsonResult.error(-1,"title不能为空");
		Map<String, ISiteSearch> searchMap= BeansUtil.getBeanOfType(ISiteSearch.class);
		List<SearchVo> listSearch=new ArrayList<>();

		if(searchMap!=null&&searchMap.size()>0){
				for (Map.Entry<String, ISiteSearch> entry : searchMap.entrySet()) {
					if(entry.getValue()!=null) {
						List<SearchVo> list = entry.getValue().search(title);
						if(list!=null&&list.size()>0)
							listSearch.addAll(list);
					}
				}

			}

		return JsonResult.success(1,"获取成功",listSearch);


	}
	
	

	

}
