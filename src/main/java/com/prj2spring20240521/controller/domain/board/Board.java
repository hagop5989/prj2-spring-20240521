package com.prj2spring20240521.controller.domain.board;

import lombok.Data;

@Data
public class Board {
    private String title;
    private String content;
    private String writer;
}