$PBExportHeader$w_sys_main_bk.srw
$PBExportComments$系统背景图形窗口
forward
global type w_sys_main_bk from w_child
end type
type dw_1 from datawindow within w_sys_main_bk
end type
type p_1 from picture within w_sys_main_bk
end type
type dw_2 from datawindow within w_sys_main_bk
end type
type dw_3 from datawindow within w_sys_main_bk
end type
type dw_5 from datawindow within w_sys_main_bk
end type
type dw_4 from datawindow within w_sys_main_bk
end type
type cbx_1 from checkbox within w_sys_main_bk
end type
type ole_web from olecustomcontrol within w_sys_main_bk
end type
type ole_winsock from olecustomcontrol within w_sys_main_bk
end type
end forward

global type w_sys_main_bk from w_child
string tag = "系统主导航器"
integer x = 5
integer y = 4
integer width = 3927
integer height = 2692
string title = ""
boolean border = false
windowstate windowstate = maximized!
long backcolor = 16777215
event ue_positionchanged pbm_windowposchanged
dw_1 dw_1
p_1 p_1
dw_2 dw_2
dw_3 dw_3
dw_5 dw_5
dw_4 dw_4
cbx_1 cbx_1
ole_web ole_web
ole_winsock ole_winsock
end type
global w_sys_main_bk w_sys_main_bk

type prototypes
 
end prototypes

type variables
String		is_module_name
dwobject		idwo					//左侧模块DW的点击对象
int ii_flag

Long			il_current_row	=	1

CONSTANT Long sckClosed            = 0    //缺省的。关闭 
CONSTANT Long sckOpen              = 1    //打开 
CONSTANT Long sckListening         = 2    //侦听 
CONSTANT Long sckConnectionPending = 3    //连接挂起 
CONSTANT Long sckResolvingHost     = 4    //识别主机 
CONSTANT Long sckHostResolved      = 5    //已识别主机 
CONSTANT Long sckConnecting        = 6    //正在连接 
CONSTANT Long sckConnected         = 7    //已连接 
CONSTANT Long sckClosing           = 8    //同级人员正在关闭连接 
CONSTANT Long sckError             = 9    //错误
string  is_sissonline
boolean ib_server_processing
end variables

forward prototypes
public subroutine of_selectothers (string as_str)
public subroutine of_selectmenu (string as_name)
public subroutine of_selectmodule (integer row)
public subroutine of_setfocusrow (datawindow ld_dw)
public subroutine of_init ()
public subroutine of_favor (string as_type, string as_menuid, string as_menuname)
public function integer of_connect_sock (string as_url)
public function boolean of_sock_status ()
public subroutine of_open_conncect_siss ()
public subroutine of_open_siss ()
end prototypes

event ue_positionchanged;//HWND_TOP        ((HWND)0)
//HWND_BOTTOM     ((HWND)1)
//HWND_TOPMOST    ((HWND)-1)
//HWND_NOTOPMOST  ((HWND)-2)

geFunc.SetWindowPos(Handle(This), -2, 0, 0, 0, 0, 1)

end event

public subroutine of_selectothers (string as_str);//Long				i, j
//String			ls_name, ls_share, ls_oper
//m_pub_popmenu	lm_popmenu
//
//IF Len(as_str) = 0 THEN
//	return
//END IF
//
//lm_popmenu = Create m_pub_popmenu	
//
//CHOOSE CASE as_str
//		
//	CASE 'SR'	//存档报表
//		
//		lb_Files.Reset()
//		lb_Files.DirList(gVar.AppDir + "\report\*.psr", 0)
//		geFunc.SetCurrentDirectoryA(gVar.AppDir)
//		
//		FOR i = 1 TO lb_Files.TotalItems()
//			lb_Files.SelectItem ( i )
//			ls_name = lb_Files.SelectedItem ( )
//			
//			IF Mid(ls_name, 1, 4) <> 'RPT_' THEN Continue
//			
//			j ++
//			IF j > 15 THEN exit
//			
//			ls_name = Mid(ls_name, 5, LEN(ls_name) - 8)	
//			lm_popmenu.m_savereport.item[j].Visible = TRUE
//			lm_popmenu.m_savereport.item[j].Enabled = TRUE
//			lm_popmenu.m_savereport.item[j].text = ls_name
//			lm_popmenu.m_savereport.item[j].tag = 'CU'
//		NEXT
//		
//		IF j > 0 THEN 			
//			lm_popmenu.m_savereport.m_moreline.Visible = TRUE
//			lm_popmenu.m_savereport.m_more.Enabled = TRUE
//			lm_popmenu.m_savereport.m_more.Text = '存档报表管理...'
//			lm_popmenu.m_savereport.m_more.Tag = 'CU'
//			lm_popmenu.m_savereport.PopMenu(ParentWindow().PointerX(), ParentWindow().PointerY())
//		END IF
//		
//	CASE 'UR'	//自定义报表
//		
//		 DECLARE Cur_MenuRep CURSOR FOR  
//		  SELECT report_name,   
//					shareable,   
//					create_oper 
//			 FROM t_sys_customize_report  
//		ORDER BY create_date DESC;		
//		
//		OPEN Cur_MenuRep ;
//		FETCH Cur_MenuRep INTO :ls_name, :ls_share, :ls_oper;
//		
//		DO WHILE SQLCA.SQLCode = 0
//
//			//访问权限控制
//			IF (ls_share <> '1') and (ls_oper <> gVar.OperInfo.OperId) THEN 
//				
//				FETCH Cur_MenuRep INTO :ls_name, :ls_share, :ls_oper;
//			
//			ELSE
//				j ++
//				IF j > 15 THEN exit
//	
//				lm_popmenu.m_savereport.item[j].Visible = TRUE
//				lm_popmenu.m_savereport.item[j].Enabled = TRUE
//				lm_popmenu.m_savereport.item[j].text = ls_name
//				lm_popmenu.m_savereport.item[j].Tag = 'UD'
//				
//				FETCH Cur_MenuRep INTO :ls_name, :ls_share, :ls_oper;
//			END IF
//
//		LOOP
//		
//		CLOSE Cur_MenuRep ;
//		
//		IF j = 0 THEN 			
//			lm_popmenu.m_savereport.m_moreline.Visible = FALSE
//		END IF
//		
//		lm_popmenu.m_savereport.m_more.Enabled = TRUE
//		lm_popmenu.m_savereport.m_more.Text = '自定义报表管理...'
//		lm_popmenu.m_savereport.m_more.Tag = 'UD'
//
//		lm_popmenu.m_savereport.m_moreline1.Visible = TRUE
//		lm_popmenu.m_savereport.m_rep_wizard.Enabled = TRUE
//		lm_popmenu.m_savereport.m_rep_wizard.Visible = TRUE
//		lm_popmenu.m_savereport.m_rep_wizard.Tag = 'UD'			
//
//		lm_popmenu.m_savereport.PopMenu(ParentWindow().PointerX(), ParentWindow().PointerY())
//		
//	CASE ELSE
//		
//END CHOOSE
//
//Destroy lm_popmenu
//
end subroutine

