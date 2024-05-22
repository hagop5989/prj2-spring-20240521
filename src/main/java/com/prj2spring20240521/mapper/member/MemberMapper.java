package com.prj2spring20240521.mapper.member;

import com.prj2spring20240521.domain.Member;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface MemberMapper {

    @Insert("""
            INSERT INTO member(email, password, nick_Name)
            VALUES (#{email}, #{password}, #{nickName})
            """)
    public int insert(Member member);

    @Select("""
            SELECT *
            FROM member
            WHERE email = #{email}
            """)
    Member selectByEmail(String email);
}
