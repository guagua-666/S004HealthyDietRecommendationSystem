let sysutil={

    isDuringDate:function(begdateStr,enddateStr){

        let curDate=new Date(),
            begdate=new Date(begdateStr),
            enddate=new Date(enddateStr);
          if (curDate>=begdate&&curDate<=enddate)
              return true;
           return false;

    },
    isPasted:function(begdateStr,enddateStr){

        let curDate=new Date(),
            begdate=new Date(begdateStr),
            enddate=new Date(enddateStr);
        if (curDate>enddate)
            return true;
        return false;

    },




}
