package board;

import java.util.*;

public interface BoardService {
	//게시글 전체 확인
	public int page(int pagelimit) throws Exception;
	//게시글 작성
	public void insert(boardvo boardvo) throws Exception;
	//게시글 삭제
	public int delete2(int boardnumber,String pwd) throws Exception;
	//게시글 출력
	public List<boardvo> listAll(int pagelimit, int pageno) throws Exception;
	//게시글 수정
	public void modify(boardvo boardvo) throws Exception;
	//게시글 읽기
	public boardvo read(int boardnumber) throws Exception;
	//게시글 검색
	public List<boardvo> listsearch(String searchtype,String keyword) throws Exception;
}
