/*
SQLyog Community v13.1.6 (64 bit)
MySQL - 5.7.37 : Database - kanayama
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`kanayama` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `kanayama`;

/*Table structure for table `animal_breed` */

DROP TABLE IF EXISTS `animal_breed`;

CREATE TABLE `animal_breed` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `specie_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `animal_breed_specie_id_dcf86d30_fk` (`specie_id`),
  CONSTRAINT `animal_breed_specie_id_dcf86d30_fk` FOREIGN KEY (`specie_id`) REFERENCES `animal_specie` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `animal_breed` */

insert  into `animal_breed`(`id`,`name`,`created_at`,`updated_at`,`specie_id`) values 
(1,'Pitbull','2021-11-09 22:58:54.522297','2021-11-09 22:58:54.522359',3),
(2,'Yorkshire','2021-11-09 22:59:48.876192','2021-11-09 22:59:48.876244',3),
(3,'Outros','2021-11-09 22:59:58.857618','2022-05-04 22:05:36.660728',3);

/*Table structure for table `animal_coat` */

DROP TABLE IF EXISTS `animal_coat`;

CREATE TABLE `animal_coat` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `animal_coat` */

insert  into `animal_coat`(`id`,`name`,`created_at`,`updated_at`) values 
(1,'Curta','2021-11-03 19:53:21.721893','2021-11-03 19:53:21.721995'),
(2,'Longa','2021-11-03 19:53:27.151514','2021-11-03 19:53:27.151556'),
(3,'Outro','2021-11-29 11:51:07.534999','2021-11-29 11:51:07.535034');

/*Table structure for table `animal_color` */

DROP TABLE IF EXISTS `animal_color`;

CREATE TABLE `animal_color` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `animal_color` */

insert  into `animal_color`(`id`,`name`,`created_at`,`updated_at`) values 
(1,'Preto','2021-11-03 19:27:58.603742','2021-11-03 19:27:58.603785'),
(2,'Branco','2021-11-03 19:28:04.151919','2021-11-03 19:28:04.151987'),
(3,'Marrom','2021-11-03 19:28:10.278163','2021-11-03 19:28:10.278208'),
(4,'Begê','2021-11-03 19:28:15.052425','2021-11-03 19:28:15.052471'),
(5,'Outra','2021-11-29 11:51:23.683008','2021-11-29 11:51:23.683042');

/*Table structure for table `animal_interest` */

DROP TABLE IF EXISTS `animal_interest`;

CREATE TABLE `animal_interest` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `login_id` bigint(20) NOT NULL,
  `pet_id` bigint(20) NOT NULL,
  `confirm` varchar(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `animal_interest_login_id_d92da4fc_fk_login_login_id` (`login_id`),
  KEY `animal_interest_pet_id_20480837_fk_animal_pet_id` (`pet_id`),
  CONSTRAINT `animal_interest_login_id_d92da4fc_fk_login_login_id` FOREIGN KEY (`login_id`) REFERENCES `login_login` (`id`),
  CONSTRAINT `animal_interest_pet_id_20480837_fk_animal_pet_id` FOREIGN KEY (`pet_id`) REFERENCES `animal_pet` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

/*Data for the table `animal_interest` */

insert  into `animal_interest`(`id`,`created_at`,`login_id`,`pet_id`,`confirm`) values 
(3,'2021-11-23 20:57:05.044420',17,1,'A'),
(4,'2021-11-23 21:00:53.322462',17,2,'N'),
(5,'2021-11-25 17:45:21.663124',21,3,'I'),
(18,'2022-05-06 21:44:17.899202',1,7,'I');

/*Table structure for table `animal_pet` */

DROP TABLE IF EXISTS `animal_pet`;

CREATE TABLE `animal_pet` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `genre` varchar(1) NOT NULL,
  `microship` varchar(150) NOT NULL,
  `age` smallint(5) unsigned NOT NULL,
  `castrated` tinyint(1) NOT NULL,
  `weight` smallint(5) unsigned NOT NULL,
  `height` smallint(5) unsigned NOT NULL,
  `personality` varchar(150) NOT NULL,
  `vaccination` varchar(150) NOT NULL,
  `available` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `breed_id` bigint(20) NOT NULL,
  `coat_id` bigint(20) DEFAULT NULL,
  `color_id` bigint(20) DEFAULT NULL,
  `login_id` bigint(20) NOT NULL,
  `specie_id` bigint(20) NOT NULL,
  `photo` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `animal_pet_breed_id_100f2d12_fk` (`breed_id`),
  KEY `animal_pet_coat_id_f849f3fa_fk` (`coat_id`),
  KEY `animal_pet_color_id_240ae0d7_fk` (`color_id`),
  KEY `animal_pet_specie_id_9b1e8467_fk` (`specie_id`),
  KEY `animal_pet_login_id_4f3d1760_fk` (`login_id`),
  CONSTRAINT `animal_pet_breed_id_100f2d12_fk` FOREIGN KEY (`breed_id`) REFERENCES `animal_breed` (`id`),
  CONSTRAINT `animal_pet_coat_id_f849f3fa_fk` FOREIGN KEY (`coat_id`) REFERENCES `animal_coat` (`id`),
  CONSTRAINT `animal_pet_color_id_240ae0d7_fk` FOREIGN KEY (`color_id`) REFERENCES `animal_color` (`id`),
  CONSTRAINT `animal_pet_login_id_4f3d1760_fk` FOREIGN KEY (`login_id`) REFERENCES `login_login` (`id`),
  CONSTRAINT `animal_pet_specie_id_9b1e8467_fk` FOREIGN KEY (`specie_id`) REFERENCES `animal_specie` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Data for the table `animal_pet` */

insert  into `animal_pet`(`id`,`name`,`genre`,`microship`,`age`,`castrated`,`weight`,`height`,`personality`,`vaccination`,`available`,`created_at`,`updated_at`,`breed_id`,`coat_id`,`color_id`,`login_id`,`specie_id`,`photo`) values 
(1,'Lazim','M','1234',6,0,1,15,'Brincalhão','Em dia',0,'2021-11-09 23:10:50.867283','2022-05-05 20:41:54.042536',2,1,1,1,3,'animais/1_vozNY5D.jpeg'),
(2,'Thor','M','321',4,1,50,60,'Agressiva','Em dia',1,'2021-11-23 01:10:29.770091','2021-11-23 02:32:42.728274',1,2,3,1,3,'animais/2.jpg'),
(3,'5 Gatos','M','não',1,1,1,1,'Recém Nascido','',1,'2021-11-23 16:17:03.487316','2021-11-23 16:17:03.487352',3,1,4,18,2,'animais/None_rNIfMnD.jpg'),
(4,'Chico','M','não',1,1,5,20,'carinhoso','',1,'2021-11-27 22:10:32.187686','2021-11-27 22:10:32.187786',3,1,3,21,2,''),
(5,'Charlie ','M','',7,1,30,20,'Ruim','',1,'2021-11-27 22:13:10.909061','2021-11-27 22:13:10.909093',3,2,1,19,3,''),
(6,'Charlie ','M','',7,1,30,20,'Ruim','',1,'2021-11-27 22:17:13.820507','2021-11-27 22:17:13.820536',3,2,1,19,3,''),
(7,'bisteca','M','',1,1,10,45,'amigavel','',1,'2021-11-28 01:34:24.977211','2021-11-28 01:34:24.977245',3,1,3,22,3,'animais/None_RGF1EGC.jpg'),
(8,'Teste 2','M','123',1,1,1,15,'Brincalhão','Em dia',1,'2021-11-29 12:07:06.270810','2022-05-06 23:17:09.412617',3,1,1,1,4,'animais/8_AioVhIe.jpeg'),
(9,'Teste 3','F','1234',12,1,12,12,'Agitado','',1,'2022-05-09 11:46:21.633667','2022-05-09 11:46:21.633667',3,2,3,1,2,'animais/None_zzgO7jH.jpg');

/*Table structure for table `animal_specie` */

DROP TABLE IF EXISTS `animal_specie`;

CREATE TABLE `animal_specie` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `animal_specie` */

insert  into `animal_specie`(`id`,`name`,`created_at`,`updated_at`) values 
(1,'Passaro','2021-11-03 19:29:02.040834','2021-11-09 22:58:37.916162'),
(2,'Gato','2021-11-03 19:29:14.543585','2021-11-09 22:58:06.752729'),
(3,'Cachorro','2021-11-03 19:29:38.150723','2021-11-09 22:58:01.797676'),
(4,'Outro','2021-11-22 11:40:36.612099','2021-11-22 11:40:36.612137');

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `auth_group` */

/*Table structure for table `auth_group_permissions` */

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `auth_group_permissions` */

/*Table structure for table `auth_permission` */

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=latin1;

/*Data for the table `auth_permission` */

insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values 
(1,'Can add log entry',1,'add_logentry'),
(2,'Can change log entry',1,'change_logentry'),
(3,'Can delete log entry',1,'delete_logentry'),
(4,'Can view log entry',1,'view_logentry'),
(5,'Can add permission',2,'add_permission'),
(6,'Can change permission',2,'change_permission'),
(7,'Can delete permission',2,'delete_permission'),
(8,'Can view permission',2,'view_permission'),
(9,'Can add group',3,'add_group'),
(10,'Can change group',3,'change_group'),
(11,'Can delete group',3,'delete_group'),
(12,'Can view group',3,'view_group'),
(13,'Can add user',4,'add_user'),
(14,'Can change user',4,'change_user'),
(15,'Can delete user',4,'delete_user'),
(16,'Can view user',4,'view_user'),
(17,'Can add content type',5,'add_contenttype'),
(18,'Can change content type',5,'change_contenttype'),
(19,'Can delete content type',5,'delete_contenttype'),
(20,'Can view content type',5,'view_contenttype'),
(21,'Can add session',6,'add_session'),
(22,'Can change session',6,'change_session'),
(23,'Can delete session',6,'delete_session'),
(24,'Can view session',6,'view_session'),
(25,'Can add Espécie',7,'add_specie'),
(26,'Can change Espécie',7,'change_specie'),
(27,'Can delete Espécie',7,'delete_specie'),
(28,'Can view Espécie',7,'view_specie'),
(29,'Can add Raça',8,'add_breed'),
(30,'Can change Raça',8,'change_breed'),
(31,'Can delete Raça',8,'delete_breed'),
(32,'Can view Raça',8,'view_breed'),
(33,'Can add Cor',9,'add_color'),
(34,'Can change Cor',9,'change_color'),
(35,'Can delete Cor',9,'delete_color'),
(36,'Can view Cor',9,'view_color'),
(37,'Can add Pelagem',10,'add_coat'),
(38,'Can change Pelagem',10,'change_coat'),
(39,'Can delete Pelagem',10,'delete_coat'),
(40,'Can view Pelagem',10,'view_coat'),
(41,'Can add Animal',11,'add_pet'),
(42,'Can change Animal',11,'change_pet'),
(43,'Can delete Animal',11,'delete_pet'),
(44,'Can view Animal',11,'view_pet'),
(45,'Can add Clínica',12,'add_clinic'),
(46,'Can change Clínica',12,'change_clinic'),
(47,'Can delete Clínica',12,'delete_clinic'),
(48,'Can view Clínica',12,'view_clinic'),
(49,'Can add Usuário',13,'add_login'),
(50,'Can change Usuário',13,'change_login'),
(51,'Can delete Usuário',13,'delete_login'),
(52,'Can view Usuário',13,'view_login'),
(53,'Can add address',14,'add_address'),
(54,'Can change address',14,'change_address'),
(55,'Can delete address',14,'delete_address'),
(56,'Can view address',14,'view_address'),
(57,'Can add document',15,'add_document'),
(58,'Can change document',15,'change_document'),
(59,'Can delete document',15,'delete_document'),
(60,'Can view document',15,'view_document'),
(61,'Can add telephone',16,'add_telephone'),
(62,'Can change telephone',16,'change_telephone'),
(63,'Can delete telephone',16,'delete_telephone'),
(64,'Can view telephone',16,'view_telephone'),
(65,'Can add ong',17,'add_ong'),
(66,'Can change ong',17,'change_ong'),
(67,'Can delete ong',17,'delete_ong'),
(68,'Can view ong',17,'view_ong'),
(69,'Can add banner',18,'add_banner'),
(70,'Can change banner',18,'change_banner'),
(71,'Can delete banner',18,'delete_banner'),
(72,'Can view banner',18,'view_banner'),
(73,'Can add Quem Somos',19,'add_quemsomos'),
(74,'Can change Quem Somos',19,'change_quemsomos'),
(75,'Can delete Quem Somos',19,'delete_quemsomos'),
(76,'Can view Quem Somos',19,'view_quemsomos'),
(77,'Can add Contato',20,'add_contact'),
(78,'Can change Contato',20,'change_contact'),
(79,'Can delete Contato',20,'delete_contact'),
(80,'Can view Contato',20,'view_contact'),
(81,'Can add Destinatário',21,'add_recipient'),
(82,'Can change Destinatário',21,'change_recipient'),
(83,'Can delete Destinatário',21,'delete_recipient'),
(84,'Can view Destinatário',21,'view_recipient'),
(85,'Can add interest',22,'add_interest'),
(86,'Can change interest',22,'change_interest'),
(87,'Can delete interest',22,'delete_interest'),
(88,'Can view interest',22,'view_interest');

/*Table structure for table `auth_user` */

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `auth_user` */

insert  into `auth_user`(`id`,`password`,`last_login`,`is_superuser`,`username`,`first_name`,`last_name`,`email`,`is_staff`,`is_active`,`date_joined`) values 
(1,'pbkdf2_sha256$260000$okh3Ai1Zjb3ZnrAjcyOdw3$vd2xJXXuDNBmf/nsb4v6A0juZPmBuMDOi80FE2dpzfk=','2022-05-09 13:18:31.704395',1,'admin','','','admin@sospet.com',1,1,'2021-11-03 18:57:45.964257');

/*Table structure for table `auth_user_groups` */

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `auth_user_groups` */

/*Table structure for table `auth_user_user_permissions` */

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `auth_user_user_permissions` */

/*Table structure for table `banner_banner` */

DROP TABLE IF EXISTS `banner_banner`;

CREATE TABLE `banner_banner` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `banner` varchar(100) NOT NULL,
  `sort_order` int(10) unsigned NOT NULL,
  `active` tinyint(1) NOT NULL,
  `link` varchar(200) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `banner_banner` */

insert  into `banner_banner`(`id`,`title`,`banner`,`sort_order`,`active`,`link`,`created_at`,`updated_at`) values 
(6,'Adote um  animal de estimação','banners/bg_1_bMpGjjN.jpg',1,1,'http://www.kanayama.app.br/animais','2021-11-10 11:37:01.508002','2021-11-23 12:15:04.008989'),
(7,'Perdeu seu animal de estimação?','banners/bg_2_8IgvUaV.jpg',2,1,'http://www.kanayama.app.br/aminais/achados-perdidos','2021-11-10 13:33:55.129101','2021-11-23 12:15:17.794188');

/*Table structure for table `clinica_clinic` */

DROP TABLE IF EXISTS `clinica_clinic`;

CREATE TABLE `clinica_clinic` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(254) NOT NULL,
  `adress` longtext NOT NULL,
  `officeHours` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `clinica_clinic` */

/*Table structure for table `django_admin_log` */

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=latin1;

/*Data for the table `django_admin_log` */

insert  into `django_admin_log`(`id`,`action_time`,`object_id`,`object_repr`,`action_flag`,`change_message`,`content_type_id`,`user_id`) values 
(1,'2021-11-03 19:27:58.605442','1','Preto',1,'[{\"added\": {}}]',9,1),
(2,'2021-11-03 19:28:04.153072','2','Branco',1,'[{\"added\": {}}]',9,1),
(3,'2021-11-03 19:28:10.279315','3','Marrom',1,'[{\"added\": {}}]',9,1),
(4,'2021-11-03 19:28:15.053558','4','Begê',1,'[{\"added\": {}}]',9,1),
(5,'2021-11-03 19:29:02.042435','1','Yorkshire',1,'[{\"added\": {}}]',7,1),
(6,'2021-11-03 19:29:14.544976','2','Pitbull',1,'[{\"added\": {}}]',7,1),
(7,'2021-11-03 19:29:38.151808','3','Bulldog',1,'[{\"added\": {}}]',7,1),
(8,'2021-11-03 19:53:21.723884','1','Curta',1,'[{\"added\": {}}]',10,1),
(9,'2021-11-03 19:53:27.152515','2','Longa',1,'[{\"added\": {}}]',10,1),
(10,'2021-11-09 22:58:01.802244','3','Cachorro',2,'[{\"changed\": {\"fields\": [\"Esp\\u00e9cie\"]}}]',7,1),
(11,'2021-11-09 22:58:06.754338','2','Gato',2,'[{\"changed\": {\"fields\": [\"Esp\\u00e9cie\"]}}]',7,1),
(12,'2021-11-09 22:58:37.918837','1','Passaro',2,'[{\"changed\": {\"fields\": [\"Esp\\u00e9cie\"]}}]',7,1),
(13,'2021-11-09 22:58:54.524512','1','Pitbull',1,'[{\"added\": {}}]',8,1),
(14,'2021-11-09 22:59:48.878596','2','Yorkshire',1,'[{\"added\": {}}]',8,1),
(15,'2021-11-09 22:59:58.859299','3','Outros',1,'[{\"added\": {}}]',8,1),
(16,'2021-11-09 23:09:11.550362','1','Paulo Zapparolli',1,'[{\"added\": {}}]',13,1),
(17,'2021-11-09 23:10:50.870726','1','Lazim',1,'[{\"added\": {}}]',11,1),
(18,'2021-11-09 23:13:51.875447','1','Lazim',2,'[]',11,1),
(19,'2021-11-09 23:14:13.277917','1','Banner 1',1,'[{\"added\": {}}]',18,1),
(20,'2021-11-09 23:14:27.087302','2','Banner 2',1,'[{\"added\": {}}]',18,1),
(21,'2021-11-09 23:17:40.728574','2','Banner 2',2,'[{\"changed\": {\"fields\": [\"Banner\"]}}]',18,1),
(22,'2021-11-09 23:18:07.648336','2','Banner 2',2,'[{\"changed\": {\"fields\": [\"Banner\"]}}]',18,1),
(23,'2021-11-09 23:24:56.255006','2','Banner 2',3,'',18,1),
(24,'2021-11-09 23:24:56.256593','1','Banner 1',3,'',18,1),
(25,'2021-11-09 23:25:09.217780','3','Banner 1',1,'[{\"added\": {}}]',18,1),
(26,'2021-11-09 23:37:10.995466','4','Banner 1',1,'[{\"added\": {}}]',18,1),
(27,'2021-11-10 11:35:04.494109','5','Banner 1',1,'[{\"added\": {}}]',18,1),
(28,'2021-11-10 11:36:40.082222','5','Banner 1',3,'',18,1),
(29,'2021-11-10 11:37:01.511238','6','Banner',1,'[{\"added\": {}}]',18,1),
(30,'2021-11-10 13:31:08.902054','6','Adote um  animal de estimação',2,'[{\"changed\": {\"fields\": [\"T\\u00edtulo\", \"Link\"]}}]',18,1),
(31,'2021-11-10 13:32:25.889703','6','Adote um  animal de estimação',2,'[]',18,1),
(32,'2021-11-10 13:32:36.996697','6','Adote um  animal de estimação',2,'[{\"changed\": {\"fields\": [\"Banner\"]}}]',18,1),
(33,'2021-11-10 13:33:55.131211','7','Perdeu seu animal de estimação?',1,'[{\"added\": {}}]',18,1),
(34,'2021-11-10 21:24:52.571609','6','Adote um  animal de estimação',2,'[{\"changed\": {\"fields\": [\"Banner\"]}}]',18,1),
(35,'2021-11-10 21:25:02.152341','7','Perdeu seu animal de estimação?',2,'[{\"changed\": {\"fields\": [\"Banner\"]}}]',18,1),
(36,'2021-11-11 01:18:39.399550','1','Quem Somos',1,'[{\"added\": {}}]',19,1),
(37,'2021-11-11 01:34:36.275631','1','Quem Somos',2,'[]',19,1),
(38,'2021-11-11 01:53:39.817168','1','Quem Somos',2,'[]',19,1),
(39,'2021-11-12 22:06:32.467206','1','Quem Somos',2,'[{\"changed\": {\"fields\": [\"content\"]}}]',19,1),
(40,'2021-11-15 14:53:26.475198','5','Paulo Zapparolli',3,'',13,1),
(41,'2021-11-15 14:57:57.792313','6','Paulo Zapparolli',3,'',13,1),
(42,'2021-11-15 14:59:35.773860','7','Paulo Zapparolli',3,'',13,1),
(43,'2021-11-15 15:00:47.028489','8','Paulo Zapparolli',3,'',13,1),
(44,'2021-11-15 15:19:47.000378','9','Paulo Zapparolli',3,'',13,1),
(45,'2021-11-15 19:12:10.623364','10','Paulo Zapparolli',3,'',13,1),
(46,'2021-11-15 19:20:16.623158','11','Paulo Zapparolli',3,'',13,1),
(47,'2021-11-15 19:21:34.839045','12','Paulo Zapparolli',3,'',13,1),
(48,'2021-11-15 19:25:14.692630','13','Paulo Zapparolli',3,'',13,1),
(49,'2021-11-15 20:02:49.266808','14','Paulo Zapparolli',3,'',13,1),
(50,'2021-11-15 20:02:54.718743','15','Paulo Zapparolli',3,'',13,1),
(51,'2021-11-15 20:16:19.719626','16','Paulo Zapparolli',3,'',13,1),
(52,'2021-11-15 20:25:22.776397','1','Paulo Zapparolli',2,'[{\"changed\": {\"fields\": [\"Ativo?\"]}}]',13,1),
(53,'2021-11-17 00:52:15.462855','1','kanayama.zappa@gmail.com',1,'[{\"added\": {}}]',21,1),
(54,'2021-11-17 00:58:41.704852','2','kanayama.zappa@gmail.com',1,'[{\"added\": {}}]',21,1),
(55,'2021-11-22 11:40:36.613511','4','Outro',1,'[{\"added\": {}}]',7,1),
(56,'2021-11-22 22:55:00.027459','1','Lazim',2,'[{\"changed\": {\"fields\": [\"Foto\"]}}]',11,1),
(57,'2021-11-22 23:35:56.008432','1','Lazim',2,'[{\"changed\": {\"fields\": [\"Sexo\"]}}]',11,1),
(58,'2021-11-22 23:36:01.357007','1','Lazim',2,'[{\"changed\": {\"fields\": [\"Sexo\"]}}]',11,1),
(59,'2021-11-23 00:02:16.967962','1','Lazim',2,'[{\"changed\": {\"fields\": [\"Dispon\\u00edvel\"]}}]',11,1),
(60,'2021-11-23 00:02:24.114448','1','Lazim',2,'[{\"changed\": {\"fields\": [\"Dispon\\u00edvel\"]}}]',11,1),
(61,'2021-11-23 00:03:42.433571','1','Lazim',2,'[{\"changed\": {\"fields\": [\"Castrado\"]}}]',11,1),
(62,'2021-11-23 02:32:42.730178','2','Thor',2,'[{\"changed\": {\"fields\": [\"Personalidade\", \"Vacina\\u00e7\\u00e3o\"]}}]',11,1),
(63,'2021-11-23 12:14:58.428437','6','Adote um  animal de estimação',2,'[{\"changed\": {\"fields\": [\"Link\"]}}]',18,1),
(64,'2021-11-23 12:15:04.010604','6','Adote um  animal de estimação',2,'[]',18,1),
(65,'2021-11-23 12:15:17.795649','7','Perdeu seu animal de estimação?',2,'[{\"changed\": {\"fields\": [\"Link\"]}}]',18,1),
(66,'2021-11-23 14:01:44.843659','1','Teste ONG 1',1,'[{\"added\": {}}]',17,1),
(67,'2021-11-23 14:01:48.497496','1','Teste ONG 1',2,'[]',17,1),
(68,'2021-11-23 14:31:57.151035','1','Quem Somos',2,'[{\"changed\": {\"fields\": [\"content\"]}}]',19,1),
(69,'2021-11-23 14:33:12.521312','1','Quem Somos',2,'[{\"changed\": {\"fields\": [\"content\"]}}]',19,1),
(70,'2021-11-23 14:38:38.369457','1','Toca Dos Gatos - Recanto Feliz',2,'[{\"changed\": {\"fields\": [\"Nome\", \"Nome Fantasia\", \"E-mail\", \"Telefone\", \"Logradouro\", \"N\\u00famero\", \"Bairro\", \"Cidade\", \"CEP\"]}}]',17,1),
(71,'2021-11-23 14:40:29.997701','1','Quem Somos',2,'[{\"changed\": {\"fields\": [\"content\"]}}]',19,1),
(72,'2021-11-23 14:41:35.747277','1','Quem Somos',2,'[{\"changed\": {\"fields\": [\"content\"]}}]',19,1),
(73,'2021-11-23 14:42:25.004572','1','Quem Somos',2,'[]',19,1),
(74,'2021-11-23 14:42:55.266442','1','Quem Somos',2,'[{\"changed\": {\"fields\": [\"content\"]}}]',19,1),
(75,'2021-11-23 14:47:33.842441','1','Quem Somos',2,'[{\"changed\": {\"fields\": [\"content\"]}}]',19,1),
(76,'2021-11-29 11:51:07.536342','3','Outro',1,'[{\"added\": {}}]',10,1),
(77,'2021-11-29 11:51:23.684232','5','Outra',1,'[{\"added\": {}}]',9,1),
(78,'2021-11-29 14:24:08.247533','2','Patas Solidárias ONG',1,'[{\"added\": {}}]',17,1),
(79,'2022-05-04 22:05:36.661729','3','Outros',2,'[]',8,1);

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values 
(1,'admin','logentry'),
(8,'animal','breed'),
(10,'animal','coat'),
(9,'animal','color'),
(22,'animal','interest'),
(11,'animal','pet'),
(7,'animal','specie'),
(3,'auth','group'),
(2,'auth','permission'),
(4,'auth','user'),
(18,'banner','banner'),
(12,'clinica','clinic'),
(5,'contenttypes','contenttype'),
(20,'home','contact'),
(19,'home','quemsomos'),
(21,'home','recipient'),
(14,'login','address'),
(15,'login','document'),
(13,'login','login'),
(16,'login','telephone'),
(17,'ong','ong'),
(6,'sessions','session');

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=latin1;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values 
(1,'contenttypes','0001_initial','2021-11-03 18:56:20.997812'),
(2,'auth','0001_initial','2021-11-03 18:56:21.489818'),
(3,'admin','0001_initial','2021-11-03 18:56:21.642006'),
(4,'admin','0002_logentry_remove_auto_add','2021-11-03 18:56:21.658431'),
(5,'admin','0003_logentry_add_action_flag_choices','2021-11-03 18:56:21.672102'),
(6,'contenttypes','0002_remove_content_type_name','2021-11-03 18:56:21.727383'),
(7,'auth','0002_alter_permission_name_max_length','2021-11-03 18:56:21.743209'),
(8,'auth','0003_alter_user_email_max_length','2021-11-03 18:56:21.759028'),
(9,'auth','0004_alter_user_username_opts','2021-11-03 18:56:21.770530'),
(10,'auth','0005_alter_user_last_login_null','2021-11-03 18:56:21.788758'),
(11,'auth','0006_require_contenttypes_0002','2021-11-03 18:56:21.791206'),
(12,'auth','0007_alter_validators_add_error_messages','2021-11-03 18:56:21.805513'),
(13,'auth','0008_alter_user_username_max_length','2021-11-03 18:56:21.821492'),
(14,'auth','0009_alter_user_last_name_max_length','2021-11-03 18:56:21.836394'),
(15,'auth','0010_alter_group_name_max_length','2021-11-03 18:56:21.850367'),
(16,'auth','0011_update_proxy_permissions','2021-11-03 18:56:21.873126'),
(17,'auth','0012_alter_user_first_name_max_length','2021-11-03 18:56:21.888341'),
(18,'sessions','0001_initial','2021-11-03 18:56:21.938608'),
(19,'login','0001_initial','2021-11-03 19:05:17.389082'),
(20,'animal','0001_initial','2021-11-03 19:05:18.047831'),
(21,'clinica','0001_initial','2021-11-03 19:05:18.132387'),
(22,'animal','0002_auto_20211108_0919','2021-11-08 12:19:36.885553'),
(23,'clinica','0002_alter_clinic_id','2021-11-08 12:19:36.904479'),
(24,'login','0002_auto_20211108_0919','2021-11-08 12:19:37.158919'),
(25,'ong','0001_initial','2021-11-08 12:19:37.409516'),
(26,'banner','0001_initial','2021-11-08 18:54:17.085022'),
(27,'animal','0003_alter_pet_genre','2021-11-09 23:18:58.277595'),
(28,'banner','0002_alter_banner_banner','2021-11-09 23:31:24.775595'),
(29,'banner','0003_alter_banner_banner','2021-11-10 13:25:14.148230'),
(30,'banner','0004_banner_external','2021-11-10 13:29:31.198025'),
(31,'banner','0005_remove_banner_external','2021-11-10 13:31:48.041697'),
(32,'home','0001_initial','2021-11-11 00:59:22.567390'),
(33,'home','0002_alter_quemsomos_options','2021-11-11 01:14:06.470086'),
(34,'home','0003_auto_20211110_2239','2021-11-11 01:39:35.779512'),
(35,'login','0003_auto_20211115_1047','2021-11-15 13:47:27.553030'),
(36,'home','0004_contact','2021-11-16 23:06:01.669613'),
(37,'home','0005_recipient','2021-11-17 00:51:34.321696'),
(38,'home','0006_auto_20211116_2158','2021-11-17 00:58:14.700291'),
(39,'animal','0004_pet_foto','2021-11-22 22:53:44.589104'),
(40,'animal','0005_rename_foto_pet_photo','2021-11-22 22:55:43.369446'),
(41,'animal','0006_auto_20211123_1624','2021-11-23 19:24:34.593175'),
(42,'animal','0007_interest_confirm','2021-11-23 20:35:18.539417'),
(43,'animal','0008_alter_interest_confirm','2021-11-27 17:26:49.583846'),
(44,'animal','0009_alter_interest_confirm','2021-11-27 17:28:41.140384'),
(45,'ong','0002_auto_20211129_1105','2021-11-29 14:05:21.644270'),
(46,'ong','0003_ong_active','2022-05-02 17:53:19.663612');

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `django_session` */

insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values 
('3jyflvmjitoy7i157f9amq7b2hvds7sr','.eJxVjEEOgjAQRe_StWlmSlvQpXvO0ExnpoIaSCisjHdXEha6_e-9_zKJtnVIW9UljWIuBs3pd8vED512IHeabrPleVqXMdtdsQettp9Fn9fD_TsYqA7fWpG8lILiA-M5uqJdw1iwQRe1y74A5EgiHQQBRwEYtFHgElvKbWbz_gD39jig:1mkaXK:zCKRemv732e93vtqc74fDiCEbDNDPqrv76klLWVPrTk','2021-11-23 23:28:18.857003'),
('64lqlqggy1li4mfnced1khibdncs3ksy','.eJxVjM0OwiAQhN-FsyH8FASP3n0GsuwuUjU0Ke3J-O62SQ96mmS-b-YtEqxLTWvnOY0kLkKL02-XAZ_cdkAPaPdJ4tSWecxyV-RBu7xNxK_r4f4dVOh1W0OJnjEotM4GBkPFZG-t0YGjjqUo73SM_kyKCSMOlPOWIbgBjQvGiM8X7aI37A:1nn5PL:DysXoUJHOeUIyoPVctDT-DZE0MIEiBM3qo5Q7DA6DJA','2022-05-20 21:22:39.274978'),
('709s2cqoodfwt3aamyzjftpq0naglhzw','eyJsb2dpbiI6dHJ1ZX0:1mlt3v:JrWzWg3-ZWvlMMUg9ks91PRC4hH-UqCvmFH9I_7NSIk','2021-11-27 13:27:19.891923'),
('cd7nyijapd4j940zblei4rk0z6jhrr4j','e30:1mr5yW:nW9gS0zDop-786HwS3yIlhjAq_QohP95oYOMgbdcnR8','2021-12-11 22:15:16.079912'),
('dnvruhdvf35jrt3ravtxxalu8rn3e5mr','e30:1mpYTz:8yFZksqfh9tMRSFPmoJPkFm6qH78yNXdVKKLh7L1or0','2021-12-07 16:17:23.863646'),
('f693oztqe5mrby4nwkko97seuqj7mvz8','.eJxVjEsOgzAMBe-SdRXZfAJl2T1niBzbAVqUSHxWVe9ekFi02zfz5m087dvo91UXP4npDJrb7xaIX5pOIE9KQ7ac07ZMwZ6Kvehq-yw6Py73LzDSOh5vRaokRpSqZry7ImpbMkYssXDahioCBEciLdQCBdXAoKUCR9dQaAIf0TkPUzIdfr49AjuU:1mpcux:fpic7SwyRzj3rbPCcWs0DANcQYj3hoLPPaSwPsWt7j4','2021-12-07 21:01:31.919532'),
('fp11jdh31bc487g5flqpzffgnszto1zu','eyJsb2dpbiI6MjB9:1mr5wY:lHoH24CTt9PG6bZX5X9wdMN5RkUgCSnW16Zce3gvzTE','2021-12-11 22:13:14.794033'),
('l0o6nzd5dn57jkj2tr85172jx51bq0w6','.eJxVjM0OwiAQhN-FsyH8FASP3n0GsuwuUjU0Ke3J-O62SQ96mmS-b-YtEqxLTWvnOY0kLkKL02-XAZ_cdkAPaPdJ4tSWecxyV-RBu7xNxK_r4f4dVOh1W0OJnjEotM4GBkPFZG-t0YGjjqUo73SM_kyKCSMOlPOWIbgBjQvGiM8X7aI37A:1nn55r:w_wrE7_htau3pkC9fLwTCM6OaEniFmnr6hKGY0e0eTc','2022-05-20 21:02:31.902320'),
('l12tfkuyikhzilg65hq41ip95f9xpzav','eyJsb2dpbiI6MjJ9:1mrBgI:BzOu9fqrZqfA4-MBG76YbFhWxsBYTB0yz8uXnugXNSg','2021-12-12 04:20:50.757945'),
('mtid8ic6taeikirnoyzot7luaaalfgeh','.eJxVjM0OwiAQhN-FsyH8FASP3n0GsuwuUjU0Ke3J-O62SQ96mmS-b-YtEqxLTWvnOY0kLkKL02-XAZ_cdkAPaPdJ4tSWecxyV-RBu7xNxK_r4f4dVOh1W0OJnjEotM4GBkPFZG-t0YGjjqUo73SM_kyKCSMOlPOWIbgBjQvGiM8X7aI37A:1nn5Sy:cNVSj5HtuH9ChM3-D6TDN6MpaHHOGmb4WF3R4QO95hM','2022-05-20 21:26:24.637700'),
('nq1kftbg44hiw2ssam0ubccijhr5tnh4','.eJxVjM0OwiAQhN-FsyH8FASP3n0GsuwuUjU0Ke3J-O62SQ96mmS-b-YtEqxLTWvnOY0kLkKL02-XAZ_cdkAPaPdJ4tSWecxyV-RBu7xNxK_r4f4dVOh1W0OJnjEotM4GBkPFZG-t0YGjjqUo73SM_kyKCSMOlPOWIbgBjQvGiM8X7aI37A:1nn5LP:HrF2zHMIHUz3K4kO4Yhy3dg7Kzt2ALK5GjNVbxivG84','2022-05-20 21:18:35.706780'),
('q96231cz9n8q3can6ti6xg0e6a4i4zch','.eJxVjM0OwiAQhN-FsyH8FASP3n0GsuwuUjU0Ke3J-O62SQ96mmS-b-YtEqxLTWvnOY0kLkKL02-XAZ_cdkAPaPdJ4tSWecxyV-RBu7xNxK_r4f4dVOh1W0OJnjEotM4GBkPFZG-t0YGjjqUo73SM_kyKCSMOlPOWIbgBjQvGiM8X7aI37A:1no3HT:rJ1HUXwhgaYUliPbjDQ4g87IDn3fCFGSwTt0wfkB42g','2022-05-23 13:18:31.710414'),
('qnt4mctkw7p5cy2ptp9wh4vws2pq812m','eyJsb2dpbiI6MjB9:1mmxcw:RDmcoFDHIKDAJ2Dovbv5Lh1XLnbeqOMe4A5oDTuSOmM','2021-11-30 12:31:54.858606'),
('qpl5ek7m2ydq4feb9e27erkpwqjvxju5','e30:1mpKlD:ej_moaUnZIjtcRHatlFEW1DxkboflHulmOeQl22lVnI','2021-12-07 01:38:15.650003'),
('r4vv6j5ne00ki8yin3ntl9s37ibixsxi','.eJxVjEEOgjAQRe_StWlmSlvQpXvO0ExnpoIaSCisjHdXEha6_e-9_zKJtnVIW9UljWIuBs3pd8vED512IHeabrPleVqXMdtdsQettp9Fn9fD_TsYqA7fWpG8lILiA-M5uqJdw1iwQRe1y74A5EgiHQQBRwEYtFHgElvKbWbz_gD39jig:1mlegR:45M907VVpswMjUiztX8K9iBm6tLOCFAxxnREpxSuZxU','2021-11-26 22:06:07.873172'),
('shpzgwj5bcygdxzqguvrgnj9z49v7z5p','.eJxVjEEOgjAQRe_StWlmSlvQpXvO0ExnpoIaSCisjHdXEha6_e-9_zKJtnVIW9UljWIuBs3pd8vED512IHeabrPleVqXMdtdsQettp9Fn9fD_TsYqA7fWpG8lILiA-M5uqJdw1iwQRe1y74A5EgiHQQBRwEYtFHgElvKbWbz_gD39jig:1miNdZ:HQNnJ_AsTGZ_ArIKlL8WbaYjMJAntCpDmKb_WHX40oM','2021-11-17 21:17:37.866691'),
('ssypkkzifl376go091e60dlrqsfeqpjf','eyJsb2dpbiI6MTl9:1mmimc:DiGlbVCx24KOKOMncl07RtebnT5ZHIpy-g4UHHWCxTI','2021-11-29 20:40:54.670524'),
('t394ne610t0qiixmt9b07gf6ojb67zfr','.eJxVjEEOgjAQRe_StWlmSlvQpXvO0ExnpoIaSCisjHdXEha6_e-9_zKJtnVIW9UljWIuBs3pd8vED512IHeabrPleVqXMdtdsQettp9Fn9fD_TsYqA7fWpG8lILiA-M5uqJdw1iwQRe1y74A5EgiHQQBRwEYtFHgElvKbWbz_gD39jig:1miNT9:kic3y-kMm-qX69sM_cS0T-QAqgVYIGu6okvwfheM3-A','2021-11-17 21:06:51.552229'),
('ubjtkaluauxsz1m3feblwss1q6aodfkc','.eJxVjM0OwiAQhN-FsyH8FASP3n0GsuwuUjU0Ke3J-O62SQ96mmS-b-YtEqxLTWvnOY0kLkKL02-XAZ_cdkAPaPdJ4tSWecxyV-RBu7xNxK_r4f4dVOh1W0OJnjEotM4GBkPFZG-t0YGjjqUo73SM_kyKCSMOlPOWIbgBjQvGiM8X7aI37A:1nmN6J:1vT2jV8WjVoNCs-dFoonBesVzk0DCnNbUCCu-Ptdaoo','2022-05-18 22:04:03.323131'),
('v14ri98sh8o5zamy7l736kmji1g74bum','.eJxVjM0OwiAQhN-FsyH8FASP3n0GsuwuUjU0Ke3J-O62SQ96mmS-b-YtEqxLTWvnOY0kLkKL02-XAZ_cdkAPaPdJ4tSWecxyV-RBu7xNxK_r4f4dVOh1W0OJnjEotM4GBkPFZG-t0YGjjqUo73SM_kyKCSMOlPOWIbgBjQvGiM8X7aI37A:1nmaFe:nKmtNMqh2cg3YT3vsSGLsEypfoQWGEzCusSVxq5tP6I','2022-05-19 12:06:34.598078'),
('y96g040w1inx0ik5iup6jcm39lgi33jk','.eJxVjEsOgzAMBe-SdRXZfAJl2T1niBzbAVqUSHxWVe9ekFi02zfz5m087dvo91UXP4npDJrb7xaIX5pOIE9KQ7ac07ZMwZ6Kvehq-yw6Py73LzDSOh5vRaokRpSqZry7ImpbMkYssXDahioCBEciLdQCBdXAoKUCR9dQaAIf0TkPUzIdfr49AjuU:1mrhb1:1kwvSBtPNtREanGNQT3AdgMhJzqb3ewipmFrbbFk08U','2021-12-13 14:25:31.131481'),
('yoruwb1evoc9jf57e28nw5h6hbv0qtbp','e30:1mqIzm:rOcMw9Xc2xIdms8fDdwi895fg5IFTWfwwC4nfMczf6c','2021-12-09 17:57:18.709511'),
('yx4ul9a8oqtkftci4tdjj01vwy8svviu','.eJxVjM0OwiAQhN-FsyH8FASP3n0GsuwuUjU0Ke3J-O62SQ96mmS-b-YtEqxLTWvnOY0kLkKL02-XAZ_cdkAPaPdJ4tSWecxyV-RBu7xNxK_r4f4dVOh1W0OJnjEotM4GBkPFZG-t0YGjjqUo73SM_kyKCSMOlPOWIbgBjQvGiM8X7aI37A:1nmex7:ibP_ANHtkvoqbo-fxDJPwlh7rzHAElxcHY1ocTDGI_M','2022-05-19 17:07:45.430002'),
('zy8o7ivkqxkwx9hrw5ltecpittb4j5su','.eJxVjM0OwiAQhN-FsyH8FASP3n0GsuwuUjU0Ke3J-O62SQ96mmS-b-YtEqxLTWvnOY0kLkKL02-XAZ_cdkAPaPdJ4tSWecxyV-RBu7xNxK_r4f4dVOh1W0OJnjEotM4GBkPFZG-t0YGjjqUo73SM_kyKCSMOlPOWIbgBjQvGiM8X7aI37A:1nmiz5:-AW5AvgW998dLHlxz8xE0nuxr4AJY4rZwaL6B_1q8HM','2022-05-19 21:26:03.471437');

/*Table structure for table `home_contact` */

DROP TABLE IF EXISTS `home_contact`;

CREATE TABLE `home_contact` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `subject` varchar(150) NOT NULL,
  `message` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;

/*Data for the table `home_contact` */

insert  into `home_contact`(`id`,`name`,`email`,`subject`,`message`,`created_at`,`updated_at`) values 
(1,'Paulo Zapparolli','paulo.zapparolli@jet.com.br','Assunto Teste','Mensagem Teste','2021-11-17 01:18:09.542480','2021-11-17 01:18:09.542535'),
(2,'Paulo Zapparolli','paulo.zapparolli@jet.com.br','Assunto Teste','Mensagem Teste','2021-11-17 01:19:11.335058','2021-11-17 01:19:11.335121'),
(3,'Paulo Zapparolli','paulo.zapparolli@jet.com.br','Assunto Teste','Mensagem Teste','2021-11-17 01:19:50.131337','2021-11-17 01:19:50.131426'),
(4,'Paulo Zapparolli','paulo.zapparolli@jet.com.br','Assunto Teste','Mensagem Teste','2021-11-17 01:26:29.545625','2021-11-17 01:26:29.545674'),
(5,'Paulo Zapparolli','paulo.zapparolli@jet.com.br','Assunto Teste','Mensagem Teste','2021-11-17 01:26:36.078451','2021-11-17 01:26:36.078525'),
(6,'Paulo Zapparolli','paulo.zapparolli@jet.com.br','Assunto Teste','Mensagem Teste','2021-11-17 01:27:13.085075','2021-11-17 01:27:13.085140'),
(7,'Paulo Zapparolli','paulo.zapparolli@jet.com.br','Assunto Teste','Mensagem Teste','2021-11-17 01:29:58.753988','2021-11-17 01:29:58.754050'),
(8,'Paulo Zapparolli','paulo.zapparolli@jet.com.br','Assunto Teste','Mensagem Teste','2021-11-17 01:30:43.079070','2021-11-17 01:30:43.079131'),
(9,'Paulo Zapparolli','paulo.zapparolli@jet.com.br','Assunto Teste','Mensagem Teste','2021-11-17 01:34:44.093291','2021-11-17 01:34:44.093355'),
(10,'Paulo Zapparolli','paulo.zapparolli@jet.com.br','Teste ','Teste ','2021-11-23 19:11:53.423613','2021-11-23 19:11:53.423668'),
(11,'Paulo Zapparolli','kanayama.zappa@gmail.com','Teste','Teste','2022-04-27 20:45:52.300742','2022-04-27 20:45:52.300742'),
(12,'Paulo Zapparolli','kanayama.zappa@gmail.com','Teste','Teste','2022-04-27 20:46:29.198406','2022-04-27 20:46:29.198406'),
(13,'Paulo Zapparolli','kanayama.zappa@gmail.com','Teste','Teste','2022-04-27 20:47:06.713578','2022-04-27 20:47:06.713578'),
(14,'Paulo Zapparolli','kanayama.zappa@gmail.com','Teste','Teste','2022-04-27 20:48:39.003127','2022-04-27 20:48:39.003127'),
(15,'Paulo Zapparolli','kanayama.zappa@gmail.com','Teste','Teste','2022-04-27 20:48:59.806698','2022-04-27 20:48:59.806698'),
(16,'Paulo Zapparolli','kanayama.zappa@gmail.com','Teste','Teste','2022-04-27 20:49:41.583882','2022-04-27 20:49:41.583882'),
(17,'Paulo Zapparolli','kanayama.zappa@gmail.com','Teste','Teste','2022-04-27 20:52:37.708791','2022-04-27 20:52:37.708791'),
(18,'Paulo Zapparolli','kanayama.zappa@gmail.com','Teste','Teste','2022-04-27 20:56:59.538039','2022-04-27 20:56:59.538039'),
(19,'teste','paulo.zapparolli@jet.com.br','teste','teste','2022-04-27 23:02:37.040721','2022-04-27 23:02:37.040721'),
(20,'Paulo Zapparolli','paulo.zapparolli@jet.com.br','Teste via API','Teste via API','2022-05-05 12:30:10.898110','2022-05-05 12:30:10.898110'),
(21,'Paulo Zapparolli','paulo.zapparolli@jet.com.br','Teste via API','Teste via API','2022-05-05 12:56:23.675674','2022-05-05 12:56:23.675674'),
(22,'Paulo Zapparolli','paulo.zapparolli@jet.com.br','Teste via API','Teste via API','2022-05-05 12:59:37.980351','2022-05-05 12:59:37.980351'),
(23,'paulo','paulo.zapparolli@jet.com.br','teste','teste','2022-05-05 13:10:16.773793','2022-05-05 13:10:16.773793'),
(24,'paulo','paulo.zapparolli@jet.com.br','teste','teste','2022-05-05 13:11:16.848330','2022-05-05 13:11:16.848330'),
(25,'paulo','paulo.zapparolli@jet.com.br','teste','teste','2022-05-05 13:12:14.659557','2022-05-05 13:12:14.660559'),
(26,'paulo','paulo.zapparolli@jet.com.br','teste','teste','2022-05-05 13:13:15.789247','2022-05-05 13:13:15.789247'),
(27,'Teste Paulo','paulo.zapparolli@jet.com.br','Teste','Teste','2022-05-05 13:15:19.706203','2022-05-05 13:15:19.706203'),
(28,'Teste Paulo','paulo.zapparolli@jet.com.br','Teste','Teste','2022-05-05 13:16:33.549985','2022-05-05 13:16:33.549985'),
(29,'Teste Paulo','paulo.zapparolli@jet.com.br','Teste','Teste','2022-05-05 13:17:32.110184','2022-05-05 13:17:32.110184'),
(30,'Teste Paulo','paulo.zapparolli@jet.com.br','Teste','Teste','2022-05-05 13:17:52.784546','2022-05-05 13:17:52.784546'),
(31,'Teste Paulo','paulo.zapparolli@jet.com.br','Teste','Teste','2022-05-05 13:18:39.263634','2022-05-05 13:18:39.263634'),
(32,'Teste Paulo','paulo.zapparolli@jet.com.br','Teste','Teste','2022-05-05 13:19:09.893709','2022-05-05 13:19:09.893709'),
(33,'Teste Paulo','paulo.zapparolli@jet.com.br','Teste','Teste','2022-05-05 13:19:55.133042','2022-05-05 13:19:55.133042'),
(34,'Teste Paulo','paulo.zapparolli@jet.com.br','Teste','Teste','2022-05-05 13:20:33.014271','2022-05-05 13:20:33.014271'),
(35,'Teste Paulo','paulo.zapparolli@jet.com.br','Teste','Teste','2022-05-05 13:21:25.144047','2022-05-05 13:21:25.144047'),
(36,'Teste Paulo','paulo.zapparolli@jet.com.br','Teste','Teste','2022-05-05 13:22:31.323310','2022-05-05 13:22:31.323310'),
(37,'Teste Paulo','paulo.zapparolli@jet.com.br','Teste','Teste','2022-05-05 13:24:27.049969','2022-05-05 13:24:27.049969'),
(38,'Paulo Zapparolli Kanayama','paulo.zapparolli@jet.com.br','Teste Site','Teste Site','2022-05-05 13:31:58.165067','2022-05-05 13:31:58.165067');

/*Table structure for table `home_quemsomos` */

DROP TABLE IF EXISTS `home_quemsomos`;

CREATE TABLE `home_quemsomos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `home_quemsomos` */

