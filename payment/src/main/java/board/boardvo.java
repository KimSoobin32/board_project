package board;

import java.util.*;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class boardvo {
	private int boardnumber,hit;
	private String name, subject, pwd, content, mobile;
	private Date regdate;
}
