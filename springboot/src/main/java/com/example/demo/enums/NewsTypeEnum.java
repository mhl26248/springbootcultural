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
public enum NewsTypeEnum {


//    SALES_ALL(-1,"全部分类"),
    SALES_SIGN(1, "咨询分类1"),
    SALES_IN(2, "咨询分类2"),
    SALES_EXECUTE(3, "咨询分类22"),
    SALES_EXECUTE4(4, "咨询分类23"),
    SALES_EXECUTE5(5, "咨询分类24"),
    SALES_EXECUTE6(6, "咨询分类25"),
    SALES_EXECUTE7(7, "咨询分类26"),
    SALES_EXECUTE8(8, "咨询分类27");

    private Integer id;
    private String name;
    private static final Set<NewsTypeEnum> ALL = EnumSet.allOf(NewsTypeEnum.class);


    public static String getType(Integer id) {
        return ALL.stream()
                .filter(o -> o.id.equals(id))
                .map(o -> o.getName())
                .findAny().orElse(null);
    }
    public static List<Catlog> getAll() {
        List<Catlog> catlogList = new ArrayList<>();
        for(NewsTypeEnum newsCatEnum:ALL){
            Catlog catlog = new Catlog();
            catlog.setId(newsCatEnum.getId());
            catlog.setName(getType(newsCatEnum.getId()));
            catlogList.add(catlog);
        }
        return catlogList;
    }
}

@Data
class Type{
    Integer id;
    String name;
}
