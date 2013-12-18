select item_clsname from t_bd_item_cls where len(item_clsno)=2 and display_flag =1

select *from t_bd_item_cls

update  t_bd_item_cls set cls_parent = substring(item_clsno,1,len(item_clsno)-2) where len(item_clsno)>2

update  t_bd_item_cls set cls_parent = 0 where len(item_clsno) =2