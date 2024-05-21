package com.prj2spring20240521.controller.service.board;

import com.prj2spring20240521.controller.domain.board.Board;
import com.prj2spring20240521.controller.service.mapper.board.BoardMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(rollbackFor = Exception.class) // 모든 e 에 대해 rollback
@RequiredArgsConstructor
public class BoardService {

    private final BoardMapper mapper;

    public void add(Board board) {
        mapper.insert(board);
    }
}