insert  into `home_quemsomos`(`id`,`content`,`created_at`,`updated_at`) values 
(1,'<p><span style=\"font-size:11pt\"><span style=\"font-family:Calibri,sans-serif\"><strong>SOS Pet&rsquo;s</strong> &eacute; um projeto sem fins lucrativos de objetivo fundamental na tentativa de suprir a condi&ccedil;&atilde;o de abandono, maus-tratos ou Pet&rsquo;s perdidos, com &ecirc;nfase para ado&ccedil;&atilde;o volunt&aacute;ria ou at&eacute; mesmo para encontrar seu pet perdido, um sistema ponta a ponta de aplica&ccedil;&atilde;o web que possibilita a intermedia&ccedil;&atilde;o e compartilhamento de informa&ccedil;&otilde;es afim de que se possa chegar a uma solu&ccedil;&atilde;o satisfat&oacute;ria&nbsp;para sociedade , o projeto tamb&eacute;m conta com o registro de ONG&rsquo;s da sociedade pr&eacute; cadastradas, na qual o usu&aacute;rio pode efetuar o encaminhamento dos pet&rsquo;s para a assist&ecirc;ncia emergencial.</span></span></p>','2021-11-11 01:18:39.397753','2021-11-23 14:47:33.841055');

/*Table structure for table `home_recipient` */

