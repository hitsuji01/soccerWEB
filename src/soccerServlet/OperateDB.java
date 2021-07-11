package soccerServlet;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

public class OperateDB {

	/**
	 * SELECT用関数OperateDate
	 * 第1引数：送信先
	 * 第2引数：SQLの種類
	 * 第3引数：SQL作成用パラメータ
	 *
	 * 戻り値 ：DBからの取得結果 (ArrayList<HashMap<String,String>>型)
	 */
	public ArrayList<HashMap<String,String>> OperateDate(String to_url, String sql_type, String param){

		// DBドライバー
		String drv = "oracle.jdbc.OracleDriver";
		String dsn = "jdbc:oracle:thin:@localhost:1521:XE";

		// SQL文作成
		String sql = "";
		sql = createSQL(to_url,sql_type,param);

		HashMap<String,String> map;
		ArrayList<HashMap<String,String>> list = new ArrayList<HashMap<String,String>>();

		// DB接続情報を初期化
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;

		try {

			// DB接続
			Class.forName(drv).newInstance();
			conn = DriverManager.getConnection(dsn,"test","test_pass");

			// DBからデータを取得
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);

			// 結果を1行ごとにHashMapに格納し、それをArrayListへ格納
			while(rs.next()){
				map = sqlBean(to_url,rs,param);
				list.add(map);
			}

			// DB接続を終了する
			rs.close();
			stmt.close();

		}catch (ClassNotFoundException e){
			System.out.println("ClassNotFoundException:" + e.getMessage());
		}catch (SQLException e){
			System.out.println("SQLException:" + e.getMessage());
		}catch (Exception e){
			System.out.println("Exception:" + e.getMessage());
		}finally{
			try{
				if (conn != null){
					conn.close();
				}
			}catch (SQLException e){
				System.out.println("SQLException:" + e.getMessage());
			}
		}

