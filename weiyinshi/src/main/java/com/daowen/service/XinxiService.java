package com.daowen.service;
import com.daowen.entity.Huiyuan;
import com.daowen.entity.Lanmu;
import com.daowen.entity.LanmuType;
import com.daowen.entity.Xinxi;

import com.daowen.util.ViewHistory;
import com.daowen.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.daowen.mapper.XinxiMapper;
import com.daowen.ssm.simplecrud.SimpleBizservice;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.text.MessageFormat;
import java.util.*;

@Service
public class XinxiService extends SimpleBizservice<XinxiMapper> implements  ISiteSearch, ILanmuAdapter {

    @Autowired
    private XinxiMapper xinxiMapper;

    private String prefix="xinxi_browser_";

    @Autowired
    private LanmuService lanmuSrv=null;

    public List<XinxiVo> getEntityPlus(HashMap map){
        return xinxiMapper.getEntityPlus(map);
    }
    public  List<XinxiVo> findXinxi(int lmid){
        HashMap<String,Object> map=new HashMap();
        map.put("lmid",lmid);
        map.put("state",2);
        return xinxiMapper.getEntityPlus(map);
    }
    public XinxiVo loadPlus(int id){
        HashMap<String,Object> map=new HashMap();
        map.put("id",id);
        return xinxiMapper.loadPlus(map);
    }


    public List<XinxiVo> getRecomment(HttpServletRequest request, Huiyuan huiyuan) {

        if(huiyuan==null)
            return null;
        String username=huiyuan==null?"":huiyuan.getAccountname();
        // 获取历史浏览
        List<String> ids =new ViewHistory(prefix+username).historyView(request);
        String temids = "";
        int i = 0;
        for (String id : ids) {
            temids += id;
            if (i < ids.size() - 1) {
                temids += ",";
            }
            i++;

        }
        if (ids != null && ids.size() > 0) {
            HashMap<String,Object> map=new HashMap<String,Object>();
            map.put("ids",ids);
            return getEntityPlus(map);

        }
        return null;
    }



    public  int getCount(int lmid ){

         return xinxiMapper.getRecordCount(MessageFormat.format("  where  lmid={0} ",lmid));

    }


    public List<Xinxi> getRelated(int id){
        int maxSize=this.getRecordCount("");
        int count=3;
        if(maxSize<count)
            count=maxSize;

        List<Integer> listPos= random(count,maxSize);
        List<Xinxi> list=getEntity("");
        List<Xinxi> listRan=new ArrayList<>();
        int index=0;
        for(Xinxi xinxi :list){
            if(has(listPos,index++))
                listRan.add(xinxi);
        }
        return listRan;
    }
    private  boolean has(List<Integer> list,Integer val){
        for(Integer i :list){
            if(val==i)
                return true;
        }
        return false;
    }

    private List<Integer> random(int count,int maxSize){
        Random r = new Random();
        ArrayList<Integer> h = new ArrayList<>();
        if(count>maxSize)
            count=maxSize;
//        循环生成随机数
        while (h.size() < count) {
            LinkedHashSet<Integer> set = new LinkedHashSet<>();//利用set集合去重
            h.add(r.nextInt((maxSize) + 1));//获取1至20的随机数，nextInt（20）的取值是0至19，所有后面+1
            set.addAll(h);//利用set集合 addAll h集合，达到去重目的
            h.clear();//清空h集合
            h.addAll(set);//再将set集合元素还给h集合
        }

        Collections.sort(h, Collections.reverseOrder());//获取随机数的降序排序
        System.out.println("降序为后：" + h);
        return h;
    }



    public List<SearchVo>  search(String title){

        HashMap map=new HashMap();
        map.put("keyword",title);
        List<XinxiVo> listXinxi=getEntityPlus(map);
        if(listXinxi==null)
            return null;
        List<SearchVo> listSearch=new ArrayList<>();
        for(XinxiVo xinxi :listXinxi){
            SearchVo searchVo=new SearchVo();
            searchVo.setId(xinxi.getId());
            searchVo.setName(xinxi.getTitle());
            searchVo.setHref("/pages/e/xinxiinfo?id="+ xinxi.getId());
            if(xinxi.getImages()!=null&&xinxi.getImages().size()>0)
                searchVo.setTupian(xinxi.getImages().get(0));
            else
                searchVo.setTupian(xinxi.getTupian());
            searchVo.setXtype(1);
            listSearch.add(searchVo);
        }
        return  listSearch;
    }

    @Override
    public int getDefineCode() {
        return LanmuType.NEWS;
    }

    @Override
    public LanmuContentVo<ImageTextItem> getLanmuContent(Lanmu lanmu) {
        if(lanmu==null)
            return null;
        HashMap map=new HashMap<String,Object>();
        map.put("lmid",lanmu.getId());
        map.put("tuijian",1);
        map.put("order"," order by id desc ");
        map.put("topcount",10);
        List<XinxiVo> listXinxi= getEntityPlus(map);
        List<ImageTextItem> listIti=new ArrayList<>();
        listXinxi.forEach(c->{
            ImageTextItem iti=new ImageTextItem();
            iti.setName(c.getTitle());
            iti.setId(c.getId());
            iti.setHref("/e/xinxiinfo.jsp?id="+c.getId());
            if(c.getImages()!=null&&c.getImages().size()>0)
                iti.setTupian(c.getImages().get(0));
            else
                iti.setTupian(c.getTupian());
            iti.setPrice(0);

            iti.setClickCount(c.getClickcount());
            listIti.add(iti);
        });
        return new LanmuContentVo<ImageTextItem>(lanmu,listIti);


    }

    @Override
    public List<LanmuVo> getMyLanmus() {

        HashMap<String,Object> map=new HashMap<>();
        map.put("type",this.getDefineCode());
        return lanmuSrv.getEntityPlus(map);
    }

    public XinxiService view(HttpServletRequest request, HttpServletResponse response, Huiyuan huiyuan, String id){
        if(huiyuan==null)
            return this;
        String username=huiyuan==null?"":huiyuan.getAccountname();
        //获取历史浏览
        new ViewHistory(prefix+username).view(request,response,id);
        return this;
    }
}