DROP TABLE IF EXISTS `home_recipient`;

CREATE TABLE `home_recipient` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email` varchar(254) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `home_recipient` */

insert  into `home_recipient`(`id`,`email`,`created_at`,`updated_at`) values 
(2,'kanayama.zappa@gmail.com','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000');

/*Table structure for table `login_address` */

DROP TABLE IF EXISTS `login_address`;

CREATE TABLE `login_address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` varchar(1) NOT NULL,
  `street` varchar(150) NOT NULL,
  `number` varchar(20) NOT NULL,
  `complement` varchar(250) NOT NULL,
  `district` varchar(150) NOT NULL,
  `city` varchar(150) NOT NULL,
  `state` varchar(2) NOT NULL,
  `zipCode` varchar(10) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `login_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `login_address_login_id_aa9c273f_fk` (`login_id`),
  CONSTRAINT `login_address_login_id_aa9c273f_fk` FOREIGN KEY (`login_id`) REFERENCES `login_login` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;

/*Data for the table `login_address` */

insert  into `login_address`(`id`,`type`,`street`,`number`,`complement`,`district`,`city`,`state`,`zipCode`,`created_at`,`updated_at`,`login_id`) values 
(12,'R','Rua Galileu Galilei','1800','Sala 706','Condomínio Itamaraty','Ribeirão Preto','SP','14020-620','2021-11-15 20:16:26.798257','2021-11-15 20:16:26.798286',17),
(13,'R','Avenida 15 de Outubro','1146','Casa','Jardim aeroporto','Ilha Solteira','SP','15385-000','2021-11-15 20:36:42.024533','2021-11-15 20:36:42.024565',18),
(14,'R','Rua Rodrigues Alves','2697','Casa','Jardim Alda','Pereira Barreto','SP','15371-132','2021-11-15 20:40:02.290571','2021-11-15 20:40:02.290599',19),
(15,'R','Passeio correntes','306','','Zona norte','Ilha Solteira','SP','15385-000','2021-11-16 12:31:54.603868','2021-11-16 12:31:54.603910',20),
(16,'R','Rua Juruá','1125','AP 65, TORRE BURITI','Jardim Maria Goretti','Ribeirão Preto','SP','14030-313','2021-11-17 02:18:02.181484','2022-05-06 22:02:03.678259',1),
(17,'R','Alameda Piauí','175','','Zona Norte','Ilha Solteira','SP','15385-000','2021-11-25 17:38:42.717940','2021-11-25 17:38:42.717971',21),
(18,'R','RUA QUALQUER','122','','JASMIM','SAO PAULO','SA','12452-223','2021-11-28 01:30:34.712650','2021-11-28 01:30:34.712679',22),
(28,'R','Rua Juruá','1125','AP 65, TORRE BURITI','Jardim Maria Goretti','Ribeirão Preto','SP','14030-313','2022-05-09 13:01:17.521353','2022-05-09 13:03:57.830741',33);