public subroutine of_selectmenu (string as_name);CHOOSE CASE Lower(as_name)
	CASE 'm_open_custreport'	//打开自定义报表
		
		w_master  w_beopen
//		Open(w_rpt_manager_document)
		opensheetwithparm(w_beopen,'C','w_pub_mem_report',w_sys_main_frame,0,original!)
		
	CASE 'm_report_wizard'	//打开自定义报表向导
		
//		opensheet(w_pub_repwizard, w_sys_main_frame, 0, Original!)	
	CASE ELSE
		
END CHOOSE

end subroutine

public subroutine of_selectmodule (integer row);String		ls_code, ls_dw,ls_branch_func

IF row = 0 or row > dw_1.RowCount() THEN RETURN

ls_code = Mid(dw_1.GetItemString(Row, 'module_id'), 1, 1)

IF w_sys_main_frame.is_module_code = ls_code THEN return

w_sys_main_frame.is_module_code = ls_code
w_sys_main_frame.is_module_name = dw_1.GetItemString(Row, 'name')

dw_2.DataObject = 'd_sys_module_' + ls_code

//dw_2.DataObject = 'd_test'
//dw_2.SetTransObject(SQLCA)
//dw_2.retrieve(ls_code + '%')

if gvar.is_distributed then
	if not gvar.is_branch then //总分
		ls_branch_func='_1____'
	else //分部
		ls_branch_func='__1___'
	end if
else //单店
	ls_branch_func='1_____'
end if
//dw_3.retrieve(ls_code + '%',ls_branch_func)
//2006-09-15 wangy
dw_3.retrieve(ls_code + '%',ls_branch_func,gvar.operinfo.operid,ii_flag)


dw_4.SetTransObject(SQLCA)
dw_4.retrieve(ls_code + '%',ls_branch_func,gVar.Operinfo.operid,ii_flag)
dw_4.Modify("t_1.Text = ' —— " + w_sys_main_frame.is_module_name + "'")


//屏蔽代销结算，联营结算，联营商品销售报表. 
If ls_code = "7" and ii_flag = 0 Then //比率用户
	dw_4.SetFilter("menu_id <> '7103' and menu_id <> '7304' and menu_id <> '7104' and menu_id <> '7203'")
	dw_4.Filter()
End If
IF dw_3.RowCount() = 0 THEN
	dw_3.Visible = FALSE
ELSE
	dw_3.Visible = TRUE
END IF

end subroutine

public subroutine of_setfocusrow (datawindow ld_dw);integer	li_row
string	ls_str, ls_item

ls_str = ld_dw.GetObjectAtPointer()

IF Len(ls_str) = 0 THEN
	return
END IF

if pos(ls_str,'menu_name_1') > 0 or pos(ls_str,'menu_name_2') > 0  or pos(ls_str,'menu_name_3') > 0 then 
else
	return
end if

li_row = Integer(Mid(ls_str, Pos(ls_str, char(09)) + 1))

IF li_row = 0 THEN return

ld_dw.ScrollToRow(li_row)

return
end subroutine

public subroutine of_init ();String		ls_str
Long			ll_flag


If gfunc.of_output_discount() Then //无比率
	ii_flag = 1
Else
	ii_flag = 0
End If

ll_flag = gs_oem[1].flag

dw_1.Object.p_2.Filename = 'resource\' + gs_oem[ll_flag].pic2
dw_1.Object.p_3.Filename = 'resource\' + gs_oem[ll_flag].pic3



This.Title = '系统主导航器'

dw_2.SetTransObject(SQLCA)
dw_3.SetTransObject(SQLCA)

Choose Case Hour(Now())
	Case Is < 12
		ls_str = '早上好！'
	Case Is > 18
		ls_str = '晚上好！'
	Case Else
		ls_str = '下午好！'
End Choose
dw_2.Modify("t_welcome.text='" + ls_str + gVar.Operinfo.OperName  + "'")
dw_2.Modify("t_opername.text='" + "   您上次使用的时间是: " + String(gVar.Operinfo.LastLoginTime, 'yyyy-mm-dd hh:mm') + "'")

of_favor('create', '', '')

//dw_5.SetTransOBject(SQLCA)
//dw_5.Retrieve( Mid(gVar.OperInfo.OperId, 1, 2) + '%')

//Modify By Dailj 2008-01-15 根据操作员功能权限来控制功能模块的可见否
string ls_sql, ls_id[], ls_name[]
long ll_i
for ll_i = 1 to dw_1.rowcount()
	ls_name[ll_i] = dw_1.getitemstring(ll_i,'name')
