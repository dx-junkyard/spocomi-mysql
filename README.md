# spocomi-mysql


## 1. 操作方法
※前提としてDocker desctopのインストールが必要です。（https://www.docker.com/ から入手）

### 1. repositoryの取得
```
git clone https://github.com/dx-junkyard/spocomi-mysql.git
```
ディレクトリ移動
```
cd spocomi-mysql
```

### 2. docker-compose.ymlの修正
[L6のplatform部分の行](https://github.com/dx-junkyard/spocomi-mysql/blob/main/docker-compose.yml#L6) を削除するか、先頭に"#"をつけてコメントアウトしてください。（MacのM系プロセッサ用の記述のため）

### 3. mysqlのコンテナを起動
```
docker compose up
```
※起動が確認できたら```Ctrl + c```等で一旦止めて大丈夫です。続きはミーティングのときに一緒にやりましょう。

余裕があれば以下を試してみてください。

### 4. mysqlのコンテナをバックグラウンドで起動（3のステップでCtrl + cで止めた後）
```
docker compose up -d
```

### 5. mysqlのコンテナに入る
```
docker exec -it spocomi_mysql /bin/bash
```

### 6. mysqlに接続
```
mysql -h spocomi_mysql  -P 3306 -u root -p
```
※パスワードは root

### 7. spocomidbを操作対象に指定
```
use spocomidb;
```

### 8. SQLによる操作
#### 8-1. テーブル一覧の表示
```
show tables;
```
以下が表示されたらOK
```
mysql> show tables;
+-----------------------+
| Tables_in_spocomidb   |
+-----------------------+
| Communities           |
| CommunityConnections  |
| CommunityMembers      |
| EquipmentReservations |
| EquipmentTypes        |
| Equipments            |
| EventInvitations      |
| Events                |
| Facilities            |
| FacilityReservations  |
| FacilityTypes         |
| Places                |
| Roles                 |
| Templates             |
| UserSocialLinks       |
| Users                 |
+-----------------------+
16 rows in set (0.00 sec)
```

#### 8-2. テーブル定義の表示（例えば、Usersテーブルの定義を表示させるとき）
```
desc Users;
```

#### 8-3. Usersテーブルの特定の列を表示させる
```
select user_id, line_id from Users;
```

※以下は終了するときのコマンド

#### 9. DB接続を切る
```
quit;
```

#### 10. コンテナから抜ける
```
exit;
```

#### 11. コンテナを止める（コンテナIDの特定）
```
docker ps
```
※　IMAGEがmysql : 5.6 となっている CONTAINER IDを探す

#### 12. CONTAINER IDを指定して停止させる  ※()は不要
```
docker stop (CONTAINER ID)
```



## Tableリスト
Equipments : １つ１つの備品を管理する

EquipmentTypes : 備品の種類

EquipmentReservations : ボールなどの備品の予約管理を行うテーブル

Facilities : 施設名など各施設固有の情報を管理する

FacilityTypes : 体育館、運動場など施設タイプ

FacilityReservations : 体育館や運動場など施設の予約管理を行うテーブル

Places : 施設の場所

Communities : コミュニティ情報

CommunityConnections : コミュニティ間の親子関係など

CommunityMembers : コミュニティメンバー

Events : 舞台、試合、練習試合など、ある程度公開で行うスポーツイベント

EventInvitations : イベント招待

Roles : 権限管理

Users : ユーザー管理

UserSocialLinks : LINE IDとユーザーIDの関連付け

Templates : テンプレート管理


