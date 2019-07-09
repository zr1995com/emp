package com.kgc.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.kgc.entity.Dept;
import com.kgc.entity.Emp;
import com.kgc.entity.EmpExample;
import com.kgc.mapper.DeptMapper;
import com.kgc.mapper.EmpMapper;
import com.kgc.service.EmpService;
import com.kgc.utils.EmpParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

@Service
public class EmpServiceImpl implements EmpService {
    @Autowired
    private EmpMapper empMapper;
    @Autowired
    private DeptMapper deptMapper;
    @Override
    public PageInfo<Emp> getEmpByPage(Integer pageIndex, Integer pageSize, EmpParam empParam) {
        EmpExample empExample=new EmpExample();
        EmpExample.Criteria criteria = empExample.createCriteria();
        if (empParam!=null){
            if (empParam.getDeptno()!=null&&empParam.getDeptno()!=-1){
                criteria.andDeptnoEqualTo(empParam.getDeptno());
            }
            if (empParam.getEmpname()!=null&&!empParam.getEmpname().equals("")){
                criteria.andEmpnameLike("%"+empParam.getEmpname()+"%");
            }
            if (empParam.getMin_sal()!=null){
                criteria.andSalGreaterThanOrEqualTo(empParam.getMin_sal());
            }
            if (empParam.getMax_sal()!=null){
                criteria.andSalLessThanOrEqualTo(empParam.getMax_sal());
            }
        }
        PageHelper.startPage(pageIndex,pageSize);
        List<Emp> emps = empMapper.selectByExample(empExample);
        if (emps!=null){
            for (Emp e:emps){
                Integer deptno = e.getDeptno();
                Dept dept = deptMapper.selectByPrimaryKey(deptno);
                e.setDept(dept);
            }
        }
        PageInfo<Emp> pageInfo=new PageInfo<>(emps,5);
        return pageInfo;
    }

    @Override
    public boolean addEmp(Emp emp) {
        return empMapper.insertSelective(emp)>0?true:false;
    }

    @Override
    public Emp getEmpById(Integer empno) {
        Emp emp = empMapper.selectByPrimaryKey(empno);
        Integer deptno = emp.getDeptno();
        Dept dept = deptMapper.selectByPrimaryKey(deptno);
        emp.setDept(dept);
        return emp;
    }

    @Override
    public boolean updateEmp(Emp emp) {
        return empMapper.updateByPrimaryKeySelective(emp)>0?true:false;
    }

    @Override
    public boolean deleteEmp(Integer empno) {
        return empMapper.deleteByPrimaryKey(empno)>0?true:false;
    }

    @Override
    public boolean deleteEmpList(Integer[] empnos) {
        EmpExample example=new EmpExample();
        EmpExample.Criteria criteria = example.createCriteria();
        List<Integer> list = Arrays.asList(empnos);
        criteria.andEmpnoIn(list);
        return empMapper.deleteByExample(example)>0?true:false;
    }
}
