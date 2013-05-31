# ************************************************************
# Sequel Pro SQL dump
# Version 4004
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: localhost (MySQL 5.5.19)
# Database: test2
# Generation Time: 2013-02-13 15:36:39 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table admin_help_video
# ------------------------------------------------------------

DROP TABLE IF EXISTS `admin_help_video`;

CREATE TABLE `admin_help_video` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(150) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `vimeo_id` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table blog_category
# ------------------------------------------------------------

DROP TABLE IF EXISTS `blog_category`;

CREATE TABLE `blog_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(150) NOT NULL DEFAULT '',
  `label` varchar(150) NOT NULL DEFAULT '',
  `created` datetime NOT NULL,
  `created_by` int(11) unsigned DEFAULT NULL,
  `modified` datetime NOT NULL,
  `modified_by` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  KEY `modified_by` (`modified_by`),
  CONSTRAINT `blog_category_ibfk_2` FOREIGN KEY (`modified_by`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `blog_category_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table blog_post
# ------------------------------------------------------------

DROP TABLE IF EXISTS `blog_post`;

CREATE TABLE `blog_post` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `slug` varchar(150) NOT NULL DEFAULT '',
  `title` varchar(150) NOT NULL DEFAULT '',
  `excerpt` text NOT NULL,
  `body` longtext NOT NULL,
  `image` varchar(150) DEFAULT '',
  `seo_title` varchar(200) DEFAULT NULL,
  `seo_description` varchar(200) DEFAULT NULL,
  `seo_keywords` varchar(200) DEFAULT NULL,
  `created` datetime NOT NULL,
  `created_by` int(11) unsigned NOT NULL,
  `modified` datetime NOT NULL,
  `modified_by` int(11) unsigned NOT NULL,
  `is_published` tinyint(1) unsigned NOT NULL,
  `is_deleted` tinyint(1) unsigned NOT NULL,
  `published` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table blog_post_category
# ------------------------------------------------------------

DROP TABLE IF EXISTS `blog_post_category`;

