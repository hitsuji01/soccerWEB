package soccerServlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class GetDBResult
 */
@WebServlet("/GetDBResult")
public class GetDBResult extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetDBResult() {
        super();
    }


    /**
	 * DBからデータを取得し、画面遷移するサーブレットgetDate
	 * 第1引数：リクエストのサーブレット変数
	 * 第2引数：レスポンスのサーブレット変数
	 *
	 * 戻り値 ：なし
	 */
    protected void getDate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    	ArrayList<HashMap<String,String>> list;

    	// 文字化け対策
    	response.setContentType("text/html;charset=UTF-8");
    	request.setCharacterEncoding("UTF-8");

    	// フォームデータの取得
    	String param = request.getParameter("sub_val");      // SQL文作成用
        String sql_type = request.getParameter("sql_type");  // SQLの種類
        String setsu = request.getParameter("setsu");        // 節番号
        String to_url   = request.getParameter("to_name");   // 遷移先


        // DB操作用クラスOperateDBのインスタンス生成
        OperateDB opDB = new OperateDB();


        // W003_TeamShousai.jspへ送るとき
        if(to_url.equals("W003_TeamShousai.jsp")){
        	// DBからデータ取得
        	list = new ArrayList<HashMap<String,String>>();
            list = opDB.OperateDate(to_url,sql_type,param);
            request.setAttribute("list", list);

            // チームの成績取得のため再度DB操作を行う
        	list = new ArrayList<HashMap<String,String>>();
        	list = opDB.OperateDate(to_url,sql_type,param+",成績");
        	request.setAttribute("seiseki", list);
        }

        // W006_KousinSakujo.jspへ送るとき
        else if(to_url.equals("W006_KousinSakujo.jsp")){
        	request.setAttribute("sql_type", sql_type);

        	// 成績取得のためsql_typeをselectへ変更
        	sql_type = "select";

        	// DBからデータ取得
        	list = new ArrayList<HashMap<String,String>>();
            list = opDB.OperateDate(to_url,sql_type,param);
            request.setAttribute("list", list);

            // チーム名取得のため再度DB操作を行う
        	list = new ArrayList<HashMap<String,String>>();
        	list = opDB.OperateDate("W005_Hensyu.jsp","select","");
        	request.setAttribute("team_name", list);
        }

        // W009_MasterTouroku.jspへ送るとき
        else if(to_url.equals("W009_MasterTouroku.jsp")){

        	// 取得するマスタテーブル名
        	String[] tbl_name = {"チームマスタ","会場マスタ","勝点マスタ"};

        	// DBからデータ取得
        	for(int i=0;i<tbl_name.length;i++){
        		list = new ArrayList<HashMap<String,String>>();
        		list = opDB.OperateDate(to_url,sql_type,tbl_name[i]);
        		request.setAttribute(tbl_name[i], list);
        	}

        }

        else{
        	// DBからデータ取得
        	list = new ArrayList<HashMap<String,String>>();
        	list = opDB.OperateDate(to_url,sql_type,param);

            request.setAttribute("setsu", setsu);
            request.setAttribute("list", list);
        }


        // フォワードにて次画面に遷移する
        ServletContext context = getServletContext();
        RequestDispatcher rd = context.getRequestDispatcher("/" + to_url);
        rd.forward(request, response);

    }



	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 画面遷移用サーブレットgetDateを呼び出す
		getDate(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 画面遷移用サーブレットgetDateを呼び出す
		getDate(request,response);
	}

}
