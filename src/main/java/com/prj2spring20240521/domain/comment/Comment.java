package com.prj2spring20240521.domain.comment;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Data
public class Comment {
    private Integer id;
    // 하나의 게시물에 같은사람이 여러번 달 수 있어서 id가 필요, 다른것을 묶어서 PRIKEY 불가.
    private Integer boardId;
    private Integer memberId;
    private String comment;
    private LocalDateTime inserted;

    private String nickName;

    public String getInserted() {
        LocalDateTime beforeOneday = LocalDateTime.now().minusDays(1);

        if (inserted.isBefore(beforeOneday)) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            return inserted.format(formatter).toString();
        } else {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss");
            return inserted.format(formatter).toString();
        }
    }
}
