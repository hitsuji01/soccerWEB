/* masterTableScript.js */

/***
 * 表示するテーブルの切り替えを行う
 ***/
function changeTable() {
	var radio_btn = document.form1.sql_type.value;
	var chk_btn = document.getElementsByName("Target");
	var tbl_name = document.form1.master_name.value;

	// チェックボックスのチェックを全解除
	for(var i=0;i<chk_btn.length;i++){
		chk_btn[i].checked = false;
	}

	switch (tbl_name){
	case 'team':
		if(radio_btn == 'insert'){
			document.getElementById("TeamMst_insert").style.display="";

			document.getElementById("TeamMst_update").style.display="none";
			document.getElementById("TeamMst_delete").style.display="none";
			document.getElementById("KaijoMst_update").style.display="none";
			document.getElementById("PointMst_update").style.display="none";
		}
		else if(radio_btn == 'update'){
			document.getElementById("TeamMst_update").style.display="";

			document.getElementById("TeamMst_insert").style.display="none";
			document.getElementById("TeamMst_delete").style.display="none";
			document.getElementById("KaijoMst_update").style.display="none";
			document.getElementById("PointMst_update").style.display="none";
		}
		else if(radio_btn == 'delete'){
			document.getElementById("TeamMst_delete").style.display="";

			document.getElementById("TeamMst_insert").style.display="none";
			document.getElementById("TeamMst_update").style.display="none";
			document.getElementById("KaijoMst_update").style.display="none";
			document.getElementById("PointMst_update").style.display="none";
		}
		break;

	case 'kaijo':
		document.getElementsByName("sql_type")[2].checked = true;

		document.getElementById("KaijoMst_update").style.display="";

		document.getElementById("TeamMst_insert").style.display="none";
		document.getElementById("TeamMst_update").style.display="none";
		document.getElementById("TeamMst_delete").style.display="none";
		document.getElementById("PointMst_update").style.display="none";

		break;

	case 'point':
		document.getElementsByName("sql_type")[2].checked = true;

		document.getElementById("PointMst_update").style.display="";

		document.getElementById("TeamMst_insert").style.display="none";
		document.getElementById("TeamMst_update").style.display="none";
		document.getElementById("TeamMst_delete").style.display="none";
		document.getElementById("KaijoMst_update").style.display="none";

		break;
	}
}


/***
 * チェックの付いた列を取得する
 ***/
function getTableRecords(){

	//送信用フォーム「sub_val」を初期化
	document.form1.elements["sub_val"].value = '';

	// チェックがついているチェックボックスを確認
	var chkRow=$("input[name=Target]:checked").parents("tr");

	// チェックボックスにチェックがついていないなら送信しない
	if (chkRow.length == 0){
		alert('選択してください');
		return false;
	}

	// 選択されているテーブルを確認
	var tbl_name = document.form1.master_name.value;

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
			chk[i]=chkTableRecords($(chkRow[chkRow.length - i]),tbl_name);
		}
		// エラーがあるなら送信しない
		if(chk.indexOf(false) >= 0){
			return false;
		}
	}

	var team=[];
	var kaijo=[];
	var id=[];
	var tbl=[];
	var array=[];

	// 送信用データの作成
	for(i=0;i<chkRow.length;i++){
		var row=chkRow[chkRow.length - i - 1];

		switch (tbl_name){
		case 'team':
			tbl[i]='SCRTBL_TEAMMST';
			id[i]=$(row).children("td:nth-child(1)").find("input").val();
			team[i]=$(row).children("td:nth-child(3)").find("input").val().replace(/[!"#$%&'‘()\*\+\-\.,\/:;<=>?@\[\\\]^_`{|}~]/g, '');

			array[i]=(tbl[i]+','+id[i]+','+team[i]);
			break;

		case 'kaijo':
			tbl[i]='SCRTBL_KAIJOMST';
			id[i]=$(row).children("td:nth-child(1)").find("input").val();
			kaijo[i]=$(row).children("td:nth-child(4)").find("input").val().replace(/[!"#$%&'‘()\*\+\-\.,\/:;<=>?@\[\\\]^_`{|}~]/g, '');

			array[i]=(tbl[i]+','+id[i]+','+kaijo[i]);
			break;

		case 'point':
			tbl[i]='SCRTBL_POINTMST';
			id[i]=$(row).children("td:nth-child(1)").find("input").val();
			team[i]=$(row).children("td:nth-child(3)").find("input").val().replace(/[!"#$%&'‘()\*\+\-\.,\/:;<=>?@\[\\\]^_`{|}~]/g, '');

			array[i]=(tbl[i]+','+id[i]+','+team[i]);
			break;
		}

		if(i == 0){
			document.form1.elements["sub_val"].value = array[i];
		}
		else{
			document.form1.elements["sub_val"].value = document.form1.elements["sub_val"].value + '/' + array[i];
		}
	}

	// 送信先を設定
	document.form1.to_name.value = "W009_MasterTouroku.jsp";
	document.form1.action="W007_Kanryou";

	return true;

}


/***
 * 入力チェックを行う
 ***/
function chkTableRecords(chkRow,tbl_name){
	var flag = true;
	var array = new Array();
	var err_msg = '';

	// 入力チェック
	switch (tbl_name){
	case 'team':
		if($(chkRow).children("td:nth-child(3)").find("input").val() == ""){
			flag = false;
			array.push('チーム名:未入力です')
		}
		break;

	case 'kaijo':
		if($(chkRow).children("td:nth-child(4)").find("input").val() == ""){
			flag = false;
			array.push('会場名:未入力です')
		}
		break;

	case 'point':
		if($(chkRow).children("td:nth-child(3)").find("input").val().search(/^[0-9]+$/) != 0){
			flag = false;
			array.push('勝点:半角数字のみです');
		}
		break;
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


