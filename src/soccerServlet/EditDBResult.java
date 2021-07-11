package soccerServlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class EditDBResult
 */
@WebServlet("/EditDBResult")
public class EditDBResult extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditDBResult() {
        super();
    }

    /**
	 * DB操作を行い、画面遷移するサーブレットsetDate
	 * 第1引数：リクエストのサーブレット変数
	 * 第2引数：レスポンスのサーブレット変数
	 *
	 * 戻り値 ：なし
	 */
    protected void setDate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    	String msg = "";

    	// 文字化け対策
    	response.setContentType("text/html;charset=UTF-8");
    	request.setCharacterEncoding("UTF-8");

    	// フォームデータの取得
    	String[] param = (request.getParameter("sub_val")).split("/", 0);  // SQL文作成用
        String sql_type = request.getParameter("sql_type");  // SQLの種類
        String to_url   = request.getParameter("to_name");   //遷移先


        // DB操作用クラスOperateDBのインスタンス生成
        OperateDB opDB = new OperateDB();

        try{
        	// DB操作
        	msg = opDB.OperateDate(to_url,sql_type,param);

        	// 実行結果がエラーなら遷移先をエラー画面(W008_Error.jsp)へ変える
        	if(msg.indexOf("Exception") >=0 ){
        		to_url = "W008_Error.jsp";
        	}

        	// エラーじゃないなら遷移先を完了画面(W007_Kanryou.jsp)へ変える
        	else{
                to_url = "W007_Kanryou.jsp";
        	}

        }catch (SQLException e){
			msg = "SQLException:" + e.getMessage();
			to_url = "W008_Error.jsp";       // 遷移先をエラー画面(W008_Error.jsp)へ変える

		}catch (Exception e){
			msg = "Exception:" + e.getMessage();
			to_url = "W008_Error.jsp";       // 遷移先をエラー画面(W008_Error.jsp)へ変える

		}

        System.out.println(msg);
        // msgをセット
        request.setAttribute("msg", msg);

        // フォワードにて次画面に遷移する
        ServletContext context = getServletContext();
        RequestDispatcher rd = context.getRequestDispatcher("/" + to_url);
        rd.forward(request, response);

    }



	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 画面遷移用サーブレットsetDateを呼び出す
		setDate(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 画面遷移用サーブレットsetDateを呼び出す
		setDate(request,response);
	}

}
