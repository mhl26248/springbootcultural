package com.example.demo.enums;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;

import java.util.ArrayList;
import java.util.EnumSet;
import java.util.List;
import java.util.Set;


@Slf4j
@Getter
@AllArgsConstructor
@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum TypeEnum {


//    SALES_ALL(-1,"全部分类"),
    SALES_SIGN(1, "申报分类11"),
    SALES_IN(2, "申报分类12"),
    SALES_EXECUTE(3, "申报分类13"),
    SALES_EXECUTE4(4, "申报分类14"),
    SALES_EXECUTE5(5, "申报分类15"),
    SALES_EXECUTE6(6, "申报分类16"),
    SALES_EXECUTE7(7, "申报分类17"),
    SALES_EXECUTE8(8, "申报分类18");

    private Integer id;
    private String name;
    public static final Set<TypeEnum> ALL = EnumSet.allOf(TypeEnum.class);


}

