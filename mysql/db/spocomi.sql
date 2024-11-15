-- MySQL Script generated by MySQL Workbench
-- Sat Aug 31 10:19:45 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema spocomidb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema spocomidb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `spocomidb` DEFAULT CHARACTER SET utf8 ;
USE `spocomidb` ;

-- -----------------------------------------------------
-- Table `spocomidb`.`Places`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spocomidb`.`Places` ;

CREATE TABLE IF NOT EXISTS `spocomidb`.`Places` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `location` GEOMETRY NULL,
  `address` VARCHAR(300) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spocomidb`.`EquipmentTypes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spocomidb`.`EquipmentTypes` ;

CREATE TABLE IF NOT EXISTS `spocomidb`.`EquipmentTypes` (
  `type_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `comment` VARCHAR(512) NULL,
  PRIMARY KEY (`type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spocomidb`.`Equipments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spocomidb`.`Equipments` ;

CREATE TABLE IF NOT EXISTS `spocomidb`.`Equipments` (
  `equipment_id` BIGINT NOT NULL AUTO_INCREMENT,
  `equipment_n` INT NOT NULL DEFAULT 1,
  `name` VARCHAR(100) NOT NULL,
  `owner_id` VARCHAR(64) NULL COMMENT 'このアイテムの所有者',
  `picture_path` VARCHAR(256) NULL,
  `status` INT NOT NULL DEFAULT 0,
  `comment` VARCHAR(500) NULL COMMENT '備品の状態などを記載',
  `equipment_type` INT NOT NULL,
  PRIMARY KEY (`equipment_id`),
  INDEX `Owners.owner_id_idx` (`owner_id` ASC),
  INDEX `EquipmentTypes.type_id_idx` (`equipment_type` ASC)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spocomidb`.`Events`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spocomidb`.`Events` ;

CREATE TABLE IF NOT EXISTS `spocomidb`.`Events` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `community_id` BIGINT NOT NULL,
  `owner_id` VARCHAR(64) NULL COMMENT 'このイベントを作成したユーザーID',
  `event_start` DATETIME NOT NULL,
  `event_end` DATETIME NOT NULL,
  `application_start` DATETIME NULL,
  `application_end` DATETIME NULL,
  `recruitment_message` VARCHAR(128) NULL,
  `description` VARCHAR(512) NULL,
  `place_id` BIGINT NULL,
  `visibility` INT NOT NULL DEFAULT 1 COMMENT '1: public event, 2: private use or team use',
  `status` INT NOT NULL DEFAULT 0 COMMENT '0 : 募集期間前, 1 : 募集期間中, 2 : 募集期間終了, 3: イベント期間中, 4 : イベント終了',
  PRIMARY KEY (`id`),
  INDEX `Events.place_id_idx` (`place_id` ASC)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spocomidb`.`EquipmentReservations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spocomidb`.`EquipmentReservations` ;

CREATE TABLE IF NOT EXISTS `spocomidb`.`EquipmentReservations` (
  `reservation_id` BIGINT NOT NULL AUTO_INCREMENT,
  `equipment_id` BIGINT NOT NULL,
  `event_id` BIGINT NOT NULL,
  `renter_id` VARCHAR(64) NOT NULL,
  `equipment_n` INT NOT NULL,
  `start_date` DATETIME NOT NULL,
  `end_date` DATETIME NOT NULL,
  `usage_date` DATETIME NOT NULL,
  `comment` VARCHAR(200) NULL,
  `status` INT NOT NULL DEFAULT 0 COMMENT '0 : 未利用、 1: 使用中,  2: 返却済',
  PRIMARY KEY (`reservation_id`),
  INDEX `EquipmentReservations.equipment_id_idx` (`equipment_id` ASC),
  INDEX `Events.event_id_idx` (`event_id` ASC)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spocomidb`.`FacilityTypes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spocomidb`.`FacilityTypes` ;

CREATE TABLE IF NOT EXISTS `spocomidb`.`FacilityTypes` (
  `type_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `comment` VARCHAR(512) NULL,
  PRIMARY KEY (`type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spocomidb`.`Facilities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spocomidb`.`Facilities` ;

CREATE TABLE IF NOT EXISTS `spocomidb`.`Facilities` (
  `facility_id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(90) NULL,
  `owner_id` VARCHAR(64) NULL,
  `picture_path` VARCHAR(256) NULL,
  `status` INT NULL,
  `comment` VARCHAR(512) NULL,
  `place_id` BIGINT NULL,
  `facility_type` INT NULL,
  PRIMARY KEY (`facility_id`),
  INDEX `Facilities.owner_id_idx` (`owner_id` ASC),
  INDEX `FacilityTypes.facility_type_idx` (`facility_type` ASC),
  INDEX `Facilities.place_id_idx` (`place_id` ASC)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spocomidb`.`FacilityReservations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spocomidb`.`FacilityReservations` ;

CREATE TABLE IF NOT EXISTS `spocomidb`.`FacilityReservations` (
  `reservation_id` BIGINT NOT NULL AUTO_INCREMENT,
  `facility_id` BIGINT NOT NULL,
  `renter_id` VARCHAR(64) NOT NULL,
  `event_id` BIGINT NOT NULL,
  `start_date` DATETIME NOT NULL,
  `end_date` DATETIME NOT NULL,
  `comment` VARCHAR(200) NULL,
  `status` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`reservation_id`),
  INDEX `FacilityReservations.facility_id_idx` (`facility_id` ASC),
  INDEX `Events.event_id_idx` (`event_id` ASC)
) ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `spocomidb`.`Users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spocomidb`.`Users` ;

CREATE TABLE IF NOT EXISTS `spocomidb`.`Users` (
  `user_id` VARCHAR(64) NOT NULL UNIQUE,
  `line_id` VARCHAR(64) NOT NULL UNIQUE,
  `password` VARCHAR(512) NULL,
  `name` VARCHAR(64) NOT NULL,
  `email` VARCHAR(256) NULL,
  `profile` VARCHAR(128) NULL,
  `status` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spocomidb`.`UserSocialLinks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spocomidb`.`UserSocialLinks` ;

CREATE TABLE IF NOT EXISTS `spocomidb`.`UserSocialLinks` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sns_user_id` VARCHAR(64) NOT NULL,
  `user_id` VARCHAR(64) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `sns_platform` VARCHAR(50) NULL,
  PRIMARY KEY (`id`),
  INDEX `SnsId.user_id_idx` (`user_id` ASC)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spocomidb`.`CommunityConnections`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spocomidb`.`CommunityConnections` ;

CREATE TABLE IF NOT EXISTS `spocomidb`.`CommunityConnections` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,       -- プライマリキーとして自動インクリメントの招待ID
    `parent_id` BIGINT UNSIGNED NOT NULL,               -- 親ID
    `child_id` BIGINT UNSIGNED NOT NULL,                -- 子ID
    `invitation_code` VARCHAR(255) NOT NULL UNIQUE,     -- 招待コード (ユニーク制約付き)
    `status` ENUM('INVITED', 'DECLINED', 'JOINED', 'LEFT') NOT NULL DEFAULT 'INVITED',
    `expiration_at` DATETIME NOT NULL,                  -- 招待コードの有効期限
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,   -- 招待が作成された日時
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- 更新日時
    PRIMARY KEY (id),                                   -- 招待IDをプライマリキーに設定
    INDEX idx_invitation_code (invitation_code),        -- 招待コードのインデックス
    INDEX idx_parent_id (parent_id),          -- 親idのインデックス
    INDEX idx_child_id (child_id),            -- 子idのインデックス
    INDEX idx_status_id (status)            -- statusのインデックス
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `spocomidb`.`EventInvitations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spocomidb`.`EventInvitations` ;

CREATE TABLE IF NOT EXISTS `spocomidb`.`EventInvitations` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,  -- プライマリキーとして自動インクリメントの招待ID
    `destination_id` BIGINT UNSIGNED NOT NULL,               -- 招待先のID (コミュニティID、イベントIDなど)
    `invitation_type` ENUM('community', 'event') NOT NULL,    -- 招待タイプ (コミュニティ or イベント)
    `remaining_uses` INT UNSIGNED NOT NULL DEFAULT 1,         -- 残り利用回数 (デフォルトは1回)
    `invitation_code` VARCHAR(255) NOT NULL UNIQUE,           -- 招待コード (ユニーク制約付き)
    `expiration_at` DATETIME NOT NULL,                               -- 招待コードの有効期限
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,         -- 招待が作成された日時
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- 更新日時
    PRIMARY KEY (id),                            -- 招待IDをプライマリキーに設定
    INDEX idx_invitation_code (invitation_code),            -- 招待コードのインデックス
    INDEX idx_destination_id (destination_id),              -- 招待先IDのインデックス
    INDEX idx_invitation_type (invitation_type)             -- 招待タイプのインデックス
) ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `spocomidb`.`Communities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spocomidb`.`Communities` ;

CREATE TABLE IF NOT EXISTS `spocomidb`.`Communities` (
  `id` BIGINT NOT NULL AUTO_INCREMENT, -- コミュニティID
  `owner_id` VARCHAR(64) NOT NULL, -- 代表者
  `place_id` BIGINT NULL,  -- 主な活動場所（拠点）
  `name` VARCHAR(128) NULL,  -- コミュニティ名
  `summary_image_url` VARCHAR(256) NULL, -- コミュニティリスト表示の際の写真
  `summary_message` VARCHAR(256) NULL, -- コミュニティリスト表示の際のよびかけ文章
  `summary_pr` VARCHAR(256) NULL,  -- コミュニティリスト表示の際の募集文
  `description` VARCHAR(1000) NULL, -- コミュニティの説明
  `member_count` INT NULL,  -- メンバー数
  `visibility` INT NULL,  -- コミュニティ情報開示範囲
  `profile_image_url` VARCHAR(256) NULL,  -- コミュニティのプロフィール写真
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- 作成日時
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  -- 更新日時
  `status` INT NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spocomidb`.`CommunityMembers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spocomidb`.`CommunityMembers` ;

CREATE TABLE IF NOT EXISTS `spocomidb`.`CommunityMembers` (
  `community_id` BIGINT NOT NULL,
  `user_id` VARCHAR(64) NOT NULL,
  `role_id` INT NULL,
  `status` INT NULL COMMENT '参加申し込み、仮入会、正式会員',
  `fav_flg` BOOLEAN NOT NULL DEFAULT 0, -- 0:初期値、1:
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `unique_community_user` (`community_id`, `user_id`)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spocomidb`.`Roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spocomidb`.`Roles` ;

CREATE TABLE IF NOT EXISTS `spocomidb`.`Roles` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `community_id` BIGINT NOT NULL,
  `role_name` VARCHAR(64) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `flg` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spocomidb`.`Templates`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `spocomidb`.`Templates` ;

CREATE TABLE IF NOT EXISTS `spocomidb`.`Templates` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `parent_template_id` BIGINT,
  `author_id` VARCHAR(100) NOT NULL,
  `title` VARCHAR(150) NULL,
  `description` VARCHAR(500) NULL,
  `template` VARCHAR(5000) NULL,
  `template_type` INT NULL,
  `version` INT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `visibility` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
