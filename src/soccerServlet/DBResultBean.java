package soccerServlet;

public class DBResultBean {

	private String Setsu = "";            // 節
	private String HomeTeam = "";         // ホームチーム
	private String AwayTeam = "";         // アウェイチーム
	private String HomeScore = "";        // ホームスコア
	private String AwayScore = "";        // アウェイスコア
	private String ShiaiDate = "";        // 試合日
	private String ShiaiTime = "";        // キックオフ時間
	private String Kaijo = "";            // 会場名
	private String Runk = "";             // 順位
	private String TeamName = "";         // チーム名
	private String WinPoint = "";         // 勝点
	private String NoWin = "";            // 勝ち数
	private String NoDrow = "";           // 引き分け数
	private String NoLose = "";           // 負け数
	private String GetScore = "";         // 得点
	private String LoseScore = "";        // 失点
	private String GoalDifference = "";   // 得失点
	private String Id = "";               // ID
	private String RowCnt = "";           // 行数
	private String TeamId = "";           // チームID
	private String GameResult = "";       // 試合結果

	/**
	 * 節を取得します。
	 * @return Setsu
	 */
	public String getSetsu() {
	    return Setsu;
	}
	/**
	 * 節を設定します。
	 * @param Setsu Setsu
	 */
	public void setSetsu(String Setsu) {
	    this.Setsu = Setsu;
	}
	/**
	 * ホームチームを取得します。
	 * @return HomeTeam
	 */
	public String getHomeTeam() {
	    return HomeTeam;
	}
	/**
	 * ホームチームを設定します。
	 * @param HomeTeam HomeTeam
	 */
	public void setHomeTeam(String HomeTeam) {
	    this.HomeTeam = HomeTeam;
	}
	/**
	 * アウェイチームを取得します。
	 * @return AwayTeam
	 */
	public String getAwayTeam() {
	    return AwayTeam;
	}
	/**
	 * アウェイチームを設定します。
	 * @param AwayTeam AwayTeam
	 */
	public void setAwayTeam(String AwayTeam) {
	    this.AwayTeam = AwayTeam;
	}
	/**
	 * ホームスコアを取得します。
	 * @return HomeScore
	 */
	public String getHomeScore() {
	    return HomeScore;
	}
	/**
	 * ホームスコアを設定します。
	 * @param HomeScore HomeScore
	 */
	public void setHomeScore(String HomeScore) {
	    this.HomeScore = HomeScore;
	}
	/**
	 * アウェイスコアを取得します。
	 * @return AwayScore
	 */
	public String getAwayScore() {
	    return AwayScore;
	}
	/**
	 * アウェイスコアを設定します。
	 * @param AwayScore AwayScore
	 */
	public void setAwayScore(String AwayScore) {
	    this.AwayScore = AwayScore;
	}
	/**
	 * 試合日を取得します。
	 * @return ShiaiDate
	 */
	public String getShiaiDate() {
	    return ShiaiDate;
	}
	/**
	 * 試合日を設定します。
	 * @param ShiaiDate ShiaiDate
	 */
	public void setShiaiDate(String ShiaiDate) {
	    this.ShiaiDate = ShiaiDate;
	}
	/**
	 * キックオフ時間を取得します。
	 * @return ShiaiTime
	 */
	public String getShiaiTime() {
	    return ShiaiTime;
	}
	/**
	 * キックオフ時間を設定します。
	 * @param ShiaiTime ShiaiTime
	 */
	public void setShiaiTime(String ShiaiTime) {
	    this.ShiaiTime = ShiaiTime;
	}
	/**
	 * 会場名を取得します。
	 * @return Kaijo
	 */
	public String getKaijo() {
	    return Kaijo;
	}
	/**
	 * 会場名を設定します。
	 * @param Kaijo Kaijo
	 */
	public void setKaijo(String Kaijo) {
	    this.Kaijo = Kaijo;
	}
	/**
	 * 順位を取得します。
	 * @return Runk
	 */
	public String getRunk() {
	    return Runk;
	}
	/**
	 * 順位を設定します。
	 * @param Runk Runk
	 */
	public void setRunk(String Runk) {
	    this.Runk = Runk;
	}
	/**
	 * チーム名を取得します。
	 * @return TeamName
	 */
	public String getTeamName() {
	    return TeamName;
	}
	/**
	 * チーム名を設定します。
	 * @param TeamName TeamName
	 */
	public void setTeamName(String TeamName) {
	    this.TeamName = TeamName;
	}
	/**
	 * 勝点を取得します。
	 * @return WinPoint
	 */
	public String getWinPoint() {
	    return WinPoint;
	}
	/**
	 * 勝点を設定します。
	 * @param WinPoint WinPoint
	 */
	public void setWinPoint(String WinPoint) {
	    this.WinPoint = WinPoint;
	}
	/**
	 * 勝ち数を取得します。
	 * @return NoWin
	 */
	public String getNoWin() {
	    return NoWin;
	}
	/**
	 * 勝ち数を設定します。
	 * @param NoWin NoWin
	 */
	public void setNoWin(String NoWin) {
	    this.NoWin = NoWin;
	}
	/**
	 * 引き分け数を取得します。
	 * @return NoDrow
	 */
	public String getNoDrow() {
	    return NoDrow;
	}
	/**
	 * 引き分け数を設定します。
	 * @param NoDrow NoDrow
	 */
	public void setNoDrow(String NoDrow) {
	    this.NoDrow = NoDrow;
	}
	/**
	 * 負け数を取得します。
	 * @return NoLose
	 */
	public String getNoLose() {
	    return NoLose;
	}
	/**
	 * 負け数を設定します。
	 * @param NoLose NoLose
	 */
	public void setNoLose(String NoLose) {
	    this.NoLose = NoLose;
	}
	/**
	 * 得点を取得します。
	 * @return GetScore
	 */
	public String getGetScore() {
	    return GetScore;
	}
	/**
	 * 得点を設定します。
	 * @param GetScore GetScore
	 */
	public void setGetScore(String GetScore) {
	    this.GetScore = GetScore;
	}
	/**
	 * 失点を取得します。
	 * @return LoseScore
	 */
	public String getLoseScore() {
	    return LoseScore;
	}
	/**
	 * 失点を設定します。
	 * @param LoseScore LoseScore
	 */
	public void setLoseScore(String LoseScore) {
	    this.LoseScore = LoseScore;
	}
	/**
	 * 得失点を取得します。
	 * @return GoalDifference
	 */
	public String getGoalDifference() {
	    return GoalDifference;
	}
	/**
	 * 得失点を設定します。
	 * @param GoalDifference GoalDifference
	 */
	public void setGoalDifference(String GoalDifference) {
	    this.GoalDifference = GoalDifference;
	}
	/**
	 * IDを取得します。
	 * @return Id
	 */
	public String getId() {
	    return Id;
	}
	/**
	 * IDを設定します。
	 * @param Id Id
	 */
	public void setId(String Id) {
	    this.Id = Id;
	}
	/**
	 * 行数を取得します。
	 * @return RowCnt
	 */
	public String getRowCnt() {
	    return RowCnt;
	}
	/**
	 * 行数を設定します。
	 * @param RowCnt RowCnt
	 */
	public void setRowCnt(String RowCnt) {
	    this.RowCnt = RowCnt;
	}
	/**
	 * チームIDを取得します。
	 * @return TeamId
	 */
	public String getTeamId() {
	    return TeamId;
	}
	/**
	 * チームIDを設定します。
	 * @param TeamId TeamId
	 */
	public void setTeamId(String TeamId) {
	    this.TeamId = TeamId;
	}
	/**
	 * 試合結果を取得します。
	 * @return GameResult
	 */
	public String getGameResult() {
	    return GameResult;
	}
	/**
	 * 試合結果を設定します。
	 * @param GameResult GameResult
	 */
	public void setGameResult(String GameResult) {
	    this.GameResult = GameResult;
	}
}
