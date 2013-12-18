
/*创建数据库simple_jxc*/
use master
go
if exists(select * from sysdatabases where name like 'simple_jxc')
drop database simple_jxc
go
create database simple_jxc

go



/*使用新数据库创建表*/
use simple_jxc
go


/*操作员表*/
if exists(select *from sysobjects where name ='t_bd_operater_info')
drop table t_bd_operater_info
go
create table t_bd_operater_info
(
	oper_id char(20) not null primary key,
	oper_name varchar(20) not null,
	pwd  char(10) not null,
	oper_grant varchar(40) null,
	longin_status char(1) not null default(0),
	department_id char(8) null,
	branch_no char(8) not null default('ALL'),
	other1 varchar(50) null,    
	other2 varchar(50) null
)

go
/*商品信息表*/
if exists(select *from sysobjects where name ='t_bd_item_info')
drop table t_bd_item_info
go
CREATE TABLE t_bd_item_info (
	item_no char (20)   NOT NULL PRIMARY KEY,
	item_subno varchar (15)   NOT NULL DEFAULT ('0'),
	item_name varchar (40)   NOT NULL ,
	item_subname varchar (20)   NULL ,
	item_clsno char (12)   NOT NULL DEFAULT ('LB'),
	item_brand char (6)   NOT NULL  DEFAULT ('PP'),
	item_brandname char (6)   NOT NULL DEFAULT ('PM'),
	unit_no char (4)   NULL ,
	item_size varchar (20)   NULL ,
	product_area varchar (18)   NULL ,
	price numeric(16, 4) NOT NULL  DEFAULT (0),
	base_price numeric(16, 4) NOT NULL  DEFAULT (0),
	sale_price numeric(16, 4) NOT NULL  DEFAULT (0),
	status char (1)   NOT NULL   DEFAULT ('1'),
	main_supcust char (8)   NULL   DEFAULT ('0'),
	item_sup_flag char (1)   NULL   DEFAULT ('A'),
	item_stock char (1)   NULL   DEFAULT ('0'),
	build_date datetime NULL ,
	modify_date datetime NULL ,
	build_man char (30)   NULL
)

go

/*商品类别表*/
if exists(select *from sysobjects where name ='t_bd_item_cls')
drop table t_bd_item_cls
go
CREATE TABLE t_bd_item_cls (
	item_clsno char (12)   NOT NULL ,
	item_clsname varchar (20)   NOT NULL ,
	item_flag char (1)   NOT NULL DEFAULT ('0'),
	cls_parent char (6)   NULL ,
	display_flag char (1)   NOT NULL  DEFAULT ('1'),
	profit_rate numeric(6, 4) NULL  DEFAULT (0),
	comp_rate numeric(16, 4) NULL DEFAULT (0),
	trans_flag char (1)   NULL  DEFAULT ('0'),
	CONSTRAINT PK_T_BD_ITEM_CLS PRIMARY KEY  CLUSTERED 
	(
		item_clsno,
		item_flag
	) 
)
GO/*供应商信息表*/
if exists(select *from sysobjects where name ='t_bd_supcust_info')
drop table t_bd_supcust_info
goCREATE TABLE t_bd_supcust_info (
	supcust_no char (8)  NOT NULL PRIMARY KEY,
	supcust_flag char (1) NOT NULL ,
	sup_name varchar (60)  NOT NULL ,
	region_no char (8)  NULL ,
	sup_type char (4)  NULL ,
	sup_man varchar (18)  NULL ,
	sup_addr varchar (40)  NULL ,
	zip char (10)  NULL ,
	sup_email varchar (30)  NULL ,
	sup_tel varchar (18)  NULL ,
	display_flag char (1)  NULL DEFAULT ('1'),
	oper_id char (4)  NULL ,
	modify_date datetime NULL ,
	settle_branch varchar (4)  NULL  DEFAULT ('0'),
	com_flag char (1)  NULL  DEFAULT ('0'),
	mobile varchar (20)  NULL ,
	sup_ly_amt numeric(16, 4) NULL DEFAULT (0)
	
) 
go