next
declare lc_emp dynamic cursor for sqlsa;
ls_sql = "select distinct left(menu_id,1) from t_sys_menu where left(menu_id,1) in (select left(func_id,1) from t_sys_oper_grant where grant0 = '1' and oper_id = '"+gVar.OperInfo.OperId+"')"
prepare sqlsa from :ls_sql;
open dynamic lc_emp;
//运行此函数时DW_1已打开了模块,需要先清除再重新ADD
dw_1.reset()
ll_i = 1
do while sqlca.sqlcode = 0
	fetch lc_emp into :ls_id[ll_i] ;
	if sqlca.sqlcode = 0 then
		dw_1.insertrow(0)
		dw_1.setitem(ll_i,'module_id',ls_id[ll_i])
		if ls_id[ll_i] = 'A' then 
			dw_1.setitem(ll_i,'name',ls_name[10])
		elseif ls_id[ll_i] = 'B' then
			dw_1.setitem(ll_i,'name',ls_name[11])
		else
			dw_1.setitem(ll_i,'name',ls_name[long(ls_id[ll_i])])
		end if
	end if
	ll_i = ll_i + 1
loop
close lc_emp;
//Modify By Dailj end 2008-01-15
	
String ls_filter = ''
If Not gVar.is_distributed Then
	ls_filter = "module_id <> '9'"
ElseIf gVar.is_branch Then
	If gVar.is_distributed_model	 = '0' Then //零售
		ls_filter = "module_id not in  ('2','8','A')"
	ElseIf gVar.is_distributed_model = '1' Then //进销存
		ls_filter = "module_id not in  ('8','A')"
	ElseIf gVar.is_distributed_model = '2' Then //加盟店
		ls_filter = "module_id not in  ('2','8','A')"
	ElseIf gVar.is_distributed_model	 = '3' Then //配送中心
		ls_filter = "module_id not in  ('5','6','8')"
	End If
End If

//add by wangy 2006-09-15
If ii_flag = 0 Then
	If Len(ls_filter) > 0 Then ls_filter += ' and '
	ls_filter += "module_id <> '9'"
End If

dw_1.SetFilter(ls_filter)
dw_1.Filter()


//add by dutianzeng 2005-08-03
Int li_len
Long ll_count
String ls_code,ls_size
If Not gVar.is_branch Then
	
	ls_code = Fill("0", gVar.gi_color_len)
	ls_size = Fill("0", gVar.gi_size_len)
	
	SELECT count(code_id)
		INTO :ll_count
		FROM t_bd_base_code
		WHERE type_no = 'CO'
		And code_id = :ls_code;
		
	If ll_count = 0 Then
		//		insert into t_bd_base_code
		//		(type_no,code_id,code_name)
		//		values ('CO',:ls_code,'单色');
		//服装V7的默认颜色
		INSERT INTO t_bd_base_code VALUES (
			'CO',
			'00',
			'单色',
			NULL,
			NULL,
			NULL,
			NULL,
			Null);
		INSERT INTO t_bd_base_code VALUES (
			'CO',
			'01',
			'黑色',
			NULL,
			NULL,
			NULL,
			NULL,
			Null);
		INSERT INTO t_bd_base_code VALUES (
			'CO',
			'02',
			'白色',
			NULL,
			NULL,
			NULL,
			NULL,
			Null);
		INSERT INTO t_bd_base_code VALUES (
			'CO',
			'03',
			'红色',
			NULL,
			NULL,
			NULL,
			NULL,
			Null);
		INSERT INTO t_bd_base_code VALUES (
			'CO',
			'04',
			'黄色',
			NULL,
			NULL,
			NULL,
			NULL,
			Null);
		INSERT INTO t_bd_base_code VALUES (
			'CO',
			'05',
			'金色',
			NULL,
			NULL,
			NULL,
			NULL,
			Null);
		INSERT INTO t_bd_base_code VALUES (
			'CO',
			'06',
			'绿色',
			NULL,
			NULL,
			NULL,
			NULL,
			Null);
		INSERT INTO t_bd_base_code VALUES (
			'CO',
			'07',
			'紫色',
			NULL,
			NULL,
			NULL,
			NULL,
			Null);
		INSERT INTO t_bd_base_code VALUES (
			'CO',
			'08',
			'蓝色',
			NULL,
			NULL,
			NULL,
			NULL,
			Null);
		INSERT INTO t_bd_base_code VALUES (
			'CO',
			'09',
			'臧青',
			NULL,
			NULL,
			NULL,
			NULL,
			Null);
		INSERT INTO t_bd_base_code VALUES (
			'CO',
			'10',
			'灰色',
			NULL,
			NULL,
			NULL,
			NULL,
			Null);
		INSERT INTO t_bd_base_code VALUES (
			'CO',
			'11',
			'粉红',
			NULL,
			NULL,
			NULL,
			NULL,
			Null);
		INSERT INTO t_bd_base_code VALUES (
			'CO',
			'22',
			'Beige',
			NULL,
			NULL,
			NULL,
			NULL,
			Null);
		INSERT INTO t_bd_base_code VALUES (
			'CO',
			'32',
			'Lemon Yellow',
			NULL,
			NULL,
			NULL,
			NULL,
			Null);
		COMMIT;
	End If
	
	SELECT count(code_id)
		INTO :ll_count
		FROM t_bd_base_code
		WHERE type_no = 'SI'
		And code_id = :ls_size;
		
	If ll_count = 0 Then
		//		INSERT INTO t_bd_base_code
		//			(type_no,code_id,code_name,code_order,size_group_id)
		//			Values ('SI',:ls_size,'均码',1,'00');
		//服装V7的默认尺码
		INSERT INTO t_bd_base_code VALUES (
			'SI',
			'00',
			'均码',
			NULL,
			NULL,
			NULL,
			1,
			'00');
		INSERT INTO t_bd_base_code VALUES (
			'SI',
			'0301',
			'S',
			NULL,
			NULL,
			NULL,
			2,
			'01');
		INSERT INTO t_bd_base_code VALUES (
			'SI',
			'0302',
			'M',
			NULL,
			NULL,
			NULL,
			1,
			'01');
		INSERT INTO t_bd_base_code VALUES (
			'SI',
			'0303',
			'L',
			NULL,
			NULL,
			NULL,
			3,
			'01');
		INSERT INTO t_bd_base_code VALUES (
			'SI',
			'0304',
			'XL',
			NULL,
			NULL,
			NULL,
			4,
			'01');
		INSERT INTO t_bd_base_code VALUES (
			'SI',
			'0305',
			'XXL',
			NULL,
			NULL,
			NULL,
			5,
			'01');
		INSERT INTO t_bd_base_code VALUES (
			'SI',
			'0306',
			'XXXL',
			NULL,
			NULL,
			NULL,
			6,
			'01');
		INSERT INTO t_bd_base_code VALUES (
			'SI',
			'0401',
			'38',
			NULL,
			NULL,
			NULL,
			1,
			'02');
		INSERT INTO t_bd_base_code VALUES (
			'SI',
			'0402',
			'39',
			NULL,
			NULL,
			NULL,
			2,
			'02');
		INSERT INTO t_bd_base_code VALUES (
			'SI',
			'0403',
			'40',
			NULL,
			NULL,
			NULL,
			3,
			'02');
		INSERT INTO t_bd_base_code VALUES (
			'SI',
			'0404',
			'41',
			NULL,
			NULL,
			NULL,
			4,
			'02');
		INSERT INTO t_bd_base_code VALUES (
			'SI',
			'0405',
			'42',
			NULL,
			NULL,
			NULL,
			5,
			'02');
		INSERT INTO t_bd_base_code VALUES (
			'SI',
			'0406',
			'43',
			NULL,
			NULL,
			NULL,
			6,
			'02');
		COMMIT;
	End If