/*Table structure for table `login_document` */

DROP TABLE IF EXISTS `login_document`;

CREATE TABLE `login_document` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` varchar(1) NOT NULL,
  `document` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `login_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `login_document_login_id_f46b4c3f_fk` (`login_id`),
  CONSTRAINT `login_document_login_id_f46b4c3f_fk` FOREIGN KEY (`login_id`) REFERENCES `login_login` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

/*Data for the table `login_document` */

insert  into `login_document`(`id`,`type`,`document`,`created_at`,`updated_at`,`login_id`) values 
(13,'C','296.247.021-10','2021-11-15 20:16:26.795207','2021-11-15 20:16:26.795270',17),
(14,'C','267.833.928-99','2021-11-15 20:36:42.022296','2021-11-15 20:36:42.022334',18),
(15,'C','351.217.208-31','2021-11-15 20:40:02.276158','2021-11-15 20:40:02.276198',19),
(16,'C','303.701.818-67','2021-11-16 12:31:54.597799','2021-11-16 12:31:54.597838',20),
(17,'C','296.247.021-10','2021-11-17 02:18:02.176653','2022-05-06 22:01:46.633171',1),
(18,'C','441.865.068-76','2021-11-25 17:38:42.711023','2021-11-25 17:38:42.711054',21),
(19,'C','012.452.123-15','2021-11-28 01:30:34.708854','2021-11-28 01:30:34.708884',22),
(30,'C','374.441.163-00','2022-05-09 13:01:08.967322','2022-05-09 13:03:40.792016',33);

