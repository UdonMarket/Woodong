package util;

public class PagingUtil {
	public static String pagingImg(int totalRecordCount, int pageSize, int blockPage, int nowPage, String page) {
		String pagingStr = "";
		int totalPage = (int) Math.ceil((double) totalRecordCount / (double) pageSize);
		int intTemp = (nowPage - 1) / blockPage * blockPage + 1;
		if (intTemp != 1) {
					
			pagingStr += "<li><a href='"+page+"nowPage=1'><div class='paging_box' style='padding-top: 2px;'><i style='font-size: 15px' class='fas'>&lt;</i></div></a></li>";
			pagingStr = pagingStr + "&nbsp;";
			pagingStr += "<li><a href='"+page+"nowPage="+(intTemp-1)+"'><div class='paging_box' style='padding-top: 2px;'><i style='font-size: 15px' class='fas'>&lt;&lt;</i></div></a></li>";
		}

		for (int blockCount = 1; blockCount <= blockPage && intTemp <= totalPage; ++blockCount) {
			if (intTemp == nowPage) {//현재페이지
				pagingStr += "<li class='active'><a href='#'><div class='paging_box' style='padding-top: 2px;'>"+intTemp+"</div></a></li>";
			} else {
				pagingStr += "<li><a href='"+page+"nowPage="+intTemp+"'><div class='paging_box' style='padding-top: 2px;'>"+intTemp+"</div></a></li>";
			}

			++intTemp;
		}

		if (intTemp <= totalPage) {
			pagingStr += "<li><a href='"+page+"nowPage="+intTemp+"'><div class='paging_box' style='padding-top: 2px;'><i style='font-size: 15px' class='fas'>&#xf054;</i></div></a></li>";
			pagingStr = pagingStr + "&nbsp;";
			pagingStr += "<li><a href='"+page+"nowPage="+totalPage+"'><div class='paging_box' style='padding-top: 2px;'><i style='font-size: 15px' class='fas'>&#xf054;&#xf054;</i></div></a></li>";
		}

		return pagingStr;
	}

}