End If

//IF NOT gVar.Is_Branch then
////	select max(len(code_id))
////	into :li_len
////	from t_bd_base_code
////   where type_no = 'CO';
////	
////	if sqlca.sqlcode = 0 and li_len > 0 then
////		if li_len <> gvar.gi_color_len then
////			gfunc.of_set_sysvar('gi_color_len',string(li_len))
////			gvar.gi_color_len = li_len
////		end if
////	end if
//	
////	select max(len(code_id))
////	into :li_len
////	from t_bd_base_code
////   where type_no = 'SI';
////	
////	if sqlca.sqlcode = 0 and li_len > 0 then
////		
////		if li_len <> gvar.gi_size_len then
////			gfunc.of_set_sysvar('gi_size_len',string(li_len))
////			gvar.gi_size_len = li_len
////		end if
////	end if
//	
//	select count(item_barcode) into :ll_count
//	from t_bd_item_barcode;
//	
//	if ll_count > 0 then
//		string ls_item_no,ls_color_code,ls_size_code,ls_item_barcode
//		
//		declare my_cur cursor for select item_no,color_code,size_code,item_barcode
//			from t_bd_item_barcode 
//			where color_code <> size_code;
//		
//		open my_cur;
//		fetch my_cur into :ls_item_no,:ls_color_code,:ls_size_code,:ls_item_barcode;
//		do while sqlca.sqlcode = 0
//			if ls_size_code + ls_color_code = ls_color_code + ls_size_code then
//				fetch my_cur into :ls_item_no,:ls_color_code,:ls_size_code,:ls_item_barcode;
//				continue
//			else
//				if ls_item_barcode <> ls_item_no + ls_size_code + ls_color_code then
//					gfunc.of_set_sysvar('gs_colorsize_order','1')
//					gvar.gs_colorsize_order = '1'
//				else
//					gfunc.of_set_sysvar('gs_colorsize_order','0')
//					gvar.gs_colorsize_order = '0'
//				end if
//				exit
//			end if
//		loop
//		close my_cur;
//	end if
//end if
////add by dutianzeng 2005-08-03

If gVar.is_demo Then
	dw_1.Object.t_test.Visible = True
End If

//add by wangy

If ll_flag = 1 Then
	ls_str = '1'
Else
	ls_str = '0'
End If
ls_str = ProfileString(gVar.InitFile, 'App_Env', 'Navigator', ls_str)

If ls_str = '1' Then
	dw_4.Visible = False
	cbx_1.Checked = True
Else
	dw_4.Visible = True
	cbx_1.Checked = False
End If

ls_str = gfunc.of_get_sysvar('Sys_Navigation_Sw')
If ls_str <> "0" Then
	cbx_1.Visible = True
Else
	cbx_1.Visible = False
End If

//导航器固定为列表界面，不可切换
ls_str = '0'
ls_str = gfunc.of_get_sysvar('Sys_Navigation_list')
If ls_str = "1" Then
	dw_4.Visible = True
	cbx_1.Checked = False
ElseIf ls_str = "0" Then
	dw_4.Visible = False
	cbx_1.Checked = True
End If


dw_4.SetPosition(behind!,dw_5)
dw_5.SetPosition(totop!,dw_4)
dw_3.SetPosition(totop!,dw_4)
cbx_1.SetPosition(totop!,dw_4)



If ii_flag = 0 Then
	dw_5.Visible = False
	cbx_1.Visible = False
	dw_4.Visible = True
	dw_4.SetPosition(behind!,dw_5)
End If


of_selectModule(1)

If ProfileString(gVar.InitFile,"app_env",'start_tips','0') = '1' Then
	Open(w_sys_start_tips)
End If


end subroutine

public subroutine of_favor (string as_type, string as_menuid, string as_menuname);Int				li_rtn
String			ls_fanc_type, ls_filename, ls_auto
Long				ll_rowcount, ll_row, ll_maxcount
Datetime			ldt_now

ll_maxcount = 15
ldt_now = datetime(today(), now())
ls_filename = gvar.AppDir+'\localdata\myfavor.txt'

