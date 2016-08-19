## Q胖開發日誌
##### Qoupon為累進式優惠卷與優惠卷分享平台。

7/19前
- 社群
- coupon user多對多

7/19
- 把coupon user改成一對多
- 完成comment_count
- 完成個人coupon列表

7/20
- 加入gem cancan來幫助做權限管理(個人的coupon list還是會被看到)
- promoter發送coupon(未完成計算折數部分）

7/21、7/22
- 加入gem closure_tree做資料樹狀結構管理
- 計算折數完成
- 顯示coupon資料在頁面上

7/28 
- 完成目前社群頁面ajax
- 發現line掃qrcode的時候只有真正的網址才能夠顯現，故須思考開發方式

7/29
- pusher在post處嘗試可以（但須改到comment處）

8/10前+8/10
- 刻使用者社群頁面70% 
- 刻使用者coupon列表80％
- pusher改到comment但仍有問題（要改用rails 5的actionCable)
- 使用model繼承的方式實作後台（Admin)
	邏輯，目前後台controller已完成coupon、store、home，缺post等等社群的controller以及sign_in的page
- 想嘗試rspec（已安裝）但未成功
- 升級成rails 5 ruby 2.3.1
- cancancan的權限管理是否使用有待商榷
- 所有erd的table都以完成（Coupon,User,Store,社群Post,Comment,Follow)

8/11
- 增加admin panel 登入連結，更改application_controller讓admin panel登入直接導向admin pages (還未完成登入後申請成為店家該如何導向頁面)
- 發現fb登入不能更新密碼

8/12
- 把admin 店家主頁設定、優惠卷發放設定的頁面裡，連結設定好，這兩頁對應的controller method也設定好

8/13
- user申請店家頁面功能寫好
- 增加store狀態（passed pending rejected)
- 登入後根據每個使用者和store不同狀態顯示連結
- 登入錯誤後各自（admin、user)重新導向回自己的登入頁

8/17
- 開始寫裁切功能（但js能成功顯現裁切卻無法依據裁切後存入）(https://rubyplus.com/articles/3951-Cropping-Images-using-jCrop-jQuery-plugin-in-Rails-5)
- 把db改為postgral db
- 完成店家聲請頁面之錯誤訊息顯現在同一頁（利用ajax顯現）

8/18
- 完成store 封面相片裁切功能（因為無法多張裁切，故只讓封面可以裁切）
- 大致完成store index頁面

8/19
- 完成bar樣式
- 完成devise樣式
- 修正部分post的樣式
- 利用helper 去寫admin-landing link的邏輯