/*采购单据信息主表*/
if exists(select *from sysobjects where name ='t_bd_supcust_info')
drop table t_bd_supcust_info
go
CREATE TABLE t_pm_sheet_master (
	sheet_no char (14)  NOT NULL ,
	trans_no char (2)  NULL ,
	db_no char (1)  NOT NULL ,
	branch_no char (6)  NOT NULL ,
	d_branch_no char (6)  NULL ,
	voucher_no char (14)  NULL ,
	supcust_no char (8)  NULL ,
	coin_no char (3)  NULL  DEFAULT ('RMB'),
	pay_way char (3)  NULL ,
	pay_date datetime NULL ,
	dept_flag char (1)  NULL ,
	approve_flag char (1)  NOT NULL ,
	oper_date datetime NULL ,
	work_date datetime NULL ,
	valid_date datetime NULL ,
	order_amt numeric(16, 4) NULL  DEFAULT (0),
	order_status char (1)  NULL ,
	order_man char (4)  NULL ,
	oper_id char (4)  NOT NULL ,
	confirm_man char (4)  NULL ,
	dept_id char (4)  NULL ,
	sale_way char (1)  NULL  DEFAULT ('A'),
	reverse_flag char (1)  NULL ,
	reverse_sheet char (14)  NULL ,
	direct_flag char (1)  NULL DEFAULT ('0'),
	trans_flag char (1)  NULL ,
	acct_flag char (1)  NULL ,
	other1 varchar (100)  NULL ,
	other2 varchar (20)  NULL ,
	other3 varchar (20)  NULL ,
	sheet_amt numeric(16, 4) NULL DEFAULT (0),
	branch_flag char (6)  NULL ,
	com_flag char (1)  NULL  DEFAULT ('0'),
	num1 numeric(16, 4) NULL DEFAULT (0),
	num2 numeric(16, 4) NULL  DEFAULT (0),
	relate_sheet_no char(20)  NULL ,
	CONSTRAINT PK_T_PM_SHEET_MASTER PRIMARY KEY  CLUSTERED 
	(
		sheet_no
	)  
)
GO



/*采购单据明细表*/
if exists(select *from sysobjects where name ='t_pm_sheet_detail')
drop table t_pm_sheet_detail
go
CREATE TABLE t_pm_sheet_detail (
	flow_id numeric(14, 0) IDENTITY (1, 1) NOT NULL ,
	sheet_no char (14)  NOT NULL ,
	item_no char (20)  NOT NULL ,
	order_qty numeric(16, 4) NULL  DEFAULT (0),
	real_qty numeric(16, 4) NULL  DEFAULT (0),
	large_qty numeric(16, 4) NULL  DEFAULT (0),
	orgi_price numeric(16, 4) NULL  DEFAULT (0),
	valid_price numeric(16, 4) NULL  DEFAULT (0),
	sub_amt numeric(16, 4) NULL  DEFAULT (0),
	tax numeric(5, 4) NULL ,
	valid_date datetime NULL ,
	other1 varchar (20)  NULL ,
	other2 varchar (20)  NULL ,
	other3 varchar (20)  NULL ,
	num1 numeric(16, 4) NULL  DEFAULT (0),
	num2 numeric(16, 4) NULL  DEFAULT (0),
	num3 numeric(16, 4) NULL  DEFAULT (0),
	discount decimal(6, 2) NOT NULL  DEFAULT (0),
	CONSTRAINT PK_T_PM_SHEET_DETAIL PRIMARY KEY  CLUSTERED 
	(
		flow_id,
		sheet_no,
		item_no
	)  
) 
GO


/*库存信息表*/
if exists(select *from sysobjects where name ='t_im_branch_stock')
drop table t_im_branch_stock
go
CREATE TABLE t_im_branch_stock (
	item_no char (20)  NOT NULL ,
	branch_no char (6)  NOT NULL ,
	stock_qty numeric(16, 4) NULL DEFAULT (0),
	route_qty numeric(16, 4) NULL DEFAULT (0),
	fifo_cost numeric(16, 4) NULL DEFAULT (0),
	avg_cost numeric(16, 4) NULL DEFAULT (0),
	cost_amt numeric(16, 4) NULL  DEFAULT (0),
	last_inprice numeric(16, 4) NULL  DEFAULT (0),
	last_baseprice numeric(16, 4) NULL DEFAULT (0),
	min_qty numeric(16, 4) NOT NULL  DEFAULT (0),
	max_qty numeric(16, 4) NOT NULL   DEFAULT (0),
	acc_qty decimal(16, 4) NULL ,
	oper_date datetime NULL ,
	com_flag char (1)  NULL  DEFAULT ('0'),
	CONSTRAINT PK_T_IM_BRANCH_STOCK PRIMARY KEY  CLUSTERED 
	(
		item_no,
		branch_no
	)  
) 
GO



