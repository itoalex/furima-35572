# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## usersテーブル
|Column              |Type   |Options                   |
|--------------------|-------|--------------------------|
|nickname            |string |null: false               |
|email               |string |null: false, unique: true |
|encrypted_password  |string |null: false               |
|real_name           |string |null: false               |
|birth_day           |integer|null: false               |

### Association
- has_many :items
- has_many :item_records

## itemsテーブル
|Column      |Type       |Options                        |
|------------|-----------|-------------------------------|
|item_name   |string     |null: false                    |
|describe    |text       |null: false                    |
|category_id |integer    |null: false                    |
|status_id   |integer    |null: false                    |
|ship_fee_id |integer    |null: false                    |
|area_id     |integer    |null: false                    |
|day_id      |integer    |null: false                    |
|price       |integer    |null: false                    |
|user        |references |null: false, foreign_keys: true|

### Association
- belongs_to :user
- has_one    :item_record

## item_recordsテーブル
|Column      |Type       |Options                         |
|------------|-----------|--------------------------------|
|user        |references |null: false, foreign_keys: true |
|item        |references |null: false, foreign_keys: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one    :ship_info

### ship_infos
|Column        |Type     |Options      |
|--------------|---------|-------------|
|post_code     |string   |null: false  |
|area_id       |integer  |null: false  |
|city          |string   |null: false  |
|house_number  |string   |null: false  |
|building      |string   |             |
|phone_number  |string   |null: false  |

### Association 
- belongs_to :item_record