ls_fanc_type = Lower(as_type)
CHOOSE CASE ls_fanc_type
	CASE 'create'
		if fileexists(ls_filename) then
			li_rtn = dw_5.ImportFile(ls_filename)
		else
			return
		end if
		
		dw_5.SetFilter("operid ='" + gvar.operinfo.operid + "'")
		dw_5.Filter()

	CASE 'destroy'
		dw_5.SetFilter('1=1')
		dw_5.Filter()
		
		dw_5.saveas(ls_filename, Text!, false)

	CASE 'additem'
		
		ls_auto = ProfileString (gVar.initfile,"app_env",'myfavorAuto', '1')

		IF ls_auto <> '1' THEN RETURN		
		
		dw_5.SetFilter("operid ='" + gvar.operinfo.operid + "'")
		dw_5.Filter()

		ll_rowcount = dw_5.RowCount()
		li_rtn = dw_5.find("menuid = '" + as_menuid + "'", 1, ll_rowcount)
		if li_rtn > 0 then
			dw_5.SetItem(li_rtn, 'time', ldt_now)
			dw_5.SetItem(li_rtn, 'count', dw_5.GetItemNumber(li_rtn, 'count') + 1)
		ELSE
			ll_row = dw_5.Insertrow(0)
			dw_5.SetItem(ll_row, 'operid', gvar.operinfo.operid)
			dw_5.SetItem(ll_row, 'menuid', as_menuid)
			dw_5.SetItem(ll_row, 'menuname', as_menuname)
			dw_5.SetItem(ll_row, 'time', ldt_now)
			dw_5.SetItem(ll_row, 'count', 1)
		END IF
		
		dw_5.SetSort("time D ")
		dw_5.Sort()

		FOR ll_row = ll_maxcount + 1 TO dw_5.RowCount() 
			dw_5.DeleteRow(ll_row)
		NEXT		

END CHOOSE

end subroutine

public function integer of_connect_sock (string as_url);
/////用于检测能否连接到指定网站 

time lt_start
long ll_seconds,ll_ole_state
If not isvalid( ole_winsock ) then
///失败
return -1
end if
ll_ole_state = ole_winsock.Object.State
//已连接
if ll_ole_state = sckconnected then return 1
//连接中
if ll_ole_state = sckconnecting then goto wait
//其它先断，再连
ole_winsock.object.close()
//指定远程主机IP
ole_winsock.Object.RemoteHost = as_url 
//指定远程主机连接端口  
ole_winsock.Object.RemotePort = 80
//连接
ole_winsock.Object.Connect()
//等待延迟
wait:
lt_start = now()
do 
yield()
ib_server_processing=true ///正在连接
if ole_winsock.Object.State = sckconnected then exit
ll_seconds = secondsafter( lt_start,now())
if ll_seconds < 0 or ll_seconds > 3 then exit
loop while true
ib_server_processing=false ///连接结束
if ole_winsock.object.state <> sckconnected then  
///失败
return -1
end if
///成功
return 1

end function

public function boolean of_sock_status ();return ib_server_processing
end function

public subroutine of_open_conncect_siss ();
		SetPointer(HourGlass!)
		////若连接不到目标网站,给出提示; 若能连接即打开网页.
		IF of_connect_sock("www.siss.com.cn") <> 1 THEN
	      ole_web.visible=false
		//	MessageBox(gvar.apptitle,"连接不到思迅公司网站,请检查网络是否连通!")
		ELSE
			ole_web.Visible = TRUE
			ole_web.Object.navigate(is_sissonline)
		END IF
		SetPointer(Arrow!)

end subroutine

public subroutine of_open_siss ();////自动打开思迅在线，默认打开
string ls_flag

ls_flag=gFunc.of_get_sysvar('connect_sissweb')
if ls_flag='' or isnull(ls_flag) then ls_flag='1'
if ls_flag='1' then
	////连接不到目标网站，直接返回
   if of_connect_sock("www.siss.com.cn") <> 1 then return
	SetPointer(HourGlass!)
	ole_web.Visible = TRUE
	ole_web.Object.navigate(is_sissonline)
	SetPointer(Arrow!)
end if

end subroutine

on w_sys_main_bk.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.p_1=create p_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.dw_5=create dw_5
this.dw_4=create dw_4
this.cbx_1=create cbx_1
this.ole_web=create ole_web
this.ole_winsock=create ole_winsock
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.p_1
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.dw_5
this.Control[iCurrent+6]=this.dw_4
this.Control[iCurrent+7]=this.cbx_1
this.Control[iCurrent+8]=this.ole_web
this.Control[iCurrent+9]=this.ole_winsock
end on

on w_sys_main_bk.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.p_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.dw_5)
destroy(this.dw_4)
destroy(this.cbx_1)
destroy(this.ole_web)
destroy(this.ole_winsock)
end on

event resize;environment env
Long			ll_x

GetEnvironment(env)

IF env.screenwidth > 800 THEN
	dw_2.x = 1000
	dw_2.y = 500
	
	dw_3.x = dw_2.x
	
	dw_3.Height = 860
	
	dw_3.Object.DataWindow.header.Height = 138
	dw_3.Object.DataWindow.Detail.Height = 90
Else
	dw_2.x = dw_3.x +100
	dw_2.y =350

	dw_1.Modify('p_3.x=2500')
END IF

dw_2.Height = newheight
dw_2.Width = newwidth - dw_2.X
dw_1.Width = newwidth

dw_4.x = dw_2.x

dw_4.Height = dw_2.Height

dw_1.Height = dw_2.Height - dw_1.Y

ll_x = newheight - dw_3.Height
IF ll_x < 1580 THEN ll_x = 1580

dw_3.y = ll_x - 10//newheight - dw_3.height - 100
//dw_3.Modify('rr_1.Height=' + String(dw_3.Height) + '')

dw_4.x = dw_2.x
dw_4.Height = dw_3.y - dw_4.y - 10


ll_x = newwidth - dw_5.Width
IF ll_x < 2900 THEN ll_x = 2900

dw_5.X = ll_x
dw_5.Height = newheight - dw_5.Y - 150
dw_5.Modify('rr_1.Height=' + String(dw_5.Height - 100) + '')

IF env.screenwidth > 800 THEN
Else
	dw_5.visible = false
	cbx_1.visible=false
End IF

IF newwidth > 3200 THEN 
	dw_1.Modify('p_3.x=' + String(newwidth - 804) + '')
End IF