/*出入库明细表*/
if exists(select *from sysobjects where name ='t_im_flow')
drop table t_im_flow
go
CREATE TABLE t_im_flow (
	flow_id numeric(14, 0) IDENTITY (1, 1) NOT NULL PRIMARY KEY ,
	voucher_no char (14)  NULL ,
	oper_date datetime NULL ,
	item_no char (20)  NOT NULL ,
	real_qty numeric(16, 4) NULL  DEFAULT (0),
	price numeric(16, 4) NULL  DEFAULT (0),
	cost_price numeric(16, 4) NULL  DEFAULT (0),
	sheet_amt numeric(16, 4) NULL  DEFAULT (0),
	branch_no char (6)  NULL ,
	d_branch_no char (6)  NULL ,
	trans_no char (2)  NULL ,
	db_no char (1)  NOT NULL  DEFAULT ('+'),
	supcust_no char (8)  NULL ,
	sale_way char (1)  NULL  DEFAULT ('A'),
	oper_id char (4)  NOT NULL ,
	pre_qnty numeric(16, 4) NULL  DEFAULT (0),
	valid_date datetime NULL ,
	acc_date datetime NULL ,
	memo varchar (255)  NULL ,
	other1 varchar (20)  NULL ,
	other2 varchar (20)  NULL ,
	num1 numeric(16, 4) NULL DEFAULT (0),
	num2 numeric(16, 4) NULL  DEFAULT (0),
	com_flag char (1)  NULL  DEFAULT ('0'),
	sup_ly_rate numeric(16, 4) NULL  DEFAULT (0),
	sup_ly_paid char (1)  NULL DEFAULT ('0'),
	flow_date datetime NULL  DEFAULT (getdate()),
	 
) 
GO




/*采购单据明细表*/
if exists(select *from sysobjects where name ='t_da_jxc_daysum')
drop table t_da_jxc_daysum
go
CREATE TABLE t_da_jxc_daysum (
	item_no char (20)  NOT NULL ,
	oper_date char (10)  NOT NULL ,
	branch_no char (6)  NOT NULL ,
	cost_price numeric(16, 4) NULL  DEFAULT (0),
	init_qty numeric(16, 4) NULL  DEFAULT (0),
	init_amt numeric(16, 4) NULL  DEFAULT (0),
	init_amt2 numeric(16, 4) NULL  DEFAULT (0),
	avg_cost_amt numeric(16, 4) NULL DEFAULT (0),
	avg_profit_amt numeric(16, 4) NULL  DEFAULT (0),
	fifo_cost_amt numeric(16, 4) NULL  DEFAULT (0),
	fifo_profit_amt numeric(16, 4) NULL DEFAULT (0),
	pi_qty numeric(16, 4) NULL  DEFAULT (0),
	pi_amt numeric(16, 4) NULL DEFAULT (0),
	so_qty numeric(16, 4) NULL DEFAULT (0),
	so_amt numeric(16, 4) NULL  DEFAULT (0),
	pos_qty numeric(16, 4) NULL  DEFAULT (0),
	pos_amt numeric(16, 4) NULL  DEFAULT (0),
	mi_qty numeric(16, 4) NULL DEFAULT (0),
	mi_amt numeric(16, 4) NULL  DEFAULT (0),
	mo_qty numeric(16, 4) NULL  DEFAULT (0),
	mo_amt numeric(16, 4) NULL  DEFAULT (0),
	oo_qty numeric(16, 4) NULL  DEFAULT (0),
	oo_amt numeric(16, 4) NULL  DEFAULT (0),
	oi_qty numeric(16, 4) NULL  DEFAULT (0),
	oi_amt numeric(16, 4) NULL  DEFAULT (0),
	settle_qty numeric(16, 4) NULL DEFAULT (0),
	settle_amt numeric(16, 4) NULL  DEFAULT (0),
	settle_amt2 numeric(16, 4) NULL  DEFAULT (0),
	num1 numeric(16, 4) NULL  DEFAULT (0),
	num2 numeric(16, 4) NULL  DEFAULT (0),
	num3 numeric(16, 4) NULL  DEFAULT (0),
	dx_flag char (1)  NULL  DEFAULT ('0'),
	flag char (1)  NOT NULL  DEFAULT ('0'),
	pos_dct_amt numeric(16, 4) NULL  DEFAULT (0),
	pos_zs_amt numeric(16, 4) NULL  DEFAULT (0),
	sup_in_price numeric(16, 4) NULL  DEFAULT (0),
	main_sup char (8)  NULL ,
	sup_ly_rate numeric(16, 4) NULL  DEFAULT (0),
	item_sup_flag char (1)  NULL ,
	so_price numeric(16, 4) NULL  DEFAULT (0),
	pos_price numeric(16, 4) NULL DEFAULT (0),
	com_flag char (1)  NULL   DEFAULT ('0'),
	CONSTRAINT PK_T_DA_JXC_DAYSUM PRIMARY KEY  CLUSTERED 
	(
		item_no,
		oper_date,
		branch_no
	)  
)
GO