CREATE TABLE `blog_post_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int(11) unsigned NOT NULL,
  `category_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `post_id` (`post_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `blog_post_category_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `blog_category` (`id`) ON DELETE CASCADE,
  CONSTRAINT `blog_post_category_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `blog_post` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table blog_post_tag
# ------------------------------------------------------------

DROP TABLE IF EXISTS `blog_post_tag`;

CREATE TABLE `blog_post_tag` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int(11) unsigned NOT NULL,
  `tag_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `post_id` (`post_id`),
  KEY `tag_id` (`tag_id`),
  CONSTRAINT `blog_post_tag_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `blog_tag` (`id`) ON DELETE CASCADE,
  CONSTRAINT `blog_post_tag_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `blog_post` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table blog_settings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `blog_settings`;

CREATE TABLE `blog_settings` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(50) DEFAULT NULL,
  `value` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `blog_settings` WRITE;
/*!40000 ALTER TABLE `blog_settings` DISABLE KEYS */;

INSERT INTO `blog_settings` (`id`, `key`, `value`)
VALUES
  (2,'blog_url','s:5:\"blog/\";'),
  (3,'sidebar_enabled','b:1;'),
  (4,'categories_enabled','b:1;'),
  (5,'tags_enabled','b:0;'),
  (6,'sidebar_position','s:5:\"right\";');

/*!40000 ALTER TABLE `blog_settings` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table blog_tag
# ------------------------------------------------------------

DROP TABLE IF EXISTS `blog_tag`;

CREATE TABLE `blog_tag` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(150) NOT NULL DEFAULT '',
  `label` varchar(150) NOT NULL DEFAULT '',
  `created` datetime NOT NULL,
  `created_by` int(11) unsigned DEFAULT NULL,
  `modified` datetime NOT NULL,
  `modified_by` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  KEY `modified_by` (`modified_by`),
  CONSTRAINT `blog_tag_ibfk_2` FOREIGN KEY (`modified_by`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `blog_tag_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




# Dump of table cdn_local_bucket
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cdn_local_bucket`;

CREATE TABLE `cdn_local_bucket` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(50) DEFAULT NULL,
  `allowed_types` varchar(300) DEFAULT NULL,
  `max_size` int(11) unsigned DEFAULT NULL,
  `user_id` int(11) unsigned DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `cdn_local_bucket_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cdn_local_bucket_tag
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cdn_local_bucket_tag`;

CREATE TABLE `cdn_local_bucket_tag` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `bucket_id` int(11) unsigned NOT NULL,
  `label` varchar(100) NOT NULL DEFAULT '',
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bucket_id` (`bucket_id`),
  CONSTRAINT `cdn_local_bucket_tag_ibfk_1` FOREIGN KEY (`bucket_id`) REFERENCES `cdn_local_bucket` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cdn_local_object
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cdn_local_object`;

CREATE TABLE `cdn_local_object` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `bucket_id` int(11) unsigned DEFAULT NULL,
  `user_id` int(11) unsigned DEFAULT NULL,
  `filename` varchar(50) NOT NULL DEFAULT '',
  `filename_display` varchar(100) NOT NULL DEFAULT '',
  `mime` varchar(50) DEFAULT NULL,
  `filesize` int(11) unsigned NOT NULL,
  `img_width` int(11) unsigned NOT NULL,
  `img_height` int(11) unsigned NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `serves` int(11) unsigned NOT NULL,
  `thumbs` int(11) unsigned NOT NULL,
  `scales` int(11) unsigned NOT NULL,
  `is_deleted` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bucket_id` (`bucket_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `cdn_local_object_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `cdn_local_object_ibfk_1` FOREIGN KEY (`bucket_id`) REFERENCES `cdn_local_bucket` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cdn_local_object_tag
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cdn_local_object_tag`;

CREATE TABLE `cdn_local_object_tag` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `object_id` int(11) unsigned NOT NULL,
  `tag_id` int(11) unsigned NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tag_id` (`tag_id`),
  KEY `object_id` (`object_id`),
  CONSTRAINT `cdn_local_object_tag_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `cdn_local_bucket_tag` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cdn_local_object_tag_ibfk_3` FOREIGN KEY (`object_id`) REFERENCES `cdn_local_object` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cms_block
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cms_block`;

CREATE TABLE `cms_block` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('plaintext','richtext','image','file','number','url') NOT NULL DEFAULT 'plaintext',
  `slug` varchar(50) NOT NULL DEFAULT '',
  `title` varchar(150) NOT NULL DEFAULT '',
  `description` varchar(500) NOT NULL DEFAULT '',
  `located` varchar(500) NOT NULL DEFAULT '',
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `created_by` int(11) unsigned DEFAULT NULL,
  `modified_by` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  KEY `slug` (`slug`),
  KEY `modified_by` (`modified_by`),
  CONSTRAINT `cms_block_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `cms_block_ibfk_2` FOREIGN KEY (`modified_by`) REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cms_block_translation
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cms_block_translation`;

CREATE TABLE `cms_block_translation` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `block_id` int(11) unsigned NOT NULL,
  `lang_id` int(11) unsigned NOT NULL DEFAULT '202',
  `value` text NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `created_by` int(11) unsigned DEFAULT NULL,
  `modified_by` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `block_id` (`block_id`),
  KEY `lang_id` (`lang_id`),
  KEY `created_by` (`created_by`),
  KEY `modified_by` (`modified_by`),
  CONSTRAINT `cms_block_translation_ibfk_1` FOREIGN KEY (`block_id`) REFERENCES `cms_block` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_block_translation_ibfk_2` FOREIGN KEY (`lang_id`) REFERENCES `language` (`id`),
  CONSTRAINT `cms_block_translation_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `cms_block_translation_ibfk_4` FOREIGN KEY (`modified_by`) REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cms_block_translation_revision
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cms_block_translation_revision`;

CREATE TABLE `cms_block_translation_revision` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `block_translation_id` int(11) unsigned NOT NULL,
  `value` text NOT NULL,
  `created_by` int(11) unsigned DEFAULT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  KEY `block_translation_id` (`block_translation_id`),
  CONSTRAINT `cms_block_translation_revision_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `cms_block_translation_revision_ibfk_3` FOREIGN KEY (`block_translation_id`) REFERENCES `cms_block_translation` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cms_page
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cms_page`;

CREATE TABLE `cms_page` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) NOT NULL DEFAULT '',
  `layout` enum('hero-sidebar-left','hero-sidebar-right','hero-full-width','no-hero-sidebar-left','no-hero-sidebar-right','no-hero-full-width') NOT NULL DEFAULT 'hero-sidebar-left',
  `sidebar_width` tinyint(1) unsigned NOT NULL,
  `title` varchar(255) NOT NULL DEFAULT '',
  `seo_description` varchar(300) DEFAULT NULL,
  `seo_keywords` varchar(150) DEFAULT NULL,
  `is_deleted` tinyint(1) unsigned NOT NULL,
  `created` datetime NOT NULL,
  `created_by` int(11) unsigned DEFAULT NULL,
  `modified` datetime NOT NULL,
  `modified_by` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  KEY `modified_by` (`modified_by`),
  CONSTRAINT `cms_page_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `cms_page_ibfk_2` FOREIGN KEY (`modified_by`) REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cms_page_widget
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cms_page_widget`;

CREATE TABLE `cms_page_widget` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `page_id` int(11) unsigned NOT NULL,
  `order` int(11) unsigned NOT NULL,
  `widget_class` varchar(100) NOT NULL DEFAULT '',
  `widget_area` enum('hero','body','sidebar') NOT NULL DEFAULT 'body',
  `widget_data` longtext NOT NULL,
  `created` datetime NOT NULL,
  `created_by` int(11) unsigned DEFAULT NULL,
  `modified` datetime NOT NULL,
  `modified_by` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `page_id` (`page_id`),
  KEY `created_by` (`created_by`),
  KEY `modified_by` (`modified_by`),
  CONSTRAINT `cms_page_widget_ibfk_1` FOREIGN KEY (`page_id`) REFERENCES `cms_page` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_page_widget_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `cms_page_widget_ibfk_3` FOREIGN KEY (`modified_by`) REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table date_format_date
# ------------------------------------------------------------

DROP TABLE IF EXISTS `date_format_date`;

CREATE TABLE `date_format_date` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(40) NOT NULL DEFAULT '',
  `format` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `date_format_date` WRITE;
/*!40000 ALTER TABLE `date_format_date` DISABLE KEYS */;

INSERT INTO `date_format_date` (`id`, `label`, `format`)
VALUES
	(1, 'DD/MM/YYYY', 'd/m/Y'),
	(2, 'DD/MM/YY', 'd/m/y'),
	(3, 'MM/DD/YYYY', 'm/d/Y'),
	(4, 'MM/DD/YYYY', 'm/d/y'),
	(5, 'DD-MM-YYYY', 'd-m-Y'),
	(6, 'DD-MM-YY', 'd-m-y'),
	(7, 'MM-DD-YYYY', 'm-d-Y'),
	(8, 'MM-DD-YY', 'm-d-y');

/*!40000 ALTER TABLE `date_format_date` ENABLE KEYS */;
UNLOCK TABLES;



# Dump of table date_format_time
# ------------------------------------------------------------

DROP TABLE IF EXISTS `date_format_time`;

CREATE TABLE `date_format_time` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(40) NOT NULL DEFAULT '',
  `format` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `date_format_time` WRITE;
/*!40000 ALTER TABLE `date_format_time` DISABLE KEYS */;

INSERT INTO `date_format_time` (`id`, `label`, `format`)
VALUES
	(1, '24 Hour', 'H:i:s'),
	(2, '12 Hour', 'g:i:s A');

/*!40000 ALTER TABLE `date_format_time` ENABLE KEYS */;
UNLOCK TABLES;



# Dump of table email_queue
# ------------------------------------------------------------

DROP TABLE IF EXISTS `email_queue`;

CREATE TABLE `email_queue` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ref` varchar(10) DEFAULT NULL,
  `user_id` int(11) unsigned DEFAULT NULL,
  `user_email` varchar(150) DEFAULT NULL,
  `time_queued` datetime NOT NULL,
  `type_id` int(11) unsigned NOT NULL,
  `email_vars` longtext,
  `internal_ref` int(11) unsigned DEFAULT NULL,
  `queue_id` bigint(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `type_id` (`type_id`),
  KEY `user_id` (`user_id`),
  KEY `type_id_2` (`type_id`,`internal_ref`),
  CONSTRAINT `email_queue_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `email_queue_type` (`id`) ON DELETE CASCADE,
  CONSTRAINT `email_queue_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table email_queue_archive
# ------------------------------------------------------------

DROP TABLE IF EXISTS `email_queue_archive`;

CREATE TABLE `email_queue_archive` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ref` varchar(10) DEFAULT NULL,
  `user_id` int(11) unsigned DEFAULT NULL,
  `user_email` varchar(150) DEFAULT NULL,
  `time_queued` datetime NOT NULL,
  `time_sent` datetime NOT NULL,
  `type_id` int(11) unsigned NOT NULL,
  `email_vars` longtext,
  `internal_ref` int(11) unsigned DEFAULT NULL,
  `read_count` tinyint(3) unsigned NOT NULL,
  `link_click_count` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type_id` (`type_id`),
  KEY `user_id` (`user_id`),
  KEY `type_id_2` (`type_id`,`internal_ref`),
  CONSTRAINT `email_queue_archive_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `email_queue_type` (`id`) ON DELETE CASCADE,
  CONSTRAINT `email_queue_archive_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table email_queue_link
# ------------------------------------------------------------

DROP TABLE IF EXISTS `email_queue_link`;

CREATE TABLE `email_queue_link` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `email_id` int(11) unsigned NOT NULL,
  `url` varchar(300) NOT NULL DEFAULT '',
  `title` varchar(255) DEFAULT NULL,
  `created` datetime NOT NULL,
  `is_html` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `email_id` (`email_id`),
  CONSTRAINT `email_queue_link_ibfk_1` FOREIGN KEY (`email_id`) REFERENCES `email_queue_archive` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table email_queue_track_link
# ------------------------------------------------------------

DROP TABLE IF EXISTS `email_queue_track_link`;

CREATE TABLE `email_queue_track_link` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `email_id` int(11) unsigned NOT NULL,
  `link_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned DEFAULT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `email_id` (`email_id`),
  KEY `link_id` (`link_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `email_queue_track_link_ibfk_1` FOREIGN KEY (`email_id`) REFERENCES `email_queue_archive` (`id`) ON DELETE CASCADE,
  CONSTRAINT `email_queue_track_link_ibfk_2` FOREIGN KEY (`link_id`) REFERENCES `email_queue_link` (`id`) ON DELETE CASCADE,
  CONSTRAINT `email_queue_track_link_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table email_queue_track_open
# ------------------------------------------------------------

DROP TABLE IF EXISTS `email_queue_track_open`;

CREATE TABLE `email_queue_track_open` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `email_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned DEFAULT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `email_id` (`email_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `email_queue_track_open_ibfk_1` FOREIGN KEY (`email_id`) REFERENCES `email_queue_archive` (`id`) ON DELETE CASCADE,
  CONSTRAINT `email_queue_track_open_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table email_queue_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `email_queue_type`;

CREATE TABLE `email_queue_type` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_string` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '',
  `cron_run` enum('instant','prompt','hourly','daily','weekly-sun','weekly-mon','weekly-tue','weekly-wed','weekly-thur','weekly-fri','weekly-sat','fortnightly','monthly') NOT NULL DEFAULT 'instant',
  `type` enum('service_acct') NOT NULL DEFAULT 'service_acct',
  `description` text,
  `template_file` varchar(150) NOT NULL,
  `subject` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_string` (`id_string`),
  KEY `id_string_2` (`id_string`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `email_queue_type` WRITE;
/*!40000 ALTER TABLE `email_queue_type` DISABLE KEYS */;

INSERT INTO `email_queue_type` (`id`, `id_string`, `name`, `cron_run`, `type`, `description`, `template_file`, `subject`)
VALUES
	(1, 'test_email', 'Test Email - instant', 'instant', 'service_acct', 'Test email template, normally used in admin to test if recipients can receive email sent by the system', 'utilities/test_email', 'Test Email'),
	(2, 'verify_email', 'Verify Email, generic - instant', 'instant', 'service_acct', 'Email sent with a verification code', 'auth/verify_email', 'Welcome'),
	(3, 'register_fb', 'Welcome Email, Facebook - instant', 'instant', 'service_acct', 'Welcome email sent when a user registers using Facebook', 'auth/welcome_email_fb', 'Welcome'),
	(4, 'register_tw', 'Welcome/Verify Email, Twitter - instant', 'instant', 'service_acct', 'Welcome email sent with a verification code for users who register using Twitter', 'auth/welcome_email_tw', 'Welcome'),
	(5, 'register_li', 'Welcome/Verify Email, LinkedIn - instant', 'instant', 'service_acct', 'Welcome email sent with a verification code for users who register using LinkedIn', 'auth/welcome_email_li', 'Welcome'),
	(6, 'forgotten_password', 'Forgotten Password - instant', 'instant', 'service_acct', 'Email which is sent when a user requests a password reset.', 'auth/forgotten_password', 'Reset your Password');

/*!40000 ALTER TABLE `email_queue_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table event
# ------------------------------------------------------------

DROP TABLE IF EXISTS `event`;

CREATE TABLE `event` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type_id` int(11) unsigned DEFAULT NULL,
  `created_by` int(11) unsigned DEFAULT NULL,
  `vars` text,
  `ref` int(11) unsigned DEFAULT NULL,
  `created` datetime NOT NULL,
  `level` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  KEY `type` (`type_id`),
  KEY `type_2` (`type_id`,`created_by`),
  CONSTRAINT `event_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `event_ibfk_3` FOREIGN KEY (`type_id`) REFERENCES `event_type` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table event_interested_party
# ------------------------------------------------------------

DROP TABLE IF EXISTS `event_interested_party`;

CREATE TABLE `event_interested_party` (
  `event_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `is_read` tinyint(1) unsigned NOT NULL,
  KEY `event_id` (`event_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `event_interested_party_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`) ON DELETE CASCADE,
  CONSTRAINT `event_interested_party_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table event_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `event_type`;

CREATE TABLE `event_type` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_string` varchar(30) NOT NULL DEFAULT '',
  `name` varchar(100) NOT NULL DEFAULT '',
  `description` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `event_type` WRITE;
/*!40000 ALTER TABLE `event_type` DISABLE KEYS */;

INSERT INTO `event_type` (`id`, `id_string`, `name`, `description`)
VALUES
	(1,'did_register','User Registered','Fired when a user registers'),
	(2,'did_log_in','User logged in','Fired when a user logs in'),
	(3,'did_log_out','User Logged out','Fired when a user logs out'),
	(4,'did_link_fb','User linked Facebook to their account','Fired when a user links their Facebook account'),
	(5,'did_unlink_fb','User unlinked Facebook from their account','Fired when a user unlinks Facebook  from their account'),
	(6,'did_link_tw','User linked Twitter to their account','Fired when a user links their Twitter account'),
	(7,'did_unlink_tw','User unlinked Twitter from their account','Fired when a user unlinks Twitter  from their account'),
	(8,'did_link_li','User linked LinkedIn to their account','Fired when a user links their LinkedIn account'),
	(9,'did_unlink_li','User unlinked LinkedIn from their account','Fired when a user unlinks LinkedIn  from their account');

/*!40000 ALTER TABLE `event_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table language
# ------------------------------------------------------------

DROP TABLE IF EXISTS `language`;

CREATE TABLE `language` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `safe_name` varchar(50) DEFAULT NULL,
  `priority` tinyint(1) unsigned DEFAULT NULL,
  `supported` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `language` WRITE;
/*!40000 ALTER TABLE `language` DISABLE KEYS */;

INSERT INTO `language` (`id`, `name`, `safe_name`, `priority`, `supported`)
VALUES
	(1,'\'Are\'are','areare',NULL,0),
	(2,'\'Auhelawa','auhelawa',NULL,0),
	(3,'A\'Tong','atong',NULL,0),
	(4,'Aari','aari',NULL,0),
	(5,'Aariya','aariya',NULL,0),
	(6,'Aasáx','aasax',NULL,0),
	(7,'Abanyom','abanyom',NULL,0),
	(8,'Abaza','abaza',NULL,0),
	(9,'Abenaki','abenaki',NULL,0),
	(10,'Abkhaz or Abkhazian','abkhaz_or_abkhazian',NULL,0),
	(11,'Abujmaria','abujmaria',NULL,0),
	(12,'Acehnese','acehnese',NULL,0),
	(13,'Adamorobe Sign Language','adamorobe_sign_language',NULL,0),
	(14,'Adele','adele',NULL,0),
	(15,'Adyghe','adyghe',NULL,0),
	(16,'Afar','afar',NULL,0),
	(17,'Afrikaans','afrikaans',NULL,0),
	(18,'Afro-Seminole Creole','afroseminole_creole',NULL,0),
	(19,'Aimaq or Barbari','aimaq_or_barbari',NULL,0),
	(20,'Aini','aini',NULL,0),
	(21,'Ainu','ainu',NULL,0),
	(22,'Akan','akan',NULL,0),
	(23,'Akawaio','akawaio',NULL,0),
	(24,'Akkadian','akkadian',NULL,0),
	(25,'Aklanon','aklanon',NULL,0),
	(26,'Albanian','albanian',NULL,0),
	(27,'Aleut','aleut',NULL,0),
	(28,'Algonquin','algonquin',NULL,0),
	(29,'Alsatian','alsatian',NULL,0),
	(30,'Altay','altay',NULL,0),
	(31,'Alutor','alutor',NULL,0),
	(32,'American Sign Language','american_sign_language',NULL,0),
	(33,'Amharic','amharic',NULL,0),
	(34,'Amorite','amorite',NULL,0),
	(35,'Anda','anda',NULL,0),
	(36,'Amdang','amdang',NULL,0),
	(37,'Ammonite','ammonite',NULL,0),
	(38,'Angika','angika',NULL,0),
	(39,'Anyin','anyin',NULL,0),
	(40,'Ao','ao',NULL,0),
	(41,'A-Pucikwar','apucikwar',NULL,0),
	(42,'Arabic','arabic',NULL,0),
	(43,'Aragonese','aragonese',NULL,0),
	(44,'Aramaic','aramaic',NULL,0),
	(45,'Are','are',NULL,0),
	(46,'Argobba','argobba',NULL,0),
	(47,'Aromanian or Macedo-Romanian','aromanian_or_macedoromanian',NULL,0),
	(48,'Armenian','armenian',NULL,0),
	(49,'Arvanitic','arvanitic',NULL,0),
	(50,'Ashkun','ashkun',NULL,0),
	(51,'Assamese','assamese',NULL,0),
	(52,'Assyrian Neo-Aramaic','assyrian_neoaramaic',NULL,0),
	(53,'Ateso or Teso','ateso_or_teso',NULL,0),
	(54,'Asi','asi',NULL,0),
	(55,'Asturian','asturian',NULL,0),
	(56,'Auslan','auslan',NULL,0),
	(57,'Austro-Bavarian','austrobavarian',NULL,0),
	(58,'Avar','avar',NULL,0),
	(59,'Avestan','avestan',NULL,0),
	(60,'Awadhi','awadhi',NULL,0),
	(61,'Aymara','aymara',NULL,0),
	(62,'Azerbaijani','azerbaijani',NULL,0),
	(63,'Badaga','badaga',NULL,0),
	(64,'Badeshi','badeshi',NULL,0),
	(65,'Bahnar','bahnar',NULL,0),
	(66,'Balinese','balinese',NULL,0),
	(67,'Balochi','balochi',NULL,0),
	(68,'Balti','balti',NULL,0),
	(69,'Bambara or Bamanankan','bambara_or_bamanankan',NULL,0),
	(70,'Banjar','banjar',NULL,0),
	(71,'Banyumasan','banyumasan',NULL,0),
	(72,'Basaa','basaa',NULL,0),
	(73,'Bashkir','bashkir',NULL,0),
	(74,'Basque','basque',NULL,0),
	(75,'Batak Karo','batak_karo',NULL,0),
	(76,'Batak Toba','batak_toba',NULL,0),
	(77,'Bats','bats',NULL,0),
	(78,'Beja','beja',NULL,0),
	(79,'Belarusian','belarusian',NULL,0),
	(80,'Belhare','belhare',NULL,0),
	(81,'Berta','berta',NULL,0),
	(82,'Bemba','bemba',NULL,0),
	(83,'Bengali','bengali',NULL,0),
	(84,'Bezhta','bezhta',NULL,0),
	(85,'Beothuk','beothuk',NULL,0),
	(86,'Berber','berber',NULL,0),
	(87,'Betawi','betawi',NULL,0),
	(88,'Bete','bete',NULL,0),
	(89,'Bété','bete',NULL,0),
	(90,'Bhili','bhili',NULL,0),
	(91,'Bhojpuri','bhojpuri',NULL,0),
	(92,'Bijil Neo-Aramaic','bijil_neoaramaic',NULL,0),
	(93,'Bikol','bikol',NULL,0),
	(94,'Bikya or Furu','bikya_or_furu',NULL,0),
	(95,'Bissa','bissa',NULL,0),
	(96,'Blackfoot','blackfoot',NULL,0),
	(97,'Boholano','boholano',NULL,0),
	(98,'Bohtan Neo-Aramaic','bohtan_neoaramaic',NULL,0),
	(99,'Bolgar','bolgar',NULL,0),
	(100,'Bonan or Paoan','bonan_or_paoan',NULL,0),
	(101,'Bororo','bororo',NULL,0),
	(102,'Bosnian','bosnian',NULL,0),
	(103,'Brahui','brahui',NULL,0),
	(104,'Breton','breton',NULL,0),
	(105,'British Sign Language','british_sign_language',NULL,0),
	(106,'Bua','bua',NULL,0),
	(107,'Buginese','buginese',NULL,0),
	(108,'Bukusu','bukusu',NULL,0),
	(109,'Bulgarian','bulgarian',NULL,0),
	(110,'Bunjevac','bunjevac',NULL,0),
	(111,'Burmese','burmese',NULL,0),
	(112,'Burushaski','burushaski',NULL,0),
	(113,'Buryat','buryat',NULL,0),
	(114,'Caluyanon or Caluyanun','caluyanon_or_caluyanun',NULL,0),
	(115,'Camunic','camunic',NULL,0),
	(116,'Cantonese','cantonese',NULL,0),
	(117,'Carian','carian',NULL,0),
	(118,'Catawba','catawba',NULL,0),
	(119,'Catalan','catalan',NULL,0),
	(120,'Cayuga','cayuga',NULL,0),
	(121,'Cebuano','cebuano',NULL,0),
	(122,'Chabacano or Chavacano','chabacano_or_chavacano',NULL,0),
	(123,'Chaga or Kichagga','chaga_or_kichagga',NULL,0),
	(124,'Chagatai','chagatai',NULL,0),
	(125,'Chakma','chakma',NULL,0),
	(126,'Chaldean Neo-Aramaic','chaldean_neoaramaic',NULL,0),
	(127,'Chamorro','chamorro',NULL,0),
	(128,'Chaouia or Tachawit','chaouia_or_tachawit',NULL,0),
	(129,'Chechen','chechen',NULL,0),
	(130,'Chemakum','chemakum',NULL,0),
	(131,'Chenchu','chenchu',NULL,0),
	(132,'Chenoua','chenoua',NULL,0),
	(133,'Cherokee','cherokee',NULL,0),
	(134,'Cheyenne','cheyenne',NULL,0),
	(135,'Chhattisgarhi','chhattisgarhi',NULL,0),
	(136,'Chickasaw','chickasaw',NULL,0),
	(137,'Chintang or Chhintang','chintang_or_chhintang',NULL,0),
	(138,'Chilcotin','chilcotin',NULL,0),
	(139,'Chinese','chinese',6,0),
	(140,'Chiricahua or Mescalero-Chiricahua Apache','chiricahua_or_mescalerochiricahua_apache',NULL,0),
	(141,'Chichewa or Nyanja','chichewa_or_nyanja',NULL,0),
	(142,'Chipewyan','chipewyan',NULL,0),
	(143,'Chittagonian','chittagonian',NULL,0),
	(144,'Choctaw','choctaw',NULL,0),
	(145,'Chorasmian or Khwarezmian','chorasmian_or_khwarezmian',NULL,0),
	(146,'Chukchi or Chukot','chukchi_or_chukot',NULL,0),
	(147,'Chulym','chulym',NULL,0),
	(148,'Church Slavonic','church_slavonic',NULL,0),
	(149,'Chuukese or Trukese','chuukese_or_trukese',NULL,0),
	(150,'Chuvash','chuvash',NULL,0),
	(151,'Cocoma or Cocama','cocoma_or_cocama',NULL,0),
	(152,'Cocopa','cocopa',NULL,0),
	(153,'Coeur d’Alene','coeur_dalene',NULL,0),
	(154,'Comanche','comanche',NULL,0),
	(155,'Comorian','comorian',NULL,0),
	(156,'Coptic','coptic',NULL,0),
	(157,'Cornish','cornish',NULL,0),
	(158,'Corsican','corsican',NULL,0),
	(159,'Cree','cree',NULL,0),
	(160,'Crimean Tatar or Crimean Turkish','crimean_tatar_or_crimean_turkish',NULL,0),
	(161,'Croatian','croatian',NULL,0),
	(162,'Cuman','cuman',NULL,0),
	(163,'Cumbric','cumbric',NULL,0),
	(164,'Curonian','curonian',NULL,0),
	(165,'Cuyonon','cuyonon',NULL,0),
	(166,'Czech','czech',NULL,0),
	(167,'Dacian','dacian',NULL,0),
	(168,'Dagbani','dagbani',NULL,0),
	(169,'Dahlik','dahlik',NULL,0),
	(170,'Dalecarlian','dalecarlian',NULL,0),
	(171,'Dalmatian','dalmatian',NULL,0),
	(172,'Dameli','dameli',NULL,0),
	(173,'Danish','danish',NULL,0),
	(174,'Dargin','dargin',NULL,0),
	(175,'Dari','dari',NULL,0),
	(176,'Dari-Persian','daripersian',NULL,0),
	(177,'Darkhat','darkhat',NULL,0),
	(178,'Daur or Dagur','daur_or_dagur',NULL,0),
	(179,'Dena\'ina or Tanaina','denaina_or_tanaina',NULL,0),
	(180,'Dhatki','dhatki',NULL,0),
	(181,'Dhivehi or Maldivian','dhivehi_or_maldivian',NULL,0),
	(182,'Dida','dida',NULL,0),
	(183,'Dioula or Jula','dioula_or_jula',NULL,0),
	(184,'Dogri','dogri',NULL,0),
	(185,'Dogrib or Tli Cho','dogrib_or_tli_cho',NULL,0),
	(186,'Dolgan','dolgan',NULL,0),
	(187,'Domaaki or Dumaki','domaaki_or_dumaki',NULL,0),
	(188,'Dongxiang or Santa','dongxiang_or_santa',NULL,0),
	(189,'Duala','duala',NULL,0),
	(190,'Dungan','dungan',NULL,0),
	(191,'Dutch','dutch',NULL,0),
	(192,'Dzhidi or Judeo-Persian','dzhidi_or_judeopersian',NULL,0),
	(193,'Dzongkha','dzongkha',NULL,0),
	(194,'Eastern Yugur','eastern_yugur',NULL,0),
	(195,'Eblaite','eblaite',NULL,0),
	(196,'Edomite','edomite',NULL,0),
	(197,'Egyptian','egyptian',NULL,0),
	(198,'Egyptian Arabic','egyptian_arabic',NULL,0),
	(199,'Ekoti','ekoti',NULL,0),
	(200,'Elamite','elamite',NULL,0),
	(201,'Enets or Yenisey Samoyed','enets_or_yenisey_samoyed',NULL,0),
	(202,'English','english',1,1),
	(203,'Erzya','erzya',NULL,0),
	(204,'Esperanto','esperanto',NULL,0),
	(205,'Estonian','estonian',NULL,0),
	(206,'Etruscan','etruscan',NULL,0),
	(207,'Even','even',NULL,0),
	(208,'Evenk or Evenki','evenk_or_evenki',NULL,0),
	(209,'Ewe','ewe',NULL,0),
	(210,'Eyak','eyak',NULL,0),
	(211,'Faeroese','faeroese',NULL,0),
	(212,'Fang','fang',NULL,0),
	(213,'Fijian','fijian',NULL,0),
	(214,'Filipino','filipino',NULL,0),
	(215,'Finnish','finnish',NULL,0),
	(216,'Finnish Sign Language','finnish_sign_language',NULL,0),
	(217,'Flemish language','flemish_language',NULL,0),
	(218,'Fon','fon',NULL,0),
	(219,'Franco-Provençal or Arpitan','francoprovencal_or_arpitan',NULL,0),
	(220,'French','french',2,0),
	(221,'French Sign Language','french_sign_language',NULL,0),
	(222,'Frisian, North','frisian_north',NULL,0),
	(223,'Frisian, Saterland','frisian_saterland',NULL,0),
	(224,'Frisian, West','frisian_west',NULL,0),
	(225,'Friulian','friulian',NULL,0),
	(226,'Fula or Fulfulde or Fulani','fula_or_fulfulde_or_fulani',NULL,0),
	(227,'Fur','fur',NULL,0),
	(228,'Ga','ga',NULL,0),
	(229,'Gadaba','gadaba',NULL,0),
	(230,'Gafat','gafat',NULL,0),
	(231,'Gagauz','gagauz',NULL,0),
	(232,'Galician','galician',NULL,0),
	(233,'Gan','gan',NULL,0),
	(234,'Gangte','gangte',NULL,0),
	(235,'Garhwali','garhwali',NULL,0),
	(236,'Gaulish','gaulish',NULL,0),
	(237,'Gayo','gayo',NULL,0),
	(238,'Ge\'ez','geez',NULL,0),
	(239,'Gen or Gẽ or Mina','gen_or_g_or_mina',NULL,0),
	(240,'Georgian','georgian',NULL,0),
	(241,'German','german',5,0),
	(242,'German Sign Language','german_sign_language',NULL,0),
	(243,'Ghomara','ghomara',NULL,0),
	(244,'Gikuyu or Kikuyu','gikuyu_or_kikuyu',NULL,0),
	(245,'Gilbertese or Kiribati','gilbertese_or_kiribati',NULL,0),
	(246,'Gileki','gileki',NULL,0),
	(247,'Goaria','goaria',NULL,0),
	(248,'Gondi','gondi',NULL,0),
	(249,'Gothic','gothic',NULL,0),
	(250,'Gawar-Bati or Gowari or Narsati','gawarbati_or_gowari_or_narsati',NULL,0),
	(251,'Greek','greek',NULL,0),
	(252,'Guanche','guanche',NULL,0),
	(253,'Guaraní','guarani',NULL,0),
	(254,'Guinea-Bissau Creole','guineabissau_creole',NULL,0),
	(255,'Gujarati','gujarati',NULL,0),
	(256,'Gula Iro or Kulaal','gula_iro_or_kulaal',NULL,0),
	(257,'Gullah or Sea Island Creole English','gullah_or_sea_island_creole_english',NULL,0),
	(258,'Gusii','gusii',NULL,0),
	(259,'Gwichʼin','gwichin',NULL,0),
	(260,'Hadramautic','hadramautic',NULL,0),
	(261,'Hadza or Hatsa','hadza_or_hatsa',NULL,0),
	(262,'Haida or Masset','haida_or_masset',NULL,0),
	(263,'Haitian Creole','haitian_creole',NULL,0),
	(264,'Hakka','hakka',NULL,0),
	(265,'Hän','han',NULL,0),
	(266,'Harari','harari',NULL,0),
	(267,'Harauti','harauti',NULL,0),
	(268,'Harsusi','harsusi',NULL,0),
	(269,'Haryanavi','haryanavi',NULL,0),
	(270,'Harzani','harzani',NULL,0),
	(271,'Hattic','hattic',NULL,0),
	(272,'Hausa','hausa',NULL,0),
	(273,'Havasupai or Upland Yuman','havasupai_or_upland_yuman',NULL,0),
	(274,'Hawaiian','hawaiian',NULL,0),
	(275,'Hawaii Pidgin Sign Language','hawaii_pidgin_sign_language',NULL,0),
	(276,'Hazaragi','hazaragi',NULL,0),
	(277,'Hebrew','hebrew',NULL,0),
	(278,'Herero','herero',NULL,0),
	(279,'Hértevin','hertevin',NULL,0),
	(280,'Hiligaynon','hiligaynon',NULL,0),
	(281,'Hindi','hindi',NULL,0),
	(282,'Hinukh','hinukh',NULL,0),
	(283,'Hiri Motu','hiri_motu',NULL,0),
	(284,'Hittite','hittite',NULL,0),
	(285,'Hixkaryana','hixkaryana',NULL,0),
	(286,'Hmong','hmong',NULL,0),
	(287,'Ho','ho',NULL,0),
	(288,'Hobyót','hobyot',NULL,0),
	(289,'Hopi','hopi',NULL,0),
	(290,'Hulaulá','hulaula',NULL,0),
	(291,'Hungarian','hungarian',NULL,0),
	(292,'Hurrian','hurrian',NULL,0),
	(293,'Hutterite German','hutterite_german',NULL,0),
	(294,'Ibibio','ibibio',NULL,0),
	(295,'Iban','iban',NULL,0),
	(296,'Ibanag','ibanag',NULL,0),
	(297,'Icelandic','icelandic',NULL,0),
	(298,'Ifè','ife',NULL,0),
	(299,'Igbo or Ibo or Biafra','igbo_or_ibo_or_biafra',NULL,0),
	(300,'Ikalanga or Kalanga','ikalanga_or_kalanga',NULL,0),
	(301,'Ili Turki','ili_turki',NULL,0),
	(302,'Illinois','illinois',NULL,0),
	(303,'Ilokano or Ilocano','ilokano_or_ilocano',NULL,0),
	(304,'Inari Sami','inari_sami',NULL,0),
	(305,'Indonesian','indonesian',NULL,0),
	(306,'Ingrian or Izhorian','ingrian_or_izhorian',NULL,0),
	(307,'Ingush','ingush',NULL,0),
	(308,'Inuktitut','inuktitut',NULL,0),
	(309,'Inupiaq','inupiaq',NULL,0),
	(310,'Inuvialuktun','inuvialuktun',NULL,0),
	(311,'Iraqw','iraqw',NULL,0),
	(312,'Irish or Irish Gaelic','irish_or_irish_gaelic',NULL,0),
	(313,'Irish Sign Language','irish_sign_language',NULL,0),
	(314,'Irula','irula',NULL,0),
	(315,'Isan or Northeastern Thai','isan_or_northeastern_thai',NULL,0),
	(316,'Istro-Romanian','istroromanian',NULL,0),
	(317,'Italian','italian',NULL,0),
	(318,'Itelmen or Kamchadal','itelmen_or_kamchadal',NULL,0),
	(319,'Jacaltec or Jakalteko','jacaltec_or_jakalteko',NULL,0),
	(320,'Jalaa','jalaa',NULL,0),
	(321,'Japanese','japanese',8,0),
	(322,'Jaqaru','jaqaru',NULL,0),
	(323,'Jarai','jarai',NULL,0),
	(324,'Javanese','javanese',NULL,0),
	(325,'Jibbali or Shehri','jibbali_or_shehri',NULL,0),
	(326,'Jewish Babylonian Aramaic','jewish_babylonian_aramaic',NULL,0),
	(327,'Jicarilla Apache','jicarilla_apache',NULL,0),
	(328,'Juang','juang',NULL,0),
	(329,'Judeo-Aramaic','judeoaramaic',NULL,0),
	(330,'Jurchen','jurchen',NULL,0),
	(331,'Kabardian','kabardian',NULL,0),
	(332,'Kabyle','kabyle',NULL,0),
	(333,'Kachin or Jingpo','kachin_or_jingpo',NULL,0),
	(334,'Kalaallisut or Greenlandic','kalaallisut_or_greenlandic',NULL,0),
	(335,'Kalami or Gawri or Dirwali','kalami_or_gawri_or_dirwali',NULL,0),
	(336,'Kalasha','kalasha',NULL,0),
	(337,'Kalmyk or Oirat','kalmyk_or_oirat',NULL,0),
	(338,'Kalto or Nahali','kalto_or_nahali',NULL,0),
	(339,'Kamas','kamas',NULL,0),
	(340,'Kankanai or Kankanaey','kankanai_or_kankanaey',NULL,0),
	(341,'Kannada','kannada',NULL,0),
	(342,'Kaonde or Chikaonde','kaonde_or_chikaonde',NULL,0),
	(343,'Kapampangan','kapampangan',NULL,0),
	(344,'Karachay-Balkar','karachaybalkar',NULL,0),
	(345,'Karagas','karagas',NULL,0),
	(346,'Karaim','karaim',NULL,0),
	(347,'Karakalpak','karakalpak',NULL,0),
	(348,'Karelian','karelian',NULL,0),
	(349,'Kashmiri','kashmiri',NULL,0),
	(350,'Kashubian','kashubian',NULL,0),
	(351,'Kawi','kawi',NULL,0),
	(352,'Kazakh','kazakh',NULL,0),
	(353,'Kemi Sami','kemi_sami',NULL,0),
	(354,'Kerek','kerek',NULL,0),
	(355,'Ket','ket',NULL,0),
	(356,'Khakas','khakas',NULL,0),
	(357,'Khalaj','khalaj',NULL,0),
	(358,'Kham or Sheshi','kham_or_sheshi',NULL,0),
	(359,'Khandeshi','khandeshi',NULL,0),
	(360,'Khanty or Ostyak','khanty_or_ostyak',NULL,0),
	(361,'Khasi','khasi',NULL,0),
	(362,'Khazar','khazar',NULL,0),
	(363,'Khmer','khmer',NULL,0),
	(364,'Khmu','khmu',NULL,0),
	(365,'Khowar','khowar',NULL,0),
	(366,'Kildin Sami','kildin_sami',NULL,0),
	(367,'Kimatuumbi','kimatuumbi',NULL,0),
	(368,'Kinaray-a or Hiraya','kinaraya_or_hiraya',NULL,0),
	(369,'Kinyarwanda','kinyarwanda',NULL,0),
	(370,'Kirombo','kirombo',NULL,0),
	(371,'Kirundi','kirundi',NULL,0),
	(372,'Kivunjo','kivunjo',NULL,0),
	(373,'Klallam or Clallam','klallam_or_clallam',NULL,0),
	(374,'Kodava Takk or Kodagu or Coorgi','kodava_takk_or_kodagu_or_coorgi',NULL,0),
	(375,'Kohistani or Khili','kohistani_or_khili',NULL,0),
	(376,'Kolami','kolami',NULL,0),
	(377,'Komi or Komi-Zyrian','komi_or_komizyrian',NULL,0),
	(378,'Konkani','konkani',NULL,0),
	(379,'Kongo or Kikongo','kongo_or_kikongo',NULL,0),
	(380,'Koraga','koraga',NULL,0),
	(381,'Korandje','korandje',NULL,0),
	(382,'Korean','korean',NULL,0),
	(383,'Korku','korku',NULL,0),
	(384,'Korowai','korowai',NULL,0),
	(385,'Korwa','korwa',NULL,0),
	(386,'Koryak','koryak',NULL,0),
	(387,'Kosraean','kosraean',NULL,0),
	(388,'Kota','kota',NULL,0),
	(389,'Koyra Chiini or Western Songhay','koyra_chiini_or_western_songhay',NULL,0),
	(390,'Koy Sanjaq Surat','koy_sanjaq_surat',NULL,0),
	(391,'Koya','koya',NULL,0),
	(392,'Krymchak or Judeo-Crimean Tatar','krymchak_or_judeocrimean_tatar',NULL,0),
	(393,'Kujarge','kujarge',NULL,0),
	(394,'Kui','kui',NULL,0),
	(395,'Kumauni','kumauni',NULL,0),
	(396,'Kumyk','kumyk',NULL,0),
	(397,'Kumzari','kumzari',NULL,0),
	(398,'ǃKung','kung',NULL,0),
	(399,'Kurdish','kurdish',NULL,0),
	(400,'Kurukh or Kurux','kurukh_or_kurux',NULL,0),
	(401,'Kusunda','kusunda',NULL,0),
	(402,'Kutenai or Kootenay or Ktunaxa','kutenai_or_kootenay_or_ktunaxa',NULL,0),
	(403,'Kwanyama or Ovambo','kwanyama_or_ovambo',NULL,0),
	(404,'Kxoe','kxoe',NULL,0),
	(405,'Kyrgyz or Kirghiz','kyrgyz_or_kirghiz',NULL,0),
	(406,'Laal','laal',NULL,0),
	(407,'Ladakhi','ladakhi',NULL,0),
	(408,'Ladin','ladin',NULL,0),
	(409,'Ladino or Judeo-Spanish','ladino_or_judeospanish',NULL,0),
	(410,'Lakota or Lakhota or Teton','lakota_or_lakhota_or_teton',NULL,0),
	(411,'Lambadi or Lamani or Banjari','lambadi_or_lamani_or_banjari',NULL,0),
	(412,'Lao or Laotian','lao_or_laotian',NULL,0),
	(413,'Latin','latin',NULL,0),
	(414,'Latvian','latvian',NULL,0),
	(415,'Laz or Lazuri','laz_or_lazuri',NULL,0),
	(416,'Lenape or Unami or Delaware','lenape_or_unami_or_delaware',NULL,0),
	(417,'Leonese','leonese',NULL,0),
	(418,'Lepontic','lepontic',NULL,0),
	(419,'Lezgi or Agul','lezgi_or_agul',NULL,0),
	(420,'Ligbi or Ligby','ligbi_or_ligby',NULL,0),
	(421,'Limburgish','limburgish',NULL,0),
	(422,'Lingala','lingala',NULL,0),
	(423,'Lipan Apache','lipan_apache',NULL,0),
	(424,'Lisan al-Dawat','lisan_aldawat',NULL,0),
	(425,'Lishana Deni','lishana_deni',NULL,0),
	(426,'Lishanid Noshan or Lishana Didan','lishanid_noshan_or_lishana_didan',NULL,0),
	(427,'Lithuanian','lithuanian',NULL,0),
	(428,'Livonian or Liv','livonian_or_liv',NULL,0),
	(429,'Lombard','lombard',NULL,0),
	(430,'Lotha','lotha',NULL,0),
	(431,'Low German or Low Saxon or Plattdeutsch','low_german_or_low_saxon_or_plattdeutsch',NULL,0),
	(432,'Lower Sorbian','lower_sorbian',NULL,0),
	(433,'Lozi or Silozi','lozi_or_silozi',NULL,0),
	(434,'Ludic or Ludian','ludic_or_ludian',NULL,0),
	(435,'Luganda','luganda',NULL,0),
	(436,'Lunda or Chilunda','lunda_or_chilunda',NULL,0),
	(437,'Luri','luri',NULL,0),
	(438,'Lushootseed','lushootseed',NULL,0),
	(439,'Lusoga or Soga','lusoga_or_soga',NULL,0),
	(440,'Luvale','luvale',NULL,0),
	(441,'Luwati','luwati',NULL,0),
	(442,'Luwian or Luvian','luwian_or_luvian',NULL,0),
	(443,'Luxembourgish','luxembourgish',NULL,0),
	(444,'Lycian','lycian',NULL,0),
	(445,'Lydian','lydian',NULL,0),
	(446,'Macedonian','macedonian',NULL,0),
	(447,'Macedonian','macedonian',NULL,0),
	(448,'Magadhi','magadhi',NULL,0),
	(449,'Maguindanao','maguindanao',NULL,0),
	(450,'Mahican','mahican',NULL,0),
	(451,'Maithili','maithili',NULL,0),
	(452,'Makasar','makasar',NULL,0),
	(453,'Makhuwa or Makua','makhuwa_or_makua',NULL,0),
	(454,'Makhuwa-Meetto','makhuwameetto',NULL,0),
	(455,'Malagasy','malagasy',NULL,0),
	(456,'Malay','malay',NULL,0),
	(457,'Malayalam','malayalam',NULL,0),
	(458,'Malaysian Sign Language','malaysian_sign_language',NULL,0),
	(459,'Maltese','maltese',NULL,0),
	(460,'Malto or Sauria Paharia','malto_or_sauria_paharia',NULL,0),
	(461,'Malvi or Malavi or Ujjaini','malvi_or_malavi_or_ujjaini',NULL,0),
	(462,'Mam','mam',NULL,0),
	(463,'Manchurian','manchurian',NULL,0),
	(464,'Mandaic','mandaic',NULL,0),
	(465,'Mandarin','mandarin',7,0),
	(466,'Mandinka','mandinka',NULL,0),
	(467,'Mansi or Vogul','mansi_or_vogul',NULL,0),
	(468,'Manx','manx',NULL,0),
	(469,'Manyika','manyika',NULL,0),
	(470,'Maori','maori',NULL,0),
	(471,'Mapudungun or Mapuche','mapudungun_or_mapuche',NULL,0),
	(472,'Maranao','maranao',NULL,0),
	(473,'Marathi','marathi',NULL,0),
	(474,'Mari or Cheremis','mari_or_cheremis',NULL,0),
	(475,'Maria','maria',NULL,0),
	(476,'Marquesan','marquesan',NULL,0),
	(477,'Marshallese or Ebon','marshallese_or_ebon',NULL,0),
	(478,'Martha\'s Vineyard Sign Language','marthas_vineyard_sign_language',NULL,0),
	(479,'Masaba','masaba',NULL,0),
	(480,'Masbatenyo or Minasbate','masbatenyo_or_minasbate',NULL,0),
	(481,'Meitei or Manipuri or Meithei','meitei_or_manipuri_or_meithei',NULL,0),
	(482,'Mator','mator',NULL,0),
	(483,'Mauritian Creole or Morisyen','mauritian_creole_or_morisyen',NULL,0),
	(484,'Maya','maya',NULL,0),
	(485,'Mazandarani or Tabari','mazandarani_or_tabari',NULL,0),
	(486,'Meänkieli or Tornedalen Finnish','meankieli_or_tornedalen_finnish',NULL,0),
	(487,'Megleno-Romanian','meglenoromanian',NULL,0),
	(488,'Megrelian or Mingrelian','megrelian_or_mingrelian',NULL,0),
	(489,'Mehri or Mahri','mehri_or_mahri',NULL,0),
	(490,'Menominee','menominee',NULL,0),
	(491,'Mentawai','mentawai',NULL,0),
	(492,'Meroitic','meroitic',NULL,0),
	(493,'Merya','merya',NULL,0),
	(494,'Mescalero Apache','mescalero_apache',NULL,0),
	(495,'Mesmes','mesmes',NULL,0),
	(496,'Messapian','messapian',NULL,0),
	(497,'Meru or Kimeru','meru_or_kimeru',NULL,0),
	(498,'Miami','miami',NULL,0),
	(499,'Michif','michif',NULL,0),
	(500,'Middle Dutch','middle_dutch',NULL,0),
	(501,'Middle English','middle_english',NULL,0),
	(502,'Middle French','middle_french',NULL,0),
	(503,'Middle High German','middle_high_german',NULL,0),
	(504,'Middle Persian or Pahlavi','middle_persian_or_pahlavi',NULL,0),
	(505,'Mikasuki or Miccosukee','mikasuki_or_miccosukee',NULL,0),
	(506,'Mi\'kmaq or Micmac','mikmaq_or_micmac',NULL,0),
	(507,'Minaean','minaean',NULL,0),
	(508,'Minangkabau','minangkabau',NULL,0),
	(509,'Mirandese','mirandese',NULL,0),
	(510,'Mlahsô or Suryoyo','mlahso_or_suryoyo',NULL,0),
	(511,'Moabite','moabite',NULL,0),
	(512,'Mobilian Jargon','mobilian_jargon',NULL,0),
	(513,'Moghol','moghol',NULL,0),
	(514,'Mohawk','mohawk',NULL,0),
	(515,'Mohegan','mohegan',NULL,0),
	(516,'Moksha','moksha',NULL,0),
	(517,'Molengue','molengue',NULL,0),
	(518,'Mon','mon',NULL,0),
	(519,'Mongolian','mongolian',NULL,0),
	(520,'Mono','mono',NULL,0),
	(521,'Mono','mono',NULL,0),
	(522,'Mono','mono',NULL,0),
	(523,'Montagnais','montagnais',NULL,0),
	(524,'Montenegrin','montenegrin',NULL,0),
	(525,'Motu','motu',NULL,0),
	(526,'Mpre','mpre',NULL,0),
	(527,'Muher','muher',NULL,0),
	(528,'Mundari','mundari',NULL,0),
	(529,'Munji','munji',NULL,0),
	(530,'Muria','muria',NULL,0),
	(531,'Muromian','muromian',NULL,0),
	(532,'Nafaanra','nafaanra',NULL,0),
	(533,'Nagarchal','nagarchal',NULL,0),
	(534,'Nahuatl','nahuatl',NULL,0),
	(535,'Nama','nama',NULL,0),
	(536,'Nanai','nanai',NULL,0),
	(537,'Nauruan','nauruan',NULL,0),
	(538,'Navajo or Navaho','navajo_or_navaho',NULL,0),
	(539,'Ndau or Southeast Shona','ndau_or_southeast_shona',NULL,0),
	(540,'Ndebele','ndebele',NULL,0),
	(541,'Ndonga','ndonga',NULL,0),
	(542,'Neapolitan','neapolitan',NULL,0),
	(543,'Negidal','negidal',NULL,0),
	(544,'Nenets or Yurak','nenets_or_yurak',NULL,0),
	(545,'Nepal Bhasa or Newari','nepal_bhasa_or_newari',NULL,0),
	(546,'Nepali','nepali',NULL,0),
	(547,'New Zealand Sign Language','new_zealand_sign_language',NULL,0),
	(548,'Nihali or Nahali','nihali_or_nahali',NULL,0),
	(549,'Nganasan or Tavgi','nganasan_or_tavgi',NULL,0),
	(550,'Ngumba','ngumba',NULL,0),
	(551,'Nheengatu or Geral or Modern Tupí','nheengatu_or_geral_or_modern_tupi',NULL,0),
	(552,'Nias','nias',NULL,0),
	(553,'Nicaraguan Sign Language','nicaraguan_sign_language',NULL,0),
	(554,'Nicola','nicola',NULL,0),
	(555,'Niellim','niellim',NULL,0),
	(556,'Nigerian Pidgin','nigerian_pidgin',NULL,0),
	(557,'Nisenan','nisenan',NULL,0),
	(558,'Niuean or Niue','niuean_or_niue',NULL,0),
	(559,'Nivkh or Gilyak','nivkh_or_gilyak',NULL,0),
	(560,'Nogai','nogai',NULL,0),
	(561,'Norfuk or Norfolk or Pitcairn-Norfolk','norfuk_or_norfolk_or_pitcairnnorfolk',NULL,0),
	(562,'Norman or Norman-French','norman_or_normanfrench',NULL,0),
	(563,'Norn','norn',NULL,0),
	(564,'Northern Sami','northern_sami',NULL,0),
	(565,'Northern Sotho or Sepedi','northern_sotho_or_sepedi',NULL,0),
	(566,'Northern Straits Salish)','northern_straits_salish',NULL,0),
	(567,'Northern Yukaghir','northern_yukaghir',NULL,0),
	(568,'Norwegian','norwegian',NULL,0),
	(569,'Nuer','nuer',NULL,0),
	(570,'Nuxálk or Bella Coola','nuxalk_or_bella_coola',NULL,0),
	(571,'Nyabwa','nyabwa',NULL,0),
	(572,'Nyah Kur','nyah_kur',NULL,0),
	(573,'Nyangumarta','nyangumarta',NULL,0),
	(574,'Nyoro','nyoro',NULL,0),
	(575,'Nǀu','nu',NULL,0),
	(576,'Occitan or Provençal','occitan_or_provencal',NULL,0),
	(577,'Ojibwe or Ojibwa or Chippewa','ojibwe_or_ojibwa_or_chippewa',NULL,0),
	(578,'Old Church Slavonic','old_church_slavonic',NULL,0),
	(579,'Old English or Anglo-Saxon','old_english_or_anglosaxon',NULL,0),
	(580,'Old French','old_french',NULL,0),
	(581,'Old French Sign Language','old_french_sign_language',NULL,0),
	(582,'Old High German','old_high_german',NULL,0),
	(583,'Old Norse','old_norse',NULL,0),
	(584,'Old Nubian language','old_nubian_language',NULL,0),
	(585,'Old Persian','old_persian',NULL,0),
	(586,'Old Prussian','old_prussian',NULL,0),
	(587,'Old Saxon','old_saxon',NULL,0),
	(588,'Old South Arabic','old_south_arabic',NULL,0),
	(589,'Old Tupi or Tupinamba','old_tupi_or_tupinamba',NULL,0),
	(590,'Olonets Karelian or Liv or Livvi','olonets_karelian_or_liv_or_livvi',NULL,0),
	(591,'Omagua','omagua',NULL,0),
	(592,'Ongota','ongota',NULL,0),
	(593,'Oriya','oriya',NULL,0),
	(594,'Ormuri','ormuri',NULL,0),
	(595,'Oroch','oroch',NULL,0),
	(596,'Orok','orok',NULL,0),
	(597,'Oromo or Afaan Oromoo','oromo_or_afaan_oromoo',NULL,0),
	(598,'Oropom','oropom',NULL,0),
	(599,'Ossetic or Ossetian','ossetic_or_ossetian',NULL,0),
	(600,'Ottoman Turkish','ottoman_turkish',NULL,0),
	(601,'Páez or Nasa Yuwe','paez_or_nasa_yuwe',NULL,0),
	(602,'Palaic','palaic',NULL,0),
	(603,'Palauan','palauan',NULL,0),
	(604,'Pali','pali',NULL,0),
	(605,'Pangasinan','pangasinan',NULL,0),
	(606,'Papiamento or Papiamentu','papiamento_or_papiamentu',NULL,0),
	(607,'Parachi','parachi',NULL,0),
	(608,'Parya','parya',NULL,0),
	(609,'Pashto or Pushto or Pashtu','pashto_or_pushto_or_pashtu',NULL,0),
	(610,'Pecheneg','pecheneg',NULL,0),
	(611,'Pennsylvania Dutch or Pennsylvania German','pennsylvania_dutch_or_pennsylvania_german',NULL,0),
	(612,'Pentlatch or Puntlatch','pentlatch_or_puntlatch',NULL,0),
	(613,'Persian or farsi, as it is referred to in the Pers','persian_or_farsi_as_it_is_referred_to_in_the_pers',NULL,0),
	(614,'Phalura','phalura',NULL,0),
	(615,'Phoenician','phoenician',NULL,0),
	(616,'Phrygian','phrygian',NULL,0),
	(617,'Phuthi','phuthi',NULL,0),
	(618,'Picard','picard',NULL,0),
	(619,'Pictish','pictish',NULL,0),
	(620,'Pirahã','piraha',NULL,0),
	(621,'Pisidian','pisidian',NULL,0),
	(622,'Plautdietsch or Mennonite Low German','plautdietsch_or_mennonite_low_german',NULL,0),
	(623,'Polabian','polabian',NULL,0),
	(624,'Polish','polish',4,0),
	(625,'Portuguese','portuguese',NULL,0),
	(626,'Pothohari or Pahari-Potwari','pothohari_or_paharipotwari',NULL,0),
	(627,'Potiguara','potiguara',NULL,0),
	(628,'Pradhan or Pardhan','pradhan_or_pardhan',NULL,0),
	(629,'Prakrit','prakrit',NULL,0),
	(630,'Proto-Indo-European','protoindoeuropean',NULL,0),
	(631,'Puelche','puelche',NULL,0),
	(632,'Puma','puma',NULL,0),
	(633,'Punjabi or Panjabi or Gurmukhi','punjabi_or_panjabi_or_gurmukhi',NULL,0),
	(634,'Qashqai or Ghashghai','qashqai_or_ghashghai',NULL,0),
	(635,'Qatabanian','qatabanian',NULL,0),
	(636,'Quebec Sign Language','quebec_sign_language',NULL,0),
	(637,'Quechua','quechua',NULL,0),
	(638,'Rajasthani','rajasthani',NULL,0),
	(639,'Ratagnon or Datagnon or Latagnun','ratagnon_or_datagnon_or_latagnun',NULL,0),
	(640,'Réunion Creole or Bourbonnais','reunion_creole_or_bourbonnais',NULL,0),
	(641,'Romanian','romanian',NULL,0),
	(642,'Romansh or Rhaeto-Romance','romansh_or_rhaetoromance',NULL,0),
	(643,'Romany','romany',NULL,0),
	(644,'Romblomanon','romblomanon',NULL,0),
	(645,'Rotokas','rotokas',NULL,0),
	(646,'Runyankole language or Nyankore','runyankole_language_or_nyankore',NULL,0),
	(647,'Russenorsk','russenorsk',NULL,0),
	(648,'Russian','russian',NULL,0),
	(649,'Russian Sign Language','russian_sign_language',NULL,0),
	(650,'Ruthenian or Rusyn or Carpathian','ruthenian_or_rusyn_or_carpathian',NULL,0),
	(651,'Sabaean','sabaean',NULL,0),
	(652,'Salar','salar',NULL,0),
	(653,'Samaritan Hebrew','samaritan_hebrew',NULL,0),
	(654,'Samoan','samoan',NULL,0),
	(655,'Sandawe','sandawe',NULL,0),
	(656,'Sango','sango',NULL,0),
	(657,'Sanskrit','sanskrit',NULL,0),
	(658,'Santali','santali',NULL,0),
	(659,'Sara','sara',NULL,0),
	(660,'Saramaccan','saramaccan',NULL,0),
	(661,'Sardinian','sardinian',NULL,0),
	(662,'Sarikoli','sarikoli',NULL,0),
	(663,'Saurashtra or Sourashtra','saurashtra_or_sourashtra',NULL,0),
	(664,'Savara','savara',NULL,0),
	(665,'Savi','savi',NULL,0),
	(666,'Sawai','sawai',NULL,0),
	(667,'Scots or Ulster Scots or Hiberno-Scots or Ullans','scots_or_ulster_scots_or_hibernoscots_or_ullans',NULL,0),
	(668,'Scots Gaelic or Scottish Gaelic or Gaidhlig or Gae','scots_gaelic_or_scottish_gaelic_or_gaidhlig_or_gae',NULL,0),
	(669,'Selangor Sign Language','selangor_sign_language',NULL,0),
	(670,'Selkup or Ostyak Samoyed','selkup_or_ostyak_samoyed',NULL,0),
	(671,'Selonian','selonian',NULL,0),
	(672,'Semnani','semnani',NULL,0),
	(673,'Senaya','senaya',NULL,0),
	(674,'Sened','sened',NULL,0),
	(675,'Senhaja de Srair','senhaja_de_srair',NULL,0),
	(676,'Serbian','serbian',NULL,0),
	(677,'Serbo-Croatian','serbocroatian',NULL,0),
	(678,'Sesotho','sesotho',NULL,0),
	(679,'Seto or Setu','seto_or_setu',NULL,0),
	(680,'Seychellois Creole','seychellois_creole',NULL,0),
	(681,'Shimaore','shimaore',NULL,0),
	(682,'Shina','shina',NULL,0),
	(683,'Shona','shona',NULL,0),
	(684,'Shor','shor',NULL,0),
	(685,'Shoshoni','shoshoni',NULL,0),
	(686,'Shughni','shughni',NULL,0),
	(687,'Shumashti','shumashti',NULL,0),
	(688,'Shuswap','shuswap',NULL,0),
	(689,'Sicilian','sicilian',NULL,0),
	(690,'Sidamo','sidamo',NULL,0),
	(691,'Sidetic','sidetic',NULL,0),
	(692,'Sika','sika',NULL,0),
	(693,'Silesian','silesian',NULL,0),
	(694,'Silt\'e or Selti or East Gurage','silte_or_selti_or_east_gurage',NULL,0),
	(695,'Sindhi','sindhi',NULL,0),
	(696,'Sinhalese','sinhalese',NULL,0),
	(697,'Sioux','sioux',NULL,0),
	(698,'Siraiki or Seraiki or Southern Punjabi','siraiki_or_seraiki_or_southern_punjabi',NULL,0),
	(699,'Sivandi','sivandi',NULL,0),
	(700,'Skolt Sami','skolt_sami',NULL,0),
	(701,'Slavey','slavey',NULL,0),
	(702,'Slovak','slovak',NULL,0),
	(703,'Slovene or Slovenian','slovene_or_slovenian',NULL,0),
	(704,'Soddo or Kistane','soddo_or_kistane',NULL,0),
	(705,'Somali','somali',NULL,0),
	(706,'Sonjo or Temi','sonjo_or_temi',NULL,0),
	(707,'Sonsorolese or Sonsorol','sonsorolese_or_sonsorol',NULL,0),
	(708,'Soqotri','soqotri',NULL,0),
	(709,'Sora','sora',NULL,0),
	(710,'Sorbian, Lower','sorbian_lower',NULL,0),
	(711,'Sorbian, Upper','sorbian_upper',NULL,0),
	(712,'Sourashtra','sourashtra',NULL,0),
	(713,'Southern Sami','southern_sami',NULL,0),
	(714,'South Estonian','south_estonian',NULL,0),
	(715,'Southern Yukaghir or Tundra Yukaghir','southern_yukaghir_or_tundra_yukaghir',NULL,0),
	(716,'Spanish','spanish',3,0),
	(717,'Sranan Tongo','sranan_tongo',NULL,0),
	(718,'St\'at\'imcets or Lillooet','statimcets_or_lillooet',NULL,0),
	(719,'Sucite or Sìcìté Sénoufo','sucite_or_sicite_senoufo',NULL,0),
	(720,'Suba','suba',NULL,0),
	(721,'Sudovian or Yotvingian','sudovian_or_yotvingian',NULL,0),
	(722,'Sumerian','sumerian',NULL,0),
	(723,'Sundanese','sundanese',NULL,0),
	(724,'Supyire or Supyire Senoufo','supyire_or_supyire_senoufo',NULL,0),
	(725,'Surigaonon','surigaonon',NULL,0),
	(726,'Susu','susu',NULL,0),
	(727,'Svan','svan',NULL,0),
	(728,'Swahili','swahili',NULL,0),
	(729,'Swati or Swazi or Siswati or Seswati','swati_or_swazi_or_siswati_or_seswati',NULL,0),
	(730,'Swedish','swedish',NULL,0),
	(731,'Syriac','syriac',NULL,0),
	(732,'Tabasaran or Tabassaran','tabasaran_or_tabassaran',NULL,0),
	(733,'Tachelhit','tachelhit',NULL,0),
	(734,'Tagalog','tagalog',NULL,0),
	(735,'Tahitian','tahitian',NULL,0),
	(736,'Taiwanese Sign Language','taiwanese_sign_language',NULL,0),
	(737,'Tajik','tajik',NULL,0),
	(738,'Takestani','takestani',NULL,0),
	(739,'Talysh','talysh',NULL,0),
	(740,'Tamil','tamil',NULL,0),
	(741,'Tanacross','tanacross',NULL,0),
	(742,'Tangut or Xixia','tangut_or_xixia',NULL,0),
	(743,'Tarifit or Rifi or Riff Berber','tarifit_or_rifi_or_riff_berber',NULL,0),
	(744,'Tat or Tati','tat_or_tati',NULL,0),
	(745,'Tatar','tatar',NULL,0),
	(746,'Tausug','tausug',NULL,0),
	(747,'Tehuelche','tehuelche',NULL,0),
	(748,'Telugu','telugu',NULL,0),
	(749,'Tetum','tetum',NULL,0),
	(750,'Tepehua language','tepehua_language',NULL,0),
	(751,'Tepehuán language','tepehuan_language',NULL,0),
	(752,'Thai','thai',NULL,0),
	(753,'Tharu','tharu',NULL,0),
	(754,'Thracian','thracian',NULL,0),
	(755,'Tibetan','tibetan',NULL,0),
	(756,'Tigre or Xasa','tigre_or_xasa',NULL,0),
	(757,'Tigrinya','tigrinya',NULL,0),
	(758,'Tillamook','tillamook',NULL,0),
	(759,'Timbisha or Panamint','timbisha_or_panamint',NULL,0),
	(760,'Tiv','tiv',NULL,0),
	(761,'Tlingit','tlingit',NULL,0),
	(762,'Tobian','tobian',NULL,0),
	(763,'Tocharian A and B','tocharian_a_and_b',NULL,0),
	(764,'Toda','toda',NULL,0),
	(765,'Tok Pisin','tok_pisin',NULL,0),
	(766,'Tokelauan','tokelauan',NULL,0),
	(767,'Tonga','tonga',NULL,0),
	(768,'Tongan','tongan',NULL,0),
	(769,'Tongva','tongva',NULL,0),
	(770,'Torwali or Turvali','torwali_or_turvali',NULL,0),
	(771,'Tregami','tregami',NULL,0),
	(772,'Tsat','tsat',NULL,0),
	(773,'Tsez or Dido','tsez_or_dido',NULL,0),
	(774,'Tshiluba or Luba-Kasai or Luba-Lulua','tshiluba_or_lubakasai_or_lubalulua',NULL,0),
	(775,'Tsimshian','tsimshian',NULL,0),
	(776,'Tsonga','tsonga',NULL,0),
	(777,'Tswana or Setswana','tswana_or_setswana',NULL,0),
	(778,'Tu or Monguor','tu_or_monguor',NULL,0),
	(779,'Tuareg languages or Tamasheq','tuareg_languages_or_tamasheq',NULL,0),
	(780,'Tulu','tulu',NULL,0),
	(781,'Tumbuka','tumbuka',NULL,0),
	(782,'Tupiniquim','tupiniquim',NULL,0),
	(783,'Turkish','turkish',NULL,0),
	(784,'Turkmen','turkmen',NULL,0),
	(785,'Turoyo','turoyo',NULL,0),
	(786,'Tuvaluan','tuvaluan',NULL,0),
	(787,'Tuvan Tuvin or Tyvan','tuvan_tuvin_or_tyvan',NULL,0),
	(788,'Ubykh','ubykh',NULL,0),
	(789,'Udihe or Ude or Udege','udihe_or_ude_or_udege',NULL,0),
	(790,'Udmurt or Votyak','udmurt_or_votyak',NULL,0),
	(791,'Ugaritic','ugaritic',NULL,0),
	(792,'Ukrainian','ukrainian',NULL,0),
	(793,'Ulch or Olcha','ulch_or_olcha',NULL,0),
	(794,'Unserdeutsch or Rabaul Creole German','unserdeutsch_or_rabaul_creole_german',NULL,0),
	(795,'Upper Sorbian','upper_sorbian',NULL,0),
	(796,'Urdu','urdu',NULL,0),
	(797,'Uripiv','uripiv',NULL,0),
	(798,'Urum','urum',NULL,0),
	(799,'Ute','ute',NULL,0),
	(800,'Uyghur or Uigur','uyghur_or_uigur',NULL,0),
	(801,'Uzbek','uzbek',NULL,0),
	(802,'Vafsi','vafsi',NULL,0),
	(803,'Valencian','valencian',NULL,0),
	(804,'Valencian Sign Language','valencian_sign_language',NULL,0),
	(805,'Vasi-vari or Prasuni','vasivari_or_prasuni',NULL,0),
	(806,'Venda or Tshivenda','venda_or_tshivenda',NULL,0),
	(807,'Venetian','venetian',NULL,0),
	(808,'Veps','veps',NULL,0),
	(809,'Vietnamese','vietnamese',NULL,0),
	(810,'Võro','voro',NULL,0),
	(811,'Votic or Votian','votic_or_votian',NULL,0),
	(812,'Waddar','waddar',NULL,0),
	(813,'Waigali or Kalasha-Ala','waigali_or_kalashaala',NULL,0),
	(814,'Waima or Roro','waima_or_roro',NULL,0),
	(815,'Wakhi','wakhi',NULL,0),
	(816,'Walloon','walloon',NULL,0),
	(817,'Waray-Waray or Binisaya','waraywaray_or_binisaya',NULL,0),
	(818,'Washo','washo',NULL,0),
	(819,'Welsh','welsh',NULL,0),
	(820,'Western Neo-Aramaic','western_neoaramaic',NULL,0),
	(821,'Weyto','weyto',NULL,0),
	(822,'Wolane','wolane',NULL,0),
	(823,'Wolof','wolof',NULL,0),
	(824,'Wu','wu',NULL,0),
	(825,'ǀXam','xam',NULL,0),
	(826,'Xhosa','xhosa',NULL,0),
	(827,'Xiang','xiang',NULL,0),
	(828,'Xibe or Sibo','xibe_or_sibo',NULL,0),
	(829,'Xipaya','xipaya',NULL,0),
	(830,'ǃXóõ','xoo',NULL,0),
	(831,'Yaaku language','yaaku_language',NULL,0),
	(832,'Yaeyama language','yaeyama_language',NULL,0),
	(833,'Yakut','yakut',NULL,0),
	(834,'Yankunytjatjara language','yankunytjatjara_language',NULL,0),
	(835,'Yanomami','yanomami',NULL,0),
	(836,'Yanyuwa','yanyuwa',NULL,0),
	(837,'Yapese','yapese',NULL,0),
	(838,'Yaqui','yaqui',NULL,0),
	(839,'Yauma','yauma',NULL,0),
	(840,'Yavapai','yavapai',NULL,0),
	(841,'Yazdi','yazdi',NULL,0),
	(842,'Yemenite Hebrew','yemenite_hebrew',NULL,0),
	(843,'Yeni language','yeni_language',NULL,0),
	(844,'Yevanic language','yevanic_language',NULL,0),
	(845,'Yi language','yi_language',NULL,0),
	(846,'Yiddish','yiddish',NULL,0),
	(847,'Yogur','yogur',NULL,0),
	(848,'Yokutsan languages','yokutsan_languages',NULL,0),
	(849,'Yonaguni language','yonaguni_language',NULL,0),
	(850,'Yorùbá language','yoruba_language',NULL,0),
	(851,'Yucatec Maya language','yucatec_maya_language',NULL,0),
	(852,'Yucatec Maya Sign Language','yucatec_maya_sign_language',NULL,0),
	(853,'Yuchi language','yuchi_language',NULL,0),
	(854,'Yugur','yugur',NULL,0),
	(855,'Yukaghir languages','yukaghir_languages',NULL,0),
	(856,'Yupik language','yupik_language',NULL,0),
	(857,'Yurats language','yurats_language',NULL,0),
	(858,'Yurok language','yurok_language',NULL,0),
	(859,'Záparo','zaparo',NULL,0),
	(860,'Zapotec','zapotec',NULL,0),
	(861,'Zazaki','zazaki',NULL,0),
	(862,'Zhuang','zhuang',NULL,0),
	(863,'Zoque','zoque',NULL,0),
	(864,'Zulu','zulu',NULL,0),
	(865,'Zuñi or Zuni','zuni_or_zuni',NULL,0),
	(866,'Zway or Zay','zway_or_zay',NULL,0),
	(867,'Yoruba','yoruba',NULL,0),
	(877,'Bengali (Sylheti Dialect)','bengali_sylheti_dialect',NULL,0),
	(879,'Frans','frans',NULL,0),
	(881,'Duits','duits',NULL,0),
	(883,'Engels','engels',NULL,0),
	(885,'Nederlands','nederlands',NULL,0);

/*!40000 ALTER TABLE `language` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table log_cron
# ------------------------------------------------------------

DROP TABLE IF EXISTS `log_cron`;

CREATE TABLE `log_cron` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `task` varchar(150) NOT NULL DEFAULT '',
  `duration` double NOT NULL,
  `message` varchar(500) DEFAULT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table profanity_list
# ------------------------------------------------------------

DROP TABLE IF EXISTS `profanity_list`;

CREATE TABLE `profanity_list` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `word` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `profanity_list` WRITE;
/*!40000 ALTER TABLE `profanity_list` DISABLE KEYS */;

INSERT INTO `profanity_list` (`id`, `word`)
VALUES
	(1,'anus '),
	(2,'ash0le '),
	(3,'ash0les '),
	(4,'asholes '),
	(5,'ass '),
	(6,'Ass Monkey '),
	(7,'Assface '),
	(8,'assh0le '),
	(9,'assh0lez '),
	(10,'asshole '),
	(11,'assholes '),
	(12,'assholz '),
	(13,'asswipe '),
	(14,'azzhole '),
	(15,'bassterds '),
	(16,'bastard '),
	(17,'bastards '),
	(18,'bastardz '),
	(19,'basterds '),
	(20,'basterdz '),
	(21,'Biatch '),
	(22,'bitch '),
	(23,'bitches '),
	(24,'Blow Job '),
	(25,'boffing '),
	(26,'butthole '),
	(27,'buttwipe '),
	(28,'c0ck '),
	(29,'c0cks '),
	(30,'c0k '),
	(31,'Carpet Muncher '),
	(32,'cawk '),
	(33,'cawks '),
	(34,'Clit '),
	(35,'cnts '),
	(36,'cntz '),
	(37,'cock '),
	(38,'cockhead '),
	(39,'cock-head '),
	(40,'cocks '),
	(41,'CockSucker '),
	(42,'cock-sucker '),
	(43,'crap '),
	(44,'cum '),
	(45,'cunt '),
	(46,'cunts '),
	(47,'cuntz '),
	(48,'dick '),
	(49,'dild0 '),
	(50,'dild0s '),
	(51,'dildo '),
	(52,'dildos '),
	(53,'dilld0 '),
	(54,'dilld0s '),
	(55,'dominatricks '),
	(56,'dominatrics '),
	(57,'dominatrix '),
	(58,'dyke '),
	(59,'enema '),
	(60,'f u c k '),
	(61,'f u c k e r '),
	(62,'fag '),
	(63,'fag1t '),
	(64,'faget '),
	(65,'fagg1t '),
	(66,'faggit '),
	(67,'faggot '),
	(68,'fagit '),
	(69,'fags '),
	(70,'fagz '),
	(71,'faig '),
	(72,'faigs '),
	(73,'fart '),
	(74,'flipping the bird '),
	(75,'fuck '),
	(76,'fucker '),
	(77,'fuckin '),
	(78,'fucking '),
	(79,'fucks '),
	(80,'Fudge Packer '),
	(81,'fuk '),
	(82,'Fukah '),
	(83,'Fuken '),
	(84,'fuker '),
	(85,'Fukin '),
	(86,'Fukk '),
	(87,'Fukkah '),
	(88,'Fukken '),
	(89,'Fukker '),
	(90,'Fukkin '),
	(91,'g00k '),
	(92,'gay '),
	(93,'gayboy '),
	(94,'gaygirl '),
	(95,'gays '),
	(96,'gayz '),
	(97,'God-damned '),
	(98,'h00r '),
	(99,'h0ar '),
	(100,'h0re '),
	(101,'hells '),
	(102,'hoar '),
	(103,'hoor '),
	(104,'hoore '),
	(105,'jackoff '),
	(106,'jap '),
	(107,'japs '),
	(108,'jerk-off '),
	(109,'jisim '),
	(110,'jiss '),
	(111,'jizm '),
	(112,'jizz '),
	(113,'knob '),
	(114,'knobs '),
	(115,'knobz '),
	(116,'kunt '),
	(117,'kunts '),
	(118,'kuntz '),
	(119,'Lesbian '),
	(120,'Lezzian '),
	(121,'Lipshits '),
	(122,'Lipshitz '),
	(123,'masochist '),
	(124,'masokist '),
	(125,'massterbait '),
	(126,'masstrbait '),
	(127,'masstrbate '),
	(128,'masterbaiter '),
	(129,'masterbate '),
	(130,'masterbates '),
	(131,'Motha Fucker '),
	(132,'Motha Fuker '),
	(133,'Motha Fukkah '),
	(134,'Motha Fukker '),
	(135,'Mother Fucker '),
	(136,'Mother Fukah '),
	(137,'Mother Fuker '),
	(138,'Mother Fukkah '),
	(139,'Mother Fukker '),
	(140,'mother-fucker '),
	(141,'Mutha Fucker '),
	(142,'Mutha Fukah '),
	(143,'Mutha Fuker '),
	(144,'Mutha Fukkah '),
	(145,'Mutha Fukker '),
	(146,'n1gr '),
	(147,'nastt '),
	(148,'nigger; '),
	(149,'nigur; '),
	(150,'niiger; '),
	(151,'niigr; '),
	(152,'orafis '),
	(153,'orgasim; '),
	(154,'orgasm '),
	(155,'orgasum '),
	(156,'oriface '),
	(157,'orifice '),
	(158,'orifiss '),
	(159,'packi '),
	(160,'packie '),
	(161,'packy '),
	(162,'paki '),
	(163,'pakie '),
	(164,'paky '),
	(165,'pecker '),
	(166,'peeenus '),
	(167,'peeenusss '),
	(168,'peenus '),
	(169,'peinus '),
	(170,'pen1s '),
	(171,'penas '),
	(172,'penis '),
	(173,'penis-breath '),
	(174,'penus '),
	(175,'penuus '),
	(176,'Phuc '),
	(177,'Phuck '),
	(178,'Phuk '),
	(179,'Phuker '),
	(180,'Phukker '),
	(181,'polac '),
	(182,'polack '),
	(183,'polak '),
	(184,'Poonani '),
	(185,'pr1c '),
	(186,'pr1ck '),
	(187,'pr1k '),
	(188,'pusse '),
	(189,'pussee '),
	(190,'pussy '),
	(191,'puuke '),
	(192,'puuker '),
	(193,'queer '),
	(194,'queers '),
	(195,'queerz '),
	(196,'qweers '),
	(197,'qweerz '),
	(198,'qweir '),
	(199,'recktum '),
	(200,'rectum '),
	(201,'retard '),
	(202,'sadist '),
	(203,'scank '),
	(204,'schlong '),
	(205,'screwing '),
	(206,'semen '),
	(207,'sex '),
	(208,'sexy '),
	(209,'Sh!t '),
	(210,'sh1t '),
	(211,'sh1ter '),
	(212,'sh1ts '),
	(213,'sh1tter '),
	(214,'sh1tz '),
	(215,'shit '),
	(216,'shits '),
	(217,'shitter '),
	(218,'Shitty '),
	(219,'Shity '),
	(220,'shitz '),
	(221,'Shyt '),
	(222,'Shyte '),
	(223,'Shytty '),
	(224,'Shyty '),
	(225,'skanck '),
	(226,'skank '),
	(227,'skankee '),
	(228,'skankey '),
	(229,'skanks '),
	(230,'Skanky '),
	(231,'slut '),
	(232,'sluts '),
	(233,'Slutty '),
	(234,'slutz '),
	(235,'son-of-a-bitch '),
	(236,'tit '),
	(237,'turd '),
	(238,'va1jina '),
	(239,'vag1na '),
	(240,'vagiina '),
	(241,'vagina '),
	(242,'vaj1na '),
	(243,'vajina '),
	(244,'vullva '),
	(245,'vulva '),
	(246,'w0p '),
	(247,'wh00r '),
	(248,'wh0re '),
	(249,'whore '),
	(250,'xrated '),
	(251,'xxx'),
	(252,'b!+ch'),
	(253,'bitch'),
	(254,'blowjob'),
	(255,'clit'),
	(256,'arschloch'),
	(257,'fuck'),
	(258,'shit'),
	(259,'ass'),
	(260,'asshole'),
	(261,'b!tch'),
	(262,'b17ch'),
	(263,'b1tch'),
	(264,'bastard'),
	(265,'bi+ch'),
	(266,'boiolas'),
	(267,'buceta'),
	(268,'c0ck'),
	(269,'cawk'),
	(270,'chink'),
	(271,'cipa'),
	(272,'clits'),
	(273,'cock'),
	(274,'cum'),
	(275,'cunt'),
	(276,'dildo'),
	(277,'dirsa'),
	(278,'ejakulate'),
	(279,'fatass'),
	(280,'fcuk'),
	(281,'fuk'),
	(282,'fux0r'),
	(283,'hoer'),
	(284,'hore'),
	(285,'jism'),
	(286,'kawk'),
	(287,'l3itch'),
	(288,'l3i+ch'),
	(289,'lesbian'),
	(290,'masturbate'),
	(291,'masterbat*'),
	(292,'masterbat3'),
	(293,'motherfucker'),
	(294,'s.o.b.'),
	(295,'mofo'),
	(296,'nazi'),
	(297,'nigga'),
	(298,'nigger'),
	(299,'nutsack'),
	(300,'phuck'),
	(301,'pimpis'),
	(302,'pusse'),
	(303,'pussy'),
	(304,'scrotum'),
	(305,'sh!t'),
	(306,'shemale'),
	(307,'shi+'),
	(308,'sh!+'),
	(309,'slut'),
	(310,'smut'),
	(311,'teets'),
	(312,'tits'),
	(313,'boobs'),
	(314,'b00bs'),
	(315,'teez'),
	(316,'testical'),
	(317,'testicle'),
	(318,'titt'),
	(319,'w00se'),
	(320,'jackoff'),
	(321,'wank'),
	(322,'whoar'),
	(323,'whore'),
	(324,'*damn'),
	(325,'*dyke'),
	(326,'*fuck*'),
	(327,'*shit*'),
	(328,'@$$'),
	(329,'amcik'),
	(330,'andskota'),
	(331,'arse*'),
	(332,'assrammer'),
	(333,'ayir'),
	(334,'bi7ch'),
	(335,'bitch*'),
	(336,'bollock*'),
	(337,'breasts'),
	(338,'butt-pirate'),
	(339,'cabron'),
	(340,'cazzo'),
	(341,'chraa'),
	(342,'chuj'),
	(343,'Cock*'),
	(344,'cunt*'),
	(345,'d4mn'),
	(346,'daygo'),
	(347,'dego'),
	(348,'dick*'),
	(349,'dike*'),
	(350,'dupa'),
	(351,'dziwka'),
	(352,'ejackulate'),
	(353,'Ekrem*'),
	(354,'Ekto'),
	(355,'enculer'),
	(356,'faen'),
	(357,'fag*'),
	(358,'fanculo'),
	(359,'fanny'),
	(360,'feces'),
	(361,'feg'),
	(362,'Felcher'),
	(363,'ficken'),
	(364,'fitt*'),
	(365,'Flikker'),
	(366,'foreskin'),
	(367,'Fotze'),
	(368,'Fu(*'),
	(369,'fuk*'),
	(370,'futkretzn'),
	(371,'gay'),
	(372,'gook'),
	(373,'guiena'),
	(374,'h0r'),
	(375,'h4x0r'),
	(376,'hell'),
	(377,'helvete'),
	(378,'hoer*'),
	(379,'honkey'),
	(380,'Huevon'),
	(381,'hui'),
	(382,'injun'),
	(383,'jizz'),
	(384,'kanker*'),
	(385,'kike'),
	(386,'klootzak'),
	(387,'kraut'),
	(388,'knulle'),
	(389,'kuk'),
	(390,'kuksuger'),
	(391,'Kurac'),
	(392,'kurwa'),
	(393,'kusi*'),
	(394,'kyrpa*'),
	(395,'lesbo'),
	(396,'mamhoon'),
	(397,'masturbat*'),
	(398,'merd*'),
	(399,'mibun'),
	(400,'monkleigh'),
	(401,'mouliewop'),
	(402,'muie'),
	(403,'mulkku'),
	(404,'muschi'),
	(405,'nazis'),
	(406,'nepesaurio'),
	(407,'nigger*'),
	(408,'orospu'),
	(409,'paska*'),
	(410,'perse'),
	(411,'picka'),
	(412,'pierdol*'),
	(413,'pillu*'),
	(414,'pimmel'),
	(415,'piss*'),
	(416,'pizda'),
	(417,'poontsee'),
	(418,'poop'),
	(419,'porn'),
	(420,'p0rn'),
	(421,'pr0n'),
	(422,'preteen'),
	(423,'pula'),
	(424,'pule'),
	(425,'puta'),
	(426,'puto'),
	(427,'qahbeh'),
	(428,'queef*'),
	(429,'rautenberg'),
	(430,'schaffer'),
	(431,'scheiss*'),
	(432,'schlampe'),
	(433,'schmuck'),
	(434,'screw'),
	(435,'sh!t*'),
	(436,'sharmuta'),
	(437,'sharmute'),
	(438,'shipal'),
	(439,'shiz'),
	(440,'skribz'),
	(441,'skurwysyn'),
	(442,'sphencter'),
	(443,'spic'),
	(444,'spierdalaj'),
	(445,'splooge'),
	(446,'suka'),
	(447,'b00b*'),
	(448,'testicle*'),
	(449,'titt*'),
	(450,'twat'),
	(451,'vittu'),
	(452,'wank*'),
	(453,'wetback*'),
	(454,'wichser'),
	(455,'wop*'),
	(456,'yed'),
	(457,'zabourah'),
	(458,'vag');

/*!40000 ALTER TABLE `profanity_list` ENABLE KEYS */;
UNLOCK TABLES;



# Dump of table shop_currency
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shop_currency`;

CREATE TABLE `shop_currency` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `code` char(3) NOT NULL DEFAULT '',
  `symbol` varchar(10) NOT NULL DEFAULT '',
  `label` varchar(50) NOT NULL DEFAULT '',
  `decimal_precision` tinyint(1) unsigned NOT NULL DEFAULT '2',
  `base_exchange` float(10,6) NOT NULL,
  `is_active` tinyint(1) unsigned NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `created_by` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `shop_currency_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table shop_order
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shop_order`;

CREATE TABLE `shop_order` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ref` char(13) NOT NULL DEFAULT '',
  `code` varchar(100) NOT NULL DEFAULT '',
  `user_id` int(11) unsigned DEFAULT NULL,
  `user_email` varchar(255) DEFAULT NULL,
  `user_first_name` varchar(150) DEFAULT NULL,
  `user_last_name` varchar(150) DEFAULT NULL,
  `ip_address` varchar(25) DEFAULT NULL,
  `currency_id` int(11) unsigned NOT NULL,
  `base_currency_id` int(11) unsigned NOT NULL,
  `payment_gateway_id` int(11) unsigned DEFAULT NULL,
  `shipping_method_id` int(11) unsigned DEFAULT NULL,
  `voucher_id` int(11) unsigned DEFAULT NULL,
  `status` enum('PENDING','VERIFIED','ABANDONED','CANCELLED','FAILED') NOT NULL DEFAULT 'PENDING',
  `requires_shipping` tinyint(1) unsigned NOT NULL,
  `fulfilment_status` enum('UNFULFILLED','FULFILLED') NOT NULL DEFAULT 'UNFULFILLED',
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `fulfilled` datetime DEFAULT NULL,
  `exchange_rate` float(10,6) unsigned NOT NULL DEFAULT '1.000000',
  `shipping_total` float(10,2) unsigned NOT NULL,
  `sub_total` float(10,2) unsigned NOT NULL,
  `tax_shipping` float(10,2) unsigned NOT NULL,
  `tax_items` float(10,2) unsigned NOT NULL COMMENT '10,2',
  `discount_shipping` float(10,2) unsigned NOT NULL,
  `discount_items` float(10,2) unsigned NOT NULL,
  `grand_total` float(10,2) unsigned NOT NULL,
  `fees_deducted` float(10,2) unsigned NOT NULL,
  `shipping_addressee` varchar(150) DEFAULT NULL,
  `shipping_line_1` varchar(150) DEFAULT NULL,
  `shipping_line_2` varchar(150) DEFAULT NULL,
  `shipping_town` varchar(150) DEFAULT NULL,
  `shipping_postcode` varchar(150) DEFAULT NULL,
  `shipping_country` varchar(150) DEFAULT NULL,
  `shipping_state` varchar(150) DEFAULT NULL,
  `pp_txn_id` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `currency_id` (`currency_id`),
  KEY `payment_gateway_id` (`payment_gateway_id`),
  KEY `base_currency_id` (`base_currency_id`),
  KEY `ref` (`ref`),
  KEY `user_id_2` (`user_id`,`status`),
  KEY `voucher_id` (`voucher_id`),
  KEY `user_email` (`user_email`),
  KEY `shipping_method_id` (`shipping_method_id`),
  CONSTRAINT `shop_order_ibfk_2` FOREIGN KEY (`currency_id`) REFERENCES `shop_currency` (`id`),
  CONSTRAINT `shop_order_ibfk_3` FOREIGN KEY (`payment_gateway_id`) REFERENCES `shop_payment_gateway` (`id`),
  CONSTRAINT `shop_order_ibfk_4` FOREIGN KEY (`base_currency_id`) REFERENCES `shop_currency` (`id`),
  CONSTRAINT `shop_order_ibfk_5` FOREIGN KEY (`voucher_id`) REFERENCES `shop_voucher` (`id`),
  CONSTRAINT `shop_order_ibfk_6` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `shop_order_ibfk_7` FOREIGN KEY (`shipping_method_id`) REFERENCES `shop_shipping_method` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table shop_order_product
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shop_order_product`;

CREATE TABLE `shop_order_product` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(11) unsigned NOT NULL,
  `product_id` int(11) unsigned NOT NULL,
  `quantity` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `title` varchar(150) DEFAULT '',
  `price` float(10,2) unsigned NOT NULL,
  `sale_price` float(10,2) unsigned NOT NULL,
  `tax` float(10,2) unsigned NOT NULL,
  `shipping` float(10,2) unsigned NOT NULL,
  `shipping_tax` float(10,2) DEFAULT NULL,
  `total` float(10,2) DEFAULT NULL,
  `tax_rate_id` int(11) unsigned DEFAULT NULL,
  `was_on_sale` tinyint(1) unsigned NOT NULL,
  `processed` tinyint(1) unsigned NOT NULL,
  `refunded` tinyint(1) unsigned NOT NULL,
  `refunded_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `shop_order_product_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `shop_order` (`id`) ON DELETE CASCADE,
  CONSTRAINT `shop_order_product_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `shop_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table shop_payment_gateway
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shop_payment_gateway`;

CREATE TABLE `shop_payment_gateway` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(50) DEFAULT NULL,
  `label` varchar(50) NOT NULL DEFAULT '',
  `logo` varchar(50) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) unsigned NOT NULL,
  `account_id` varchar(100) DEFAULT NULL,
  `api_key` varchar(100) DEFAULT NULL,
  `api_secret` varchar(100) DEFAULT NULL,
  `sandbox_account_id` varchar(100) DEFAULT NULL,
  `sandbox_api_key` varchar(100) DEFAULT NULL,
  `sandbox_api_secret` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table shop_product
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shop_product`;

CREATE TABLE `shop_product` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type_id` int(11) unsigned NOT NULL,
  `title` varchar(150) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `seo_title` varchar(255) DEFAULT NULL,
  `seo_description` varchar(255) DEFAULT NULL,
  `seo_keywords` varchar(255) DEFAULT NULL,
  `price` float(10,2) NOT NULL,
  `sale_price` float(10,2) NOT NULL,
  `tax_rate_id` int(11) unsigned DEFAULT NULL,
  `is_on_sale` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `sale_start` datetime DEFAULT NULL,
  `sale_end` datetime DEFAULT NULL,
  `is_active` tinyint(1) unsigned NOT NULL,
  `is_deleted` tinyint(1) unsigned NOT NULL,
  `quantity_available` int(11) unsigned DEFAULT NULL,
  `quantity_sold` int(11) unsigned DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `created_by` int(11) unsigned DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `modified_by` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `type_id` (`type_id`),
  KEY `created_by` (`created_by`),
  KEY `tax_rate_id` (`tax_rate_id`),
  KEY `modified_by` (`modified_by`),
  CONSTRAINT `shop_product_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `shop_product_type` (`id`),
  CONSTRAINT `shop_product_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `shop_product_ibfk_3` FOREIGN KEY (`tax_rate_id`) REFERENCES `shop_tax_rate` (`id`),
  CONSTRAINT `shop_product_ibfk_4` FOREIGN KEY (`modified_by`) REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table shop_product_gallery
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shop_product_gallery`;

CREATE TABLE `shop_product_gallery` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(11) unsigned NOT NULL,
  `media_type` enum('IMAGE','YOUTUBE','VIMEO') NOT NULL DEFAULT 'IMAGE',
  `title` varchar(150) NOT NULL DEFAULT '',
  `order` tinyint(1) unsigned NOT NULL,
  `image_filename` varchar(50) DEFAULT '',
  `youtube_id` varchar(50) DEFAULT NULL,
  `vimeo_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `shop_product_gallery_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `shop_product` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table shop_product_meta
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shop_product_meta`;

CREATE TABLE `shop_product_meta` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(11) unsigned NOT NULL,
  `download_bucket` varchar(50) DEFAULT NULL,
  `download_filename` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `shop_product_meta_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `shop_product` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table shop_product_shipping_method
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shop_product_shipping_method`;

CREATE TABLE `shop_product_shipping_method` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(11) unsigned NOT NULL,
  `shipping_method_id` int(11) unsigned NOT NULL,
  `price` float(10,2) unsigned NOT NULL,
  `price_additional` float(10,2) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table shop_product_tax_rate
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shop_product_tax_rate`;

CREATE TABLE `shop_product_tax_rate` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(150) NOT NULL DEFAULT '',
  `rate` float(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table shop_product_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shop_product_type`;

CREATE TABLE `shop_product_type` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(100) NOT NULL DEFAULT '',
  `label` varchar(150) NOT NULL DEFAULT '',
  `requires_shipping` tinyint(1) unsigned NOT NULL,
  `ipn_method` varchar(50) DEFAULT NULL,
  `max_per_order` tinyint(1) unsigned DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table shop_settings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shop_settings`;

CREATE TABLE `shop_settings` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(50) NOT NULL DEFAULT '',
  `value` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `shop_settings` WRITE;
/*!40000 ALTER TABLE `shop_settings` DISABLE KEYS */;

INSERT INTO `shop_settings` (`id`, `key`, `value`)
VALUES
  (1,'base_currency','i:52;'),
  (2,'notify_order','s:24:\"hello@shedcollective.org\";'),
  (3,'shop_url','s:5:\"shop/\";'),
  (4,'free_shipping_threshold','d:50;'),
  (5,'invoice_company','s:19:\"Some dude\'s company\";'),
  (6,'invoice_company_no','s:9:\"123456789\";'),
  (7,'invoice_address','s:28:\"27 Truman Walk\nLondon\nE3 3GQ\";'),
  (8,'invoice_vat_no','s:9:\"VAT123456\";');

/*!40000 ALTER TABLE `shop_settings` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table shop_shipping_method
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shop_shipping_method`;

CREATE TABLE `shop_shipping_method` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `courier` varchar(100) DEFAULT NULL,
  `method` varchar(100) DEFAULT NULL,
  `notes` text,
  `default_price` float(10,2) unsigned NOT NULL,
  `default_price_additional` float(10,2) unsigned NOT NULL,
  `tax_rate_id` int(11) unsigned DEFAULT NULL,
  `is_active` tinyint(1) unsigned NOT NULL,
  `is_deleted` tinyint(1) unsigned NOT NULL,
  `is_default` tinyint(1) unsigned NOT NULL,
  `order` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `shop_shipping_method` WRITE;
/*!40000 ALTER TABLE `shop_shipping_method` DISABLE KEYS */;

INSERT INTO `shop_shipping_method` (`id`, `courier`, `method`, `notes`, `default_price`, `default_price_additional`, `tax_rate_id`, `is_active`, `is_deleted`, `is_default`, `order`)
VALUES
  (1,'Royal Mail','1st Class',NULL,2.50,1.00,NULL,1,0,0,0),
  (2,'Royal Mail','2nd Class',NULL,1.50,0.75,NULL,1,0,1,1),
  (3,'Royal Mail','Recorded',NULL,3.20,2.00,NULL,1,0,0,2),
  (4,'Royal Mail','Next Day','Orders placed before 1pm will be processed same day and delivered the next working day. Orders placed after 1pm will be processed the following day.',5.00,5.00,NULL,1,0,0,3),
  (5,'UPS','Next Day','For next day delivery orders must be placed before noon.',6.00,6.00,1,1,0,0,0);

/*!40000 ALTER TABLE `shop_shipping_method` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table shop_tax_rate
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shop_tax_rate`;

CREATE TABLE `shop_tax_rate` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(150) NOT NULL DEFAULT '',
  `rate` float(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `shop_tax_rate` WRITE;
/*!40000 ALTER TABLE `shop_tax_rate` DISABLE KEYS */;

INSERT INTO `shop_tax_rate` (`id`, `label`, `rate`)
VALUES
  (1,'UK VAT',0.20);

/*!40000 ALTER TABLE `shop_tax_rate` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table shop_voucher
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shop_voucher`;

CREATE TABLE `shop_voucher` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(25) NOT NULL,
  `type` enum('NORMAL','LIMITED_USE','GIFT_CARD') NOT NULL DEFAULT 'NORMAL',
  `discount_type` enum('PERCENTAGE','AMOUNT') NOT NULL DEFAULT 'PERCENTAGE',
  `discount_value` float(10,6) unsigned NOT NULL,
  `discount_application` enum('PRODUCTS','PRODUCT_TYPES','SHIPPING','ALL') NOT NULL DEFAULT 'PRODUCTS',
  `label` varchar(150) NOT NULL DEFAULT '',
  `valid_from` datetime NOT NULL,
  `valid_to` datetime DEFAULT NULL,
  `use_count` tinyint(1) unsigned NOT NULL,
  `limited_use_limit` int(11) unsigned NOT NULL,
  `gift_card_balance` float(10,6) unsigned NOT NULL,
  `product_type_id` int(11) unsigned DEFAULT NULL,
  `created` datetime NOT NULL,
  `created_by` int(11) unsigned DEFAULT NULL,
  `modified` datetime NOT NULL,
  `modified_by` int(11) unsigned DEFAULT NULL,
  `last_used` datetime DEFAULT NULL,
  `is_active` tinyint(1) unsigned NOT NULL,
  `is_deleted` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `code_2` (`code`,`is_deleted`),
  KEY `code_3` (`code`,`is_active`,`is_deleted`),
  KEY `product_type_id` (`product_type_id`),
  CONSTRAINT `shop_voucher_ibfk_1` FOREIGN KEY (`product_type_id`) REFERENCES `shop_product_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table timezone
# ------------------------------------------------------------

DROP TABLE IF EXISTS `timezone`;

CREATE TABLE `timezone` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `gmt_offset` tinyint(11) NOT NULL,
  `label` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `timezone` WRITE;
/*!40000 ALTER TABLE `timezone` DISABLE KEYS */;

INSERT INTO `timezone` (`id`, `gmt_offset`, `label`)
VALUES
	(1,-11,'International Date Line West'),
	(2,-11,'Midway Island'),
	(3,-10,'Hawaii'),
	(4,-9,'Alaska'),
	(5,-8,'Pacific Time (US &amp; Canada)'),
	(6,-8,'Tijuana'),
	(7,-7,'Arizona'),
	(8,-7,'Chihuahua'),
	(9,-7,'Mazatlan'),
	(10,-7,'Mountain Time (US &amp; Canada)'),
	(11,-6,'Central America'),
	(12,-6,'Central Time (US &amp; Canada)'),
	(13,-6,'Guadalajara'),
	(14,-6,'Mexico City'),
	(15,-6,'Monterrey'),
	(16,-6,'Saskatchewan'),
	(17,-5,'Bogota'),
	(18,-5,'Eastern Time (US &amp; Canada)'),
	(19,-5,'Indiana (East)'),
	(20,-5,'Lima'),
	(21,-5,'Quito'),
	(22,-4,'Caracas'),
	(23,-4,'Atlantic Time (Canada)'),
	(24,-4,'Georgetown'),
	(25,-4,'La Paz'),
	(26,-4,'Santiago'),
	(27,-3,'Newfoundland'),
	(28,-3,'Brasilia'),
	(29,-3,'Buenos Aires'),
	(30,-3,'Greenland'),
	(31,-2,'Mid-Atlantic'),
	(32,-1,'Azores'),
	(33,-1,'Cape Verde Is.'),
	(34,0,'Casablanca'),
	(35,0,'Dublin'),
	(36,0,'Edinburgh'),
	(37,0,'Lisbon'),
	(38,0,'London'),
	(39,0,'Monrovia'),
	(40,0,'UTC'),
	(41,1,'Amsterdam'),
	(42,1,'Belgrade'),
	(43,1,'Berlin'),
	(44,1,'Bern'),
	(45,1,'Bratislava'),
	(46,1,'Brussels'),
	(47,1,'Budapest'),
	(48,1,'Copenhagen'),
	(49,1,'Ljubljana'),
	(50,1,'Madrid'),
	(51,1,'Paris'),
	(52,1,'Prague'),
	(53,1,'Rome'),
	(54,1,'Sarajevo'),
	(55,1,'Skopje'),
	(56,1,'Stockholm'),
	(57,1,'Vienna'),
	(58,1,'Warsaw'),
	(59,1,'West Central Africa'),
	(60,1,'Zagreb'),
	(61,2,'Athens'),
	(62,2,'Bucharest'),
	(63,2,'Cairo'),
	(64,2,'Harare'),
	(65,2,'Helsinki'),
	(66,2,'Istanbul'),
	(67,2,'Jerusalem'),
	(68,2,'Kyiv'),
	(69,2,'Pretoria'),
	(70,2,'Riga'),
	(71,2,'Sofia'),
	(72,2,'Tallinn'),
	(73,2,'Vilnius'),
	(74,3,'Baghdad'),
	(75,3,'Kuwait'),
	(76,3,'Minsk'),
	(77,3,'Nairobi'),
	(78,3,'Riyadh'),
	(79,3,'Tehran'),
	(80,4,'Abu Dhabi'),
	(81,4,'Baku'),
	(82,4,'Moscow'),
	(83,4,'Muscat'),
	(84,4,'St. Petersburg'),
	(85,4,'Tbilisi'),
	(86,4,'Volgograd'),
	(87,4,'Yerevan'),
	(88,4,'Kabul'),
	(89,5,'Islamabad'),
	(90,5,'Karachi'),
	(91,5,'Tashkent'),
	(92,5,'Chennai'),
	(93,5,'Kolkata'),
	(94,5,'Mumbai'),
	(95,5,'New Delhi'),
	(96,5,'Sri Jayawardenepura'),
	(97,5,'Kathmandu'),
	(98,6,'Almaty'),
	(99,6,'Astana'),
	(100,6,'Dhaka'),
	(101,6,'Ekaterinburg'),
	(102,6,'Rangoon'),
	(103,7,'Bangkok'),
	(104,7,'Hanoi'),
	(105,7,'Jakarta'),
	(106,7,'Novosibirsk'),
	(107,8,'Beijing'),
	(108,8,'Chongqing'),
	(109,8,'Hong Kong'),
	(110,8,'Krasnoyarsk'),
	(111,8,'Kuala Lumpur'),
	(112,8,'Perth'),
	(113,8,'Singapore'),
	(114,8,'Taipei'),
	(115,8,'Ulaan Bataar'),
	(116,8,'Urumqi'),
	(117,9,'Irkutsk'),
	(118,9,'Osaka'),
	(119,9,'Sapporo'),
	(120,9,'Seoul'),
	(121,9,'Tokyo'),
	(122,9,'Adelaide'),
	(123,9,'Darwin'),
	(124,10,'Brisbane'),
	(125,10,'Canberra'),
	(126,10,'Guam'),
	(127,10,'Hobart'),
	(128,10,'Melbourne'),
	(129,10,'Port Moresby'),
	(130,10,'Sydney'),
	(131,10,'Yakutsk'),
	(132,11,'New Caledonia'),
	(133,11,'Vladivostok'),
	(134,12,'Auckland'),
	(135,12,'Fiji'),
	(136,12,'Kamchatka'),
	(137,12,'Magadan'),
	(138,12,'Marshall Is.'),
	(139,12,'Solomon Is.'),
	(140,12,'Wellington'),
	(141,13,'Nuku\'alofa'),
	(142,13,'Samoa'),
	(143,13,'Tokelau Is.');

/*!40000 ALTER TABLE `timezone` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table url_short
# ------------------------------------------------------------

DROP TABLE IF EXISTS `url_short`;

CREATE TABLE `url_short` (
  `id` char(32) NOT NULL DEFAULT '',
  `translates_as` varchar(350) NOT NULL DEFAULT '',
  `created` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_md5` char(32) DEFAULT NULL,
  `auth_method_id` int(11) unsigned NOT NULL DEFAULT '1',
  `group_id` int(11) unsigned NOT NULL,
  `fb_id` bigint(20) unsigned DEFAULT NULL,
  `fb_token` varchar(255) DEFAULT NULL,
  `tw_id` bigint(20) unsigned DEFAULT NULL,
  `tw_token` varchar(255) DEFAULT NULL,
  `tw_secret` varchar(255) DEFAULT NULL,
  `li_id` varchar(15) DEFAULT NULL,
  `li_token` varchar(255) DEFAULT NULL,
  `li_secret` varchar(255) DEFAULT NULL,
  `ip_address` char(16) NOT NULL,
  `last_ip` char(16) DEFAULT NULL,
  `username` varchar(30) DEFAULT NULL,
  `password` varchar(40) DEFAULT '',
  `password_md5` char(32) DEFAULT NULL,
  `salt` varchar(40) DEFAULT NULL,
  `email` varchar(255) NOT NULL DEFAULT '',
  `activation_code` varchar(40) DEFAULT NULL,
  `forgotten_password_code` varchar(40) DEFAULT NULL,
  `remember_code` varchar(40) DEFAULT NULL,
  `created` datetime NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `last_seen` datetime DEFAULT NULL,
  `is_verified` tinyint(1) unsigned DEFAULT '0',
  `is_suspended` tinyint(1) unsigned DEFAULT '0',
  `temp_pw` tinyint(1) unsigned DEFAULT '0',
  `failed_login_count` tinyint(4) unsigned DEFAULT '0',
  `failed_login_expires` datetime DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  `user_acl` text,
  `login_count` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_unique` (`email`),
  KEY `group_id` (`group_id`),
  KEY `auth_method_id` (`auth_method_id`),
  KEY `email_index` (`email`),
  KEY `fb_token` (`fb_token`),
  KEY `fb_id` (`fb_id`),
  KEY `id_md5` (`id_md5`),
  KEY `password_md5` (`password_md5`),
  KEY `activation_code` (`activation_code`),
  KEY `email` (`email`),
  KEY `forgotten_password_code` (`forgotten_password_code`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `user_group` (`id`),
  CONSTRAINT `user_ibfk_2` FOREIGN KEY (`auth_method_id`) REFERENCES `user_auth_method` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table user_auth_method
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_auth_method`;

CREATE TABLE `user_auth_method` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `user_auth_method` WRITE;
/*!40000 ALTER TABLE `user_auth_method` DISABLE KEYS */;

INSERT INTO `user_auth_method` (`id`, `type`)
VALUES
	(2,'facebook'),
	(5,'linkedin'),
	(1,'native'),
	(4,'open_id'),
	(3,'twitter');

/*!40000 ALTER TABLE `user_auth_method` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user_group
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_group`;

CREATE TABLE `user_group` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `display_name` varchar(20) NOT NULL DEFAULT '',
  `description` varchar(500) NOT NULL,
  `default_homepage` varchar(255) NOT NULL,
  `registration_redirect` varchar(255) DEFAULT NULL,
  `acl` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `user_group` WRITE;
/*!40000 ALTER TABLE `user_group` DISABLE KEYS */;

INSERT INTO `user_group` (`id`, `name`, `display_name`, `description`, `default_homepage`, `acl`)
VALUES
	(1,'superuser','Superuser','Superuser\'s have complete access to all modules in admin regardless of specific module allocations.','/admin','a:2:{s:9:\"superuser\";b:1;s:5:\"admin\";a:1:{i:0;s:9:\"dashboard\";}}'),
	(2,'admin','Administrator','Administrators have access to specific areas within admin.','/admin','a:1:{s:5:\"admin\";a:1:{i:0;s:9:\"dashboard\";}}'),
	(3,'member','Member','Members have no access to admin.','/',NULL);

/*!40000 ALTER TABLE `user_group` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user_meta
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_meta`;

CREATE TABLE `user_meta` (
  `user_id` int(11) unsigned NOT NULL,
  `referral` varchar(10) DEFAULT NULL,
  `referred_by` int(11) unsigned DEFAULT NULL,
  `first_name` varchar(150) NOT NULL DEFAULT '',
  `last_name` varchar(150) NOT NULL DEFAULT '',
  `gender` enum('undisclosed','male','female','transgender','other') NOT NULL DEFAULT 'undisclosed',
  `timezone_id` int(11) unsigned NOT NULL DEFAULT '40',
  `date_format_date_id` int(11) unsigned NOT NULL DEFAULT '1',
  `date_format_time_id` int(11) unsigned NOT NULL DEFAULT '1',
  `language_id` int(11) unsigned NOT NULL DEFAULT '202',
  `profile_img` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_id_2` (`user_id`),
  KEY `user_id` (`user_id`),
  KEY `last_name` (`last_name`,`first_name`),
  KEY `first_name` (`first_name`,`last_name`),
  KEY `referred_by` (`referred_by`),
  KEY `referral` (`referral`),
  KEY `timezone_id` (`timezone_id`),
  CONSTRAINT `user_meta_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_meta_ibfk_4` FOREIGN KEY (`timezone_id`) REFERENCES `timezone` (`id`),
  CONSTRAINT `user_meta_ibfk_5` FOREIGN KEY (`date_format_date_id`) REFERENCES `date_format_date` (`id`),
  CONSTRAINT `user_meta_ibfk_6` FOREIGN KEY (`date_format_time_id`) REFERENCES `date_format_time` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