cbx_1.x = dw_5.x + 80
 IF env.screenwidth > 800 THEN
   ole_web.X = dw_4.X - 310
	ole_web.Y = dw_4.Y - 30
	ole_web.Width = dw_4.Width +dw_5.width - 50
	ole_web.Height = dw_4.Height +dw_3.height 
else
	   ole_web.X = dw_3.X +3
	ole_web.Y = dw_4.Y - 30 
	ole_web.Width = dw_4.Width +200
	ole_web.Height = dw_4.Height +dw_3.height - 106
end if

end event

event open;string ls_num,ls_RegisterNo
ls_num=gfunc.of_get_usercount()
ls_RegisterNo=gfunc.of_str_decrypt(gfunc.of_get_sysvar('RegisterNo'))
is_sissonline='www.siss.com.cn/online/index.aspx?type=2&&product='+gvar.appname +'&&no='+gHb.is_DogId+'&&register_no='+ls_RegisterNo+'&&num='+ls_num+'&&name='+gvar.CustomerName

of_init()



end event

event key;return

end event

event closequery;call super::closequery;of_favor('destroy', '', '')

end event

type dw_1 from datawindow within w_sys_main_bk
event ue_mousemove pbm_mousemove
event ue_mdown pbm_lbuttondown
event ue_mup pbm_lbuttonup
event ue_dwnkey pbm_dwnkey
integer width = 3931
integer height = 1964
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sys_module"
boolean border = false
boolean livescroll = true
end type

event ue_mousemove;of_setfocusrow(dw_1)


end event

event ue_mdown;long		ll_white, ll_black
string	ls_str 

ls_str = This.GetObjectAtPointer()

IF Len(ls_str) = 0 THEN
	return
END IF

ll_white = RGB(128,225,255)
ll_black = RGB(0,0,128)

//This.Modify("l_3.Pen.Color='" + string(ll_black) + "'")
//This.Modify("l_4.Pen.Color='" + string(ll_black) + "'")
//
//This.Modify("l_5.Pen.Color='" + string(ll_white) + "'")
//This.Modify("l_6.Pen.Color='" + string(ll_white) + "'")

end event

event ue_mup;long	ll_white, ll_black
string ls_str

ll_white = RGB(128,225,255)
ll_black = RGB(0,0,128)

//This.Modify("l_3.Pen.Color='" + string(ll_white) + "'")
//This.Modify("l_4.Pen.Color='" + string(ll_white) + "'")
//
//This.Modify("l_5.Pen.Color='" + string(ll_black) + "'")
//This.Modify("l_6.Pen.Color='" + string(ll_black) + "'")
//
end event

event ue_dwnkey;If key = KeyLeftArrow! Or key = KeyRightArrow! Or key = KeyUpArrow! Or key = KeyDownArrow! Then
	Return -1
End If

return
end event

event clicked;Inet  	iinet_base
string	ls_str 
long		ll_row
ole_web.visible=false
IF row = 0 THEN
	
	ls_str = This.GetObjectAtPointer()
	
	IF Len(ls_str) = 0 THEN
		return
	END IF
	
	ls_str = Lower(Mid(ls_str, 1, Pos(ls_str, char(09)) - 1))
	
	IF lower(ls_str) = 'p_logo' THEN
		GetContextService("Internet", iinet_base)
		iinet_base.HyperlinkToURL("http://")
	END IF
	
	IF lower(ls_str) = 't_11' THEN
		GetContextService("Internet", iinet_base)
		iinet_base.HyperlinkToURL("http://www.siss.com.cn")
	END IF
	
	IF lower(ls_str) = 't_22' THEN
		GetContextService("Internet", iinet_base)
		iinet_base.HyperlinkToURL("http://www.siss.com.cn/2product/index.asp")
	END IF
	
	IF lower(ls_str) = 't_exit' THEN
		w_sys_main_frame.TriggerEvent('ue_close')
		return
	END IF
	
	IF lower(ls_str) = 't_33' THEN
		open(w_sys_about)
	END IF

	IF lower(ls_str) = 't_55' THEN
		w_sys_main_frame.of_select_function('B111')
	END IF
	
	IF lower(ls_str) = 't_44' THEN
		open(w_sys_product_validate)
	END IF
	
	IF lower(ls_str) = 't_66' THEN
		open(w_sys_validation)
	END IF
	
	IF lower(ls_str) = 't_2' THEN
		open(w_sys_online_subscribe)
	END IF
	
	IF lower(ls_str) = 't_3' THEN
		open(w_sys_online_advice)
	END IF
	if lower(ls_str)='t_4' then
		if not fileexists( "mswinsck.ocx" )  then
			MessageBox(gvar.apptitle,"mswinsck.ocx文件不存在,不能打开思迅在线")
			return
		end if
		ole_web.visible=true
		SetPointer(HourGlass!)
		////若连接不到目标网站,给出提示; 若能连接即打开网页.
		IF of_connect_sock("www.siss.com.cn") <> 1 THEN
			MessageBox(gvar.apptitle,"连接不到思迅公司网站,请检查网络是否连通!")
		ELSE
			ole_web.Visible = TRUE
			ole_web.Object.navigate(is_sissonline)
		END IF
		SetPointer(Arrow!)

	end if
	ll_row = this.getrow()
	this.scrolltorow(ll_row)
	this.setcolumn("name")
	
	return
	
END IF

idwo = dwo
//IF not ( STRING(DWO.NAME ) = 't_1' or STRING(DWO.NAME ) = 't_2' or string( dwo.name ) = 'name' ) then 
//	post setrow( il_current_row )
//	return
//end if
//il_current_row = row
//ls_str = GetItemString(row, 'module_id')
//
//dw_2.SetRedraw(FALSE)
//
//IF Upper(ls_str) = 'EXIT' THEN	//退出
//	w_sys_main_frame.TriggerEvent('ue_close')
//	return
//ELSE
//	of_selectModule(row)
//END IF
//
//dw_2.SetRedraw(TRUE)

end event

event rowfocuschanging;
IF isnull( idwo) or &
	not isvalid( idwo ) then
	return 1
end if	

