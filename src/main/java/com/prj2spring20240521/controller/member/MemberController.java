package com.prj2spring20240521.controller.member;

import com.prj2spring20240521.domain.Member;
import com.prj2spring20240521.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/member")
public class MemberController {
    MemberService service;

    @PostMapping("signup")
    public void signup(@RequestBody Member member) {
        System.out.println("member = " + member);
    }

    @GetMapping(value = "check", params = "email")
    public ResponseEntity checkEmail(@RequestParam("email") String email) {
        Member member = service.getByEmail(email);
        if (member == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(email);
    }

    @GetMapping(value = "check", params = "nickName")
    public void checkNickName(@RequestParam("nickName") String nickName) {
        System.out.println("nickName = " + nickName);
    }
}
