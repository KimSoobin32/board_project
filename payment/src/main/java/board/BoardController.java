package board;

import java.io.PrintWriter;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.format.Printer;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
@Controller
@RequestMapping("/board")
public class BoardController {
		
		@Inject
		BoardService service;
	
		@RequestMapping("/search.do")
		public String board_search(Model m,@RequestParam("searchtype") String searchtype, @RequestParam("keyword") String keyword) throws Exception{
			m.addAttribute("lists",service.listsearch(searchtype, keyword));
			m.addAttribute("keyword",keyword);
			m.addAttribute("searchtype",searchtype);
			return "list";
		}
		
		@RequestMapping("/list.do")//게시판 리스트
		public String board_list(Model m, @RequestParam("pageno") @Nullable String pageno) throws Exception {
			
			//한페이지 당 보여질 개수
			int pagelimit = 4;
			
			//@Nullable : 파라미터 없더라도 에러 없도록.., post/get형태에서 값이 null로 올 경우 에러 발생을 하지 않도록 적용하는 어노테이션
			//페이지 번호가 null일 때 1page
			if(pageno==null) {
				pageno = "1";
			}
			
			
			m.addAttribute("lists",service.listAll(pagelimit,Integer.parseInt(pageno)));
			m.addAttribute("pageno", pageno);
			m.addAttribute("totalpage",service.page(pagelimit));
			
			return "list";
		}
		
		@RequestMapping("/insert.do")//입력창 출력
		public String board_insert() {
	
			return "insert";
		}
		
		@RequestMapping("/write.do")//저장
		public String board_write(@ModelAttribute("board") boardvo boardvo) throws Exception {
			service.insert(boardvo);
			return "redirect:../board/list.do";
		}
		
		@RequestMapping("/view.do")//게시글 읽기 + 조회수
		public String board_view(Model m, @RequestParam("boardnumber") int boardnumber) throws Exception {
			m.addAttribute("vo",service.read(boardnumber));
			return "update";
		}
		
		@RequestMapping("updateok.do")	//게시글 수정
		public void board_update(@ModelAttribute("board") boardvo boardvo, HttpServletResponse res) throws Exception {
			service.modify(boardvo);
			
			res.setContentType("text/html;charset=utf-8");
			PrintWriter pw = res.getWriter();
			pw.print("<script>alert('정상적으로 수정 완료 되었습니다.');"
					+ "location.href='../board/list.do';</script>");
			//return "redirect:../board/list.do";
		}
		
		@RequestMapping("delete.do")//게시글 삭제
		public String board_del(Model m, @RequestParam("boardnumber") int boardnumber) {
			m.addAttribute("boardnumber",boardnumber);
			return "delete";
		}
		
		@RequestMapping("deleteok.do")
		public void board_delok(@RequestParam("boardnumber") int boardnumber,@RequestParam("pwd") String pwd, HttpServletResponse res) throws Exception{
			
			int aa = service.delete2(boardnumber, pwd);
			res.setContentType("text/html;charset=utf-8");
			PrintWriter pw = res.getWriter();
			if(aa > 0) {
			pw.print("<script>alert('정상적으로 삭제 완료 되었습니다.');"
					+ "location.href='../board/list.do';</script>");
			}
			else {
				pw.print("<script>alert('패스워드가 틀렸습니다.');"
						+ "location.href='../board/list.do';</script>");
			}
			
		}
		
}
