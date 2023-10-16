package com.pickmeup.jobstartup.recruiter.mypage.controller;

import com.pickmeup.jobstartup.recruiter.apply.dto.ApplyDTO;
import com.pickmeup.jobstartup.recruiter.apply.service.ApplyServiceImpl;
import com.pickmeup.jobstartup.recruiter.appmanagement.dto.AppManageDTO;
import com.pickmeup.jobstartup.recruiter.jobposting.dto.JobPostingDTO;
import com.pickmeup.jobstartup.recruiter.mypage.dto.RecruiterCalendarDTO;
import com.pickmeup.jobstartup.recruiter.mypage.dto.RecruiterFileDTO;
import com.pickmeup.jobstartup.recruiter.mypage.dto.RecruiterJobPostingDTO;
import com.pickmeup.jobstartup.recruiter.mypage.dto.RecruiterMyPageDTO;
import com.pickmeup.jobstartup.recruiter.mypage.service.RecruiterMyPageService;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@RequestMapping("/recruiter")
@RequiredArgsConstructor
@Controller
public class RecruiterMyPageController {
    @Autowired
    private RecruiterMyPageService recruiterMyPageService;

    //관련 서비스 또는 DTO
    private ApplyServiceImpl applyService;
    private ApplyDTO applyDTO;

    //기업 페이지: 회사 정보
    @GetMapping("/myPage")
    public String companyInfo(@RequestParam int company_no, Model model) {
        //Business Logic
        RecruiterMyPageDTO recruiterMyPageDTO = recruiterMyPageService.selectRecruiterInfo(company_no);         //이건? 바꿔야 함
        RecruiterFileDTO recruiterFileDTO = recruiterMyPageService.selectComLogoName(company_no);   //file select
        //Model and View
        recruiterFileDTO.setCompany_no(company_no);
        model.addAttribute("recruiterMyPageDTO", recruiterMyPageDTO);
        model.addAttribute("recruiterFileDTO", recruiterFileDTO);

        //임시
        List<RecruiterJobPostingDTO> recruiterJobPostingDTO = recruiterMyPageService.getJobPostingList(company_no);
        model.addAttribute("recruiterJobPostingDTO",recruiterJobPostingDTO);
        System.out.println(recruiterJobPostingDTO);

        return "/recruiter/mypage/recruiterMyPage";
    }

    //기업 페이지: 1) 박람회 현황(Ajax) + pagination
    @PostMapping("/getJobFairList")
    public String companyJobFairList() {
        //Parameter: company_no
        //Business Logic: call JobFairList
        //Model and View
        return "";
    }

    //기업 페이지: 2) 공고 관리(Ajax) + pagination
    @PostMapping("/getJobPostingList")
    public String companyJobPostingList(@RequestParam int company_no, Model model,
                                         List<RecruiterJobPostingDTO> recruiterJobPostingDTO) {
        //Business Logic: call JobPostingList
        recruiterJobPostingDTO = recruiterMyPageService.getJobPostingList(company_no);
        //Model and View
        model.addAttribute("recruiterJobPostingDTO",recruiterJobPostingDTO);
        return "/recruiter/mypage/recruiterMyPage";
    }

    //기업 페이지: 3) 지원자 관리(Ajax) + pagination
    @PostMapping("/getAppList")
    public String companyAppList() {
        //Parameter: company_no
        //Business Logic: call AppList
        //Model and View
        return "";
    }

    //기업 페이지: 정보 수정 리스트 (또는 approval 담당의 jsp 이용)
    @PostMapping("/editCompanyInfoList")
    public String editCompanyInfoList() {

        return "";
    }

    //기업 페이지: 정보 수정 (또는 approval 담당의 jsp 이용)
    @PostMapping("/editCompanyInfo")
    public String editCompanyInfo() {

        return "";
    }

    //기업 페이지: 파일 - 저장된 로고 이름 확인
    @PostMapping("/selectComLogo")
    public String selectComLogoName(@RequestParam int company_no) {

        //Business Logic
        RecruiterFileDTO recruiterFileDTO = new RecruiterFileDTO();
        recruiterFileDTO = recruiterMyPageService.selectComLogoName(company_no);
        //Model and View
        return recruiterFileDTO.getLogo_savname();
    }

    //기업 페이지: 파일 - 로고 수정(원본 삭제, 파일 업로드)
    @PostMapping("/updateComLogo")
    public String updateComLogo(Model model, @RequestParam int company_no,
                                @RequestParam("logoFile") MultipartFile logoFile) {

        //Business Logic
        String savedSavname = selectComLogoName(company_no);
        recruiterMyPageService.updateComLogo(logoFile, company_no, savedSavname);
        //Model and View
        return "/recruiter/mypage/recruiterMyPage";
    }

    //기업 페이지: 파일 - 로고 다운로드
    @RequestMapping("/downloadComLogo/{company_no}")
    public void download(RecruiterFileDTO recruiterFileDTO, @PathVariable int company_no, HttpServletResponse response) throws Exception{

        //Business Logic
        recruiterFileDTO = recruiterMyPageService.selectComLogoName(company_no);

        String logo_orgname = recruiterFileDTO.getLogo_orgname();
        String logo_savname = recruiterFileDTO.getLogo_savname();

        byte[] fileByte = FileUtils.readFileToByteArray(new File("C:/jobStartUp_fileUpload/company/logo/"+logo_savname));
        response.setContentType("application/octet-stream");    //파일유형설정
        response.setContentLength(fileByte.length);             //파일길이설정
        response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(logo_orgname,"UTF-8")+"\";"); //데이터형식/성향설정 (attachment: 첨부파일)
        response.setHeader("Content-Transfer-Encoding", "binary");         //내용물 인코딩방식설정
        response.getOutputStream().write(fileByte);             //버퍼의 출력스트림을 출력
        response.getOutputStream().flush();                     //버퍼에 남아있는 출력스트림을 출력
        response.getOutputStream().close();                     //출력스트림을 닫는다
    }

    //기업 페이지: 캘린더 팝업
    @RequestMapping("/calendarPopup")
    public String companyCalendarPop(){
        return "/recruiter/mypage/recruiterCalendarPopUp";
    }

    //기업 페이지: 조회 - 캘린더 일정
    @GetMapping(value = "/getCalendar", params = "method=data", produces = "application/json")
    @ResponseBody // JSON 데이터를 반환
    public List<RecruiterCalendarDTO> selectCalendar() {
        List<RecruiterCalendarDTO> calendarList = recruiterMyPageService.selectRecruCalendar();
        return calendarList; // 실제 데이터를 반환
    }

    //기업 페이지: 입력 - 캘린더 일정
    @ResponseBody
    @PostMapping(value = "/insertCalendar", produces = "application/json")
    public String insertCalendar(@RequestBody RecruiterCalendarDTO recruiterCalendarDTO
                                ,@RequestParam String method){
        recruiterMyPageService.insertRecruCalendar(recruiterCalendarDTO);
        return "success";
    }

    //기업 페이지: 삭제 - 캘린더 일정
    @ResponseBody
    @PostMapping(value = "/deleteCalendar", produces = "application/json")
    public String deleteCalendar(@RequestBody RecruiterCalendarDTO recruiterCalendarDTO
                                ,@RequestParam String method){
        System.out.println("컨트롤러"+recruiterCalendarDTO);
        recruiterMyPageService.deleteRecruCalendar(recruiterCalendarDTO);
        return "success";
    }

}
