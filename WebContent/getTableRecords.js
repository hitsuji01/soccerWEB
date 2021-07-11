/* getTableRecords.js */

/***
 * チェックの付いた列を取得する
 ***/
function getTableRecords(button){
	var btnName = button.getAttribute('name');

	// 送信用フォーム「sub_val」を初期化
	document.form1.elements["sub_val"].value = '';

	// 押されたボタンがsub_buttonのとき
	if(btnName == 'sub_button' ) {
		var chkRow=$("input[name=Target]:checked").parents("tr");

		// チェックボックスにチェックがついていないなら送信しない
		if (chkRow.length == 0){
			alert('選択してください');
			return false;
		}

		// チェックされているラジオボタンを確認
		var radio_btn = document.getElementsByName("sql_type");
		var radio_btnName = '';
		for(var i=0; i<radio_btn.length;i++){
			if(radio_btn[i].checked == true){
				radio_btnName = radio_btn[i].value;
			}
		}

		// チェックされているラジオボタンがinsertまたはupdateなら入力チェック
		if(radio_btnName == 'insert' || radio_btnName == 'update'){
			var chk=[];
			for(i=1;i<=chkRow.length;i++){
				chk[i]=chkTableRecords($(chkRow[chkRow.length - i]));
			}
			// エラーがあるなら送信しない
			if(chk.indexOf(false) >= 0){
				return false;
			}
		}

		var setsu=[];
		var day=[];
		var time=[];
		var home=[];
		var away=[];
		var score_home=[];
		var score_away=[];
		var id=[];
		var array=[];

		// 送信用データの作成
		for(i=0;i<chkRow.length;i++){
			var row=chkRow[chkRow.length - i - 1];
			setsu[i]=$(row).children("td:nth-child(3)").find("input").val();
			day[i]=$(row).children("td:nth-child(4)").find("input").val();
			time[i]=$(row).children("td:nth-child(5)").find("input").val();
			home[i]=$(row).children("td:nth-child(6)").find("select").val();
			away[i]=$(row).children("td:nth-child(7)").find("select").val();
			//home[i]=$(row).children("td:nth-child(6)").find("input").val().replace(/[!"#$%&'()\*\+\-\.,\/:;<=>?@\[\\\]^_`{|}~]/g, '');
			//away[i]=$(row).children("td:nth-child(7)").find("input").val().replace(/[!"#$%&'()\*\+\-\.,\/:;<=>?@\[\\\]^_`{|}~]/g, '');
			score_home[i]=$(row).children("td:nth-child(8)").find("input").val();
			score_away[i]=$(row).children("td:nth-child(9)").find("input").val();
			id[i]=$(row).children("td:nth-child(1)").find("input").val();

			array[i]=(setsu[i]+','+day[i]+','+time[i]+','+home[i]+','+away[i]+','+score_home[i]+','+score_away[i]+','+id[i]);

			if(i == 0){
				document.form1.elements["sub_val"].value = array[i];
			}
			else{
				document.form1.elements["sub_val"].value = document.form1.elements["sub_val"].value + '/' + array[i];
			}
		}

		// 送信先を設定
		document.form1.to_name.value = "W007_Kanryou.jsp";
		document.form1.action="W007_Kanryou";

		return true;
	}

	// 押されたボタンがsetsu_buttonのとき
	else if(btnName == 'setsu_button' ) {

		// 送信用データの作成
		document.form1.elements["sub_val"].value = button.value;

		// 送信先を設定
		document.form1.to_name.value = "W006_KousinSakujo.jsp";
		document.form1.action="W006_KousinSakujo";

		return true;
	}

	return false;
}

/***
 * 入力チェックを行う
 ***/
function chkTableRecords(chkRow){
	var flag = true;
	var array = new Array();
	var err_msg = '';

	// 節
	if($(chkRow).children("td:nth-child(3)").find("input").val() == ""){
		flag = false;
		array.push('節:未入力です');
	}
	else if($(chkRow).children("td:nth-child(3)").find("input").val().search(/^[0-9]+$/) != 0){
		flag = false;
		array.push('節:半角数字のみです');
	}

	// 試合日
	if($(chkRow).children("td:nth-child(4)").find("input").val() == ""){
		flag = false;
		array.push('試合日:未入力です')
	}
	else if($(chkRow).children("td:nth-child(4)").find("input").val().search(/^\d{4}-\d{2}-\d{2}$/) != 0){
		flag = false;
		array.push('試合日:「YYYY-MM-DD」の形式で入力してください');
	}
	else{
		var dateArr = $(chkRow).children("td:nth-child(4)").find("input").val().split("-");
		var year = Number(dateArr[0]);
		var month = Number(dateArr[1] - 1);
		var day = Number(dateArr[2]);

		if(year >= 0 && (month >= 0 && month <= 11) && (day >= 1 && day <= 31)){
			var date = new Date(year, month, day);
			if(isNaN(date)){
				flag =  false;
				array.push('試合日:日付が正しくありません');
			}
			else if(date.getFullYear() == year && date.getMonth() == month && date.getDate() == day){

			}
			else{
				flag =  false;
				array.push('試合日:日付が正しくありません');
			}
		}
		else{
			flag = false;
			array.push('試合日:日付が正しくありません');
		}
	}

	// キックオフ
	if($(chkRow).children("td:nth-child(5)").find("input").val() == ""){
		flag = false;
		array.push('キックオフ:未入力です')
	}
	else if($(chkRow).children("td:nth-child(5)").find("input").val().search(/^([01]?[0-9]|2[0-3]):([0-5][0-9])$/) != 0){
		flag = false;
		array.push('キックオフ:「HH:MM」の形式で入力してください(HHは「00～23」、MMは「00～59」)');
	}

	// ホーム
	if($(chkRow).children("td:nth-child(6)").find("select").val() == ""){
		flag = false;
		array.push('ホーム:未入力です')
	}

	// アウェー
	if($(chkRow).children("td:nth-child(7)").find("select").val() == ""){
		flag = false;
		array.push('アウェー:未入力です')
	}

	if($(chkRow).children("td:nth-child(6)").find("select").val() == $(chkRow).children("td:nth-child(7)").find("select").val()){
		flag = false;
		array.push('ホームとチームで同じ名前を選択することはできません')
	}

	// スコア(ホーム)
	if($(chkRow).children("td:nth-child(8)").find("input").val() == ""){
		flag = false;
		array.push('スコア(ホーム):未入力です')
	}
	else if($(chkRow).children("td:nth-child(8)").find("input").val().search(/^[0-9]+$/) != 0){
		flag = false;
		array.push('スコア(ホーム):半角数字のみです');
	}

	// スコア(アウェー)
	if($(chkRow).children("td:nth-child(9)").find("input").val() == ""){
		flag = false;
		array.push('スコア(アウェー):未入力です')
	}
	else if($(chkRow).children("td:nth-child(9)").find("input").val().search(/^[0-9]+$/) != 0){
		flag = false;
		array.push('スコア(アウェー):半角数字のみです');
	}


	// 入力に不備があるならメッセージ表示
	if(flag == false){
		for(var i = 0; i<array.length; i++){
			err_msg = err_msg + '\n' + array[i];
		}

		err_msg = 'No.' + $(chkRow).children("td:nth-child(2)").html() + err_msg;
		alert(err_msg);
	}
	return flag;
}


