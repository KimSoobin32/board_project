package board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

@Service
public class BoardServiceinfo implements BoardService {

	@Inject
	private SqlSessionTemplate sqlSession;
	
	private static String namespace="query";
	
	@Override
	public List<boardvo> listsearch(String searchtype, String keyword) throws Exception {
		/* 조건문,반복문,선택문 같이 문법을 이용하는 경우 null 선언 */
		List<boardvo> boardlist = null;
		
		Map<String,String> map = new HashMap();
		map.put("searchtype", searchtype);
		map.put("keyword", keyword);

		if(searchtype.equals("name")) {
			boardlist = sqlSession.selectList(namespace+".searchview2",map);
		}
		else {
			boardlist = sqlSession.selectList(namespace+".searchview",map);
		}
		return boardlist;
	}
		
	@Override
	public void insert(boardvo boardvo) throws Exception {
		sqlSession.insert(namespace+".create",boardvo);
	}

	@Override
	public int delete2(int boardnumber,String pwd) throws Exception {
		//파라미터값이 1개이상 자료형 서로 다를경우, 같을 경우
		//namespace 무조건 한개
		Map<String, String> map = new HashMap();
		map.put("boardnumber", Integer.toString(boardnumber));
		map.put("pwd", pwd);
		int a = sqlSession.delete(namespace+".del",map);
		
		//return시 String, int에 
		//따라서 메소드에 자료형을 맞춰서 사용해야함
		return a;
	}
	/*limit=2
	 * page=1
	 * (2*1)-2
	 * 0,2
	 * 
	 * page=2
	 * 2,2
	 * 
	 * page=3
	 * (2*3)-2
	 *4,2
	 *
	 */

	@Override
	public List<boardvo> listAll(int pagelimit, int pageno) throws Exception {
		int pageing = (pagelimit * pageno) - pagelimit;
		//map에는 int 못 씀..
		Map<String,String> map = new HashMap<String, String>();
		map.put("pageing", Integer.toString(pageing));
		map.put("pagelimit", Integer.toString(pagelimit));
		//2개 값을 xml에 보냄..
		
		List<boardvo> boardlist = sqlSession.selectList(namespace+".select",map);
		return boardlist;
	}

	@Override
	public void modify(boardvo boardvo) throws Exception {
		sqlSession.update(namespace+".modify",boardvo);
	}

	@Override
	public boardvo read(int boardnumber) throws Exception {
		sqlSession.update(namespace+".updateview",boardnumber);
		boardvo boardvo = sqlSession.selectOne(namespace+".selectview",boardnumber);
		return boardvo;
	}
	/*
	 * 10rows
	 * 1page -> 3rows
	 * 4page -> 1rows
	 * 
	 */

	@Override
	public int page(int pagelimit) throws Exception {
		int pgno = sqlSession.selectOne(namespace+".pages",pagelimit);
		return pgno;
	}
	
}
