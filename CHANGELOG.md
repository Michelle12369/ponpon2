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

8/20
- 完成post po文部分樣式
- comment若英文很長中間沒有空格還是會超出去

8/23 
- 刪除git上database.yml
- admindevelopment合併到master
- 開始寫admin bar

8/24
- 完成admin bar
- 開始load資料進admin
- admin store和coupon使用crop（單一頁面的js，production有可能出問題）

8/25
- 新增item的table
- admin::item controller中，有一些是require(:admin_item)，有些事require(:item)，不知道為什麼
- 店家資訊設定完成query

8/26
- 完成一半篩選優惠卷發放者

8/30
- 完成篩選優惠卷發放者

9/3
- 商家下篩選條件後能夠發放（不會發放到已經有優惠卷的使用者）

9/4
- 使用者發放優惠卷篩選朋友包含有追蹤自己和自己追蹤的人（沒有扣除已經有優惠卷的人）
- 新增優惠卷時增加最多發放幾張和初始優惠折數、店家收費方案（三種plan_a、plan_b、plan_c，搭配優惠卷給多少折扣）
- 店家方案搭配的折扣數還未完成

9/5
- 店家產生優惠卷(/store/:store_id/coupon/:coupon_id/take是顧客掃描店家qrcode後跳出的是否領取優惠卷頁面)
（/admin/stores/:store_id/coupons/:coupon_id/confirm是店家掃顧客的qrcode跳出的兌換頁)
- 使用者兌換優惠卷時不刪除本張優惠卷但更新狀態(且兌換後顧客兌換網頁消失）
- 店家兌換優惠卷的兌換按鈕出現條件(掃qrcode時：若使用者拿別人的優惠卷來：消掉沒關係、若拿過期或是已使用的優惠卷顯示已過期或已使用）(會redirect)
- 店家和顧客過期、已使用不可以再發放和兌換優惠卷（會redirect)
- 在cloud9上開手機測試，沒什麼問題

9/6
- 發送給誰的選項刪除包含發送給自己的人
- 若為店家優惠卷、已過期優惠卷、已兌換優惠卷不會更新折數、優惠折數達上限不可再增加折數（是寫條件在coupon.rb的calculate_discount)
- 店家發送張數上限不可以再增加，且有上下增加鍵
- 店家優惠卷若已達上限就不可以再給（顧客掃描＋線上給都不行）
- 顧客在線上或是掃qrcode已經領過店家給的優惠卷就會顯示不能再領取

9/7
- 開始製作admin post，完成post部分，comment和like和follow未完成

9/8
- 完成基本admin post，差post數據，感覺要加入show(通知跟分享貼文時要)

9/15
- 版面：商家申請帳號三頁（合約書、店家基本資料、審核）
- 版面：使用說明頁面（faq）v
- 版面：商家主頁設定編輯頁（店家資訊設定->店家主頁設定）

9/17 
- 版面：篩選推廣優惠卷（優惠券發放管理->發送）
- 版面：店家新增商品資訊 （店家資訊設定->商品資訊->新增）
- 版面：優惠券發送管理
- 前台搜尋功能
- 數據分析一半
- 社群數據分析一半

9/19
- user可以發摟store
- f.select可以load資料庫的選項為select
- load 貼文頁、粉絲頁、追蹤頁、喜愛店家頁資料、編輯個人檔案、註冊頁
- 版面：各種版面微調（把妝感轉換成線條）
- 版面：coupon/new 調整（QR code）
- 版面：搜尋的bar
- 版面：未登入首頁的footer。
- 版面：商店街的各個商店內頁的調整，目前條到一半，需找新的模板或重新設計。

9/24
- 版面：消費者端，編輯個人檔案/更改密碼/刪除密碼（參考ig）

10/10
- 版面：Q胖推薦、名人推薦頁面

10/12 >> 備審交出
- 版面：消費者端，店家頁面調整完成
- 版面：我的優惠券列表微調

10/16
- 版面：消費者端-個人頁面
- 版面：消費者端-搜尋結果
- 版面：消費者端完成九成

11/16
- 版面：404 422 500
- 版面：索取頁面
- 版面：店家頁面微調
- 版面：footer微調

11/22
- 版面：愛心調整
- 版面：加入標題

11/26
- 版面：優惠券介紹頁面
- 版面：rwd時的留言