		return list;

	}


	/**
	 * INSERT,UPDATE,DELETE用関数OperateDate (SELECT用関数OperateDateをオーバーロード)
	 * 第1引数：送信先
	 * 第2引数：SQLの種類
	 * 第3引数：SQL作成用パラメータ
	 *
	 * 戻り値 ：DBへの操作結果 (String型)
	 */
	public String OperateDate(String to_url, String sql_type, String[] param) throws SQLException{

		// DBドライバー
		String drv = "oracle.jdbc.OracleDriver";
		String dsn = "jdbc:oracle:thin:@localhost:1521:XE";

		String msg = "";  // DBへの操作結果
		int rs = 0;       // DBへの操作件数

		// SQL文作成
		ArrayList<String> sql = new ArrayList<String>();
		for(int i=0;i<param.length;i++){
			String[] split_str = createSQL(to_url,sql_type,param[i]).split("/", 0);
			for(String str : split_str){
				sql.add(str);
			}
		}

		// DB接続情報を初期化
		Connection conn = null;
		Statement stmt = null;

		try {

			//DB接続
			Class.forName(drv).newInstance();
			conn = DriverManager.getConnection(dsn,"test","test_pass");

			// to_urlがW007_Kanryou.jspかつsql_typeがinsertなら、テーブルに登録されている「節」の件数を確認する
			if(to_url.equals("W007_Kanryou.jsp") && sql_type.equals("insert")){

				// 件数を取得
				ArrayList<HashMap<String,String>> list = new ArrayList<HashMap<String,String>>();
				list = OperateDate(to_url, "select", param[0]);

				// 件数をセット
				int RowCnt = 0;
				RowCnt = Integer.parseInt(list.get(0).get("RowCnt"));

				// 登録されている件数と登録予定の件数が10より多くなる場合、処理を中断する
				if((RowCnt + sql.size()) > 10){
					msg = "Exception:1つの節に登録できる件数は10件までです　(登録されている件数：" + RowCnt +
							"　登録予定の件数：" + sql.size() + ")";

					return msg;
				}
			}

			// to_urlがW009_MasterTouroku.jspかつsql_typeがinsertなら、テーブルに登録されている「チームID」の件数を確認する
			else if(to_url.equals("W009_MasterTouroku.jsp") && sql_type.equals("insert")){

				// 件数を取得
				ArrayList<HashMap<String,String>> list = new ArrayList<HashMap<String,String>>();
				list = OperateDate(to_url, "select", "insert用");

				// 件数をセット
				int RowCnt = 0;
				RowCnt = Integer.parseInt(list.get(0).get("RowCnt"));

				// 登録されている件数と登録予定の件数が20より多くなる場合、処理を中断する
				if((RowCnt + sql.size()) > 20){
					msg = "Exception:登録できるチーム名は20件までです　(登録されている件数：" + RowCnt +
							"　登録予定の件数：" + sql.size() + ")";

					return msg;
				}
			}

			// オートコミットOFF
			conn.setAutoCommit(false);

			stmt = conn.createStatement();

			// SQL文を実行する
			for(int i=0;i<sql.size();i++){
				rs += stmt.executeUpdate(sql.get(i));
			}

			// コミット
			conn.commit();

			// DBへの操作結果を格納する
			if(sql_type.equals("insert")){
				msg = rs + "件追加しました";
			}
			else if(sql_type.equals("update")){
				msg = rs + "件更新しました";
			}
			else if(sql_type.equals("delete")){
				msg = rs + "件削除しました";
			}

			stmt.close();

		}catch (Exception e){
			System.out.println("Exception:" + e.getMessage());
			conn.rollback();       //ロールバックする
			msg = "Exception:" + e.getMessage();

		}finally{
			try{
				if (conn != null){
					conn.close();
				}
			}catch (SQLException e){
				System.out.println("SQLException:" + e.getMessage());
				msg = "SQLException:" + e.getMessage();
			}
		}

		return msg;

	}



	/**
	 * SQL文作成用関数createSQL
	 * 第1引数：送信先
	 * 第2引数：SQLの種類
	 * 第3引数：SQL作成用パラメータ
	 *
	 * 戻り値 ：作成したSQL文 (String型)
	 */
	public String createSQL(String to_url, String sql_type, String param){

		String sql = "";

		// SQL作成用パラメータを分割
		String[] sql_param = param.split(",", 0);

		// SQLの種類
		switch(sql_type){
		case "select":
			sql = "SELECT ";
			break;
		case "insert":
			sql = "INSERT INTO ";
			break;
		case "update":
			sql = "UPDATE ";
			break;
		case "delete":
			sql = "DELETE FROM ";
			break;
		}

		// 送信先によって作成内容を変化
		switch(to_url){
		case "W002_ShiaiKekkaItiran.jsp":
			// select句
			sql = sql + "SETSU"
					  + ",(SELECT TEAMNAME FROM SCRTBL_TEAMMST WHERE TEAMID = HOMETEAM) as HOMETEAM"
					  + ",(SELECT TEAMNAME FROM SCRTBL_TEAMMST WHERE TEAMID = AWAYTEAM) as AWAYTEAM"
					  + ",HOMESCORE"
					  + ",AWAYSCORE"
					  + ",TO_CHAR(SHIAIDATE, 'YYYY-MM-DD') AS SHIAIDATE"
					  + ",TO_CHAR(SHIAITIME, 'HH24:MI') AS SHIAITIME"
					  + ",KAIJO ";

			// from句
			sql = sql + "FROM SCRTBL_SHIAIKEKKA, SCRTBL_KAIJOMST ";

			// where句
			sql = sql + "WHERE HOMETEAM = SCRTBL_KAIJOMST.TEAMID "
					  + "AND SETSU = '" + sql_param[0] + "' ";

			// order by句
			sql = sql + "ORDER BY SETSU, SHIAIDATE, SHIAITIME";

			break;

		case "W003_TeamShousai.jsp":
			// 成績取得用
			if(sql_param.length >= 2 && sql_param[sql_param.length-1].equals("成績")){
				// select句
				sql = sql + "* FROM ";

				   // 副問い合わせ(1)
				sql = sql + "(SELECT rank() OVER (ORDER BY \"勝点\" DESC, \"勝数\" DESC, \"得失点\" DESC) AS \"順位\","
						  + "\"チーム名\",\"勝点\",\"勝数\",\"引分数\",\"負数\",\"得点\",\"失点\",\"得失点\" ";
				sql = sql + "FROM "
				   // 副問い合わせ(2)
						  + "(SELECT \"チーム名\",SUM(NVL(\"勝点\", 0)) AS \"勝点\",SUM(NVL(\"勝数\", 0)) AS \"勝数\","
						  + "SUM(NVL(\"引分数\", 0)) AS \"引分数\",SUM(NVL(\"負数\", 0)) AS \"負数\",SUM(NVL(\"得点\", 0)) AS \"得点\","
						  + "SUM(NVL(\"失点\", 0)) AS \"失点\",SUM(\"得点\"-\"失点\") AS \"得失点\" "
						  + "FROM ";
				   // 副問い合わせ(3)
				sql = sql + "(SELECT "
							+ "(SELECT TEAMNAME FROM SCRTBL_TEAMMST WHERE TEAMID = HOMETEAM) AS \"チーム名\""
							+ ",CASE"
							+ " WHEN HOMESCORE > AWAYSCORE THEN (SELECT POINT FROM SCRTBL_POINTMST WHERE RESULT = 'win')"
							+ " WHEN HOMESCORE = AWAYSCORE THEN (SELECT POINT FROM SCRTBL_POINTMST WHERE RESULT = 'draw')"
							+ " ELSE (SELECT POINT FROM SCRTBL_POINTMST WHERE RESULT = 'lose') "
							+ "END AS \"勝点\""
							+ ",CASE"
							+ " WHEN HOMESCORE > AWAYSCORE THEN '1'"
							+ " ELSE '0' "
							+ "END AS \"勝数\""
							+ ",CASE"
							+ " WHEN HOMESCORE = AWAYSCORE THEN '1'"
							+ " ELSE '0' "
							+ "END AS \"引分数\""
							+ ",CASE"
							+ " WHEN HOMESCORE < AWAYSCORE THEN '1'"
							+ " ELSE '0' "
							+ "END AS \"負数\""
							+ ",HOMESCORE AS \"得点\""
							+ ",AWAYSCORE AS \"失点\""
							+ "FROM SCRTBL_SHIAIKEKKA";
				sql = sql + " UNION ALL "
							+ "SELECT "
							+ "(SELECT TEAMNAME FROM SCRTBL_TEAMMST WHERE TEAMID = AWAYTEAM) AS \"チーム名\""
							+ ",CASE"
							+ " WHEN AWAYSCORE > HOMESCORE THEN (SELECT POINT FROM SCRTBL_POINTMST WHERE RESULT = 'win')"
							+ " WHEN AWAYSCORE = HOMESCORE THEN (SELECT POINT FROM SCRTBL_POINTMST WHERE RESULT = 'draw')"
							+ " ELSE (SELECT POINT FROM SCRTBL_POINTMST WHERE RESULT = 'lose') "
							+ "END AS \"勝点\""
							+ ",CASE"
							+ " WHEN AWAYSCORE > HOMESCORE THEN '1'"
							+ " ELSE '0' "
							+ "END AS \"勝数\""
							+ ",CASE"
							+ " WHEN AWAYSCORE = HOMESCORE THEN '1'"
							+ " ELSE '0' "
							+ "END AS \"引分数\""
							+ ",CASE"
							+ " WHEN AWAYSCORE < HOMESCORE THEN '1'"
							+ " ELSE '0' "
							+ "END AS \"負数\""
							+ ",AWAYSCORE AS \"得点\""
							+ ",HOMESCORE AS \"失点\""
							+ "FROM SCRTBL_SHIAIKEKKA) ";
				   // 副問い合わせ(2) GROUP BY句
				sql = sql + "GROUP BY \"チーム名\")) ";

				// WHERE句
				sql = sql + "WHERE \"チーム名\" = '" + sql_param[0] + "' ";

			}

			// 試合一覧取得用
			else{
				sql = sql + "* FROM (";
				// 副問い合わせ
				// select句(1)
				sql = sql + "SELECT "
						  + "SETSU"
						  + ",(SELECT TEAMNAME FROM SCRTBL_TEAMMST WHERE TEAMID = HOMETEAM) as HOMETEAM"
						  + ",(SELECT TEAMNAME FROM SCRTBL_TEAMMST WHERE TEAMID = AWAYTEAM) as AWAYTEAM"
						  + ",HOMESCORE"
						  + ",AWAYSCORE"
						  + ",TO_CHAR(SHIAIDATE, 'YYYY-MM-DD') AS SHIAIDATE"
						  + ",TO_CHAR(SHIAITIME, 'HH24:MI') AS SHIAITIME"
						  + ",KAIJO ";
				sql = sql + "FROM SCRTBL_SHIAIKEKKA, SCRTBL_KAIJOMST ";
				sql = sql + "WHERE HOMETEAM = SCRTBL_KAIJOMST.TEAMID "
						  + "AND HOMETEAM = (SELECT TEAMID FROM SCRTBL_TEAMMST WHERE TEAMNAME = '" + sql_param[0] + "') ";

				// UNION ALLで結合
				sql = sql + "UNION ALL ";

				// select句(2)
				sql = sql + "SELECT "
						  + "SETSU"
						  + ",(SELECT TEAMNAME FROM SCRTBL_TEAMMST WHERE TEAMID = HOMETEAM) as HOMETEAM"
						  + ",(SELECT TEAMNAME FROM SCRTBL_TEAMMST WHERE TEAMID = AWAYTEAM) as AWAYTEAM"
						  + ",HOMESCORE"
						  + ",AWAYSCORE"
						  + ",TO_CHAR(SHIAIDATE, 'YYYY-MM-DD') AS SHIAIDATE"
						  + ",TO_CHAR(SHIAITIME, 'HH24:MI') AS SHIAITIME"
						  + ",KAIJO ";
				sql = sql + "FROM SCRTBL_SHIAIKEKKA, SCRTBL_KAIJOMST ";
				sql = sql + "WHERE HOMETEAM = SCRTBL_KAIJOMST.TEAMID "
						  + "AND AWAYTEAM = (SELECT TEAMID FROM SCRTBL_TEAMMST WHERE TEAMNAME = '" + sql_param[0] + "')";

				sql = sql + ") ORDER BY SETSU";
			}
			break;

		case "W004_ScoreShousai.jsp":
			// select句
			sql = sql + "SETSU"
					  + ",(SELECT TEAMNAME FROM SCRTBL_TEAMMST WHERE TEAMID = HOMETEAM) as HOMETEAM"
					  + ",(SELECT TEAMNAME FROM SCRTBL_TEAMMST WHERE TEAMID = AWAYTEAM) as AWAYTEAM"
					  + ",HOMESCORE"
					  + ",AWAYSCORE"
					  + ",TO_CHAR(SHIAIDATE, 'YYYY-MM-DD') AS SHIAIDATE"
					  + ",TO_CHAR(SHIAITIME, 'HH24:MI') AS SHIAITIME"
					  + ",KAIJO ";

			// from句
			sql = sql + "FROM SCRTBL_SHIAIKEKKA, SCRTBL_KAIJOMST ";

			// where句
			sql = sql + "WHERE HOMETEAM = SCRTBL_KAIJOMST.TEAMID "
					  + "AND SETSU = '" + sql_param[0] + "' "
					  + "AND HOMETEAM = (SELECT TEAMID FROM SCRTBL_TEAMMST WHERE TEAMNAME = '" + sql_param[1] + "') "
					  + "AND AWAYTEAM = (SELECT TEAMID FROM SCRTBL_TEAMMST WHERE TEAMNAME = '" + sql_param[2] + "')";

			break;

		case "W005_Hensyu.jsp":
			// select句
			sql = sql + "TEAMNAME ";

			// from句
			sql = sql + "from SCRTBL_TEAMMST ";

			break;

		case "W006_KousinSakujo.jsp":
			// select句
			sql = sql + "ID"
					  + ",SETSU"
					  + ",(SELECT TEAMNAME FROM SCRTBL_TEAMMST WHERE TEAMID = HOMETEAM) as HOMETEAM"
					  + ",(SELECT TEAMNAME FROM SCRTBL_TEAMMST WHERE TEAMID = AWAYTEAM) as AWAYTEAM"
					  + ",HOMESCORE"
					  + ",AWAYSCORE"
					  + ",TO_CHAR(SHIAIDATE, 'YYYY-MM-DD') AS SHIAIDATE"
					  + ",TO_CHAR(SHIAITIME, 'HH24:MI') AS SHIAITIME"
					  + ",KAIJO ";

			// from句
			sql = sql + "FROM SCRTBL_SHIAIKEKKA, SCRTBL_KAIJOMST ";

			// where句
			sql = sql + "WHERE HOMETEAM = SCRTBL_KAIJOMST.TEAMID "
					  + "AND SETSU = '" + sql_param[0] + "' ";

			// order by句
			sql = sql + "ORDER BY SETSU, SHIAIDATE, SHIAITIME";

			break;


		case "W007_Kanryou.jsp":
			switch(sql_type){
			case "select":
				// select句
				sql = sql + "count(SETSU) as RowCnt ";

				// from句
				sql = sql + "from SCRTBL_SHIAIKEKKA ";

				// where句
				sql = sql + "where SETSU = '" + sql_param[0] + "' ";

				break;
			case "insert":
				// テーブル名
				sql = sql + "SCRTBL_SHIAIKEKKA ";

				// 列名
				sql = sql + "(SETSU,HOMETEAM,AWAYTEAM,HOMESCORE,AWAYSCORE,SHIAIDATE,SHIAITIME,ID ) ";

				// values句
				sql = sql + "VALUES("
						+ "'" + sql_param[0] + "'"
						+ ",(SELECT TEAMID FROM SCRTBL_TEAMMST WHERE TEAMNAME = '" + sql_param[3] + "')"
						+ ",(SELECT TEAMID FROM SCRTBL_TEAMMST WHERE TEAMNAME = '" + sql_param[4] + "')"
						+ ",'" + sql_param[5] + "'"
						+ ",'" + sql_param[6] + "'"
						+ ",TO_DATE('" + sql_param[1] + "','YYYY-MM-DD')"
						+ ",TO_DATE('" + sql_param[2] + "','HH24:MI')"
						+ ",(SELECT NVL(MAX(id)+1,1) FROM SCRTBL_SHIAIKEKKA WHERE SETSU = '" + sql_param[0] + "')"
						+ ")";
				break;
			case "update":
				// テーブル名
				sql = sql + "SCRTBL_SHIAIKEKKA ";

				// 列名
				sql = sql + "SET "
						  + "HOMETEAM = (SELECT TEAMID FROM SCRTBL_TEAMMST WHERE TEAMNAME = '" + sql_param[3] + "')"
						  + ",AWAYTEAM = (SELECT TEAMID FROM SCRTBL_TEAMMST WHERE TEAMNAME = '" + sql_param[4] + "')"
						  + ",HOMESCORE = '" + sql_param[5] + "'"
						  + ",AWAYSCORE = '" + sql_param[6] + "'"
						  + ",SHIAIDATE = TO_DATE('" + sql_param[1] + "','YYYY-MM-DD')"
						  + ",SHIAITIME = TO_DATE('" + sql_param[2] + "','HH24:MI') ";
				// where句
				sql = sql + "WHERE ID = '" + sql_param[7] + "' "
						  + "AND SETSU = '" + sql_param[0] + "'";
				break;
			case "delete":
				// テーブル名
				sql = sql + "SCRTBL_SHIAIKEKKA ";

				// where句
				sql = sql + "WHERE ID = '" + sql_param[7] + "' "
						  + "AND SETSU = '" + sql_param[0] + "'";
				break;
			}

			break;

		case "W009_MasterTouroku.jsp":
			switch(sql_type){
			case "select":
				switch(sql_param[0]){
				case "チームマスタ":
					sql = sql + "TEAMID,TEAMNAME FROM SCRTBL_TEAMMST ORDER BY TEAMID";
					break;

				case "会場マスタ":
					sql = sql + "SCRTBL_TEAMMST.TEAMID,SCRTBL_TEAMMST.TEAMNAME,SCRTBL_KAIJOMST.KAIJO FROM SCRTBL_TEAMMST "
							  + "LEFT JOIN SCRTBL_KAIJOMST "
							  + "ON SCRTBL_TEAMMST.TEAMID = SCRTBL_KAIJOMST.TEAMID "
							  + "ORDER BY TEAMID";
					break;

				case "勝点マスタ":
					sql = sql + "RESULT,POINT FROM SCRTBL_POINTMST";
					break;

				case "insert用":
					sql = sql + " count(TEAMID) AS RowCnt FROM SCRTBL_TEAMMST";
					break;

				case "update用":
					sql = sql + " TEAMID FROM SCRTBL_TEAMMST WHERE = '" + sql_param[1] + "'";
					break;
				}
				break;
			case "insert":
				switch(sql_param[0]){
				case "SCRTBL_TEAMMST":
					// テーブル名
					sql = sql + " SCRTBL_TEAMMST ";
					// 列名
					sql = sql + "( TEAMID, TEAMNAME ) ";
					// values句
					sql = sql + "VALUES ("
							  + "(select lpad(nvl(max(TEAMID)+1,1),3,0) from SCRTBL_TEAMMST)"
							  + ",'" + sql_param[2] + "'"
							  + ")";
					break;
				}
				break;

			case "update":
				switch(sql_param[0]){
				case "SCRTBL_TEAMMST":
					// テーブル名
					sql = sql + "SCRTBL_TEAMMST ";
					// 列名
					sql = sql + "SET "
							  + "TEAMNAME = '" + sql_param[2] + "' ";
					// where句
					sql = sql + "WHERE TEAMID = '" + sql_param[1] + "'";
					break;

				case "SCRTBL_KAIJOMST":

					// TEAMIDがSCRTBL_KAIJOMSTに存在するか確認
					OperateDB od = new OperateDB();
					ArrayList<HashMap<String,String>> list = new ArrayList<HashMap<String,String>>();
					list = od.OperateDate(to_url, "select", "update用"+","+ sql_param[1]);

					// TEAMIDがSCRTBL_KAIJOMSTに存在する
					if(list.size() > 0){
						// テーブル名
						sql = sql + "SCRTBL_KAIJOMST ";
						// 列名
						sql = sql + "SET "
								  + "KAIJO = '" + sql_param[2] + "' ";
						// where句
						sql = sql + "WHERE TEAMID = '" + sql_param[1] + "'";

					}

					// TEAMIDがSCRTBL_KAIJOMSTに存在しない
					else{
						// テーブル名
						sql = "INSERT INTO SCRTBL_KAIJOMST ";
						// 列名
						sql = sql + "( TEAMID, KAIJO ) ";
						// values句
						sql = sql + "VALUES ("
								  + "(select lpad(nvl(max(TEAMID)+1,1),3,0) from SCRTBL_KAIJOMST)"
								  + ",'" + sql_param[2] + "'"
								  + ")";
					}
					break;

				case "SCRTBL_POINTMST":
					// テーブル名
					sql = sql + "SCRTBL_POINTMST ";
					// 列名
					sql = sql + "SET "
							  + "POINT = '" + sql_param[2] + "' ";
					// where句
					sql = sql + "WHERE RESULT = '" + sql_param[1] + "'";
					break;
				}
				break;

			case "delete":
				switch(sql_param[0]){
				case "SCRTBL_TEAMMST":
					sql = sql + "SCRTBL_TEAMMST ";
					sql = sql + "WHERE TEAMID = '" + sql_param[1] + "' ";

					// SCRTBL_KAIJOMSTも連動して削除する
					sql = sql + "/";

					sql = sql + "DELETE FROM SCRTBL_KAIJOMST "
							  + "WHERE TEAMID = '" + sql_param[1] + "' ";
					break;
				}
				break;
			}
		}

		return sql;
	}



	/**
	 * DB取得結果格納用関数sqlBean
	 * 第1引数：送信先
	 * 第2引数：DBから取得したデータ(1行分)
	 * 第3引数：SQL作成用パラメータ
	 *
	 * 戻り値 ：DBから取得した1行分データを分割して1つにまとめたもの (HashMap<String,String>型)
	 */
	public HashMap<String,String> sqlBean(String to_url,ResultSet rs,String param){
		HashMap<String,String> map = new HashMap<String,String>();

		try {
			switch(to_url){
			case "W002_ShiaiKekkaItiran.jsp":
				map.put("節", rs.getString("SETSU"));
				map.put("ホーム", rs.getString("HOMETEAM"));
				map.put("アウェー", rs.getString("AWAYTEAM"));
				map.put("ホームスコア", rs.getString("HOMESCORE"));
				map.put("アウェースコア", rs.getString("AWAYSCORE"));
				map.put("試合日", rs.getString("SHIAIDATE"));
				map.put("キックオフ", rs.getString("SHIAITIME"));
				map.put("会場", rs.getString("KAIJO"));
				break;

			case "W003_TeamShousai.jsp":
				if(param.endsWith(",成績")){
					map.put("順位", rs.getString("順位"));
					map.put("チーム名", rs.getString("チーム名"));
					map.put("勝点", rs.getString("勝点"));
					map.put("勝数", rs.getString("勝数"));
					map.put("引分数", rs.getString("引分数"));
					map.put("負数", rs.getString("負数"));
					map.put("得点", rs.getString("得点"));
					map.put("失点", rs.getString("失点"));
					map.put("得失点", rs.getString("得失点"));
				}
				else{
					map.put("節", rs.getString("SETSU"));
					map.put("ホーム", rs.getString("HOMETEAM"));
					map.put("アウェー", rs.getString("AWAYTEAM"));
					map.put("ホームスコア", rs.getString("HOMESCORE"));
					map.put("アウェースコア", rs.getString("AWAYSCORE"));
					map.put("試合日", rs.getString("SHIAIDATE"));
					map.put("キックオフ", rs.getString("SHIAITIME"));
					map.put("会場", rs.getString("KAIJO"));
				}
				break;

			case "W004_ScoreShousai.jsp":
				map.put("節", rs.getString("SETSU"));
				map.put("ホーム", rs.getString("HOMETEAM"));
				map.put("アウェー", rs.getString("AWAYTEAM"));
				map.put("ホームスコア", rs.getString("HOMESCORE"));
				map.put("アウェースコア", rs.getString("AWAYSCORE"));
				map.put("試合日", rs.getString("SHIAIDATE"));
				map.put("キックオフ", rs.getString("SHIAITIME"));
				map.put("会場", rs.getString("KAIJO"));
				break;

			case "W005_Hensyu.jsp":
				map.put("チーム名", rs.getString("TEAMNAME"));
				break;

			case "W006_KousinSakujo.jsp":
				map.put("id", rs.getString("ID"));
				map.put("節", rs.getString("SETSU"));
				map.put("ホーム", rs.getString("HOMETEAM"));
				map.put("アウェー", rs.getString("AWAYTEAM"));
				map.put("ホームスコア", rs.getString("HOMESCORE"));
				map.put("アウェースコア", rs.getString("AWAYSCORE"));
				map.put("試合日", rs.getString("SHIAIDATE"));
				map.put("キックオフ", rs.getString("SHIAITIME"));
				break;

			case "W007_Kanryou.jsp":
				map.put("RowCnt", rs.getString("ROWCNT"));
				break;

			case "W009_MasterTouroku.jsp":
				if(param.equals("チームマスタ")){
					map.put("チームID", rs.getString("TEAMID"));
					map.put("チーム名", rs.getString("TEAMNAME"));
				}
				else if(param.equals("会場マスタ")){
					map.put("チームID", rs.getString("TEAMID"));
					map.put("チーム名", rs.getString("TEAMNAME"));
					map.put("会場名", rs.getString("KAIJO"));
				}
				else if(param.equals("勝点マスタ")){
					map.put("勝敗", rs.getString("RESULT"));
					map.put("勝ち点", rs.getString("POINT"));
				}
				else {
					map.put("RowCnt", rs.getString("ROWCNT"));
				}
				break;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return map;
	}









}
