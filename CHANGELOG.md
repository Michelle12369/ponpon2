##Q胖開發日誌
######Qoupon為累進式優惠卷與優惠卷分享平台。

*7/19前
	*社群＋coupon user多對多
---
*7/19
	*把coupon user改成一對多、完成comment_count、完成個人coupon列表

---
*7/20
	*加入gem cancan來幫助做權限管理(個人的coupon list還是會被看到）、promoter發送coupon(未完成計算折數部分）
---
*7/21、7/22
	*加入gem closure_tree做資料樹狀結構管理、計算折數完成、顯示coupon資料在頁面上
---
*7/28 
	*完成目前社群頁面ajax/ 發現line掃qrcode的時候只有真正的網址才能夠顯現，故須思考開發方式
---
*7/29
	*pusher在post處嘗試可以（但須改到comment處）
---
*8/10前+8/10
	*刻使用者社群頁面70%/刻使用者coupon列表80％/pusher改到comment但仍有問題（要改用rails 5的actionCable)/使用model繼承的方式實作後台（Admin)
	邏輯，目前後台controller已完成coupon、store、home，缺post等等社群的controller以及sign_in的page/想嘗試rspec（已安裝）但未成功/升級成rails 5 ruby 2.3.1/cancancan的權限管理是否使用有待商榷/所有erd的table都以完成（Coupon,User,Store,社群Post,Comment,Follow)

