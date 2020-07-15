package util;

public class PagingUtil {
	public static String pagingImg(int totalRecordCount, int pageSize, int blockPage, int nowPage, String page) {
		String pagingStr = "";
		int totalPage = (int) Math.ceil((double) totalRecordCount / (double) pageSize);
		int intTemp = (nowPage - 1) / blockPage * blockPage + 1;
		if (intTemp != 1) {
			pagingStr = pagingStr + "<a href='" + page + "nowPage=1'>" + "<img src='../images/paging1.gif'></a>";
			pagingStr = pagingStr + "&nbsp;";
			pagingStr = pagingStr + "<a href='" + page + "nowPage=" + (intTemp - blockPage) + "'>"
					+ "<img src='../images/paging2.gif'></a>";
		}

		for (int blockCount = 1; blockCount <= blockPage && intTemp <= totalPage; ++blockCount) {
			if (intTemp == nowPage) {
				pagingStr = pagingStr + "&nbsp;" + intTemp + "&nbsp;";
			} else {
				pagingStr = pagingStr + "&nbsp;<a href='" + page + "nowPage=" + intTemp + "'>" + intTemp + "</a>&nbsp;";
			}

			++intTemp;
		}

		if (intTemp <= totalPage) {
			pagingStr = pagingStr + "<a href='" + page + "nowPage=" + intTemp + "'>"
					+ "<img src='../images/paging3.gif'></a>";
			pagingStr = pagingStr + "&nbsp;";
			pagingStr = pagingStr + "<a href='" + page + "nowPage=" + totalPage + "'>"
					+ "<img src='../images/paging4.gif'></a>";
		}

		return pagingStr;
	}

	public static String pagingAjax(int totalRecordCount, int pageSize, int blockPage, int nowPage, String page) {
		String pagingStr = "";
		int totalPage = (int) Math.ceil((double) totalRecordCount / (double) pageSize);
		int intTemp = (nowPage - 1) / blockPage * blockPage + 1;
		if (intTemp != 1) {
			pagingStr = pagingStr + "<a href='javascript:paging(1);'><img src='../images/paging1.gif'></a>";
			pagingStr = pagingStr + "&nbsp;";
			pagingStr = pagingStr + "<a href='javascript:paging(" + (intTemp - blockPage) + ");'>"
					+ "<img src='../images/paging2.gif'></a>";
		}

		for (int blockCount = 1; blockCount <= blockPage && intTemp <= totalPage; ++blockCount) {
			if (intTemp == nowPage) {
				pagingStr = pagingStr + "&nbsp;" + intTemp + "&nbsp;";
			} else {
				pagingStr = pagingStr + "&nbsp;<a href='javascript:paging(" + intTemp + ");'>" + intTemp + "</a>&nbsp;";
			}

			++intTemp;
		}

		if (intTemp <= totalPage) {
			pagingStr = pagingStr + "<a href='javascript:paging(" + intTemp + ");'>"
					+ "<img src='../images/paging3.gif'></a>";
			pagingStr = pagingStr + "&nbsp;";
			pagingStr = pagingStr + "<a href='javascript:paging(" + totalPage + ");'>"
					+ "<img src='../images/paging4.gif'></a>";
		}

		return pagingStr;
	}
}