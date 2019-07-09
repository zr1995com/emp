package com.kgc.service;

import com.github.pagehelper.PageInfo;
import com.kgc.entity.Emp;
import com.kgc.utils.EmpParam;

public interface EmpService {
    public PageInfo<Emp> getEmpByPage(Integer pageIndex,Integer pageSize,EmpParam empParam);

    public boolean addEmp(Emp emp);

    public Emp getEmpById(Integer empno);

    public boolean updateEmp(Emp emp);

    public boolean deleteEmp(Integer empno);

    public boolean deleteEmpList(Integer[] empnos);
}