if not ( STRING(iDWO.NAME ) = 't_1' or &
	STRING(idwo.NAME ) = 't_2' or &
	string(idwo.name ) = 'name' ) then 
	return 1
end if

setnull( idwo ) 

string		ls_str
il_current_row = newrow
ls_str = GetItemString(il_current_row, 'module_id')

dw_2.SetRedraw(FALSE)

IF Upper(ls_str) = 'EXIT' THEN	//退出
	w_sys_main_frame.TriggerEvent('ue_close')
	return
ELSE
	of_selectModule(il_current_row)
END IF

dw_2.SetRedraw(TRUE)
end event

type p_1 from picture within w_sys_main_bk
boolean visible = false
integer width = 3931
integer height = 336
boolean bringtotop = true
boolean enabled = false
string picturename = "resource\main_title_fs.gif"
end type

type dw_2 from datawindow within w_sys_main_bk
event ue_mousemove pbm_mousemove
integer x = 613
integer y = 344
integer width = 2446
integer height = 1436
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_sys_module_1"
boolean border = false
boolean livescroll = true
end type

event ue_mousemove;//of_setfocusrow(this)
//
end event

event clicked;String	ls_menuid, ls_name
string	ls_str 

ls_str = Lower(This.GetObjectAtPointer())
ls_str = Lower(Mid(ls_str, 1, Pos(ls_str, char(09)) - 1))

IF (Len(ls_str) = 0) or (Pos(ls_str, 'p_') <> 0)THEN
	return
END IF

//IF (row = 0) or (row > this.RowCount()) THEN
//	return
//END IF
//ls_menuid = This.GetItemString(Row, 'menu_id')

ls_name = This.Describe(ls_str + '.tag')

IF ls_name = '' THEN
	ls_name = This.Describe(ls_str + '.text')
END IF

SELECT menu_id INTO :ls_menuid FROM t_sys_menu WHERE menu_name = :ls_name;

IF ls_menuid = '' or ls_menuid = '!' or isnull(ls_menuid) THEN RETURN

Choose Case Upper(ls_menuid)
	Case "T102"			//管理用户自定义报表
		of_SelectOthers('UR')
		
	Case "T101"			//管理存档报表
		of_SelectOthers('SR')		
		
	Case Else
		
		IF Isvalid(w_sys_main_frame) THEN
			w_sys_main_frame.of_select_function(ls_menuid)
		END IF
End Choose
end event

type dw_3 from datawindow within w_sys_main_bk
event ue_mousemove pbm_mousemove
integer x = 681
integer y = 1460
integer width = 2039
integer height = 560
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_sys_function_report"
boolean border = false
boolean livescroll = true
end type

event ue_mousemove;of_setfocusrow(this)

end event

event clicked;String	ls_menuid, ls_str 

ls_str = Lower(This.GetObjectAtPointer())
//ls_str = Lower(Mid(ls_str, 1, Pos(ls_str, char(09)) - 1))

IF (Len(ls_str) = 0) or (Pos(ls_str, 'p_') <> 0)THEN
	return
END IF

if pos(ls_str,'menu_name') <> 1 then return

IF (row = 0) or (row > this.RowCount()) THEN
	return
END IF

ls_menuid = This.GetItemString(Row, 'menu_id')

IF ls_menuid = '' or isnull(ls_menuid) THEN RETURN

IF Isvalid(w_sys_main_frame) THEN
	w_sys_main_frame.of_select_function(ls_menuid)
END IF



end event

type dw_5 from datawindow within w_sys_main_bk
integer x = 2990
integer y = 448
integer width = 663
integer height = 1032
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_sys_myfavor"
boolean border = false
boolean livescroll = true
end type

event clicked;String	ls_name, ls_type, ls_tag
string	ls_str 

ls_str = Lower(This.GetObjectAtPointer())
ls_str = Lower(Mid(ls_str, 1, Pos(ls_str, char(09)) - 1))

IF (Len(ls_str) = 0) or (Pos(ls_str, 'p_') <> 0) THEN
	return
END IF

IF ls_str = 't_favor' THEN
	OpenWithParm(w_sys_myfavor, This)
	return
END IF

IF (row = 0) or (row > this.RowCount()) THEN
	return
END IF

ls_name = This.GetItemString(Row, 'menuid')

IF ls_name = '' or isnull(ls_name) THEN RETURN

IF Isvalid(w_sys_main_frame) THEN
	w_sys_main_frame.of_select_function(ls_name)
END IF

end event

type dw_4 from datawindow within w_sys_main_bk
event ue_mousemove pbm_mousemove
integer x = 635
integer y = 376
integer width = 2683
integer height = 1212
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_sys_function"
boolean border = false
boolean livescroll = true
end type

event ue_mousemove;of_setfocusrow(this)
end event

event clicked;String	ls_menuid, ls_str 

ls_str = Lower(This.GetObjectAtPointer())
ls_str = Lower(Mid(ls_str, 1, Pos(ls_str, char(09)) - 1))

IF (Len(ls_str) = 0) or (Pos(ls_str, 'p_') <> 0)THEN
	return
END IF

IF (row = 0) or (row > this.RowCount()) THEN
	return
END IF

IF (Pos(ls_str, 'compute_') <> 0)THEN
	return
END IF

ls_menuid = This.GetItemString(Row, 'menu_id')

IF ls_menuid = '' or isnull(ls_menuid) THEN RETURN

IF Isvalid(w_sys_main_frame) THEN
	w_sys_main_frame.of_select_function(ls_menuid)
END IF



end event

type cbx_1 from checkbox within w_sys_main_bk
integer x = 3456
integer y = 364
integer width = 466
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = gb2312charset!
fontpitch fontpitch = variable!
string facename = "宋体"
long textcolor = 10789024
long backcolor = 16777215
string text = "系统导航器切换"
end type

event clicked;String		ls_str

Parent.SetRedraw(False)

dw_5.SetPosition(totop!,dw_4)
dw_3.SetPosition(totop!,dw_4)
cbx_1.SetPosition(totop!,dw_4)
dw_4.Visible = NOT This.Checked

