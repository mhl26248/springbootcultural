package com.example.demo.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.common.Result;
import com.example.demo.entity.CheckCode;
import com.example.demo.entity.Word;
import com.example.demo.mapper.CheckCodeMapper;
import com.example.demo.mapper.RecordMapper;
import com.example.demo.mapper.UserMapper;
import com.example.demo.mapper.WordMapper;
import com.example.demo.utils.SensitiveFilterUtil;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/word")
public class WordController extends BaseController {

    @Resource
    WordMapper wordMapper;


    @PostMapping("/save")
    public Result<?> save(@RequestBody Word obj) {
        //check
        LambdaQueryWrapper<Word> wrapper = Wrappers.lambdaQuery();
        wrapper.eq(Word::getUserId,obj.getUserId());
        wrapper.eq(Word::getRecordId,obj.getRecordId());
        if(wordMapper.selectCount(wrapper)>0){
            return Result.error("001","已经举报过了");
        }

        wordMapper.insert(obj);
        return Result.success();
    }

    @PostMapping("/update")
    public Result<?> update(@RequestBody Word obj) {
        wordMapper.updateById(obj);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<?> update(@PathVariable Long id) {
        wordMapper.deleteById(id);
        return Result.success();
    }
    @GetMapping("/check")
    public Result<?> check(@RequestParam String text) {
        List<Word> ingWord = wordMapper.selectList(null);
        Set<String> wordStrs = ingWord.stream().map(Word::getWord).collect(Collectors.toSet());
        HashSet set = SensitiveFilterUtil.checkTxt(text, (HashSet<String>) wordStrs);

        if(CollectionUtils.isNotEmpty(set)){
            return Result.error("001","词汇异常，请重新输入");
        }
        return Result.success();
    }


    @GetMapping("/{id}")
    public Result<?> getById(@PathVariable Long id) {
        return Result.success(wordMapper.selectById(id));
    }


    @Resource
    UserMapper userMapper;
    @Resource
    RecordMapper recordMapper;
    @GetMapping("/findPage")
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "")  String text1,
                              @RequestParam(defaultValue = "") String search) {
        LambdaQueryWrapper<Word> wrapper = Wrappers.lambdaQuery();
        if (StrUtil.isNotBlank(text1)) {
            List<Word> ingWord = wordMapper.selectList(null);
            Set<String> wordStrs = ingWord.stream().map(Word::getWord).collect(Collectors.toSet());
            HashSet set = SensitiveFilterUtil.checkTxt(text1, (HashSet<String>) wordStrs);

            if(CollectionUtils.isNotEmpty(set)){
                return Result.error("001","词汇异常，请重新输入");
            }
        }
        Page<Word> page = wordMapper.selectPage(new Page<>(pageNum, pageSize), wrapper.orderByDesc(Word::getId));
        List<Word> words = page.getRecords();
        if(CollectionUtils.isNotEmpty(words)){
            for (Word w:words){
                w.setUserName(userMapper.selectById(w.getUserId()).getUsername());
                w.setTitle(recordMapper.selectById(w.getRecordId()).getTitle());
            }
        }
        return Result.success(page);
    }
}