/*Table structure for table `login_login` */

DROP TABLE IF EXISTS `login_login`;

CREATE TABLE `login_login` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `password` varchar(1024) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `login_login_email_active_e8372814_idx` (`email`,`active`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;

/*Data for the table `login_login` */

insert  into `login_login`(`id`,`name`,`email`,`password`,`created_at`,`updated_at`,`active`) values 
(1,'Paulo Zapparolli','kanayama.zappa@gmail.com','123456','2021-11-09 23:09:11.548123','2022-05-06 22:01:38.009752',1),
(17,'Paulo Zapparolli','paulo.zapparolli@jet.com.br','123456','2021-11-15 20:16:26.793382','2021-11-15 20:17:15.158867',1),
(18,'Sergio Sato','sergio.taka.sato@gmail.com','tucg9167','2021-11-15 20:36:42.020475','2021-11-15 20:37:07.017885',1),
(19,'Henrique dos Santos Ferreira ','lester.henrique@gmail.com','unibb3156','2021-11-15 20:40:02.258083','2021-11-15 20:40:54.236476',1),
(20,'Giseli C Serrado','giserrado@gmail.com','teste123','2021-11-16 12:31:54.595250','2021-11-16 12:53:45.925970',1),
(21,'Kawana Lopes','kawanalopesm@gmail.com','123456789','2021-11-25 17:38:42.708541','2021-11-25 17:40:31.769205',1),
(22,'emerson gabriel de castro','gordeldi@gmail.com','123456789','2021-11-28 01:30:34.707210','2021-11-28 01:31:25.364304',1),
(33,'Paulo Zapparolli','ursopzk@gmail.com','123456','2022-05-09 13:01:04.637461','2022-05-09 13:03:32.258316',0);

/*Table structure for table `login_telephone` */

DROP TABLE IF EXISTS `login_telephone`;

CREATE TABLE `login_telephone` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` varchar(1) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `login_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `login_telephone_login_id_64241d22_fk` (`login_id`),
  CONSTRAINT `login_telephone_login_id_64241d22_fk` FOREIGN KEY (`login_id`) REFERENCES `login_login` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;

/*Data for the table `login_telephone` */

insert  into `login_telephone`(`id`,`type`,`phone`,`created_at`,`updated_at`,`login_id`) values 
(12,'R','(16) 99999-9999','2021-11-15 20:16:26.797087','2021-11-15 20:16:26.797133',17),
(13,'R','(18) 98105-0754','2021-11-15 20:36:42.023344','2021-11-15 20:36:42.023379',18),
(14,'R','(18) 92000-4594','2021-11-15 20:40:02.288858','2021-11-15 20:40:02.288897',19),
(15,'R','(18) 99105-6712','2021-11-16 12:31:54.600676','2021-11-16 12:31:54.600712',20),
(16,'R','(16) 99999-9999','2021-11-17 02:18:02.179178','2022-05-06 22:01:55.158441',1),
(17,'R','(18) 99712-7238','2021-11-25 17:38:42.714518','2021-11-25 17:38:42.714549',21),
(18,'R','(16) 98114-4670','2021-11-28 01:30:34.711363','2021-11-28 01:30:34.711392',22),
(28,'R','(16) 99999-9999','2022-05-09 13:01:13.245443','2022-05-09 13:03:49.333947',33);

/*Table structure for table `ong_ong` */

DROP TABLE IF EXISTS `ong_ong`;

CREATE TABLE `ong_ong` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `fantasia` varchar(100) NOT NULL,
  `email` varchar(254) NOT NULL,
  `telephone` varchar(20) NOT NULL,
  `street` varchar(150) NOT NULL,
  `number` varchar(20) NOT NULL,
  `complement` varchar(250) NOT NULL,
  `district` varchar(150) NOT NULL,
  `city` varchar(150) NOT NULL,
  `state` varchar(2) NOT NULL,
  `zipCode` varchar(10) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `bank` varchar(50) NOT NULL,
  `pix` varchar(50) NOT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ong_ong_slug_1ee8a437` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `ong_ong` */

insert  into `ong_ong`(`id`,`name`,`fantasia`,`email`,`telephone`,`street`,`number`,`complement`,`district`,`city`,`state`,`zipCode`,`slug`,`created_at`,`updated_at`,`bank`,`pix`,`active`) values 
(1,'Toca Dos Gatos - Recanto Feliz','Toca Dos Gatos - Recanto Feliz','tocadosgatos.ilhasolteira@gmail.com','(18) 9691-1863','Passeio Marilia','319','','Zona Sul','Ilha Solteira','SP','15385-000','teste-ong-1','2021-11-23 14:01:44.841010','2021-11-23 14:38:38.367693','','',1),
(2,'Patas Solidárias ONG','Associação Protetora dos Animais Patas Solidárias de Ilha Solteira','patas.solidariasong@gmail.com','-','Av. 15º de Outubro','300','','Viela C','Ilha Solteira','SP','15385-000','patas-solidarias-ong','2021-11-29 14:24:08.245022','2021-11-29 14:24:08.245059','Banco do Brasil, Ag: 2833-9, Acc: 109','24.310.424/0001-10',1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