IF This.Checked THEN
	ls_str = '1'
ELSE
	ls_str = '0'
	dw_4.SetPosition(behind!,dw_5)
END IF


Parent.SetRedraw(True)

SetProfileString(gVar.InitFile, "App_Env", "Navigator", ls_str)
end event

type ole_web from olecustomcontrol within w_sys_main_bk
event statustextchange ( string text )
event progresschange ( long progress,  long progressmax )
event commandstatechange ( long command,  boolean enable )
event downloadbegin ( )
event downloadcomplete ( )
event titlechange ( string text )
event propertychange ( string szproperty )
event beforenavigate2 ( oleobject pdisp,  any url,  any flags,  any targetframename,  any postdata,  any headers,  ref boolean cancel )
event newwindow2 ( ref oleobject ppdisp,  ref boolean cancel )
event navigatecomplete2 ( oleobject pdisp,  any url )
event documentcomplete ( oleobject pdisp,  any url )
event onquit ( )
event onvisible ( boolean ocx_visible )
event ontoolbar ( boolean toolbar )
event onmenubar ( boolean menubar )
event onstatusbar ( boolean statusbar )
event onfullscreen ( boolean fullscreen )
event ontheatermode ( boolean theatermode )
event windowsetresizable ( boolean resizable )
event windowsetleft ( long left )
event windowsettop ( long top )
event windowsetwidth ( long ocx_width )
event windowsetheight ( long ocx_height )
event windowclosing ( boolean ischildwindow,  ref boolean cancel )
event clienttohostwindow ( ref long cx,  ref long cy )
event setsecurelockicon ( long securelockicon )
event filedownload ( ref boolean cancel )
event navigateerror ( oleobject pdisp,  any url,  any frame,  any statuscode,  ref boolean cancel )
event printtemplateinstantiation ( oleobject pdisp )
event printtemplateteardown ( oleobject pdisp )
event updatepagestatus ( oleobject pdisp,  any npage,  any fdone )
event privacyimpactedstatechange ( boolean bimpacted )
integer x = 1376
integer y = 1732
integer width = 672
integer height = 256
integer taborder = 30
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_sys_main_bk.win"
string displayname = "思迅在线"
integer textsize = -9
integer weight = 400
fontcharset fontcharset = gb2312charset!
fontpitch fontpitch = variable!
string facename = "宋体"
long textcolor = 33554432
end type

type ole_winsock from olecustomcontrol within w_sys_main_bk
event ocx_error ( integer number,  string description,  long scode,  string source,  string helpfile,  long helpcontext,  boolean canceldisplay )
event dataarrival ( long bytestotal )
event ocx_connect ( )
event connectionrequest ( long requestid )
event ocx_close ( )
event sendprogress ( long bytessent,  long bytesremaining )
event sendcomplete ( )
integer x = 1001
integer y = 1820
integer width = 128
integer height = 112
integer taborder = 40
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_sys_main_bk.win"
integer binaryindex = 1
integer textsize = -9
integer weight = 400
fontcharset fontcharset = gb2312charset!
fontpitch fontpitch = variable!
string facename = "宋体"
long textcolor = 33554432
end type

event ocx_error(integer number, string description, long scode, string source, string helpfile, long helpcontext, boolean canceldisplay);this.object.close()
end event

event ocx_close();this.object.close()
end event

event error;if errornumber = 39 then
	return
else
end if
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Cw_sys_main_bk.bin 
2000000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000090d08d5001c9fa0f00000003000000c00000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe0000000000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000038856f96111d0340ac0006ba9a205d74f0000000090d08d5001c9fa0f90d08d5001c9fa0f000000000000000000000000004f00430054004e004e00450053005400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000009c000000000000000100000002fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
20ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000004c00000f310000069d0000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c04600000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000200028002000290072002000740065007200750073006e006c0020006e006f002000670070005b006d00620064005f007300650072007400630075006f0074005d0072006400000075006f006c0062006300650069006c006b00630064006500280020006900200074006e006700650072006500780020006f0070002c0073006900200074006e006700650072006500790020006f0070002c0073006c0020006e006f00200067006f0072002c007700640020006f0077006a00620063006500200074007700640020006f002000290072002000740065007200750073006e006c0020006e006f002000670070005b006d00620064005f006e00770062006c00740075006f00740064006e006c0062006c0063005d006b0020000000780028002000290038002800380039002900330032002000300030002d0037003000310031002d00200037003100310030003a003a00310030003391c7002000008d2d0000000000000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd00000004fffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000030000000000000000000000000000000000000000000000000000000090d08d5001c9fa0f00000003000000c00000000000500003004c004200430049004e0045004500530045004b000000590000000000000000000000000000000000000000000000000000000000000000000000000002001cffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000480000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000002001affffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe0000000000000000004200500043004f00530058004f0054
200041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000101001a000000020000000100000004248dd89611cfbb458000bc9a8db7e7c70000000090d08d5001c9fa0f90d08d5001c9fa0f00000000000000000000000000000001fffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006300320039003400380066003000300063002d00640032002d006400310031006600630039002d00640061002d0036003000300030003800370063003700650037006200640038000000000000004c0002140100000000000000c04600000000000080000000000000000000000000000000000000000000000000000000001234432100000008000002e5000002e5248dd892000600000000000000000000000000000000000000740065007200750073006e006c0020006e006f002000670070005b006d00620064005f007300650072007400630075006f0074005d0072006400000075006f006c0062006300650069006c006b00630064006500280020006900200074006e006700650072006500780020006f0070002c0073006900200074006e006700650072006500790020006f0070002c0073006c0020006e006f00200067006f0072002c007700640020006f0077006a00620063006500200074007700640020006f002000290072002000740065007200750073006e006c0020006e006f002000670070005b006d00620064005f006e00770062006c00740075006f00740064006e006c0062006c0063005d006b0020000000780028002000290038002800380039002900330032002000300030002d0037003000310031002d00200037003100310030003a003a00310030003391c7002000008d2d00000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000200000028000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Cw_sys_main_bk.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
