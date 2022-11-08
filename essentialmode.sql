-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Nov 08, 2022 at 09:04 PM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `essentialmode`
--

-- --------------------------------------------------------

--
-- Table structure for table `addon_account`
--

DROP TABLE IF EXISTS `addon_account`;
CREATE TABLE IF NOT EXISTS `addon_account` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `addon_account`
--

INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('society_mechanic', 'Mehanicar', 1);

-- --------------------------------------------------------

--
-- Table structure for table `addon_account_data`
--

DROP TABLE IF EXISTS `addon_account_data`;
CREATE TABLE IF NOT EXISTS `addon_account_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_name` varchar(100) DEFAULT NULL,
  `money` int(11) NOT NULL,
  `owner` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_addon_account_data_account_name_owner` (`account_name`,`owner`),
  KEY `index_addon_account_data_account_name` (`account_name`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `addon_account_data`
--

INSERT INTO `addon_account_data` (`id`, `account_name`, `money`, `owner`) VALUES
(1, 'society_mechanic', 111708, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `addon_inventory`
--

DROP TABLE IF EXISTS `addon_inventory`;
CREATE TABLE IF NOT EXISTS `addon_inventory` (
  `name` int(11) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `addon_inventory`
--

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
(3, 'Mehanicar', 1);

-- --------------------------------------------------------

--
-- Table structure for table `addon_inventory_items`
--

DROP TABLE IF EXISTS `addon_inventory_items`;
CREATE TABLE IF NOT EXISTS `addon_inventory_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inventory_name` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `count` int(11) NOT NULL,
  `owner` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_addon_inventory_items_inventory_name_name` (`inventory_name`,`name`),
  KEY `index_addon_inventory_items_inventory_name_name_owner` (`inventory_name`,`name`,`owner`),
  KEY `index_addon_inventory_inventory_name` (`inventory_name`)
) ENGINE=MyISAM AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `addon_inventory_items`
--

INSERT INTO `addon_inventory_items` (`id`, `inventory_name`, `name`, `count`, `owner`) VALUES
(50, 3, 'turbo', 1, NULL),
(49, 3, 'filter', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `atm`
--

DROP TABLE IF EXISTS `atm`;
CREATE TABLE IF NOT EXISTS `atm` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Koord` varchar(255) DEFAULT NULL,
  `bKoord` varchar(255) DEFAULT NULL,
  `Iznos` int(11) DEFAULT 50000,
  `Heading` float(200,11) DEFAULT NULL,
  `Objekt` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=68 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `atm`
--

INSERT INTO `atm` (`ID`, `Koord`, `bKoord`, `Iznos`, `Heading`, `Objekt`) VALUES
(1, '{\"x\":-386.7330017089844,\"y\":6045.953125,\"z\":31.50099945068359}', NULL, 50000, NULL, NULL),
(2, '{\"x\":-284.0369873046875,\"y\":6224.384765625,\"z\":31.1870002746582}', NULL, 50000, NULL, NULL),
(3, '{\"x\":-110.75299835205078,\"y\":6467.703125,\"z\":31.78400039672851}', NULL, 50000, NULL, NULL),
(4, '{\"x\":155.42999267578126,\"y\":6641.9912109375,\"z\":31.78400039672851}', NULL, 50000, NULL, NULL),
(5, '{\"x\":174.6719970703125,\"y\":6637.2177734375,\"z\":31.78400039672851}', NULL, 50000, NULL, NULL),
(6, '{\"x\":1703.137939453125,\"y\":6426.783203125,\"z\":32.72999954223633}', NULL, 50000, NULL, NULL),
(7, '{\"x\":1702.842041015625,\"y\":4933.5927734375,\"z\":42.05099868774414}', NULL, 50000, NULL, NULL),
(8, '{\"x\":1967.3330078125,\"y\":3744.29296875,\"z\":32.27199935913086}', NULL, 50000, NULL, NULL),
(9, '{\"x\":1821.9169921875,\"y\":3683.48291015625,\"z\":34.24399948120117}', NULL, 50000, NULL, NULL),
(10, '{\"x\":540.0419921875,\"y\":2671.007080078125,\"z\":42.17699813842773}', NULL, 50000, NULL, NULL),
(11, '{\"x\":-284.0369873046875,\"y\":6224.384765625,\"z\":31.1870002746582}', NULL, 50000, NULL, NULL),
(12, '{\"x\":-94.96900177001953,\"y\":6455.30078125,\"z\":31.78400039672851}', NULL, 50000, NULL, NULL),
(13, '{\"x\":1735.114013671875,\"y\":6411.03515625,\"z\":35.16400146484375}', NULL, 50000, NULL, NULL),
(14, '{\"x\":-135.1649932861328,\"y\":6365.73779296875,\"z\":31.10099983215332}', NULL, 50000, NULL, NULL),
(15, '{\"x\":2564.39892578125,\"y\":2585.10009765625,\"z\":38.01599884033203}', NULL, 50000, NULL, NULL),
(16, '{\"x\":1168.9749755859376,\"y\":-457.2409973144531,\"z\":66.64099884033203}', NULL, 50000, NULL, NULL),
(17, '{\"x\":1153.884033203125,\"y\":-326.5400085449219,\"z\":69.24500274658203}', NULL, 50000, NULL, NULL),
(18, '{\"x\":381.28271484375,\"y\":323.2518005371094,\"z\":103.2699966430664}', NULL, 50000, NULL, NULL),
(19, '{\"x\":236.46380615234376,\"y\":217.4718017578125,\"z\":106.83999633789063}', NULL, 50000, NULL, NULL),
(20, '{\"x\":265.0043029785156,\"y\":212.1717071533203,\"z\":106.77999877929688}', NULL, 50000, NULL, NULL),
(21, '{\"x\":285.2029113769531,\"y\":143.56900024414063,\"z\":104.97000122070313}', NULL, 50000, NULL, NULL),
(22, '{\"x\":157.76980590820313,\"y\":233.5449981689453,\"z\":106.44999694824219}', NULL, 50000, NULL, NULL),
(23, '{\"x\":-164.5679931640625,\"y\":233.50660705566407,\"z\":94.91899871826172}', NULL, 50000, NULL, NULL),
(24, '{\"x\":-1827.0400390625,\"y\":785.5159301757813,\"z\":138.02000427246095}', NULL, 50000, NULL, NULL),
(25, '{\"x\":-1409.3900146484376,\"y\":-99.26029968261719,\"z\":52.4729995727539}', NULL, 50000, NULL, NULL),
(26, '{\"x\":-1205.3499755859376,\"y\":-325.5790100097656,\"z\":37.86999893188476}', NULL, 50000, NULL, NULL),
(27, '{\"x\":-1215.6400146484376,\"y\":-332.2309875488281,\"z\":37.88100051879883}', NULL, 50000, NULL, NULL),
(28, '{\"x\":-2072.409912109375,\"y\":-316.9590148925781,\"z\":13.3450002670288}', NULL, 50000, NULL, NULL),
(29, '{\"x\":-2975.719970703125,\"y\":379.7737121582031,\"z\":14.99199962615966}', NULL, 50000, NULL, NULL),
(30, '{\"x\":-2955.699951171875,\"y\":488.7218017578125,\"z\":15.48600006103515}', NULL, 50000, NULL, NULL),
(31, '{\"x\":-3044.219970703125,\"y\":595.242919921875,\"z\":7.59499979019165}', NULL, 50000, NULL, NULL),
(32, '{\"x\":-3144.1298828125,\"y\":1127.4150390625,\"z\":20.86800003051757}', NULL, 50000, NULL, NULL),
(33, '{\"x\":-3241.10009765625,\"y\":996.6881103515625,\"z\":12.5}', NULL, 50000, NULL, NULL),
(34, '{\"x\":-3241.110107421875,\"y\":1009.1519775390625,\"z\":12.8769998550415}', NULL, 50000, NULL, NULL),
(35, '{\"x\":-1305.4000244140626,\"y\":-706.239990234375,\"z\":25.35199928283691}', NULL, 50000, NULL, NULL),
(36, '{\"x\":2558.68310546875,\"y\":349.60101318359377,\"z\":108.05000305175781}', NULL, 50000, NULL, NULL),
(37, '{\"x\":2558.051025390625,\"y\":389.481689453125,\"z\":108.66000366210938}', NULL, 50000, NULL, NULL),
(38, '{\"x\":-538.2249755859375,\"y\":-854.4229736328125,\"z\":29.23399925231933}', NULL, 50000, NULL, NULL),
(39, '{\"x\":-711.156005859375,\"y\":-818.9580078125,\"z\":23.76799964904785}', NULL, 50000, NULL, NULL),
(40, '{\"x\":-717.614013671875,\"y\":-915.8800048828125,\"z\":19.26799964904785}', NULL, 50000, NULL, NULL),
(41, '{\"x\":-526.5659790039063,\"y\":-1222.9000244140626,\"z\":18.43400001525879}', NULL, 50000, NULL, NULL),
(42, '{\"x\":-256.83099365234377,\"y\":-719.64599609375,\"z\":33.44400024414062}', NULL, 50000, NULL, NULL),
(43, '{\"x\":-203.54800415039063,\"y\":-861.5880126953125,\"z\":30.20499992370605}', NULL, 50000, NULL, NULL),
(44, '{\"x\":112.41020202636719,\"y\":-776.1619873046875,\"z\":31.42700004577636}', NULL, 50000, NULL, NULL),
(45, '{\"x\":112.92900085449219,\"y\":-818.7100219726563,\"z\":31.38599967956543}', NULL, 50000, NULL, NULL),
(46, '{\"x\":119.9000015258789,\"y\":-883.8259887695313,\"z\":31.19099998474121}', NULL, 50000, NULL, NULL),
(47, '{\"x\":-846.3040161132813,\"y\":-340.4020080566406,\"z\":38.6870002746582}', NULL, 50000, NULL, NULL),
(48, '{\"x\":-1204.3499755859376,\"y\":-324.3909912109375,\"z\":37.87699890136719}', NULL, 50000, NULL, NULL),
(49, '{\"x\":-56.19350051879883,\"y\":-1752.530029296875,\"z\":29.45199966430664}', NULL, 50000, NULL, NULL),
(50, '{\"x\":-261.6919860839844,\"y\":-2012.6400146484376,\"z\":30.12100028991699}', NULL, 50000, NULL, NULL),
(51, '{\"x\":-273.0010070800781,\"y\":-2025.5999755859376,\"z\":30.19700050354004}', NULL, 50000, NULL, NULL),
(52, '{\"x\":24.58900070190429,\"y\":-946.0560302734375,\"z\":29.35700035095215}', NULL, 50000, NULL, NULL),
(53, '{\"x\":-254.11199951171876,\"y\":-692.4829711914063,\"z\":33.61600112915039}', NULL, 50000, NULL, NULL),
(54, '{\"x\":-1570.197021484375,\"y\":-546.6510009765625,\"z\":34.95500183105469}', NULL, 50000, NULL, NULL),
(55, '{\"x\":-1415.9090576171876,\"y\":-211.8249969482422,\"z\":46.5}', NULL, 50000, NULL, NULL),
(56, '{\"x\":-1430.112060546875,\"y\":-211.01400756835938,\"z\":46.5}', NULL, 50000, NULL, NULL),
(57, '{\"x\":33.23199844360351,\"y\":-1347.8489990234376,\"z\":29.49699974060058}', NULL, 50000, NULL, NULL),
(58, '{\"x\":129.21600341796876,\"y\":-1292.3470458984376,\"z\":29.26899909973144}', NULL, 50000, NULL, NULL),
(59, '{\"x\":1077.6920166015626,\"y\":-775.7960205078125,\"z\":58.21799850463867}', NULL, 50000, NULL, NULL),
(60, '{\"x\":287.6449890136719,\"y\":-1282.64599609375,\"z\":29.65900039672851}', NULL, 50000, NULL, NULL),
(61, '{\"x\":289.0119934082031,\"y\":-1256.5450439453126,\"z\":29.44000053405761}', NULL, 50000, NULL, NULL),
(62, '{\"x\":295.8389892578125,\"y\":-895.6400146484375,\"z\":29.21699905395507}', NULL, 50000, NULL, NULL),
(63, '{\"x\":1686.7530517578126,\"y\":4815.80908203125,\"z\":42.00799942016601}', NULL, 50000, NULL, NULL),
(64, '{\"x\":-302.4079895019531,\"y\":-829.9450073242188,\"z\":32.41699981689453}', NULL, 50000, NULL, NULL),
(65, '{\"x\":5.13399982452392,\"y\":-919.948974609375,\"z\":29.55699920654297}', NULL, 50000, NULL, NULL),
(66, '{\"x\":1139.0179443359376,\"y\":-469.885986328125,\"z\":66.78900146484375}', NULL, 50000, NULL, NULL),
(67, '{\"x\":327.63372802734377,\"y\":-1373.388671875,\"z\":31.90983009338379}', '{\"x\":328.00469970703127,\"y\":-1372.8931884765626,\"z\":30.91242218017578}', 50000, 319.79721069336, 'prop_atm_01');

-- --------------------------------------------------------

--
-- Table structure for table `baninfo`
--

DROP TABLE IF EXISTS `baninfo`;
CREATE TABLE IF NOT EXISTS `baninfo` (
  `identifier` varchar(25) COLLATE utf8mb4_bin NOT NULL,
  `license` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `liveid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `xblid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `discord` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL,
  `playerip` varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  `playername` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Dumping data for table `baninfo`
--

INSERT INTO `baninfo` (`identifier`, `license`, `liveid`, `xblid`, `discord`, `playerip`, `playername`) VALUES
('steam:11000010441bee9', 'license:23735c7344bc9f32a2137cba6cbd67751184a27f', 'live:844427293949585', 'xbl:2535427538323355', 'discord:319628026251837442', 'ip:192.168.1.12', 'Sikora'),
('steam:110000106921eea', 'license:1a17700fb3ebe57d0e8179efdd6e6e1ccb43168b', 'live:1688852646456500', 'xbl:2533274866168124', 'discord:275436547317301248', 'ip:91.49.45.110', 'Ficho'),
('steam:11000010a1d1042', 'license:c7a857dcd5b4160c69d1671f02e52332bd339733', 'live:1829578983319685', 'xbl:2535460133546917', 'discord:293992988936241153', 'ip:109.237.34.43', 'chame'),
('steam:11000010ad5cf80', 'license:104849bd70250f8f538fb51379f5a4a258f6e960', 'live:1829582274463247', 'xbl:2535463957312212', 'no info', 'ip:92.195.157.176', 'MaZz'),
('steam:11000010e086b7e', 'license:ebdfe690c597862ea966a6893ad2fe9aaddcc873', 'live:985153873677826', 'xbl:2535440026774096', 'discord:267022675866550275', 'ip:31.45.213.135', 'LJANTU'),
('steam:110000111cd0aa0', 'license:e4090a08909875dbb99f15633c3ec4ef87d9e9f8', 'live:914801695294364', 'xbl:2535456657275324', 'no info', 'ip:80.187.96.5', 'GABO'),
('steam:110000115e9ac6b', 'no info', 'no info', 'no info', 'no info', 'ip:141.170.197.97', 'SpeLLe'),
('steam:11000011aee96e0', 'license:23735c7344bc9f32a2137cba6cbd67751184a27f', 'live:844427293949585', 'xbl:2535427538323355', 'discord:319628026251837442', 'ip:192.168.1.14', 'hashtag.sikora'),
('steam:1100001453fc4a4', 'license:28b3a93ce930a76bb21c53788d5a938c86ed7160', 'live:914798680250289', 'xbl:2535464137820964', 'discord:853641506148319302', 'ip:86.31.105.27', '~r~Owner | ~w~Fuezify'),
('steam:11000014694839f', 'license:90b661c3b1f4c5647edd360963abfb730037ed79', 'no info', 'no info', 'no info', 'ip:185.193.240.203', 'zarezarkovski csgocases.com');

-- --------------------------------------------------------

--
-- Table structure for table `banka_transakcije`
--

DROP TABLE IF EXISTS `banka_transakcije`;
CREATE TABLE IF NOT EXISTS `banka_transakcije` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Vlasnik` int(11) DEFAULT NULL,
  `Tekst` varchar(255) DEFAULT NULL,
  `Iznos` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `vlasnik` (`Vlasnik`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `banka_transakcije`
--

INSERT INTO `banka_transakcije` (`ID`, `Vlasnik`, `Tekst`, `Iznos`) VALUES
(47, 10000, 'Plaćanje poreza', -95000),
(46, 10000, 'Plaćanje poreza', -95000),
(45, 10000, 'Plaćanje poreza', -95000),
(44, 10000, 'Plaćanje poreza', -92500),
(43, 10000, 'Plaćanje poreza', -92500),
(42, 10000, 'Spremanje novca na račun', 12),
(41, 10000, 'Podizanje novca s računa', -189),
(40, 10000, 'Podizanje novca s računa', -16),
(38, 10000, 'Plaćanje poreza', -92500),
(37, 10000, 'Podizanje novca s računa', -1),
(34, 10000, 'Spremanje novca na račun', 1),
(32, 10000, 'Isplata kredita', 50000),
(33, 10000, 'Vraćanje kredita', -57500),
(39, 10000, 'Podizanje novca s računa', -14),
(29, 10000, 'Spremanje novca na račun', 15),
(36, 10000, 'Plaćanje poreza', -92500),
(35, 10000, 'Podizanje novca s računa', -1),
(31, 10000, 'Vraćanje kredita', -125000),
(30, 10000, 'Isplata kredita', 100000),
(28, 10000, 'Podizanje novca s računa', -15),
(27, 10000, 'Plaćanje poreza', -92500),
(48, 10000, 'Plaćanje poreza', -95000),
(49, 10000, 'Plaćanje poreza', -95000),
(50, 10000, 'Plaćanje poreza', -95000),
(51, 10000, 'Plaćanje poreza', -95000),
(52, 10000, 'Plaćanje poreza', -95000);

-- --------------------------------------------------------

--
-- Table structure for table `banlist`
--

DROP TABLE IF EXISTS `banlist`;
CREATE TABLE IF NOT EXISTS `banlist` (
  `identifier` varchar(25) COLLATE utf8mb4_bin NOT NULL,
  `license` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `liveid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `xblid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `discord` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL,
  `playerip` varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  `targetplayername` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `sourceplayername` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `reason` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `timeat` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `added` datetime DEFAULT current_timestamp(),
  `expiration` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `permanent` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`identifier`),
  KEY `target` (`targetplayername`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Table structure for table `banlisthistory`
--

DROP TABLE IF EXISTS `banlisthistory`;
CREATE TABLE IF NOT EXISTS `banlisthistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(25) COLLATE utf8mb4_bin NOT NULL,
  `license` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `liveid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `xblid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `discord` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL,
  `playerip` varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  `targetplayername` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `sourceplayername` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `reason` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `timeat` int(11) NOT NULL,
  `added` datetime DEFAULT current_timestamp(),
  `expiration` int(11) NOT NULL,
  `permanent` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Dumping data for table `banlisthistory`
--

INSERT INTO `banlisthistory` (`id`, `identifier`, `license`, `liveid`, `xblid`, `discord`, `playerip`, `targetplayername`, `sourceplayername`, `reason`, `timeat`, `added`, `expiration`, `permanent`) VALUES
(1, 'steam:11000010ad5cf80', 'license:104849bd70250f8f538fb51379f5a4a258f6e960', 'live:1829582274463247', 'xbl:2535463957312212', '', 'ip:92.195.233.240', 'MaZz', 'autobanned', 'Citer. Ukoliko mislite da je doslo do pogreske kontaktirajte nas na: https://discord.gg/rAWxYmp', 1635024253, '2021-10-23 23:24:13', 1635024253, 1),
(2, 'steam:11000010ad5cf80', 'license:104849bd70250f8f538fb51379f5a4a258f6e960', 'live:1829582274463247', 'xbl:2535463957312212', '', 'ip:92.195.233.240', 'MaZz', 'autobanned', 'Citer. Ukoliko mislite da je doslo do pogreske kontaktirajte nas na: https://discord.gg/rAWxYmp', 1635036020, '2021-10-24 02:40:20', 1635036020, 1),
(3, 'steam:11000014694839f', 'license:90b661c3b1f4c5647edd360963abfb730037ed79', 'no info', 'no info', 'no info', 'ip:185.193.240.203', 'zarezarkovski csgocases.com', '#Sikora', 'ode (#Sikora)', 1635080138, '2021-10-24 14:55:38', 1635080138, 1),
(4, 'steam:110000111cd0aa0', 'license:e4090a08909875dbb99f15633c3ec4ef87d9e9f8', 'live:914801695294364', 'xbl:2535456657275324', '', 'ip:80.187.97.35', 'GABO', 'autobanned', 'Citer. Ukoliko mislite da je doslo do pogreske kontaktirajte nas na: https://discord.gg/rAWxYmp', 1635083175, '2021-10-24 15:46:15', 1635083175, 1),
(5, 'steam:11000010e086b7e', 'license:ebdfe690c597862ea966a6893ad2fe9aaddcc873', 'live:985153873677826', 'xbl:2535440026774096', 'discord:267022675866550275', 'ip:109.227.20.189', 'LJANTU', 'Ficho', 'dm (Ficho)', 1635083389, '2021-10-24 15:49:49', 1635169789, 0),
(6, 'steam:110000106921eea', 'license:1a17700fb3ebe57d0e8179efdd6e6e1ccb43168b', 'live:1688852646456500', 'xbl:2533274866168124', 'discord:275436547317301248', 'ip:91.49.39.37', 'Ficho', '#Sikora', '0 (#Sikora)', 1635083613, '2021-10-24 15:53:33', 1635083613, 1),
(7, 'steam:110000106921eea', 'license:1a17700fb3ebe57d0e8179efdd6e6e1ccb43168b', 'live:1688852646456500', 'xbl:2533274866168124', 'discord:275436547317301248', 'ip:91.49.39.37', 'Ficho', 'autobanned', 'Citer. Ukoliko mislite da je doslo do pogreske kontaktirajte nas na: https://discord.gg/rAWxYmp', 1635084076, '2021-10-24 16:01:16', 1635084076, 1),
(8, 'steam:11000010441bee9', 'license:23735c7344bc9f32a2137cba6cbd67751184a27f', 'live:844427293949585', 'xbl:2535427538323355', 'discord:319628026251837442', 'ip:89.172.237.211', '#Sikora', 'autobanned', 'Citer. Ukoliko mislite da je doslo do pogreske kontaktirajte nas na: https://discord.gg/rAWxYmp', 1635279492, '2021-10-26 22:18:12', 1635279492, 1),
(9, 'steam:11000010441bee9', 'license:23735c7344bc9f32a2137cba6cbd67751184a27f', 'live:844427293949585', 'xbl:2535427538323355', 'discord:319628026251837442', 'ip:93.143.253.4', '#Sikora', 'autobanned', 'Citer. Ukoliko mislite da je doslo do pogreske kontaktirajte nas na: https://discord.gg/rAWxYmp', 1635359946, '2021-10-27 20:39:06', 1635359946, 1),
(10, 'steam:11000010e086b7e', 'license:ebdfe690c597862ea966a6893ad2fe9aaddcc873', 'live:985153873677826', 'xbl:2535440026774096', 'discord:267022675866550275', 'ip:109.227.20.189', 'LJANTU', 'autobanned', 'Citer. Ukoliko mislite da je doslo do pogreske kontaktirajte nas na: https://discord.gg/rAWxYmp', 1635727042, '2021-11-01 01:37:22', 1635727042, 1),
(11, 'steam:11000010441bee9', 'license:23735c7344bc9f32a2137cba6cbd67751184a27f', 'live:844427293949585', 'xbl:2535427538323355', 'discord:319628026251837442', 'ip:89.172.244.191', '#Sikora', 'autobanned', 'Citer. Ukoliko mislite da je doslo do pogreske kontaktirajte nas na: https://discord.gg/rAWxYmp', 1635727281, '2021-11-01 01:41:21', 1635727281, 1),
(12, 'steam:110000106921eea', 'license:1a17700fb3ebe57d0e8179efdd6e6e1ccb43168b', 'live:1688852646456500', 'xbl:2533274866168124', 'discord:275436547317301248', 'ip:91.49.45.110', 'Ficho', 'autobanned', 'Citer. Ukoliko mislite da je doslo do pogreske kontaktirajte nas na: https://discord.gg/rAWxYmp', 1636057531, '2021-11-04 21:25:32', 1636057531, 1),
(13, 'steam:11000010441bee9', 'license:23735c7344bc9f32a2137cba6cbd67751184a27f', '', '', 'discord:319628026251837442', 'ip:93.141.162.122', '#Sikora', 'autobanned', 'Citer. Ukoliko mislite da je doslo do pogreske kontaktirajte nas na: https://discord.gg/rAWxYmp', 1636057532, '2021-11-04 21:25:32', 1636057532, 1),
(14, 'steam:11000010e086b7e', 'license:ebdfe690c597862ea966a6893ad2fe9aaddcc873', 'live:985153873677826', 'xbl:2535440026774096', 'discord:267022675866550275', 'ip:109.227.18.158', 'LJANTU', 'autobanned', 'Citer. Ukoliko mislite da je doslo do pogreske kontaktirajte nas na: https://discord.gg/rAWxYmp', 1636057532, '2021-11-04 21:25:32', 1636057532, 1),
(15, 'steam:11000010441bee9', 'license:23735c7344bc9f32a2137cba6cbd67751184a27f', 'no info', 'no info', 'discord:319628026251837442', 'ip:192.168.1.13', 'Sikora', 'Sikora', 'test bana (Sikora)', 1650921941, '2022-04-25 23:25:41', 1651094741, 0),
(16, 'steam:11000010441bee9', 'license:23735c7344bc9f32a2137cba6cbd67751184a27f', 'live:844427293949585', 'xbl:2535427538323355', 'discord:319628026251837442', 'ip:192.168.1.13', 'Sikora', 'Sikora', 'test bana 2 (Sikora)', 1650922344, '2022-04-25 23:32:24', 1650922344, 1);

-- --------------------------------------------------------

--
-- Table structure for table `billing`
--

DROP TABLE IF EXISTS `billing`;
CREATE TABLE IF NOT EXISTS `billing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` int(11) NOT NULL,
  `sender` int(11) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `target` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `billing`
--

INSERT INTO `billing` (`id`, `identifier`, `sender`, `target_type`, `target`, `label`, `amount`) VALUES
(6, 10011, 10000, 'society', 'society_mechanic', 'Mehanicar | Dijelovi', 3600),
(7, 10011, 10000, 'society', 'society_mechanic', 'Mehanicar | Dijelovi', 7200),
(10, 10010, 10000, 'society', 'society_mechanic', 'Mehanicar | Dijelovi', 7230),
(11, 10010, 10000, 'player', 'steam:11000010441bee9', 'Bolnicar', 2000);

-- --------------------------------------------------------

--
-- Table structure for table `biznisi`
--

DROP TABLE IF EXISTS `biznisi`;
CREATE TABLE IF NOT EXISTS `biznisi` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Ime` text NOT NULL,
  `Label` text NOT NULL,
  `Koord` longtext NOT NULL DEFAULT '{}',
  `Sef` int(20) NOT NULL DEFAULT 0,
  `Vlasnik` int(11) DEFAULT NULL,
  `Posao` varchar(100) DEFAULT NULL,
  `Sati` longtext NOT NULL DEFAULT '{}',
  `Tjedan` int(11) NOT NULL DEFAULT 0,
  `Cijena` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `biznisi`
--

INSERT INTO `biznisi` (`ID`, `Ime`, `Label`, `Koord`, `Sef`, `Vlasnik`, `Posao`, `Sati`, `Tjedan`, `Cijena`) VALUES
(1, 'kosac', 'Kosac trave', '[-1366.4168701171876,56.53075408935547,53.09845733642578]', 0, NULL, 'kosac', '[{\"Ime\":\"Sikora\",\"Identifier\":\"steam:11000010441bee9\",\"Ture\":29,\"Posao\":\"kosac\"}]', 61, 150000),
(2, 'farmer', 'Farmer', '[2415.745849609375,4993.283203125,45.2213249206543]', 917, NULL, 'farmer', '{}', 0, 100000),
(3, 'kamion', 'Kamiondzija', '[1183.4019775390626,-3303.89501953125,5.9168572425842289]', 23280, NULL, 'kamion', '[{\"Ture\":5,\"Ime\":\"Sikora\",\"Identifier\":\"steam:11000010441bee9\",\"Posao\":\"kamion\"}]', 2070, 120000),
(4, 'luka', 'Lucki radnik', '[926.2833862304688,-2935.85009765625,4.90115547180175]', 0, 10000, 'luka', '[{\"Posao\":\"luka\",\"Ture\":1,\"Identifier\":\"steam:11000010441bee9\",\"Ime\":\"Sikora\"}]', 210, 115000);

-- --------------------------------------------------------

--
-- Table structure for table `bought_houses`
--

DROP TABLE IF EXISTS `bought_houses`;
CREATE TABLE IF NOT EXISTS `bought_houses` (
  `houseid` int(50) NOT NULL,
  `vlasnik` int(11) DEFAULT NULL,
  PRIMARY KEY (`houseid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `bought_houses`
--

INSERT INTO `bought_houses` (`houseid`, `vlasnik`) VALUES
(29, 10000);

-- --------------------------------------------------------

--
-- Table structure for table `communityservice`
--

DROP TABLE IF EXISTS `communityservice`;
CREATE TABLE IF NOT EXISTS `communityservice` (
  `identifier` int(11) NOT NULL,
  `actions_remaining` int(10) NOT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `datastore`
--

DROP TABLE IF EXISTS `datastore`;
CREATE TABLE IF NOT EXISTS `datastore` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `datastore_data`
--

DROP TABLE IF EXISTS `datastore_data`;
CREATE TABLE IF NOT EXISTS `datastore_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `owner` varchar(60) DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_datastore_data_name_owner` (`name`,`owner`),
  KEY `index_datastore_data_name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `droge`
--

DROP TABLE IF EXISTS `droge`;
CREATE TABLE IF NOT EXISTS `droge` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `vrsta` int(11) DEFAULT NULL COMMENT '1 - heroin',
  `branje` longtext DEFAULT NULL,
  `heading` decimal(11,2) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `droge`
--

INSERT INTO `droge` (`ID`, `vrsta`, `branje`, `heading`) VALUES
(1, 1, '{\"x\":-1240.41064453125,\"y\":73.79826354980469,\"z\":51.98569869995117}', NULL),
(2, 2, '{\"x\":-1015.3260498046875,\"y\":0.84805941581726,\"z\":47.87119674682617}', NULL),
(3, 3, '{\"x\":1522.4974365234376,\"y\":6329.16845703125,\"z\":23.60689353942871}', '332.71');

-- --------------------------------------------------------

--
-- Table structure for table `elektricar`
--

DROP TABLE IF EXISTS `elektricar`;
CREATE TABLE IF NOT EXISTS `elektricar` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ime` varchar(255) NOT NULL,
  `lokacija` varchar(255) NOT NULL DEFAULT '{}',
  `radius` int(11) NOT NULL DEFAULT 40,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=47 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `elektricar`
--

INSERT INTO `elektricar` (`ID`, `ime`, `lokacija`, `radius`) VALUES
(2, 'Kvar 1', '{\"x\":19.09602165222168,\"y\":-1335.6456298828126,\"z\":29.27881050109863}', 40),
(7, 'Kvar 2', '{\"x\":239.26345825195313,\"y\":-1277.830078125,\"z\":29.2890396118164}', 80),
(8, 'Kvar 3', '{\"x\":-88.11775970458985,\"y\":-1750.27880859375,\"z\":29.5396614074707}', 60),
(9, 'Kvar 4', '{\"x\":71.82926940917969,\"y\":-1392.4063720703126,\"z\":34.8285026550293}', 30),
(10, 'Kvar 5', '{\"x\":149.0435333251953,\"y\":-837.6505737304688,\"z\":31.05932998657226}', 150),
(11, 'Kvar 6', '{\"x\":137.57676696777345,\"y\":-1280.72802734375,\"z\":29.36229515075683}', 70),
(12, 'Kvar 7', '{\"x\":1125.5672607421876,\"y\":-983.0593872070313,\"z\":45.41583251953125}', 40),
(13, 'Kvar 8', '{\"x\":14.96589946746826,\"y\":-1114.8077392578126,\"z\":29.79118537902832}', 40),
(14, 'Kvar 9', '{\"x\":-143.32786560058595,\"y\":-272.4048156738281,\"z\":41.81704711914062}', 60),
(15, 'Kvar 10', '{\"x\":-40.79038619995117,\"y\":-135.7283477783203,\"z\":57.3576431274414}', 40),
(16, 'Kvar 11', '{\"x\":-712.393798828125,\"y\":-165.4031524658203,\"z\":36.98808288574219}', 40),
(17, 'Kvar 12', '{\"x\":-804.3504638671875,\"y\":-186.19041442871095,\"z\":37.31045532226562}', 40),
(18, 'Kvar 13', '{\"x\":-1299.04296875,\"y\":-389.1418762207031,\"z\":36.5162467956543}', 50),
(19, 'Kvar 14', '{\"x\":-1479.5716552734376,\"y\":-372.41796875,\"z\":39.18350601196289}', 40),
(20, 'Kvar 15', '{\"x\":-1201.5537109375,\"y\":-776.0203857421875,\"z\":17.32086563110351}', 40),
(21, 'Kvar 16', '{\"x\":-1217.572998046875,\"y\":-915.7728881835938,\"z\":11.32657718658447}', 40),
(22, 'Kvar 17', '{\"x\":-1291.820068359375,\"y\":-1123.7720947265626,\"z\":6.39883995056152}', 40),
(23, 'Kvar 18', '{\"x\":-678.8347778320313,\"y\":-923.9144287109375,\"z\":23.07683372497558}', 80),
(24, 'Kvar 19', '{\"x\":-790.18310546875,\"y\":-1103.57666015625,\"z\":10.64577770233154}', 60),
(25, 'Kvar 20', '{\"x\":138.62147521972657,\"y\":-1703.9486083984376,\"z\":29.29162788391113}', 25),
(26, 'Kvar 21', '{\"x\":813.984130859375,\"y\":-2159.734130859375,\"z\":29.61902046203613}', 45),
(27, 'Kvar 22', '{\"x\":1167.103759765625,\"y\":-321.4547119140625,\"z\":69.27613067626953}', 45),
(28, 'Kvar 23', '{\"x\":1216.796630859375,\"y\":-472.6036682128906,\"z\":66.20800018310547}', 25),
(29, 'Kvar 24', '{\"x\":370.0440979003906,\"y\":324.3636169433594,\"z\":103.56730651855469}', 25),
(30, 'Kvar 25', '{\"x\":216.95556640625,\"y\":-49.9837532043457,\"z\":69.08808898925781}', 45),
(31, 'Kvar 26', '{\"x\":852.3270874023438,\"y\":-995.280029296875,\"z\":29.03023338317871}', 80),
(32, 'Kvar 27', '{\"x\":-1837.3992919921876,\"y\":789.905029296875,\"z\":138.655029296875}', 70),
(33, 'Kvar 28', '{\"x\":2545.80615234375,\"y\":371.99755859375,\"z\":108.61490631103516}', 120),
(34, 'Kvar 29', '{\"x\":-3049.685302734375,\"y\":589.705810546875,\"z\":7.74872827529907}', 40),
(35, 'Kvar 30', '{\"x\":-3241.970947265625,\"y\":1012.9772338867188,\"z\":12.39639091491699}', 25),
(36, 'Kvar 31', '{\"x\":555.2152099609375,\"y\":2665.177490234375,\"z\":42.20278167724609}', 40),
(37, 'Kvar 32', '{\"x\":1965.1390380859376,\"y\":3750.11083984375,\"z\":32.24761581420898}', 40),
(38, 'Kvar 33', '{\"x\":2678.63232421875,\"y\":3275.0673828125,\"z\":55.40906143188476}', 40),
(39, 'Kvar 34', '{\"x\":1713.204833984375,\"y\":6426.8837890625,\"z\":32.7645034790039}', 55),
(40, 'Kvar 35', '{\"x\":-2978.6943359375,\"y\":383.77398681640627,\"z\":14.99244022369384}', 40),
(41, 'Kvar 36', '{\"x\":-356.1400451660156,\"y\":-1475.953857421875,\"z\":30.00131797790527}', 70),
(42, 'Kvar 37', '{\"x\":-543.7998657226563,\"y\":-1226.195556640625,\"z\":18.45167732238769}', 50),
(43, 'Kvar 38', '{\"x\":430.98272705078127,\"y\":-803.9796752929688,\"z\":29.49115943908691}', 40),
(44, 'Kvar 39', '{\"x\":8.64949512481689,\"y\":6505.0302734375,\"z\":31.53084564208984}', 40),
(45, 'Kvar 40', '{\"x\":1702.630126953125,\"y\":4818.22412109375,\"z\":41.95983505249023}', 40),
(46, 'Kvar 41', '{\"x\":1710.8399658203126,\"y\":4934.6669921875,\"z\":42.07932662963867}', 50);

-- --------------------------------------------------------

--
-- Table structure for table `fine_types`
--

DROP TABLE IF EXISTS `fine_types`;
CREATE TABLE IF NOT EXISTS `fine_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `category` (`category`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Dumping data for table `fine_types`
--

INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
(1, 'Krivo koristenje trube', 5300, 0),
(2, 'Gazenje pune linije', 5400, 0),
(3, 'Voznja krivom stranom ceste', 7500, 0),
(4, 'Nelegalno okretanje', 7500, 0),
(5, 'Ilegalna voznja izvan ceste', 6700, 0),
(6, 'Odbijanje zakonite naredbe', 5300, 0),
(7, 'Nelegalno zaustavljanje vozila', 5150, 0),
(8, 'Nelegalno parkiranje', 5700, 0),
(9, 'Ne propustanje sluzbenog vozila', 5500, 0),
(10, 'Vozilo ne odgovara papirima', 7500, 0),
(11, 'Ne zaustavljanje na stop znak', 6500, 0),
(12, 'Ne zaustavljanje na crveno svjetlo', 6500, 0),
(13, 'Nelegalno obilazenje', 6000, 0),
(14, 'Voznja neregistriranog vozila', 6000, 0),
(15, 'Voznja bez vozacke dozvole', 6500, 0),
(16, 'Napustanje mjesta prometne nesrece', 13000, 0),
(17, 'Prekoracenje brzine > 5 km/h', 5900, 0),
(18, 'Prekoracenje brzine izmedju 5 i 15 km/h', 6200, 0),
(19, 'Prekoracenje brzine izmedju 15 i 30 km/h', 6800, 0),
(20, 'Prekoracenje brzine vise od 30 km/h', 8000, 0),
(21, 'Ometanje tijeka prometa', 5100, 1),
(22, 'Javno pijan', 5900, 1),
(23, 'Neprimjereno ponasanje', 5090, 1),
(24, 'Ometanje pravnih sluzbi', 5130, 1),
(25, 'Vrijedjanje osobe', 5075, 1),
(26, 'Nepostivanaje pravne osobe', 5110, 1),
(27, 'Verbalna prijetnja civilu', 5090, 1),
(28, 'Verbalna prijetnja sluzbenoj osobi', 5150, 1),
(29, 'Davanje laznih podataka', 5250, 1),
(30, 'Pokusaj korupcije', 6500, 1),
(31, 'Javno pokazivanje oruzja unutar grada', 5120, 2),
(32, 'Javno pokazivanje smrtonosnog oruzja unutar grada', 5300, 2),
(33, 'Nema dozvole za oruzje', 5600, 2),
(34, 'Posjedovanje nelegalnog oruzja', 5700, 2),
(35, 'Posjedovanje alata za provaljivanje', 5300, 2),
(36, 'Kradja vozila', 6800, 2),
(37, 'Namjera prodaje/distribucije ilegalnih substanci', 6500, 2),
(38, 'Proizvodnja ilegalnih substanci', 6500, 2),
(39, 'Posjedovanje ilegalne substance', 5650, 2),
(40, 'Otmica civila', 6500, 2),
(41, 'Otmica sluzbene osobe', 7000, 2),
(42, 'Pljacka', 5650, 2),
(43, 'Oruzana pljacka trgovine', 5650, 2),
(44, 'Oruzana pljacka banke', 6500, 2),
(45, 'Napad na civila', 7000, 3),
(46, 'Napad na sluzbenu osobu', 7500, 3),
(47, 'Pokusaj ubojstva civila', 8000, 3),
(48, 'Pokusaj ubojstva sluzbene osobe', 10000, 3),
(49, 'Ubojstvo civila', 15000, 3),
(50, 'Ubojstvo sluzbene osobe', 35000, 3),
(51, 'Ubojstvo iz nehaja', 6800, 3),
(52, 'Prevara', 7000, 2),
(53, 'Nepropisno parkiranje osobnog vozila.', 15000, 2),
(54, 'Pljacka Banke.', 150000, 2),
(55, 'Pljacka trgovine.', 20000, 2),
(56, 'Pljacka zlatare.', 50000, 2),
(57, 'Organizirani Kriminal.', 80000, 2);

-- --------------------------------------------------------

--
-- Table structure for table `firme`
--

DROP TABLE IF EXISTS `firme`;
CREATE TABLE IF NOT EXISTS `firme` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Ime` varchar(255) NOT NULL,
  `Label` varchar(255) DEFAULT NULL,
  `Tip` int(11) NOT NULL DEFAULT 1,
  `Kupovina` varchar(255) NOT NULL DEFAULT '{}',
  `Ulaz` varchar(255) NOT NULL DEFAULT '{}',
  `Izlaz` varchar(255) NOT NULL DEFAULT '{}',
  `VlasnikKoord` varchar(255) NOT NULL DEFAULT '{}',
  `Vlasnik` int(11) DEFAULT NULL,
  `Sef` int(11) NOT NULL DEFAULT 0,
  `Cijena` int(11) NOT NULL DEFAULT 1000000,
  `Zakljucana` int(11) NOT NULL DEFAULT 0,
  `Posao` int(11) NOT NULL DEFAULT 0,
  `Skladiste` int(11) NOT NULL DEFAULT 0,
  `Vozila` longtext DEFAULT NULL,
  `Proizvodi` longtext DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=90 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `firme`
--

INSERT INTO `firme` (`ID`, `Ime`, `Label`, `Tip`, `Kupovina`, `Ulaz`, `Izlaz`, `VlasnikKoord`, `Vlasnik`, `Sef`, `Cijena`, `Zakljucana`, `Posao`, `Skladiste`, `Vozila`, `Proizvodi`) VALUES
(51, 'firma9', 'Firma 9', 1, '{\"x\":1135.608642578125,\"y\":-982.2374877929688,\"z\":46.41579055786133}', '{}', '{}', '{\"x\":1130.785400390625,\"y\":-983.2907104492188,\"z\":46.41579055786133}', NULL, 0, 105000, 0, 0, 0, '{}', '[]'),
(50, 'firma8', 'Firma 8', 1, '{\"x\":25.74614143371582,\"y\":-1346.8341064453126,\"z\":29.49701118469238}', '{}', '{}', '{\"x\":30.63790321350097,\"y\":-1339.8995361328126,\"z\":29.49701118469238}', NULL, 0, 125000, 0, 0, 0, '{}', '[]'),
(49, 'firma7', 'Firma 7', 1, '{\"x\":1729.101806640625,\"y\":6415.0322265625,\"z\":35.03721237182617}', '{}', '{}', '{\"x\":1736.4447021484376,\"y\":6419.095703125,\"z\":35.03721237182617}', NULL, 0, 56000, 0, 0, 0, '{}', '[]'),
(48, 'firma6', 'Firma 6', 1, '{\"x\":2678.23388671875,\"y\":3280.870849609375,\"z\":55.24111938476562}', '{}', '{}', '{\"x\":2674.646240234375,\"y\":3288.287353515625,\"z\":55.24111938476562}', NULL, 0, 74000, 0, 0, 0, '{}', '[]'),
(47, 'firma5', 'Firma 5', 1, '{\"x\":1960.943603515625,\"y\":3741.1650390625,\"z\":32.34373092651367}', '{}', '{}', '{\"x\":1961.6397705078126,\"y\":3749.4482421875,\"z\":32.34373092651367}', NULL, 0, 65000, 0, 0, 0, '{}', '[]'),
(46, 'firma4', 'Firma 4', 1, '{\"x\":547.8786010742188,\"y\":2670.676513671875,\"z\":42.1564826965332}', '{}', '{}', '{\"x\":543.9300537109375,\"y\":2663.234375,\"z\":42.1564826965332}', NULL, 85, 73000, 0, 0, 0, '{}', '[]'),
(45, 'firma3', 'Firma 3', 1, '{\"x\":-3242.785400390625,\"y\":1001.221923828125,\"z\":12.83070373535156}', '{}', '{}', '{\"x\":-3248.99658203125,\"y\":1006.9669799804688,\"z\":12.83070373535156}', NULL, 0, 76000, 0, 0, 0, '{}', '[]'),
(44, 'firma2', 'Firma 2', 1, '{\"x\":-3039.935791015625,\"y\":585.5108032226563,\"z\":7.90892839431762}', '{}', '{}', '{\"x\":-3047.92138671875,\"y\":588.3067626953125,\"z\":7.90892839431762}', NULL, 0, 85000, 0, 0, 0, '{}', '[]'),
(43, 'firma1', 'Firma 1', 1, '{\"x\":2556.7587890625,\"y\":382.1427307128906,\"z\":108.6229248046875}', '{}', '{}', '{\"x\":2550.07763671875,\"y\":387.1881408691406,\"z\":108.6229248046875}', NULL, 0, 80000, 0, 0, 0, '{}', '[]'),
(42, 'firma0', 'Firma 0', 1, '{\"x\":373.9737854003906,\"y\":326.5569152832031,\"z\":103.56635284423828}', '{}', '{}', '{\"x\":380.04425048828127,\"y\":332.1336975097656,\"z\":103.56635284423828}', NULL, 0, 120000, 0, 0, 0, '{}', '[]'),
(52, 'firma10', 'Firma 10', 1, '{\"x\":-1222.769287109375,\"y\":-907.1284790039063,\"z\":12.32633876800537}', '{}', '{}', '{\"x\":-1219.471923828125,\"y\":-910.6727905273438,\"z\":12.32676029205322}', NULL, 0, 108000, 0, 0, 0, '{}', '[]'),
(53, 'firma11', 'Firma 11', 1, '{\"x\":-1487.2860107421876,\"y\":-378.93603515625,\"z\":40.16337203979492}', '{}', '{}', '{\"x\":-1484.6513671875,\"y\":-374.9789123535156,\"z\":40.16360855102539}', NULL, 0, 110000, 0, 0, 0, '{}', '[]'),
(54, 'firma12', 'Firma 12', 1, '{\"x\":-2968.155029296875,\"y\":390.91717529296877,\"z\":15.04329872131347}', '{}', '{}', '{\"x\":-2963.06787109375,\"y\":391.6311340332031,\"z\":15.04332065582275}', NULL, 0, 87000, 0, 0, 0, '{}', '[]'),
(55, 'firma13', 'Firma 13', 1, '{\"x\":1166.02197265625,\"y\":2708.996826171875,\"z\":38.15761947631836}', '{}', '{}', '{\"x\":1164.896240234375,\"y\":2714.0908203125,\"z\":38.15814590454101}', NULL, 0, 78000, 0, 0, 0, '{}', '[]'),
(56, 'firma14', 'Firma 14', 1, '{\"x\":1392.4520263671876,\"y\":3604.804443359375,\"z\":34.98087692260742}', '{}', '{}', '{\"x\":1393.780517578125,\"y\":3609.297119140625,\"z\":34.98087692260742}', NULL, 0, 65000, 0, 0, 0, '{}', '[]'),
(57, 'firma15', 'Firma 15', 1, '{\"x\":-47.98810958862305,\"y\":-1757.4256591796876,\"z\":29.42098808288574}', '{}', '{}', '{\"x\":-45.04561233520508,\"y\":-1750.4444580078126,\"z\":29.42101860046386}', NULL, 0, 109000, 0, 0, 0, '{}', '[]'),
(58, 'firma16', 'Firma 16', 1, '{\"x\":1163.539306640625,\"y\":-323.42889404296877,\"z\":69.20502471923828}', '{}', '{}', '{\"x\":1160.241455078125,\"y\":-316.27947998046877,\"z\":69.20502471923828}', NULL, 0, 103000, 0, 0, 0, '{}', '[]'),
(59, 'firma17', 'Firma 17', 1, '{\"x\":-707.3284301757813,\"y\":-914.1729125976563,\"z\":19.2155818939209}', '{}', '{}', '{\"x\":-709.3485107421875,\"y\":-906.6134643554688,\"z\":19.2155818939209}', NULL, 0, 112000, 0, 0, 0, '{}', '[]'),
(60, 'firma18', 'Firma 18', 1, '{\"x\":-1820.8211669921876,\"y\":793.1325073242188,\"z\":138.11141967773438}', '{}', '{}', '{\"x\":-1827.2333984375,\"y\":797.1124267578125,\"z\":138.17434692382813}', NULL, 0, 88000, 0, 0, 0, '{}', '[]'),
(61, 'firma19', 'Firma 19', 1, '{\"x\":1698.5770263671876,\"y\":4924.3095703125,\"z\":42.06361389160156}', '{}', '{}', '{\"x\":1705.5875244140626,\"y\":4921.49462890625,\"z\":42.06361389160156}', NULL, 0, 78000, 0, 0, 0, '{}', '[]'),
(62, 'firma20', 'Firma 20', 2, '{\"x\":-814.3079833984375,\"y\":-183.82350158691407,\"z\":37.54518508911133}', '{}', '{}', '{\"x\":-809.01513671875,\"y\":-180.4512939453125,\"z\":37.56887817382812}', NULL, 0, 75000, 0, 0, 0, '{}', '[]'),
(63, 'firma21', 'Firma 21', 2, '{\"x\":136.82125854492188,\"y\":-1708.3829345703126,\"z\":29.29155158996582}', '{}', '{}', '{\"x\":141.14288330078126,\"y\":-1706.326171875,\"z\":29.29162979125976}', NULL, 0, 66000, 0, 0, 0, '{}', '[]'),
(64, 'firma22', 'Firma 22', 2, '{\"x\":-1282.60400390625,\"y\":-1116.7569580078126,\"z\":6.99002647399902}', '{}', '{}', '{\"x\":-1278.7142333984376,\"y\":-1119.0989990234376,\"z\":6.9901213645935}', NULL, 0, 75000, 0, 0, 0, '{}', '[]'),
(65, 'firma23', 'Firma 23', 2, '{\"x\":1931.512939453125,\"y\":3729.6708984375,\"z\":32.84412002563476}', '{}', '{}', '{\"x\":1931.2784423828126,\"y\":3734.667724609375,\"z\":32.84447860717773}', NULL, 0, 51000, 0, 0, 0, '{}', '[]'),
(66, 'firma24', 'Firma 24', 2, '{\"x\":1212.8399658203126,\"y\":-472.9211730957031,\"z\":66.20800018310547}', '{}', '{}', '{\"x\":1215.8123779296876,\"y\":-475.5716247558594,\"z\":66.20800018310547}', NULL, 0, 65000, 0, 0, 0, '{}', '[]'),
(67, 'firma25', 'Firma 25', 2, '{\"x\":-32.88523864746094,\"y\":-152.3190460205078,\"z\":57.0761489868164}', '{}', '{}', '{\"x\":-36.25354766845703,\"y\":-155.8475799560547,\"z\":57.07655715942383}', NULL, 0, 67000, 0, 0, 0, '{}', '[]'),
(68, 'firma26', 'Firma 26', 2, '{\"x\":-278.0769958496094,\"y\":6228.462890625,\"z\":31.69512939453125}', '{}', '{}', '{\"x\":-276.7023620605469,\"y\":6224.1083984375,\"z\":31.69554138183593}', NULL, 0, 45000, 0, 0, 0, '{}', '[]'),
(69, 'firma27', 'Firma 27', 3, '{\"x\":72.24475860595703,\"y\":-1399.10205078125,\"z\":29.37605667114257}', '{}', '{}', '{\"x\":71.25747680664063,\"y\":-1391.0709228515626,\"z\":29.37615394592285}', NULL, 0, 88000, 0, 0, 0, '{}', '[]'),
(70, 'firma28', 'Firma 28', 3, '{\"x\":-703.7697143554688,\"y\":-152.24977111816407,\"z\":37.41505813598633}', '{}', '{}', '{\"x\":-708.8536376953125,\"y\":-151.46649169921876,\"z\":37.41512298583984}', NULL, 0, 100000, 0, 0, 0, '{}', '[]'),
(71, 'firma29', 'Firma 29', 3, '{\"x\":-167.86314392089845,\"y\":-298.96905517578127,\"z\":39.73307418823242}', '{}', '{}', '{\"x\":-164.94041442871095,\"y\":-302.9537658691406,\"z\":39.73327255249023}', NULL, 0, 95000, 0, 0, 0, '{}', '[]'),
(72, 'firma30', 'Firma 30', 3, '{\"x\":428.69403076171877,\"y\":-800.1060180664063,\"z\":29.49103546142578}', '{}', '{}', '{\"x\":429.4186096191406,\"y\":-808.0657958984375,\"z\":29.49115753173828}', NULL, 0, 99000, 0, 0, 0, '{}', '[]'),
(73, 'firma31', 'Firma 31', 3, '{\"x\":-829.4130859375,\"y\":-1073.7099609375,\"z\":11.32802772521972}', '{}', '{}', '{\"x\":-822.722900390625,\"y\":-1069.21630859375,\"z\":11.32811546325683}', NULL, 0, 92000, 0, 0, 0, '{}', '[]'),
(74, 'firma32', 'Firma 32', 3, '{\"x\":-1447.7969970703126,\"y\":-242.4613037109375,\"z\":49.8082389831543}', '{}', '{}', '{\"x\":-1448.7855224609376,\"y\":-237.90692138671876,\"z\":49.81341552734375}', NULL, 0, 98000, 0, 0, 0, '{}', '[]'),
(75, 'firma33', 'Firma 33', 3, '{\"x\":11.6318244934082,\"y\":6514.22412109375,\"z\":31.87721443176269}', '{}', '{}', '{\"x\":6.26214742660522,\"y\":6508.384765625,\"z\":31.87786102294922}', NULL, 0, 67000, 0, 0, 0, '{}', '[]'),
(76, 'firma34', 'Firma 34', 3, '{\"x\":123.63652038574219,\"y\":-219.4370880126953,\"z\":54.55775833129883}', '{}', '{}', '{\"x\":117.81684875488281,\"y\":-233.59048461914063,\"z\":54.55780029296875}', NULL, 0, 89000, 0, 0, 0, '{}', '[]'),
(77, 'firma35', 'Firma 35', 3, '{\"x\":1696.291015625,\"y\":4829.31201171875,\"z\":42.06302261352539}', '{}', '{}', '{\"x\":1698.141357421875,\"y\":4821.568359375,\"z\":42.06315994262695}', NULL, 0, 56000, 0, 0, 0, '{}', '[]'),
(78, 'firma36', 'Firma 36', 3, '{\"x\":618.0931396484375,\"y\":2759.62890625,\"z\":42.0880241394043}', '{}', '{}', '{\"x\":617.5364990234375,\"y\":2775.14794921875,\"z\":42.08807373046875}', NULL, 0, 73000, 0, 0, 0, '{}', '[]'),
(79, 'firma37', 'Firma 37', 3, '{\"x\":1190.550048828125,\"y\":2713.44091796875,\"z\":38.22215270996094}', '{}', '{}', '{\"x\":1198.62841796875,\"y\":2714.277099609375,\"z\":38.22265625}', NULL, 0, 61000, 0, 0, 0, '{}', '[]'),
(80, 'firma38', 'Firma 38', 3, '{\"x\":-1193.428955078125,\"y\":-772.2621459960938,\"z\":17.32410812377929}', '{}', '{}', '{\"x\":-1180.7735595703126,\"y\":-764.0654907226563,\"z\":17.32663345336914}', NULL, 0, 82000, 0, 0, 0, '{}', '[]'),
(81, 'firma39', 'Firma 39', 3, '{\"x\":-3172.49609375,\"y\":1048.133056640625,\"z\":20.86305999755859}', '{}', '{}', '{\"x\":-3179.291259765625,\"y\":1034.1827392578126,\"z\":20.86320686340332}', NULL, 0, 62000, 0, 0, 0, '{}', '[]'),
(82, 'firma40', 'Firma 40', 3, '{\"x\":-1108.4410400390626,\"y\":2708.923095703125,\"z\":19.09982681274414}', '{}', '{}', '{\"x\":-1102.66162109375,\"y\":2714.638671875,\"z\":19.1078872680664}', NULL, 0, 56000, 0, 0, 0, '{}', '[]'),
(83, 'firma41', 'Firma 41', 6, '{\"x\":1322.5963134765626,\"y\":-1651.894287109375,\"z\":52.27481079101562}', '{}', '{}', '{\"x\":1324.929931640625,\"y\":-1650.32861328125,\"z\":52.27517318725586}', NULL, 313, 63000, 0, 0, 0, '{}', '[]'),
(84, 'firma42', 'Firma 42', 6, '{\"x\":-1153.5999755859376,\"y\":-1425.612060546875,\"z\":4.95368719100952}', '{}', '{}', '{\"x\":-1151.9586181640626,\"y\":-1423.6500244140626,\"z\":4.95445775985717}', NULL, 0, 54000, 0, 0, 0, '{}', '[]'),
(85, 'firma43', 'Firma 43', 6, '{\"x\":322.0897216796875,\"y\":180.39585876464845,\"z\":103.58580017089844}', '{}', '{}', '{\"x\":319.534912109375,\"y\":181.13531494140626,\"z\":103.58647155761719}', NULL, 0, 60000, 0, 0, 0, '{}', '[]'),
(86, 'firma44', 'Firma 44', 6, '{\"x\":-3170.0,\"y\":1074.988037109375,\"z\":20.82843208312988}', '{}', '{}', '{\"x\":-3170.63623046875,\"y\":1072.7921142578126,\"z\":20.82915878295898}', NULL, 0, 53000, 0, 0, 0, '{}', '[]'),
(87, 'firma45', 'Firma 45', 6, '{\"x\":1864.610595703125,\"y\":3747.699951171875,\"z\":33.03106689453125}', '{}', '{}', '{\"x\":1862.3421630859376,\"y\":3748.359619140625,\"z\":33.03609848022461}', NULL, 0, 42000, 0, 0, 0, '{}', '[]'),
(88, 'firma46', 'Firma 46', 6, '{\"x\":-293.7037048339844,\"y\":6200.0,\"z\":31.4818058013916}', '{}', '{}', '{\"x\":-291.94317626953127,\"y\":6199.90869140625,\"z\":31.4883918762207}', NULL, 0, 44000, 0, 0, 0, '{}', '[]'),
(89, 'firma47', 'Firma 47', 7, '{\"x\":934.3333129882813,\"y\":-2952.836669921875,\"z\":5.87173986434936}', '{}', '{}', '{\"x\":933.8359375,\"y\":-2957.855712890625,\"z\":5.90115642547607}', 10000, 159, 500, 0, 0, 0, NULL, '[]');

-- --------------------------------------------------------

--
-- Table structure for table `firme_kraft`
--

DROP TABLE IF EXISTS `firme_kraft`;
CREATE TABLE IF NOT EXISTS `firme_kraft` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Firma` int(11) NOT NULL,
  `Item` varchar(255) NOT NULL,
  `Vrijeme` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `imanja`
--

DROP TABLE IF EXISTS `imanja`;
CREATE TABLE IF NOT EXISTS `imanja` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Ime` varchar(255) NOT NULL,
  `Koord` longtext NOT NULL DEFAULT '{}',
  `Cijena` int(11) NOT NULL DEFAULT 0,
  `Vlasnik` int(11) DEFAULT NULL,
  `Kuca` varchar(255) DEFAULT NULL,
  `KKoord` longtext NOT NULL DEFAULT '{}',
  `MKoord` longtext NOT NULL DEFAULT '{}',
  `KucaID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `imanja`
--

INSERT INTO `imanja` (`ID`, `Ime`, `Koord`, `Cijena`, `Vlasnik`, `Kuca`, `KKoord`, `MKoord`, `KucaID`) VALUES
(11, 'Imanje 1', '[{\"x\":2556.414306640625,\"y\":4786.0703125},{\"x\":2566.040771484375,\"y\":4797.10107421875},{\"x\":2564.235595703125,\"y\":4810.2490234375},{\"x\":2559.5625,\"y\":4818.5498046875},{\"x\":2551.644287109375,\"y\":4823.52099609375},{\"x\":2544.89208984375,\"y\":4824.6181640625},{\"x\":2540.824462890625,\"y\":4820.234375},{\"x\":2535.984375,\"y\":4816.5869140625},{\"x\":2532.796875,\"y\":4810.39990234375},{\"x\":2533.652587890625,\"y\":4802.51611328125},{\"x\":2536.1708984375,\"y\":4795.75439453125},{\"x\":2542.257080078125,\"y\":4788.2919921875},{\"x\":2546.875,\"y\":4785.33251953125}]', 100, NULL, NULL, '{}', '{\"x\":2559.91455078125,\"y\":4778.2978515625,\"z\":32.82449340820312}', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
CREATE TABLE IF NOT EXISTS `items` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `limit` int(11) NOT NULL DEFAULT -1,
  `rare` int(11) NOT NULL DEFAULT 0,
  `can_remove` int(11) NOT NULL DEFAULT 1,
  `weight` int(255) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=182 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`ID`, `name`, `label`, `limit`, `rare`, `can_remove`, `weight`) VALUES
(1, 'absinthe', 'Pelin', 5, 0, 1, 0),
(2, 'acetone', 'Aceton', 5, 0, 1, 0),
(3, 'acid', 'Acid', 20, 0, 1, 0),
(4, 'alive_chicken', 'Ziva Kokos', 20, 0, 1, 0),
(5, 'auspuh', 'Auspuh', 1, 0, 1, 2000),
(6, 'autobomba', 'Auto-bomba', 1, 0, 1, 0),
(7, 'bandage', 'Zavoj', 20, 0, 1, 0),
(8, 'beer', 'Pivo', 15, 0, 1, 0),
(9, 'biser', 'Biser', 20, 0, 1, 0),
(10, 'blowpipe', 'Chalumeaux', 10, 0, 1, 0),
(11, 'bread', 'Kruh', 10, 0, 1, 125),
(12, 'burek', 'Burek', 5, 0, 1, 0),
(13, 'cannabis', 'Kanabis', 20, 0, 1, 0),
(14, 'carokit', 'Kit carosserie', 3, 0, 1, 0),
(15, 'carotool', 'Repair Kit', 4, 0, 1, 0),
(16, 'ccijev', 'Carbine rifle (Cijev)', 5, 0, 1, 1000),
(17, 'champagne', 'Sampanjac', 10, 0, 1, 0),
(18, 'chemicals', 'Kemikalije', 20, 0, 1, 0),
(19, 'chemicalslisence', 'Chemicals license', 1, 0, 1, 0),
(20, 'cigarett', 'Cigara', 20, 0, 1, 0),
(21, 'ckundak', 'Carbine rifle (Kundak)', 5, 0, 1, 1000),
(22, 'clip', 'Sarzer', 15, 0, 1, 0),
(23, 'clothe', 'Krpa', 40, 0, 1, 0),
(24, 'cocaine', 'Kokain', 10, 0, 1, 0),
(25, 'coke', 'List Kokaina', 20, 0, 1, 100),
(26, 'contract', 'Kupoprodajni Ugovor', 5, 0, 1, 0),
(27, 'copper', 'Bakar', 56, 0, 1, 0),
(28, 'croquettes', 'Hrana za zivotinje', 20, 0, 1, 0),
(29, 'ctijelo', 'Carbine rifle (Tijelo)', 5, 0, 1, 2000),
(30, 'cutted_wood', 'Izrezano Drvo', 20, 0, 1, 0),
(31, 'diamond', 'Dijamant', 50, 0, 1, 0),
(32, 'drone_flyer_7', 'Policijski dron', -1, 0, 1, 0),
(33, 'duhan', 'Duhan', 25, 0, 1, 0),
(34, 'elektronika', 'Elektronika', 3, 0, 1, 200),
(35, 'essence', 'Essence', 24, 0, 1, 0),
(36, 'fabric', 'Tkanina', 80, 0, 1, 0),
(37, 'filter', 'Filter', 2, 0, 1, 200),
(38, 'finjectori', 'Fuel injectori', 2, 0, 1, 700),
(39, 'fish', 'Riba', 100, 0, 1, 0),
(40, 'fixkit', 'Repair Kit', 5, 0, 1, 0),
(41, 'fixtool', 'Gedore', 6, 0, 1, 0),
(42, 'gazbottle', 'Plinska boca', 11, 0, 1, 0),
(43, 'gintonic', 'Gin Tónic', 5, 0, 1, 0),
(44, 'gljive', 'Gljive', 30, 0, 1, 0),
(45, 'gold', 'Zlato', 21, 0, 1, 0),
(46, 'grebalica', 'Grebalica', 5, 0, 1, 100),
(47, 'gym_membership', 'Gym clanarina', -1, 0, 1, 0),
(48, 'headbag', 'Vreca', 2, 0, 1, 0),
(49, 'heartpump', 'Heartpump', 255, 0, 1, 0),
(50, 'heroin', 'Heroin', 10, 0, 1, 0),
(51, 'hydrochloric_acid', 'Hidrokloricna kiselina', 15, 0, 1, 0),
(52, 'intercooler', 'Intercooler', 1, 0, 1, 1600),
(53, 'iron', 'Zeljezo', 10, 0, 1, 1000),
(54, 'jewels', 'Nakit', -1, 0, 1, 1),
(55, 'kcijev', 'Assault rifle (Cijev)', 5, 0, 1, 1000),
(56, 'kemija', 'Kemija', 20, 0, 1, 0),
(57, 'kkundak', 'Assault rifle (Kundak)', 5, 0, 1, 1000),
(58, 'kmotor', 'Kovani motor', 1, 0, 1, 4000),
(59, 'kola', 'Coca-Cola', 5, 0, 1, 0),
(60, 'koza', 'Koža', -1, 0, 1, 0),
(61, 'ktijelo', 'Assault rifle (Tijelo)', 5, 0, 1, 2000),
(62, 'kvacilo', 'Kvacilo', 1, 0, 1, 600),
(63, 'lancic', 'Lancic', 50, 0, 1, 0),
(64, 'lighter', 'Upaljac', 1, 0, 1, 0),
(65, 'lithium', 'Litijum baterije', 10, 0, 1, 0),
(66, 'ljudi', 'osoba', 100, 0, 1, 0),
(67, 'loto', 'Loto listic', 1, 0, 1, 125),
(68, 'LSD', 'LSD', 10, 0, 1, 0),
(69, 'marijuana', 'Marihuana', 20, 0, 1, 0),
(70, 'medikit', 'Med-kit', 10, 0, 1, 0),
(71, 'meso', 'Meso', -1, 0, 1, 0),
(72, 'meth', 'Meth', 20, 0, 1, 0),
(73, 'methlab', 'Prijenosni laboratorij za meth', 1, 0, 1, 0),
(74, 'milk', 'Mlijeko', 10, 0, 1, 0),
(75, 'mobitel', 'Mobitel', 1, 0, 1, 0),
(76, 'moneywash', 'MoneyWash License', 1, 0, 1, 0),
(77, 'narukvica', 'Narukvica', 50, 0, 1, 0),
(78, 'net_cracker', 'Laptop', 1, 0, 1, 0),
(79, 'odznaka', 'Odznaka', -1, 0, 0, 0),
(80, 'packaged_chicken', 'Pakirana Piletina', 100, 0, 1, 0),
(81, 'packaged_plank', 'Pakirane daske', 100, 0, 1, 0),
(82, 'petarda', 'Petarda', 50, 0, 1, 0),
(83, 'petarde', 'Petarde', 10, 0, 1, 0),
(84, 'petrol', 'Benzin', 24, 0, 1, 0),
(85, 'petrol_raffin', 'Rafinirani Benzin', 24, 0, 1, 0),
(86, 'pizza', 'Pizza', 2, 0, 1, 0),
(87, 'poppyresin', 'Makova smola', 20, 0, 1, 0),
(88, 'rakija', 'Rakija', 1, 0, 1, 0),
(89, 'repairkit', 'Repair Kit', 2, 0, 1, 0),
(90, 'ronjenje', 'Ronilacka oprema', 1, 0, 1, 0),
(91, 'saksija', 'Saksija', 5, 0, 1, 0),
(92, 'sarafciger', 'Sarafciger', 1, 0, 1, 0),
(93, 'scijev', 'Special carbine (Cijev)', 5, 0, 1, 1000),
(94, 'seed', 'Sjeme kanabisa', 5, 0, 1, 0),
(95, 'skoljka', 'Skoljka', 10, 0, 1, 0),
(96, 'skundak', 'Special carbine (Kundak)', 5, 0, 1, 1000),
(97, 'slaughtered_chicken', 'Ubijena Kokos', 20, 0, 1, 0),
(98, 'smcijev', 'SMG (Cijev)', 5, 0, 1, 1000),
(99, 'smkundak', 'SMG (Kundak)', 5, 0, 1, 1000),
(100, 'smtijelo', 'SMG (Tijelo)', 5, 0, 1, 2000),
(101, 'sodium', 'Sodium', 15, 0, 1, 0),
(102, 'speed', 'Speed', 25, 0, 1, 0),
(103, 'stijelo', 'Special carbine (Tijelo)', 5, 0, 1, 2000),
(104, 'stone', 'Kamen', 7, 0, 1, 0),
(105, 'sulfuric_acid', 'Sumporna kiselina', 15, 0, 1, 0),
(106, 'tequila', 'Tequila', 15, 0, 1, 0),
(107, 'thermite', 'Termitna bomba', 5, 0, 1, 0),
(108, 'thionyl_chloride', 'Thionil klorid', 20, 0, 1, 0),
(109, 'turbo', 'Turbo', 2, 0, 1, 1200),
(110, 'ukosnica', 'Ukosnica', 5, 0, 1, 0),
(111, 'vatromet', 'Vatromet', 1, 0, 1, 0),
(112, 'vodka', 'Vodka', 15, 0, 1, 0),
(113, 'washed_stone', 'Isprani kamen', 7, 0, 1, 0),
(114, 'water', 'Voda', 5, 0, 1, 0),
(115, 'weapon_advancedrifle', 'Advanced Rifle(stvar)', 5, 0, 1, 0),
(116, 'weapon_appistol', 'AP Pistol(stvar)', 5, 0, 1, 0),
(117, 'weapon_assaultrifle', 'Kalas(stvar)', 5, 0, 1, 0),
(118, 'weapon_assaultrifle_mk2', 'Assault Rifle MK2(stvar)', 5, 0, 1, 0),
(119, 'weapon_assaultshotgun', 'Assault Shotgun(stvar)', 5, 0, 1, 0),
(120, 'weapon_assaultsmg', 'Assault SMG(stvar)', 5, 0, 1, 0),
(121, 'weapon_autoshotgun', 'Auto Shotgun(stvar)', 5, 0, 1, 0),
(122, 'weapon_bat', 'Palica(stvar)', 5, 0, 1, 0),
(123, 'weapon_battleaxe', 'Battle Sjekira(stvar)', 5, 0, 1, 0),
(124, 'weapon_bullpuprifle', 'Bullpup Rifle(stvar)', 5, 0, 1, 0),
(125, 'weapon_bullpupshotgun', 'Bullpup Shotgun(stvar)', 5, 0, 1, 0),
(126, 'weapon_carbinerifle', 'Carbine Rifle(stvar)', 5, 0, 1, 0),
(127, 'weapon_carbinerifle_mk2', 'Carbine Rifle MK2(stvar)', 5, 0, 1, 0),
(128, 'weapon_combatmg', 'Combat MG(stvar)', 5, 0, 1, 0),
(129, 'weapon_combatpdw', 'Combat PDW(stvar)', 5, 0, 1, 0),
(130, 'weapon_combatpistol', 'Combat Pistol(stvar)', 5, 0, 1, 0),
(131, 'weapon_compactrifle', 'Compact Rifle(stvar)', 5, 0, 1, 0),
(132, 'weapon_crowbar', 'Pajser(stvar)', 5, 0, 1, 0),
(133, 'weapon_dbshotgun', 'DBShotgun(stvar)', 5, 0, 1, 0),
(134, 'weapon_doubleaction', 'Double Action(stvar)', 5, 0, 1, 0),
(135, 'weapon_fireextinguisher', 'Aparat za gasenje(stvar)', 5, 0, 1, 0),
(136, 'weapon_firework', 'Firework(stvar)', 5, 0, 1, 0),
(137, 'weapon_flashlight', 'Lampa(stvar)', 5, 0, 1, 0),
(138, 'weapon_golfclub', 'Golfclub(stvar)', 5, 0, 1, 0),
(139, 'weapon_gusenberg', 'Gusenberg(stvar)', 5, 0, 1, 0),
(140, 'weapon_hammer', 'Cekic(stvar)', 5, 0, 1, 0),
(141, 'weapon_hatchet', 'Sjekira(stvar)', 5, 0, 1, 0),
(142, 'weapon_heavypistol', 'Heavy Pistolj(stvar)', 6, 0, 1, 0),
(143, 'weapon_heavyshotgun', 'Heavy Shotgun(stvar)', 5, 0, 1, 0),
(144, 'weapon_heavysniper', 'Heavy Sniper(stvar)', 5, 0, 1, 0),
(145, 'weapon_knife', 'Noz(stvar)', 5, 0, 1, 0),
(146, 'weapon_machete', 'Maceta(stvar)', 5, 0, 1, 0),
(147, 'weapon_machinepsitol', 'Machine Pistolj(stvar)', 5, 0, 1, 0),
(148, 'weapon_marksmanpistol', 'Marksman Pistolj(stvar)', 5, 0, 1, 0),
(149, 'weapon_marksmanrifle', 'Marksman Sniper(stvar)', 5, 0, 1, 0),
(150, 'weapon_marksmanrifle_mk2', 'Marksman Rifle MK2(stvar)', 5, 0, 1, 0),
(151, 'weapon_mg', 'MG(stvar)', 5, 0, 1, 0),
(152, 'weapon_microsmg', 'Micro SMG(stvar)', 5, 0, 1, 0),
(153, 'weapon_minismg', 'Mini SMG(stvar)', 5, 0, 1, 0),
(154, 'weapon_musket', 'Musket(stvar)', 5, 0, 1, 0),
(155, 'weapon_nightstick', 'Pendrek(stvar)', 5, 0, 1, 0),
(156, 'weapon_pistol', 'Pistolj(stvar)', 6, 0, 1, 0),
(157, 'weapon_pistol50', 'Pistol50(stvar)', 5, 0, 1, 0),
(158, 'weapon_poolcue', 'Stap(stvar)', 5, 0, 1, 0),
(159, 'weapon_pumpshotgun', 'Sacma(stvar)', 5, 0, 1, 0),
(160, 'weapon_revolver', 'Revolver(stvar)', 5, 0, 1, 0),
(161, 'weapon_revolver_mk2', 'Revolver MK2(stvar)', 5, 0, 1, 0),
(162, 'weapon_sawnoffshotgun', 'Sawnoff sacma(stvar)', 5, 0, 1, 0),
(163, 'weapon_smg', 'SMG(stvar)', 5, 0, 1, 0),
(164, 'weapon_sniperrifle', 'Sniper(stvar)', 5, 0, 1, 0),
(165, 'weapon_snspistol', 'SNS Pistolj(stvar)', 5, 0, 1, 0),
(166, 'weapon_specialcarbine', 'Special Carbine(stvar)', 5, 0, 1, 0),
(167, 'weapon_switchblade', 'Switchblade(stvar)', 5, 0, 1, 0),
(168, 'weapon_vintagepistol', 'Vintage Pistolj(stvar)', 5, 0, 1, 0),
(169, 'weapon_wrench', 'Wrench(stvar)', 5, 0, 1, 0),
(170, 'whisky', 'Whisky', 15, 0, 1, 0),
(171, 'wine', 'Vino', 15, 0, 1, 0),
(172, 'wood', 'Drvo', 20, 0, 1, 0),
(173, 'wool', 'Vuna', 40, 0, 1, 0),
(174, 'zemlja', 'Vreca zemlje', 5, 0, 1, 0),
(175, 'zeton', 'Zeton', -1, 0, 1, 0),
(176, 'novine', 'Novine', 1, 0, 1, 0),
(177, 'fishingrod', 'Stap za pecanje', 1, 0, 1, 1500),
(179, 'fishbait', 'Mamac', 20, 0, 1, 500),
(180, 'fish', 'Riba', 50, 0, 1, 1000);

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `pID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  `whitelisted` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `id` int(255) NOT NULL DEFAULT 1,
  PRIMARY KEY (`name`),
  KEY `whitelisted` (`whitelisted`),
  KEY `pID` (`pID`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`pID`, `name`, `label`, `whitelisted`, `id`) VALUES
(2, 'ambulance', 'LSMD', 1, 0),
(3, 'mechanic', 'Mehanicar', 1, 0),
(4, 'police', 'LSPD', 1, 0),
(5, 'reporter', 'Reporter', 1, 1),
(6, 'taxi', 'Uber', 1, 0),
(1, 'unemployed', 'Nezaposlen', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `job_grades`
--

DROP TABLE IF EXISTS `job_grades`;
CREATE TABLE IF NOT EXISTS `job_grades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(50) DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `salary` int(11) NOT NULL,
  `skin_male` longtext NOT NULL,
  `skin_female` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=240 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `job_grades`
--

INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
(1, 'unemployed', 0, 'unemployed', 'Nezaposlen', 50, '{}', '{}'),
(3, 'fisherman', 0, 'employee', 'Radnik', 300, '{}', '{}'),
(4, 'fueler', 0, 'employee', 'Radnik', 350, '{}', '{}'),
(6, 'tailor', 0, 'employee', 'Radnik', 350, '{\"mask_1\":0,\"arms\":1,\"glasses_1\":0,\"hair_color_2\":4,\"makeup_1\":0,\"face\":19,\"glasses\":0,\"mask_2\":0,\"makeup_3\":0,\"skin\":29,\"helmet_2\":0,\"lipstick_4\":0,\"sex\":0,\"torso_1\":24,\"makeup_2\":0,\"bags_2\":0,\"chain_2\":0,\"ears_1\":-1,\"bags_1\":0,\"bproof_1\":0,\"shoes_2\":0,\"lipstick_2\":0,\"chain_1\":0,\"tshirt_1\":0,\"eyebrows_3\":0,\"pants_2\":0,\"beard_4\":0,\"torso_2\":0,\"beard_2\":6,\"ears_2\":0,\"hair_2\":0,\"shoes_1\":36,\"tshirt_2\":0,\"beard_3\":0,\"hair_1\":2,\"hair_color_1\":0,\"pants_1\":48,\"helmet_1\":-1,\"bproof_2\":0,\"eyebrows_4\":0,\"eyebrows_2\":0,\"decals_1\":0,\"age_2\":0,\"beard_1\":5,\"shoes\":10,\"lipstick_1\":0,\"eyebrows_1\":0,\"glasses_2\":0,\"makeup_4\":0,\"decals_2\":0,\"lipstick_3\":0,\"age_1\":0}', '{\"mask_1\":0,\"arms\":5,\"glasses_1\":5,\"hair_color_2\":4,\"makeup_1\":0,\"face\":19,\"glasses\":0,\"mask_2\":0,\"makeup_3\":0,\"skin\":29,\"helmet_2\":0,\"lipstick_4\":0,\"sex\":1,\"torso_1\":52,\"makeup_2\":0,\"bags_2\":0,\"chain_2\":0,\"ears_1\":-1,\"bags_1\":0,\"bproof_1\":0,\"shoes_2\":1,\"lipstick_2\":0,\"chain_1\":0,\"tshirt_1\":23,\"eyebrows_3\":0,\"pants_2\":0,\"beard_4\":0,\"torso_2\":0,\"beard_2\":6,\"ears_2\":0,\"hair_2\":0,\"shoes_1\":42,\"tshirt_2\":4,\"beard_3\":0,\"hair_1\":2,\"hair_color_1\":0,\"pants_1\":36,\"helmet_1\":-1,\"bproof_2\":0,\"eyebrows_4\":0,\"eyebrows_2\":0,\"decals_1\":0,\"age_2\":0,\"beard_1\":5,\"shoes\":10,\"lipstick_1\":0,\"eyebrows_1\":0,\"glasses_2\":0,\"makeup_4\":0,\"decals_2\":0,\"lipstick_3\":0,\"age_1\":0}'),
(7, 'miner', 0, 'employee', 'Radnik', 550, '{\"tshirt_2\":0,\"ears_1\":8,\"glasses_1\":15,\"torso_2\":0,\"ears_2\":2,\"glasses_2\":3,\"shoes_2\":6,\"pants_1\":98,\"shoes_1\":61,\"bags_1\":0,\"helmet_2\":0,\"pants_2\":0,\"torso_1\":56,\"tshirt_1\":59,\"arms\":19,\"bags_2\":0,\"helmet_1\":0}', '{}'),
(8, 'slaughterer', 0, 'employee', 'Radnik', 300, '{\"age_1\":0,\"glasses_2\":0,\"beard_1\":5,\"decals_2\":0,\"beard_4\":0,\"shoes_2\":0,\"tshirt_2\":0,\"lipstick_2\":0,\"hair_2\":0,\"arms\":67,\"pants_1\":36,\"skin\":29,\"eyebrows_2\":0,\"shoes\":10,\"helmet_1\":-1,\"lipstick_1\":0,\"helmet_2\":0,\"hair_color_1\":0,\"glasses\":0,\"makeup_4\":0,\"makeup_1\":0,\"hair_1\":2,\"bproof_1\":0,\"bags_1\":0,\"mask_1\":0,\"lipstick_3\":0,\"chain_1\":0,\"eyebrows_4\":0,\"sex\":0,\"torso_1\":56,\"beard_2\":6,\"shoes_1\":12,\"decals_1\":0,\"face\":19,\"lipstick_4\":0,\"tshirt_1\":15,\"mask_2\":0,\"age_2\":0,\"eyebrows_3\":0,\"chain_2\":0,\"glasses_1\":0,\"ears_1\":-1,\"bags_2\":0,\"ears_2\":0,\"torso_2\":0,\"bproof_2\":0,\"makeup_2\":0,\"eyebrows_1\":0,\"makeup_3\":0,\"pants_2\":0,\"beard_3\":0,\"hair_color_2\":4}', '{\"age_1\":0,\"glasses_2\":0,\"beard_1\":5,\"decals_2\":0,\"beard_4\":0,\"shoes_2\":0,\"tshirt_2\":0,\"lipstick_2\":0,\"hair_2\":0,\"arms\":72,\"pants_1\":45,\"skin\":29,\"eyebrows_2\":0,\"shoes\":10,\"helmet_1\":-1,\"lipstick_1\":0,\"helmet_2\":0,\"hair_color_1\":0,\"glasses\":0,\"makeup_4\":0,\"makeup_1\":0,\"hair_1\":2,\"bproof_1\":0,\"bags_1\":0,\"mask_1\":0,\"lipstick_3\":0,\"chain_1\":0,\"eyebrows_4\":0,\"sex\":1,\"torso_1\":49,\"beard_2\":6,\"shoes_1\":24,\"decals_1\":0,\"face\":19,\"lipstick_4\":0,\"tshirt_1\":9,\"mask_2\":0,\"age_2\":0,\"eyebrows_3\":0,\"chain_2\":0,\"glasses_1\":5,\"ears_1\":-1,\"bags_2\":0,\"ears_2\":0,\"torso_2\":0,\"bproof_2\":0,\"makeup_2\":0,\"eyebrows_1\":0,\"makeup_3\":0,\"pants_2\":0,\"beard_3\":0,\"hair_color_2\":4}'),
(9, 'banker', 0, 'advisor', 'Savjetnik', 700, '{}', '{}'),
(10, 'banker', 1, 'banker', 'Bankar', 900, '{}', '{}'),
(11, 'banker', 2, 'business_banker', 'Visi bankar', 1100, '{}', '{}'),
(12, 'banker', 3, 'trader', 'Bitcoin', 1400, '{}', '{}'),
(13, 'banker', 4, 'boss', 'Gazda', 1300, '{}', '{}'),
(14, 'cardealer', 0, 'recruit', 'Pocetnik', 650, '{}', '{}'),
(15, 'cardealer', 1, 'novice', 'Prodavac', 800, '{}', '{}'),
(16, 'cardealer', 2, 'experienced', 'Visi Prodavac', 900, '{}', '{}'),
(17, 'cardealer', 3, 'boss', 'Sef Autosalona', 1100, '{}', '{}'),
(18, 'taxi', 0, 'recrue', 'Pocetnik', 500, '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":32,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":31,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":0,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":27,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":10,\"pants_1\":24}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
(19, 'taxi', 1, 'novice', 'Vozac', 650, '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":32,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":31,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":0,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":27,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":10,\"pants_1\":24}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
(20, 'taxi', 2, 'experimente', 'Iskusni Vozac', 850, '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":26,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":57,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":4,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":11,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":0,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":10,\"pants_1\":24}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
(21, 'taxi', 3, 'uber', 'Uber', 1000, '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":26,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":57,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":4,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":11,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":0,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":10,\"pants_1\":24}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
(22, 'taxi', 4, 'boss', 'Sef', 1500, '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":29,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":31,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":4,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":1,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":0,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":4,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":10,\"pants_1\":24}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
(23, 'police', 0, 'recruit', 'Kadet', 800, '{}', '{}'),
(24, 'police', 1, 'officer', 'Saobracajac', 1100, '{}', '{}'),
(26, 'police', 2, 'sergeant', 'Policajac', 1300, '{}', '{}'),
(27, 'police', 5, 'chef', 'Komandant', 1600, '{{\"tshirt_1\":96,\"tshirt_2\":0,\"torso_1\":32,\"arms\":4,\"pants_1\":28,\"shoes_1\":10,\"chain_1\":125,\"chain_2\":0,\"helmet_1\":46,\"helmet_2\":3}}', '{}'),
(28, 'mechanic', 0, 'recrue', 'Segrt', 1000, '{}', '{}'),
(29, 'mechanic', 1, 'novice', 'Radnik', 1200, '{}', '{}'),
(30, 'mechanic', 2, 'experimente', 'Iskusni Radnik', 1500, '{}', '{}'),
(31, 'mechanic', 3, 'chief', 'Podsef', 1700, '{}', '{}'),
(32, 'mechanic', 4, 'boss', 'Sef', 2000, '{}', '{}'),
(54, 'ambulance', 0, 'ambulance', 'Vozac', 1200, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":9,\"torso_2\":3,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":0,\"helmet_2\":0,\"arms\":92,\"face\":19,\"decals_1\":60,\"torso_1\":13,\"hair_2\":0,\"skin\":34,\"pants_2\":5}', '{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
(55, 'ambulance', 1, 'doctor', 'Medicinski Tehnicar', 1500, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":9,\"torso_2\":3,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":0,\"helmet_2\":0,\"arms\":92,\"face\":19,\"decals_1\":60,\"torso_1\":13,\"hair_2\":0,\"skin\":34,\"pants_2\":5}', '{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
(56, 'ambulance', 2, 'chief_doctor', 'Doktor', 1700, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":9,\"torso_2\":3,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":0,\"helmet_2\":0,\"arms\":92,\"face\":19,\"decals_1\":60,\"torso_1\":13,\"hair_2\":0,\"skin\":34,\"pants_2\":5}', '{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
(57, 'ambulance', 3, 'boss', 'Kirurg', 2000, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":9,\"torso_2\":3,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":0,\"helmet_2\":0,\"arms\":92,\"face\":19,\"decals_1\":60,\"torso_1\":13,\"hair_2\":0,\"skin\":34,\"pants_2\":5}', '{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
(58, 'kosac', 0, 'employee', 'Radnik', 200, '{\"tshirt_1\":59,\"torso_1\":89,\"arms\":31,\"pants_1\":36,\"glasses_1\":19,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":2,\"glasses_2\":0,\"torso_2\":1,\"shoes\":35,\"hair_1\":0,\"skin\":0,\"sex\":0,\"glasses_1\":19,\"pants_2\":0,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":5}', '{\"tshirt_1\":36,\"torso_1\":0,\"arms\":68,\"pants_1\":30,\"glasses_1\":15,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":27,\"glasses_2\":0,\"torso_2\":11,\"shoes\":26,\"hair_1\":5,\"skin\":0,\"sex\":1,\"glasses_1\":15,\"pants_2\":2,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":19}'),
(59, 'deliverer', 0, 'employee', 'Radnik', 600, '{\"tshirt_1\":59,\"torso_1\":89,\"arms\":31,\"pants_1\":36,\"glasses_1\":19,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":2,\"glasses_2\":0,\"torso_2\":1,\"shoes\":35,\"hair_1\":0,\"skin\":0,\"sex\":0,\"glasses_1\":19,\"pants_2\":0,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":5}', '{\"tshirt_1\":36,\"torso_1\":0,\"arms\":68,\"pants_1\":30,\"glasses_1\":15,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":27,\"glasses_2\":0,\"torso_2\":11,\"shoes\":26,\"hair_1\":5,\"skin\":0,\"sex\":1,\"glasses_1\":15,\"pants_2\":2,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":19}'),
(60, 'vatrogasac', 0, 'employee', 'Radnik', 200, '{\"tshirt_1\":75,\"torso_1\":267,\"arms\":17,\"pants_1\":34,\"glasses_1\":0,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":4,\"hair_color_1\":0,\"face\":2,\"glasses_2\":0,\"torso_2\":4,\"shoes_1\":71,\"shoes_2\":25,\"hair_1\":0,\"skin\":0,\"sex\":0,\"glasses_1\":0,\"pants_2\":0,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":3,\"helmet_1\":126}', '{\"tshirt_1\":75,\"torso_1\":267,\"arms\":17,\"pants_1\":34,\"glasses_1\":0,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":4,\"hair_color_1\":0,\"face\":2,\"glasses_2\":0,\"torso_2\":4,\"shoes_1\":71,\"shoes_2\":25,\"hair_1\":0,\"skin\":0,\"sex\":0,\"glasses_1\":0,\"pants_2\":0,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":3,\"helmet_1\":126}'),
(62, 'police', 4, 'lieutenant', 'Inspektor', 1500, '{}', '{}'),
(64, 'police', 3, 'intendent', 'Serif', 1300, '{\"tshirt_1\":5,\"tshirt_2\":3,\"torso_1\":53,\"arms\":17,\"pants_1\":33,\"shoes_1\":62,\"decals_1\":0,\"decals_2\":0,\"helmet_1\":59,\"helmet_2\":9,\"glasses_1\":15,\"glasses_2\":7,\"watch_1\":6,\"mask_1\":56,\"mask_2\":1}', '{}'),
(76, 'reporter', 0, 'soldato', 'Pocetnik', 100, '{}', '{}'),
(77, 'reporter', 1, 'capo', 'Novinar', 600, '{}', '{}'),
(78, 'reporter', 2, 'consigliere', 'Reporter', 1000, '{}', '{}'),
(79, 'reporter', 3, 'boss', 'Sef', 2000, '{}', '{}'),
(80, 'garbage', 0, 'employee', 'Employee', 200, '{\"tshirt_1\":59,\"torso_1\":89,\"arms\":31,\"pants_1\":36,\"glasses_1\":19,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":2,\"glasses_2\":0,\"torso_2\":1,\"shoes\":35,\"hair_1\":0,\"skin\":0,\"sex\":0,\"glasses_1\":19,\"pants_2\":0,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":5}', '{\"tshirt_1\":36,\"torso_1\":0,\"arms\":68,\"pants_1\":30,\"glasses_1\":15,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":27,\"glasses_2\":0,\"torso_2\":11,\"shoes\":26,\"hair_1\":5,\"skin\":0,\"sex\":1,\"glasses_1\":15,\"pants_2\":2,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":19}'),
(81, 'farmer', 0, 'employee', 'Radnik', 200, '{\"tshirt_1\":59,\"torso_1\":89,\"arms\":31,\"pants_1\":36,\"glasses_1\":19,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":2,\"glasses_2\":0,\"torso_2\":1,\"shoes\":35,\"hair_1\":0,\"skin\":0,\"sex\":0,\"glasses_1\":19,\"pants_2\":0,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":5}', '{\"tshirt_1\":59,\"torso_1\":89,\"arms\":31,\"pants_1\":36,\"glasses_1\":19,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":2,\"glasses_2\":0,\"torso_2\":1,\"shoes\":35,\"hair_1\":0,\"skin\":0,\"sex\":0,\"glasses_1\":19,\"pants_2\":0,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":5}'),
(87, 'hitman', 0, 'assassin', 'Nepoznato', 1500, '{}', '{}'),
(88, 'hitman', 1, 'soldier', 'Nepoznato', 1800, '{}', '{}'),
(89, 'hitman', 2, 'coleader', 'Nepoznato', 2100, '{}', '{}'),
(90, 'hitman', 3, 'boss', 'Nepoznato', 2700, '{}', '{}'),
(113, 'vodoinstalater', 0, 'employee', 'Radnik', 200, '{\"tshirt_1\":59,\"torso_1\":89,\"arms\":31,\"pants_1\":36,\"glasses_1\":19,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":2,\"glasses_2\":0,\"torso_2\":1,\"shoes\":35,\"hair_1\":0,\"skin\":0,\"sex\":0,\"glasses_1\":19,\"pants_2\":0,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":5}', '{\"tshirt_1\":36,\"torso_1\":0,\"arms\":68,\"pants_1\":30,\"glasses_1\":15,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":27,\"glasses_2\":0,\"torso_2\":11,\"shoes\":26,\"hair_1\":5,\"skin\":0,\"sex\":1,\"glasses_1\":15,\"pants_2\":2,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":19}'),
(114, 'police', 6, 'boss', 'Nacelnik', 2000, '{{\"tshirt_1\":96,\"tshirt_2\":0,\"torso_1\":32,\"arms\":4,\"pants_1\":28,\"shoes_1\":10,\"chain_1\":125,\"chain_2\":0,\"helmet_1\":46,\"helmet_2\":3}}', '{}'),
(120, 'drvosjeca', 0, 'employee', 'Radnik', 200, '{\"tshirt_1\":59,\"torso_1\":89,\"arms\":31,\"pants_1\":36,\"glasses_1\":19,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":2,\"glasses_2\":0,\"torso_2\":1,\"shoes\":35,\"hair_1\":0,\"skin\":0,\"sex\":0,\"glasses_1\":19,\"pants_2\":0,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":5}', '{\"tshirt_1\":36,\"torso_1\":0,\"arms\":68,\"pants_1\":30,\"glasses_1\":15,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":27,\"glasses_2\":0,\"torso_2\":11,\"shoes\":26,\"hair_1\":5,\"skin\":0,\"sex\":1,\"glasses_1\":15,\"pants_2\":2,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":19}'),
(121, 'elektricar', 0, 'employee', 'Radnik', 200, '{\"tshirt_1\":59,\"torso_1\":89,\"arms\":31,\"pants_1\":36,\"glasses_1\":19,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":2,\"glasses_2\":0,\"torso_2\":1,\"shoes\":35,\"hair_1\":0,\"skin\":0,\"sex\":0,\"glasses_1\":19,\"pants_2\":0,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":5}', '{\"tshirt_1\":36,\"torso_1\":0,\"arms\":68,\"pants_1\":30,\"glasses_1\":15,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":27,\"glasses_2\":0,\"torso_2\":11,\"shoes\":26,\"hair_1\":5,\"skin\":0,\"sex\":1,\"glasses_1\":15,\"pants_2\":2,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":19}'),
(135, 'ballas', 0, 'soldato', 'Younglings', 0, '{}', '{}'),
(136, 'ballas', 1, 'capo', 'Runners', 0, '{}', '{}'),
(137, 'ballas', 2, 'consigliere', 'Shooters', 0, '{}', '{}'),
(138, 'ballas', 3, 'boss', 'O.G\'s', 3500, '{}', '{}'),
(143, 'sipa', 0, 'intendent', 'SIPA', 2500, '{}', '{}'),
(144, 'sipa', 1, 'boss', 'Komandant', 3500, '{}', '{}'),
(153, 'kamion', 0, 'employee', 'Radnik', 200, '{\"tshirt_1\":59,\"torso_1\":89,\"arms\":31,\"pants_1\":36,\"glasses_1\":19,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":2,\"glasses_2\":0,\"torso_2\":1,\"shoes\":35,\"hair_1\":0,\"skin\":0,\"sex\":0,\"glasses_1\":19,\"pants_2\":0,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":5}', '{\"tshirt_1\":36,\"torso_1\":0,\"arms\":68,\"pants_1\":30,\"glasses_1\":15,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":27,\"glasses_2\":0,\"torso_2\":11,\"shoes\":26,\"hair_1\":5,\"skin\":0,\"sex\":1,\"glasses_1\":15,\"pants_2\":2,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":19}'),
(181, 'gradjevinar', 0, 'employee', 'Radnik', 200, '{\"tshirt_1\":59,\"torso_1\":89,\"arms\":31,\"pants_1\":36,\"glasses_1\":19,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":2,\"glasses_2\":0,\"torso_2\":1,\"shoes\":35,\"hair_1\":0,\"skin\":0,\"sex\":0,\"glasses_1\":19,\"pants_2\":0,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":5}', '{\"tshirt_1\":36,\"torso_1\":0,\"arms\":68,\"pants_1\":30,\"glasses_1\":15,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":27,\"glasses_2\":0,\"torso_2\":11,\"shoes\":26,\"hair_1\":5,\"skin\":0,\"sex\":1,\"glasses_1\":15,\"pants_2\":2,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":19}'),
(190, 'ralica', 0, 'employee', 'Radnik', 200, '{\"tshirt_1\":59,\"torso_1\":89,\"arms\":31,\"pants_1\":36,\"glasses_1\":19,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":2,\"glasses_2\":0,\"torso_2\":1,\"shoes\":35,\"hair_1\":0,\"skin\":0,\"sex\":0,\"glasses_1\":19,\"pants_2\":0,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":5}', '{\"tshirt_1\":36,\"torso_1\":0,\"arms\":68,\"pants_1\":30,\"glasses_1\":15,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":27,\"glasses_2\":0,\"torso_2\":11,\"shoes\":26,\"hair_1\":5,\"skin\":0,\"sex\":1,\"glasses_1\":15,\"pants_2\":2,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":19}'),
(191, 'vlak', 0, 'employee', 'Radnik', 200, '{\"tshirt_1\":59,\"torso_1\":89,\"arms\":31,\"pants_1\":36,\"glasses_1\":19,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":2,\"glasses_2\":0,\"torso_2\":1,\"shoes\":35,\"hair_1\":0,\"skin\":0,\"sex\":0,\"glasses_1\":19,\"pants_2\":0,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":5}', '{\"tshirt_1\":36,\"torso_1\":0,\"arms\":68,\"pants_1\":30,\"glasses_1\":15,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":27,\"glasses_2\":0,\"torso_2\":11,\"shoes\":26,\"hair_1\":5,\"skin\":0,\"sex\":1,\"glasses_1\":15,\"pants_2\":2,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":19}'),
(200, 'automafija', 4, 'boss', 'Sef', 300, '{}', '{}'),
(202, 'spasioc', 0, 'employee', 'Radnik', 200, '{\"tshirt_1\":129,\"torso_1\":148,\"arms\":1,\"pants_1\":16,\"glasses_1\":0,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":2,\"glasses_2\":0,\"torso_2\":3,\"shoes\":5,\"hair_1\":0,\"skin\":0,\"sex\":0,\"glasses_1\":19,\"pants_2\":0,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":-1}', '{\"tshirt_1\":36,\"torso_1\":0,\"arms\":68,\"pants_1\":30,\"glasses_1\":15,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":27,\"glasses_2\":0,\"torso_2\":11,\"shoes\":26,\"hair_1\":5,\"skin\":0,\"sex\":1,\"glasses_1\":15,\"pants_2\":2,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":19}'),
(203, 'fastfood', 0, 'employee', 'Uber Eats', 200, '{\"tshirt_1\":59,\"torso_1\":67,\"arms\":1,\"pants_1\":22,\"glasses_1\":0,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":2,\"glasses_2\":0,\"torso_2\":3,\"shoes_1\":1,\"hair_1\":0,\"skin\":0,\"sex\":0,\"glasses_1\":19,\"pants_2\":5,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":17}', '{\"tshirt_1\":36,\"torso_1\":0,\"arms\":68,\"pants_1\":30,\"glasses_1\":15,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":27,\"glasses_2\":0,\"torso_2\":11,\"shoes\":26,\"hair_1\":5,\"skin\":0,\"sex\":1,\"glasses_1\":15,\"pants_2\":2,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":19}');

-- --------------------------------------------------------

--
-- Table structure for table `jsfour_criminalrecord`
--

DROP TABLE IF EXISTS `jsfour_criminalrecord`;
CREATE TABLE IF NOT EXISTS `jsfour_criminalrecord` (
  `offense` varchar(160) NOT NULL,
  `date` varchar(255) DEFAULT NULL,
  `institution` varchar(255) DEFAULT NULL,
  `charge` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `term` varchar(255) DEFAULT NULL,
  `classified` int(2) NOT NULL DEFAULT 0,
  `identifier` varchar(255) DEFAULT NULL,
  `dob` varchar(255) DEFAULT NULL,
  `warden` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`offense`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `jsfour_criminalrecord`
--

INSERT INTO `jsfour_criminalrecord` (`offense`, `date`, `institution`, `charge`, `description`, `term`, `classified`, `identifier`, `dob`, `warden`) VALUES
('D-192', '01.05.2021', 'LOS SANTOS', 'UBIO TROJICU', 'QEQEQEQE', '0 60 0 ', 1, 'steam:110000115e9ac6b', '19960405', 'Meha'),
('D-694', '01.05.2021', 'LOS SANTOS', 'Oruzana pljacka i ubistvo', 'Oruzana pljacka trgovine', '0 60 0 ', 1, 'steam:110000115e9ac6b', '19960405', 'Meha'),
('A-287', '2021-05-01', 'LOS SANTOS', 'TEST', 'eeqeqqe', '0 30 0 ', 0, 'steam:11000010a1d1042', '01021987', 'Meha'),
('D-713', '2021-05-01', 'LOS SANTOS', 'Pljacka', 'kkdkdkdk', '2 0 0', 0, 'steam:11000010441bee9', '1998-09-25', 'Tony'),
('A-270', '2021-05-01', 'LOS SANTOS', 'Ubojstvo', 'Ubio ga ko vola u kupusu jebote', '1 0 0', 0, 'steam:11000010441bee9', '1998-09-25', 'Tony'),
('F-301', '2021-05-01', 'LOS SANTOS', 'Kurcna', 'ahahah to je to', '5 2 1', 1, 'steam:11000010441bee9', '1998-09-25', 'Tony'),
('F-330', 'DANAS', 'LOS SANTOS', 'Jeo burek', 'Jeo burek sa sirom', '5 10 0', 1, 'steam:11000010441bee9', '1998-09-25', 'Tony');

-- --------------------------------------------------------

--
-- Table structure for table `jsfour_criminaluserinfo`
--

DROP TABLE IF EXISTS `jsfour_criminaluserinfo`;
CREATE TABLE IF NOT EXISTS `jsfour_criminaluserinfo` (
  `identifier` varchar(160) NOT NULL,
  `aliases` varchar(255) DEFAULT NULL,
  `recordid` varchar(255) DEFAULT NULL,
  `weight` varchar(255) DEFAULT NULL,
  `eyecolor` varchar(255) DEFAULT NULL,
  `haircolor` varchar(255) DEFAULT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `dob` varchar(255) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `height` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `jsfour_criminaluserinfo`
--

INSERT INTO `jsfour_criminaluserinfo` (`identifier`, `aliases`, `recordid`, `weight`, `eyecolor`, `haircolor`, `firstname`, `lastname`, `dob`, `sex`, `height`) VALUES
('steam:11000010a1d1042', 'MEHA ', 'F767D915', '71kg', 'Smedja', 'Smedja', 'MEHA ', 'VAN DAMME', '01021987', 'm', '182cm'),
('steam:11000010441bee9', 'TONY', 'F408C951', '77kg', 'Crna', 'Crna', 'TONY', 'SIKORA', '1998-09-25', 'm', '200cm'),
('steam:110000115e9ac6b', 'DERIM', 'F755A779', '65kg', 'Crna', 'Crna', 'DERIM', 'UPAKAS', '19960405', 'm', '177cm');

-- --------------------------------------------------------

--
-- Table structure for table `kuce`
--

DROP TABLE IF EXISTS `kuce`;
CREATE TABLE IF NOT EXISTS `kuce` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `prop` varchar(255) NOT NULL,
  `door` longtext NOT NULL,
  `price` int(11) NOT NULL,
  `prodaja` int(11) NOT NULL DEFAULT 0,
  `rentanje` int(11) DEFAULT 0,
  `rentCijena` int(11) DEFAULT 20,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=356 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `kuce`
--

INSERT INTO `kuce` (`ID`, `prop`, `door`, `price`, `prodaja`, `rentanje`, `rentCijena`) VALUES
(1, 'trevor', '{\"x\":-1112.25,\"y\":-1578.4000244140626,\"z\":7.69999980926513}', 250000, 0, 0, 20),
(2, 'trevor', '{\"x\":-1114.3399658203126,\"y\":-1579.469970703125,\"z\":7.69999980926513}', 250000, 0, 0, 20),
(3, 'trevor', '{\"x\":-1114.949951171875,\"y\":-1577.5699462890626,\"z\":3.55999994277954}', 250000, 0, 0, 20),
(4, 'trevor', '{\"x\":373.9276123046875,\"y\":427.87890625,\"z\":144.7342071533203}', 350000, 0, 0, 20),
(5, 'nice', '{\"x\":346.4424133300781,\"y\":440.6260070800781,\"z\":146.7830047607422}', 450000, 0, 0, 20),
(6, 'nice', '{\"x\":331.4053955078125,\"y\":465.68231201171877,\"z\":150.2642059326172}', 450000, 0, 0, 20),
(7, 'mansion', '{\"x\":316.0714111328125,\"y\":501.47869873046877,\"z\":152.22979736328126}', 750000, 0, 0, 20),
(8, 'mansion', '{\"x\":325.3428039550781,\"y\":537.4041748046875,\"z\":152.92059326171876}', 750000, 0, 0, 20),
(9, 'nice', '{\"x\":223.64830017089845,\"y\":513.9970703125,\"z\":139.8170928955078}', 450000, 0, 0, 20),
(10, 'nice', '{\"x\":119.22889709472656,\"y\":494.32330322265627,\"z\":146.3928985595703}', 450000, 0, 0, 20),
(11, 'nice', '{\"x\":80.12486267089844,\"y\":485.8677978515625,\"z\":147.25169372558595}', 450000, 0, 0, 20),
(12, 'nice', '{\"x\":57.8746109008789,\"y\":450.0857849121094,\"z\":146.0814971923828}', 450000, 0, 0, 20),
(13, 'nice', '{\"x\":42.98038864135742,\"y\":468.6543884277344,\"z\":147.14590454101563}', 450000, 0, 0, 20),
(14, 'mansion', '{\"x\":-7.60816717147827,\"y\":468.3959045410156,\"z\":144.92080688476563}', 750000, 0, 0, 20),
(15, 'nice', '{\"x\":-66.48236846923828,\"y\":490.8035888671875,\"z\":143.74229431152345}', 450000, 0, 0, 20),
(16, 'mansion', '{\"x\":-109.8572006225586,\"y\":502.61920166015627,\"z\":142.3531036376953}', 750000, 0, 0, 20),
(17, 'nice', '{\"x\":-174.7194061279297,\"y\":502.5979919433594,\"z\":136.47059631347657}', 450000, 0, 0, 20),
(18, 'nice', '{\"x\":84.86479949951172,\"y\":561.9719848632813,\"z\":181.8175048828125}', 450000, 0, 0, 20),
(19, 'lester', '{\"x\":119.08489990234375,\"y\":564.5529174804688,\"z\":183.00369262695313}', 150000, 0, 0, 20),
(20, 'nice', '{\"x\":215.64540100097657,\"y\":620.1937255859375,\"z\":186.66729736328126}', 450000, 0, 0, 20),
(21, 'nice', '{\"x\":231.95640563964845,\"y\":672.4473266601563,\"z\":188.99549865722657}', 450000, 0, 0, 20),
(22, 'nice', '{\"x\":-230.5478057861328,\"y\":488.45928955078127,\"z\":127.81749725341797}', 450000, 0, 0, 20),
(23, 'nice', '{\"x\":-311.9219970703125,\"y\":474.8205871582031,\"z\":110.87239837646485}', 450000, 0, 1, 40),
(24, 'nice', '{\"x\":-166.7200927734375,\"y\":424.6629943847656,\"z\":110.85579681396485}', 450000, 0, 0, 20),
(25, 'mansion', '{\"x\":-297.89208984375,\"y\":380.3153076171875,\"z\":111.14530181884766}', 750000, 0, 0, 20),
(26, 'lester', '{\"x\":-328.2933044433594,\"y\":369.9056091308594,\"z\":109.05599975585938}', 150000, 0, 0, 20),
(27, 'nice', '{\"x\":-371.7889099121094,\"y\":344.114990234375,\"z\":108.9926986694336}', 450000, 0, 0, 20),
(28, 'nice', '{\"x\":-409.4172058105469,\"y\":341.6883850097656,\"z\":107.9573974609375}', 450000, 0, 0, 20),
(29, 'mansion', '{\"x\":-349.23748779296877,\"y\":514.6478881835938,\"z\":119.69670104980469}', 450000, 0, 1, 20),
(30, 'nice', '{\"x\":-386.7586669921875,\"y\":504.2430725097656,\"z\":120.41266632080078}', 450000, 0, 0, 20),
(31, 'nice', '{\"x\":-406.48748779296877,\"y\":567.513427734375,\"z\":123.65290069580078}', 450000, 0, 0, 20),
(32, 'mansion', '{\"x\":-459.1129150390625,\"y\":537.52099609375,\"z\":120.50679779052735}', 750000, 0, 0, 20),
(33, 'nice', '{\"x\":-500.55029296875,\"y\":552.2288818359375,\"z\":119.6604995727539}', 450000, 0, 0, 20),
(34, 'nice', '{\"x\":-520.2656860351563,\"y\":594.2166137695313,\"z\":119.88670349121094}', 450000, 0, 0, 20),
(35, 'nice', '{\"x\":-475.13739013671877,\"y\":585.8267822265625,\"z\":127.7333984375}', 450000, 0, 0, 20),
(36, 'nice', '{\"x\":-559.4097900390625,\"y\":664.381591796875,\"z\":144.50660705566407}', 450000, 0, 0, 20),
(37, 'mansion', '{\"x\":-605.9417114257813,\"y\":672.86669921875,\"z\":150.647705078125}', 750000, 0, 0, 20),
(38, 'nice', '{\"x\":-579.7288818359375,\"y\":733.1072998046875,\"z\":183.2602996826172}', 450000, 0, 0, 20),
(39, 'nice', '{\"x\":-655.07958984375,\"y\":803.4769287109375,\"z\":198.04190063476563}', 450000, 0, 0, 20),
(40, 'lester', '{\"x\":-746.9130859375,\"y\":808.4434814453125,\"z\":214.08009338378907}', 150000, 0, 0, 20),
(41, 'lester', '{\"x\":-597.1287231445313,\"y\":851.828125,\"z\":210.4842071533203}', 150000, 0, 0, 20),
(42, 'nice', '{\"x\":-494.42401123046877,\"y\":795.8173828125,\"z\":183.39340209960938}', 450000, 0, 0, 20),
(43, 'mansion', '{\"x\":-495.45819091796877,\"y\":738.9638061523438,\"z\":162.08070373535157}', 750000, 0, 0, 20),
(44, 'nice', '{\"x\":-533.0499877929688,\"y\":709.0921020507813,\"z\":152.13070678710938}', 450000, 0, 0, 20),
(45, 'nice', '{\"x\":-686.1759033203125,\"y\":596.1190185546875,\"z\":142.69200134277345}', 450000, 0, 0, 20),
(46, 'nice', '{\"x\":-732.7766723632813,\"y\":594.086181640625,\"z\":141.1907958984375}', 450000, 0, 0, 20),
(47, 'nice', '{\"x\":-752.8132934570313,\"y\":620.974609375,\"z\":141.55650329589845}', 450000, 0, 0, 20),
(48, 'mansion', '{\"x\":-699.1110229492188,\"y\":706.7750854492188,\"z\":156.99630737304688}', 750000, 0, 0, 20),
(49, 'nice', '{\"x\":-476.8587951660156,\"y\":648.3369750976563,\"z\":143.4365997314453}', 450000, 0, 0, 20),
(50, 'mansion', '{\"x\":-400.098388671875,\"y\":665.4254150390625,\"z\":162.8802032470703}', 750000, 0, 0, 20),
(51, 'nice', '{\"x\":-353.2795104980469,\"y\":667.8524780273438,\"z\":168.11900329589845}', 450000, 0, 0, 20),
(52, 'nice', '{\"x\":-299.8464050292969,\"y\":635.0609130859375,\"z\":174.73170471191407}', 450000, 0, 0, 20),
(53, 'nice', '{\"x\":-293.52978515625,\"y\":601.4298706054688,\"z\":180.62550354003907}', 450000, 0, 0, 20),
(54, 'nice', '{\"x\":-232.61129760742188,\"y\":588.7606811523438,\"z\":189.58619689941407}', 450000, 0, 0, 20),
(55, 'nice', '{\"x\":-189.13409423828126,\"y\":617.6110229492188,\"z\":198.71249389648438}', 450000, 0, 0, 20),
(56, 'nice', '{\"x\":-185.30760192871095,\"y\":591.8223266601563,\"z\":196.87100219726563}', 450000, 0, 0, 20),
(57, 'mansion', '{\"x\":-126.82649993896485,\"y\":588.7379150390625,\"z\":203.56680297851563}', 750000, 0, 0, 20),
(58, 'nice', '{\"x\":-527.0712280273438,\"y\":517.5831909179688,\"z\":111.99120330810547}', 450000, 0, 0, 20),
(59, 'nice', '{\"x\":-580.6823120117188,\"y\":492.38800048828127,\"z\":107.95120239257813}', 450000, 0, 0, 20),
(60, 'mansion', '{\"x\":-640.75341796875,\"y\":519.7141723632813,\"z\":108.73780059814453}', 750000, 0, 0, 20),
(61, 'mansion', '{\"x\":-667.3151245117188,\"y\":471.9706115722656,\"z\":113.1884994506836}', 750000, 0, 0, 20),
(62, 'nice', '{\"x\":-678.8621215820313,\"y\":511.72918701171877,\"z\":112.57599639892578}', 450000, 0, 0, 20),
(63, 'mansion', '{\"x\":-718.1337280273438,\"y\":449.260009765625,\"z\":105.95909881591797}', 750000, 0, 0, 20),
(64, 'nice', '{\"x\":-762.3024291992188,\"y\":431.52801513671877,\"z\":99.22505187988281}', 450000, 0, 0, 20),
(65, 'nice', '{\"x\":-784.1950073242188,\"y\":459.1264953613281,\"z\":99.22904205322266}', 450000, 0, 0, 20),
(66, 'nice', '{\"x\":-824.7244873046875,\"y\":422.07879638671877,\"z\":91.17418670654297}', 450000, 0, 0, 20),
(67, 'nice', '{\"x\":-843.2042236328125,\"y\":466.74700927734377,\"z\":86.6477279663086}', 450000, 0, 0, 20),
(68, 'nice', '{\"x\":-848.961669921875,\"y\":508.8512878417969,\"z\":89.86675262451172}', 450000, 0, 0, 20),
(69, 'nice', '{\"x\":-883.855224609375,\"y\":518.0172729492188,\"z\":91.49284362792969}', 450000, 0, 0, 20),
(70, 'mansion', '{\"x\":-905.24658203125,\"y\":587.4351806640625,\"z\":100.04090118408203}', 750000, 0, 0, 20),
(71, 'nice', '{\"x\":-924.6613159179688,\"y\":561.7769775390625,\"z\":98.99629211425781}', 450000, 0, 0, 20),
(72, 'nice', '{\"x\":-947.9395141601563,\"y\":568.203125,\"z\":100.527099609375}', 450000, 0, 0, 20),
(73, 'nice', '{\"x\":-974.3864135742188,\"y\":582.1177978515625,\"z\":101.97810363769531}', 450000, 0, 0, 20),
(74, 'nice', '{\"x\":-1022.6699829101563,\"y\":587.364501953125,\"z\":102.28350067138672}', 450000, 0, 0, 20),
(75, 'nice', '{\"x\":-1107.261962890625,\"y\":593.9844970703125,\"z\":103.50399780273438}', 450000, 0, 0, 20),
(76, 'nice', '{\"x\":-1125.425048828125,\"y\":548.6654052734375,\"z\":101.61920166015625}', 450000, 0, 0, 20),
(77, 'nice', '{\"x\":-1146.4339599609376,\"y\":545.8892822265625,\"z\":100.95369720458985}', 450000, 0, 0, 20),
(78, 'nice', '{\"x\":-1193.072998046875,\"y\":563.761474609375,\"z\":99.38944244384766}', 450000, 0, 0, 20),
(79, 'nice', '{\"x\":-970.9652709960938,\"y\":456.0506896972656,\"z\":78.85919189453125}', 450000, 0, 0, 20),
(80, 'mansion', '{\"x\":-967.3018188476563,\"y\":510.3299865722656,\"z\":81.11641693115235}', 750000, 0, 0, 20),
(81, 'nice', '{\"x\":-987.416015625,\"y\":487.6513977050781,\"z\":81.31524658203125}', 450000, 0, 0, 20),
(82, 'nice', '{\"x\":-1052.02099609375,\"y\":432.3935852050781,\"z\":76.12246704101563}', 450000, 0, 0, 20),
(83, 'nice', '{\"x\":-1094.1839599609376,\"y\":427.4130859375,\"z\":74.93000793457031}', 450000, 0, 0, 20),
(84, 'nice', '{\"x\":-1122.762939453125,\"y\":485.6831970214844,\"z\":81.21085357666016}', 450000, 0, 0, 20),
(85, 'nice', '{\"x\":-1174.9530029296876,\"y\":440.31561279296877,\"z\":85.8994369506836}', 450000, 0, 0, 20),
(86, 'nice', '{\"x\":-1215.7030029296876,\"y\":458.46771240234377,\"z\":90.9036865234375}', 450000, 0, 0, 20),
(87, 'lester', '{\"x\":-1294.4229736328126,\"y\":454.8558044433594,\"z\":96.52876281738281}', 150000, 0, 0, 20),
(88, 'nice', '{\"x\":-1308.1939697265626,\"y\":449.26409912109377,\"z\":100.0197982788086}', 450000, 0, 0, 20),
(89, 'nice', '{\"x\":-1413.60205078125,\"y\":462.2876892089844,\"z\":108.25859832763672}', 450000, 0, 0, 20),
(90, 'nice', '{\"x\":-1404.8590087890626,\"y\":561.2164916992188,\"z\":124.456298828125}', 450000, 0, 0, 20),
(91, 'nice', '{\"x\":-1346.741943359375,\"y\":560.8566284179688,\"z\":129.5814971923828}', 450000, 0, 0, 20),
(92, 'lester', '{\"x\":-1366.824951171875,\"y\":611.169189453125,\"z\":132.95590209960938}', 150000, 0, 0, 20),
(93, 'nice', '{\"x\":-1337.7559814453126,\"y\":606.1082153320313,\"z\":133.42979431152345}', 450000, 0, 0, 20),
(94, 'nice', '{\"x\":-1291.7220458984376,\"y\":650.06640625,\"z\":140.55130004882813}', 450000, 0, 0, 20),
(95, 'nice', '{\"x\":-1248.572021484375,\"y\":643.0164794921875,\"z\":141.747802734375}', 450000, 0, 0, 20),
(96, 'nice', '{\"x\":-1241.2509765625,\"y\":674.0632934570313,\"z\":141.86349487304688}', 450000, 0, 0, 20),
(97, 'nice', '{\"x\":-1219.115966796875,\"y\":665.676025390625,\"z\":143.5832977294922}', 450000, 0, 0, 20),
(98, 'nice', '{\"x\":-1197.6800537109376,\"y\":693.6865844726563,\"z\":146.43890380859376}', 450000, 0, 0, 20),
(99, 'lester', '{\"x\":-1165.6500244140626,\"y\":727.1096801757813,\"z\":154.6566925048828}', 150000, 0, 0, 20),
(100, 'nice', '{\"x\":-1130.0260009765626,\"y\":784.1541748046875,\"z\":162.93699645996095}', 450000, 0, 0, 20),
(101, 'nice', '{\"x\":-1100.4239501953126,\"y\":797.4185791015625,\"z\":166.3083038330078}', 450000, 0, 0, 20),
(102, 'nice', '{\"x\":-1056.18505859375,\"y\":761.752685546875,\"z\":166.3686065673828}', 450000, 0, 0, 20),
(103, 'nice', '{\"x\":-999.0889892578125,\"y\":816.4957275390625,\"z\":172.09719848632813}', 450000, 0, 0, 20),
(104, 'nice', '{\"x\":-962.6514282226563,\"y\":813.8961181640625,\"z\":176.61570739746095}', 450000, 0, 0, 20),
(105, 'lester', '{\"x\":-912.3673095703125,\"y\":777.6082153320313,\"z\":186.0594024658203}', 150000, 0, 0, 20),
(106, 'nice', '{\"x\":-867.3571166992188,\"y\":785.290771484375,\"z\":190.98379516601563}', 450000, 0, 0, 20),
(107, 'nice', '{\"x\":-824.052490234375,\"y\":806.051513671875,\"z\":201.83250427246095}', 450000, 0, 0, 20),
(108, 'nice', '{\"x\":-1065.2779541015626,\"y\":727.3834838867188,\"z\":164.52459716796876}', 450000, 0, 0, 20),
(109, 'lester', '{\"x\":-1019.85498046875,\"y\":719.11279296875,\"z\":163.0460968017578}', 150000, 0, 0, 20),
(110, 'nice', '{\"x\":-931.4409790039063,\"y\":691.4453125,\"z\":152.51669311523438}', 450000, 0, 0, 20),
(111, 'nice', '{\"x\":-908.8555908203125,\"y\":693.87841796875,\"z\":150.48609924316407}', 450000, 0, 0, 20),
(112, 'nice', '{\"x\":-885.5114135742188,\"y\":699.32568359375,\"z\":150.3199005126953}', 450000, 0, 0, 20),
(113, 'lester', '{\"x\":-853.5562133789063,\"y\":696.361572265625,\"z\":147.83090209960938}', 150000, 0, 0, 20),
(114, 'nice', '{\"x\":-819.3508911132813,\"y\":696.5076904296875,\"z\":147.15420532226563}', 450000, 0, 0, 20),
(115, 'nice', '{\"x\":-765.37109375,\"y\":650.6353149414063,\"z\":144.7480926513672}', 450000, 0, 0, 20),
(116, 'trailer', '{\"x\":1632.530029296875,\"y\":3719.43701171875,\"z\":34.04853820800781}', 75000, 0, 0, 20),
(117, 'trailer', '{\"x\":1733.47802734375,\"y\":3808.677978515625,\"z\":34.12612915039062}', 75000, 0, 0, 20),
(118, 'trailer', '{\"x\":1760.14599609375,\"y\":3821.47900390625,\"z\":34.7677993774414}', 75000, 0, 0, 20),
(119, 'trailer', '{\"x\":1777.5679931640626,\"y\":3799.884033203125,\"z\":34.52312088012695}', 75000, 0, 0, 20),
(120, 'trailer', '{\"x\":1777.1829833984376,\"y\":3737.909912109375,\"z\":33.70544052124023}', 75000, 0, 0, 20),
(121, 'trailer', '{\"x\":1748.654052734375,\"y\":3783.681884765625,\"z\":33.88486862182617}', 75000, 0, 0, 20),
(122, 'trailer', '{\"x\":1639.6510009765626,\"y\":3731.573974609375,\"z\":34.11709976196289}', 75000, 0, 0, 20),
(123, 'trailer', '{\"x\":1642.6199951171876,\"y\":3727.39697265625,\"z\":34.11709976196289}', 75000, 0, 0, 20),
(124, 'trailer', '{\"x\":1691.5269775390626,\"y\":3866.06298828125,\"z\":33.95724105834961}', 75000, 0, 0, 20),
(125, 'trailer', '{\"x\":1700.3389892578126,\"y\":3867.1298828125,\"z\":33.94834899902344}', 75000, 0, 0, 20),
(126, 'trailer', '{\"x\":1733.616943359375,\"y\":3895.489990234375,\"z\":34.60903930664062}', 75000, 0, 0, 20),
(127, 'trailer', '{\"x\":1786.594970703125,\"y\":3913.041015625,\"z\":33.96126174926758}', 75000, 0, 0, 20),
(128, 'lester', '{\"x\":1803.4420166015626,\"y\":3913.945068359375,\"z\":36.10694885253906}', 150000, 0, 0, 20),
(129, 'lester', '{\"x\":1809.0810546875,\"y\":3907.696044921875,\"z\":32.79610824584961}', 150000, 0, 0, 20),
(130, 'trailer', '{\"x\":1838.583984375,\"y\":3907.39599609375,\"z\":32.38100814819336}', 75000, 0, 0, 20),
(131, 'trailer', '{\"x\":1841.9110107421876,\"y\":3928.6220703125,\"z\":32.77209091186523}', 75000, 0, 0, 20),
(132, 'lester', '{\"x\":1880.2879638671876,\"y\":3920.64599609375,\"z\":32.25875854492187}', 150000, 0, 0, 20),
(133, 'trailer', '{\"x\":1895.43798828125,\"y\":3873.758056640625,\"z\":31.8044490814209}', 75000, 0, 0, 20),
(134, 'trailer', '{\"x\":1888.4749755859376,\"y\":3892.89306640625,\"z\":32.22338104248047}', 75000, 0, 0, 20),
(135, 'lester', '{\"x\":1943.6820068359376,\"y\":3804.373046875,\"z\":31.08716011047363}', 150000, 0, 0, 20),
(136, 'lester', '{\"x\":-374.5137939453125,\"y\":6190.9580078125,\"z\":30.77953910827636}', 150000, 0, 0, 20),
(137, 'lester', '{\"x\":-356.8976135253906,\"y\":6207.4541015625,\"z\":30.89236068725586}', 150000, 0, 0, 20),
(138, 'lester', '{\"x\":-347.4773864746094,\"y\":6225.40087890625,\"z\":30.93763923645019}', 150000, 0, 0, 20),
(139, 'lester', '{\"x\":-360.1221923828125,\"y\":6260.69384765625,\"z\":30.95252990722656}', 150000, 0, 0, 20),
(140, 'lester', '{\"x\":-407.23968505859377,\"y\":6314.18798828125,\"z\":27.99109077453613}', 150000, 0, 0, 20),
(141, 'trevor', '{\"x\":-359.7261047363281,\"y\":6334.634765625,\"z\":28.90011024475097}', 350000, 0, 0, 20),
(142, 'lester', '{\"x\":-332.5201110839844,\"y\":6302.31884765625,\"z\":32.12770080566406}', 150000, 0, 0, 20),
(143, 'lester', '{\"x\":-302.2420959472656,\"y\":6326.9169921875,\"z\":31.93611907958984}', 150000, 0, 0, 20),
(144, 'lester', '{\"x\":-280.5108947753906,\"y\":6350.701171875,\"z\":31.64801025390625}', 150000, 0, 0, 20),
(145, 'lester', '{\"x\":-247.7366943359375,\"y\":6370.14697265625,\"z\":30.90242004394531}', 150000, 0, 0, 20),
(146, 'lester', '{\"x\":-227.1403045654297,\"y\":6377.43017578125,\"z\":30.80915069580078}', 150000, 0, 0, 20),
(147, 'lester', '{\"x\":-272.4501037597656,\"y\":6400.94287109375,\"z\":30.45620918273925}', 150000, 0, 0, 20),
(148, 'lester', '{\"x\":-246.12770080566407,\"y\":6413.9482421875,\"z\":30.5086498260498}', 150000, 0, 0, 20),
(149, 'lester', '{\"x\":-213.84559631347657,\"y\":6396.2900390625,\"z\":32.13463973999023}', 150000, 0, 0, 20),
(150, 'lester', '{\"x\":-188.93359375,\"y\":6409.4658203125,\"z\":31.34683990478515}', 150000, 0, 0, 20),
(151, 'lester', '{\"x\":-215.0478973388672,\"y\":6444.32421875,\"z\":30.3631591796875}', 150000, 0, 0, 20),
(152, 'lester', '{\"x\":-15.28662967681884,\"y\":6557.60595703125,\"z\":32.29037857055664}', 150000, 0, 0, 20),
(153, 'lester', '{\"x\":4.47418022155761,\"y\":6568.0859375,\"z\":32.12141036987305}', 150000, 0, 0, 20),
(154, 'lester', '{\"x\":30.94100952148437,\"y\":6596.576171875,\"z\":31.85994911193847}', 150000, 0, 0, 20),
(155, 'lester', '{\"x\":-9.35308074951171,\"y\":6654.244140625,\"z\":30.44062042236328}', 150000, 0, 0, 20),
(156, 'lester', '{\"x\":-41.70463943481445,\"y\":6637.40087890625,\"z\":30.1366901397705}', 150000, 0, 0, 20),
(157, 'lester', '{\"x\":-34.11275863647461,\"y\":-1846.8740234375,\"z\":25.24352073669433}', 150000, 0, 0, 20),
(158, 'lester', '{\"x\":-20.60475921630859,\"y\":-1858.613037109375,\"z\":24.45816993713379}', 150000, 0, 0, 20),
(159, 'lester', '{\"x\":21.12751960754394,\"y\":-1844.6500244140626,\"z\":23.65169906616211}', 150000, 0, 0, 20),
(160, 'lester', '{\"x\":-5.16767406463623,\"y\":-1871.823974609375,\"z\":23.20046997070312}', 150000, 0, 0, 20),
(161, 'lester', '{\"x\":4.92084312438964,\"y\":-1884.343994140625,\"z\":22.74724960327148}', 150000, 0, 0, 20),
(162, 'lester', '{\"x\":46.00617980957031,\"y\":-1864.281005859375,\"z\":22.32830047607422}', 150000, 0, 0, 20),
(163, 'lester', '{\"x\":23.06887054443359,\"y\":-1896.68701171875,\"z\":22.0528392791748}', 150000, 0, 0, 20),
(164, 'lester', '{\"x\":54.56005096435547,\"y\":-1873.2020263671876,\"z\":21.87973976135254}', 150000, 0, 0, 20),
(165, 'lester', '{\"x\":38.99372863769531,\"y\":-1911.6409912109376,\"z\":21.00349998474121}', 150000, 0, 0, 20),
(166, 'lester', '{\"x\":56.53649139404297,\"y\":-1922.5980224609376,\"z\":20.96063041687011}', 150000, 0, 0, 20),
(167, 'lester', '{\"x\":100.85590362548828,\"y\":-1912.47705078125,\"z\":20.45294952392578}', 150000, 0, 0, 20),
(168, 'lester', '{\"x\":72.05095672607422,\"y\":-1938.9439697265626,\"z\":20.41856956481933}', 150000, 0, 0, 20),
(169, 'lester', '{\"x\":76.55005645751953,\"y\":-1948.3819580078126,\"z\":20.22415924072265}', 150000, 0, 0, 20),
(170, 'lester', '{\"x\":85.69458770751953,\"y\":-1959.39697265625,\"z\":20.17106056213379}', 150000, 0, 0, 20),
(171, 'lester', '{\"x\":114.5376968383789,\"y\":-1961.072998046875,\"z\":20.36113929748535}', 150000, 0, 0, 20),
(172, 'lester', '{\"x\":126.5083999633789,\"y\":-1929.905029296875,\"z\":20.43240928649902}', 150000, 0, 0, 20),
(173, 'lester', '{\"x\":104.08090209960938,\"y\":-1885.3480224609376,\"z\":23.3687801361084}', 150000, 0, 0, 20),
(174, 'lester', '{\"x\":130.7884979248047,\"y\":-1853.3330078125,\"z\":24.32526969909668}', 150000, 0, 0, 20),
(175, 'lester', '{\"x\":150.04629516601563,\"y\":-1864.904052734375,\"z\":23.63022994995117}', 150000, 0, 0, 20),
(176, 'lester', '{\"x\":127.75759887695313,\"y\":-1897.176025390625,\"z\":22.71497917175293}', 150000, 0, 0, 20),
(177, 'lester', '{\"x\":148.6717071533203,\"y\":-1904.125,\"z\":22.54187965393066}', 150000, 0, 0, 20),
(178, 'lester', '{\"x\":171.31500244140626,\"y\":-1871.39697265625,\"z\":23.45022964477539}', 150000, 0, 0, 20),
(179, 'lester', '{\"x\":192.45140075683595,\"y\":-1883.4520263671876,\"z\":24.15228080749511}', 150000, 0, 0, 20),
(180, 'lester', '{\"x\":179.0854949951172,\"y\":-1924.2640380859376,\"z\":20.4210205078125}', 150000, 0, 0, 20),
(181, 'lester', '{\"x\":165.5446014404297,\"y\":-1945.0260009765626,\"z\":19.27413940429687}', 150000, 0, 0, 20),
(182, 'lester', '{\"x\":148.8780059814453,\"y\":-1960.5269775390626,\"z\":18.54301071166992}', 150000, 0, 0, 20),
(183, 'lester', '{\"x\":143.86380004882813,\"y\":-1968.9610595703126,\"z\":17.90508079528808}', 150000, 0, 0, 20),
(184, 'lester', '{\"x\":236.57009887695313,\"y\":-2045.9560546875,\"z\":17.42999076843261}', 150000, 0, 0, 20),
(185, 'lester', '{\"x\":256.685302734375,\"y\":-2023.3990478515626,\"z\":18.38438987731933}', 150000, 0, 0, 20),
(186, 'lester', '{\"x\":279.556396484375,\"y\":-1993.748046875,\"z\":19.891939163208}', 150000, 0, 0, 20),
(187, 'lester', '{\"x\":291.3570861816406,\"y\":-1980.2860107421876,\"z\":20.64545059204101}', 150000, 0, 0, 20),
(188, 'lester', '{\"x\":295.8619079589844,\"y\":-1971.990966796875,\"z\":21.81773948669433}', 150000, 0, 0, 20),
(189, 'lester', '{\"x\":312.06988525390627,\"y\":-1956.2850341796876,\"z\":23.66682052612304}', 150000, 0, 0, 20),
(190, 'lester', '{\"x\":324.42138671875,\"y\":-1937.9329833984376,\"z\":24.06393051147461}', 150000, 0, 0, 20),
(191, 'lester', '{\"x\":319.8839111328125,\"y\":-1854.20703125,\"z\":26.56307029724121}', 150000, 0, 0, 20),
(192, 'lester', '{\"x\":329.2549133300781,\"y\":-1845.7490234375,\"z\":26.80142974853515}', 150000, 0, 0, 20),
(193, 'lester', '{\"x\":339.0870056152344,\"y\":-1829.2640380859376,\"z\":27.38430976867675}', 150000, 0, 0, 20),
(194, 'lester', '{\"x\":348.77081298828127,\"y\":-1820.5279541015626,\"z\":27.94408988952636}', 150000, 0, 0, 20),
(195, 'lester', '{\"x\":440.2500915527344,\"y\":-1829.9949951171876,\"z\":27.41186904907226}', 150000, 0, 0, 20),
(196, 'lester', '{\"x\":427.45001220703127,\"y\":-1841.81396484375,\"z\":27.50075912475586}', 150000, 0, 0, 20),
(197, 'lester', '{\"x\":412.5542907714844,\"y\":-1856.125,\"z\":26.37175941467285}', 150000, 0, 0, 20),
(198, 'lester', '{\"x\":399.5801086425781,\"y\":-1864.5909423828126,\"z\":25.76935958862304}', 150000, 0, 0, 20),
(199, 'lester', '{\"x\":385.0556945800781,\"y\":-1881.489990234375,\"z\":25.08609962463379}', 150000, 0, 0, 20),
(200, 'lester', '{\"x\":495.37091064453127,\"y\":-1823.4580078125,\"z\":27.91968917846679}', 150000, 0, 0, 20),
(201, 'lester', '{\"x\":512.5225219726563,\"y\":-1790.4329833984376,\"z\":27.96949958801269}', 150000, 0, 0, 20),
(202, 'lester', '{\"x\":472.17620849609377,\"y\":-1775.282958984375,\"z\":28.11978912353515}', 150000, 0, 0, 20),
(203, 'lester', '{\"x\":479.372802734375,\"y\":-1735.7320556640626,\"z\":28.20037078857422}', 150000, 0, 0, 20),
(204, 'lester', '{\"x\":489.68170166015627,\"y\":-1713.9730224609376,\"z\":28.72011947631836}', 150000, 0, 0, 20),
(205, 'lester', '{\"x\":500.44879150390627,\"y\":-1697.029052734375,\"z\":28.82995986938476}', 150000, 0, 0, 20),
(206, 'lester', '{\"x\":405.3066101074219,\"y\":-1751.10498046875,\"z\":28.76036071777343}', 150000, 0, 0, 20),
(207, 'lester', '{\"x\":419.1455993652344,\"y\":-1735.9320068359376,\"z\":28.65644073486328}', 150000, 0, 0, 20),
(208, 'lester', '{\"x\":431.0881042480469,\"y\":-1725.8089599609376,\"z\":28.651460647583}', 150000, 0, 0, 20),
(209, 'lester', '{\"x\":443.41241455078127,\"y\":-1707.2440185546876,\"z\":28.75728988647461}', 150000, 0, 0, 20),
(210, 'lester', '{\"x\":332.92388916015627,\"y\":-1741.041015625,\"z\":28.78051948547363}', 150000, 0, 0, 20),
(211, 'lester', '{\"x\":320.85589599609377,\"y\":-1760.2149658203126,\"z\":28.68787956237793}', 150000, 0, 0, 20),
(212, 'lester', '{\"x\":304.5138854980469,\"y\":-1775.3680419921876,\"z\":28.20438003540039}', 150000, 0, 0, 20),
(213, 'lester', '{\"x\":300.00518798828127,\"y\":-1784.344970703125,\"z\":27.48621940612793}', 150000, 0, 0, 20),
(214, 'lester', '{\"x\":288.7145080566406,\"y\":-1792.511962890625,\"z\":27.16629028320312}', 150000, 0, 0, 20),
(215, 'lester', '{\"x\":198.1999053955078,\"y\":-1725.60205078125,\"z\":28.71232032775879}', 150000, 0, 0, 20),
(216, 'lester', '{\"x\":216.56219482421876,\"y\":-1717.3070068359376,\"z\":28.72633934020996}', 150000, 0, 0, 20),
(217, 'lester', '{\"x\":249.60549926757813,\"y\":-1730.614013671875,\"z\":28.72248077392578}', 150000, 0, 0, 20),
(218, 'lester', '{\"x\":223.07040405273438,\"y\":-1702.9610595703126,\"z\":28.74216079711914}', 150000, 0, 0, 20),
(219, 'lester', '{\"x\":257.2825927734375,\"y\":-1723.1590576171876,\"z\":28.70379066467285}', 150000, 0, 0, 20),
(220, 'lester', '{\"x\":269.3035888671875,\"y\":-1712.8800048828126,\"z\":28.71730041503906}', 150000, 0, 0, 20),
(221, 'lester', '{\"x\":252.8022003173828,\"y\":-1670.6209716796876,\"z\":28.71315956115722}', 150000, 0, 0, 20),
(222, 'lester', '{\"x\":240.77520751953126,\"y\":-1687.9239501953126,\"z\":28.73524093627929}', 150000, 0, 0, 20),
(223, 'trevor', '{\"x\":1060.572021484375,\"y\":-378.39630126953127,\"z\":67.28117370605469}', 350000, 0, 0, 20),
(224, 'trevor', '{\"x\":1029.074951171875,\"y\":-408.5787048339844,\"z\":65.1752700805664}', 350000, 0, 0, 20),
(225, 'nice', '{\"x\":1044.2679443359376,\"y\":-449.1225891113281,\"z\":65.3031997680664}', 400000, 0, 0, 20),
(226, 'trevor', '{\"x\":1010.5189819335938,\"y\":-423.3440856933594,\"z\":64.39826965332031}', 350000, 0, 0, 20),
(227, 'trevor', '{\"x\":1014.4290161132813,\"y\":-469.0126953125,\"z\":63.55712890625}', 350000, 0, 0, 20),
(228, 'trevor', '{\"x\":987.8521728515625,\"y\":-433.585205078125,\"z\":62.94142913818359}', 350000, 0, 0, 20),
(229, 'trevor', '{\"x\":967.1243286132813,\"y\":-451.5813903808594,\"z\":61.84420013427734}', 350000, 0, 0, 20),
(230, 'trevor', '{\"x\":970.1668701171875,\"y\":-502.1628112792969,\"z\":61.19075012207031}', 350000, 0, 0, 20),
(231, 'nice', '{\"x\":943.9503784179688,\"y\":-463.34381103515627,\"z\":60.44573974609375}', 400000, 0, 0, 20),
(232, 'trevor', '{\"x\":945.9931030273438,\"y\":-518.9094848632813,\"z\":59.66810989379883}', 350000, 0, 0, 20),
(233, 'trevor', '{\"x\":921.9141845703125,\"y\":-478.1665954589844,\"z\":60.13360977172851}', 350000, 0, 0, 20),
(234, 'nice', '{\"x\":906.4796142578125,\"y\":-490.0975036621094,\"z\":58.48627090454101}', 400000, 0, 0, 20),
(235, 'lester', '{\"x\":878.5615844726563,\"y\":-498.1047058105469,\"z\":57.14323043823242}', 150000, 0, 0, 20),
(236, 'trevor', '{\"x\":862.4705810546875,\"y\":-509.7611999511719,\"z\":56.37899017333984}', 350000, 0, 0, 20),
(237, 'trevor', '{\"x\":850.8225708007813,\"y\":-532.6475219726563,\"z\":56.97534942626953}', 350000, 0, 0, 20),
(238, 'trevor', '{\"x\":893.1566772460938,\"y\":-540.6182861328125,\"z\":57.55649948120117}', 350000, 0, 0, 20),
(239, 'nice', '{\"x\":844.0634155273438,\"y\":-563.1956176757813,\"z\":56.88386917114258}', 400000, 0, 0, 20),
(240, 'trevor', '{\"x\":861.7772216796875,\"y\":-583.19140625,\"z\":57.20605850219726}', 350000, 0, 0, 20),
(241, 'trevor', '{\"x\":886.8756713867188,\"y\":-608.086181640625,\"z\":57.4929084777832}', 350000, 0, 0, 20),
(242, 'nice', '{\"x\":903.2581787109375,\"y\":-615.666015625,\"z\":57.50368118286133}', 400000, 0, 0, 20),
(243, 'trevor', '{\"x\":928.9735107421875,\"y\":-639.6768188476563,\"z\":57.28987121582031}', 350000, 0, 0, 20),
(244, 'trevor', '{\"x\":943.5170288085938,\"y\":-653.4185180664063,\"z\":57.47093963623047}', 350000, 0, 0, 20),
(245, 'nice', '{\"x\":960.40771484375,\"y\":-669.7490234375,\"z\":57.49974822998047}', 400000, 0, 0, 20),
(246, 'trevor', '{\"x\":970.8856201171875,\"y\":-701.3883056640625,\"z\":57.53192901611328}', 350000, 0, 0, 20),
(247, 'trevor', '{\"x\":979.3054809570313,\"y\":-716.3038940429688,\"z\":57.26874160766601}', 350000, 0, 0, 20),
(248, 'lester', '{\"x\":997.111328125,\"y\":-729.2736206054688,\"z\":56.86407089233398}', 150000, 0, 0, 20),
(249, 'trevor', '{\"x\":1090.0069580078126,\"y\":-484.2412109375,\"z\":64.71035766601563}', 350000, 0, 0, 20),
(250, 'trevor', '{\"x\":1098.5870361328126,\"y\":-464.70379638671877,\"z\":66.36903381347656}', 350000, 0, 0, 20),
(251, 'trevor', '{\"x\":1099.4110107421876,\"y\":-438.3407897949219,\"z\":66.83293914794922}', 350000, 0, 0, 20),
(252, 'trevor', '{\"x\":1100.8370361328126,\"y\":-411.4032897949219,\"z\":66.6018295288086}', 350000, 0, 0, 20),
(253, 'trevor', '{\"x\":1046.2349853515626,\"y\":-497.9067077636719,\"z\":63.12947082519531}', 350000, 0, 0, 20),
(254, 'trevor', '{\"x\":1051.8499755859376,\"y\":-470.5256042480469,\"z\":62.94894027709961}', 350000, 0, 0, 20),
(255, 'trevor', '{\"x\":1056.177001953125,\"y\":-448.88580322265627,\"z\":65.30745697021485}', 350000, 0, 0, 20),
(256, 'trevor', '{\"x\":964.1450805664063,\"y\":-596.046875,\"z\":58.95257949829101}', 350000, 0, 0, 20),
(257, 'lester', '{\"x\":976.3568725585938,\"y\":-579.2255249023438,\"z\":58.68561172485351}', 150000, 0, 0, 20),
(258, 'trevor', '{\"x\":1009.9130249023438,\"y\":-572.3914184570313,\"z\":59.64313888549805}', 350000, 0, 0, 20),
(259, 'trevor', '{\"x\":1229.2860107421876,\"y\":-725.4603271484375,\"z\":59.84466934204101}', 350000, 0, 0, 20),
(260, 'lester', '{\"x\":1222.5980224609376,\"y\":-697.0645141601563,\"z\":59.85625076293945}', 150000, 0, 0, 20),
(261, 'trevor', '{\"x\":1221.362060546875,\"y\":-669.0396728515625,\"z\":62.54291915893555}', 350000, 0, 0, 20),
(262, 'trevor', '{\"x\":1206.8179931640626,\"y\":-620.2753295898438,\"z\":65.48861694335938}', 350000, 0, 0, 20),
(263, 'trevor', '{\"x\":1200.93896484375,\"y\":-575.8314819335938,\"z\":68.1892318725586}', 350000, 0, 0, 20),
(264, 'trevor', '{\"x\":1241.9239501953126,\"y\":-566.2299194335938,\"z\":68.70738220214844}', 350000, 0, 0, 20),
(265, 'trevor', '{\"x\":1240.510009765625,\"y\":-601.5778198242188,\"z\":68.83270263671875}', 350000, 0, 0, 20),
(266, 'trevor', '{\"x\":1251.303955078125,\"y\":-621.6561279296875,\"z\":68.46317291259766}', 350000, 0, 0, 20),
(267, 'trevor', '{\"x\":1265.5870361328126,\"y\":-648.352294921875,\"z\":66.9722671508789}', 350000, 0, 0, 20),
(268, 'trevor', '{\"x\":1270.9940185546876,\"y\":-683.5012817382813,\"z\":65.08128356933594}', 350000, 0, 0, 20),
(269, 'trevor', '{\"x\":1265.156982421875,\"y\":-703.1201171875,\"z\":63.61639022827148}', 350000, 0, 0, 20),
(270, 'lester', '{\"x\":1251.3260498046876,\"y\":-515.7340087890625,\"z\":68.3991470336914}', 150000, 0, 0, 20),
(271, 'trevor', '{\"x\":1251.593017578125,\"y\":-494.16180419921877,\"z\":68.9568862915039}', 350000, 0, 0, 20),
(272, 'trevor', '{\"x\":1260.58203125,\"y\":-479.6108093261719,\"z\":69.23887634277344}', 350000, 0, 0, 20),
(273, 'trevor', '{\"x\":1266.2919921875,\"y\":-457.9032897949219,\"z\":69.56670379638672}', 350000, 0, 0, 20),
(274, 'trevor', '{\"x\":1263.196044921875,\"y\":-429.37188720703127,\"z\":68.85603332519531}', 350000, 0, 0, 20),
(275, 'nice', '{\"x\":1301.0379638671876,\"y\":-574.0164184570313,\"z\":70.78176879882813}', 400000, 0, 0, 20),
(276, 'nice', '{\"x\":1302.89697265625,\"y\":-527.9202270507813,\"z\":70.51077270507813}', 400000, 0, 0, 20),
(277, 'nice', '{\"x\":1323.51904296875,\"y\":-582.8726196289063,\"z\":72.29634094238281}', 400000, 0, 0, 20),
(278, 'nice', '{\"x\":1348.259033203125,\"y\":-547.1375732421875,\"z\":72.9415512084961}', 400000, 0, 0, 20),
(279, 'nice', '{\"x\":1341.7869873046876,\"y\":-597.4871826171875,\"z\":73.75066375732422}', 400000, 0, 0, 20),
(280, 'nice', '{\"x\":1367.3160400390626,\"y\":-605.9420776367188,\"z\":73.76093292236328}', 400000, 0, 0, 20),
(281, 'nice', '{\"x\":1385.77197265625,\"y\":-593.0620727539063,\"z\":73.53543853759766}', 400000, 0, 0, 20),
(282, 'nice', '{\"x\":1388.7490234375,\"y\":-569.701171875,\"z\":73.54611206054688}', 400000, 0, 0, 20),
(283, 'nice', '{\"x\":1372.821044921875,\"y\":-555.698974609375,\"z\":73.73565673828125}', 400000, 0, 0, 20),
(284, 'nice', '{\"x\":1328.1800537109376,\"y\":-535.9559936523438,\"z\":71.49114227294922}', 400000, 0, 0, 20),
(285, 'kinda_nice', '{\"x\":1203.4749755859376,\"y\":-1671.0159912109376,\"z\":41.76279067993164}', 125000, 0, 0, 20),
(286, 'kinda_nice', '{\"x\":1220.2850341796876,\"y\":-1658.9549560546876,\"z\":47.68088150024414}', 125000, 0, 0, 20),
(287, 'kinda_nice', '{\"x\":1252.8060302734376,\"y\":-1638.5849609375,\"z\":52.17658996582031}', 125000, 0, 0, 20),
(288, 'kinda_nice', '{\"x\":1276.39501953125,\"y\":-1628.864013671875,\"z\":53.8273696899414}', 125000, 0, 0, 20),
(289, 'lester', '{\"x\":1297.35595703125,\"y\":-1618.011962890625,\"z\":53.63013076782226}', 150000, 0, 0, 20),
(290, 'kinda_nice', '{\"x\":1336.9639892578126,\"y\":-1579.0760498046876,\"z\":53.52740859985351}', 125000, 0, 0, 20),
(291, 'lester', '{\"x\":1437.1669921875,\"y\":-1492.4620361328126,\"z\":62.68135070800781}', 150000, 0, 0, 20),
(292, 'trailer', '{\"x\":1404.5830078125,\"y\":-1496.260986328125,\"z\":59.01226043701172}', 75000, 0, 0, 20),
(293, 'trailer', '{\"x\":1411.3900146484376,\"y\":-1490.81396484375,\"z\":59.70767974853515}', 75000, 0, 0, 20),
(294, 'lester', '{\"x\":1390.93994140625,\"y\":-1508.0880126953126,\"z\":57.48577880859375}', 150000, 0, 0, 20),
(295, 'lester', '{\"x\":1381.906005859375,\"y\":-1544.7969970703126,\"z\":56.1573486328125}', 150000, 0, 0, 20),
(296, 'kinda_nice', '{\"x\":1338.2879638671876,\"y\":-1524.47705078125,\"z\":53.6551399230957}', 125000, 0, 0, 20),
(297, 'kinda_nice', '{\"x\":1315.85595703125,\"y\":-1526.364013671875,\"z\":50.85356903076172}', 125000, 0, 0, 20),
(298, 'kinda_nice', '{\"x\":1327.47900390625,\"y\":-1552.9019775390626,\"z\":53.1015396118164}', 125000, 0, 0, 20),
(299, 'lester', '{\"x\":1286.64501953125,\"y\":-1604.1910400390626,\"z\":53.87475967407226}', 150000, 0, 0, 20),
(300, 'kinda_nice', '{\"x\":1230.72900390625,\"y\":-1590.9110107421876,\"z\":52.82479858398437}', 125000, 0, 0, 20),
(301, 'lester', '{\"x\":1261.345947265625,\"y\":-1616.60205078125,\"z\":53.79375076293945}', 150000, 0, 0, 20),
(302, 'kinda_nice', '{\"x\":1245.14404296875,\"y\":-1626.56298828125,\"z\":52.3319091796875}', 125000, 0, 0, 20),
(303, 'kinda_nice', '{\"x\":1210.6829833984376,\"y\":-1607.112060546875,\"z\":49.5815200805664}', 125000, 0, 0, 20),
(304, 'kinda_nice', '{\"x\":1214.2939453125,\"y\":-1644.031982421875,\"z\":47.69498062133789}', 125000, 0, 0, 20),
(305, 'kinda_nice', '{\"x\":1193.241943359375,\"y\":-1622.39599609375,\"z\":44.27138900756836}', 125000, 0, 0, 20),
(306, 'lester', '{\"x\":1193.2919921875,\"y\":-1656.072998046875,\"z\":42.07606887817383}', 150000, 0, 0, 20),
(307, 'kinda_nice', '{\"x\":1258.863037109375,\"y\":-1761.5009765625,\"z\":48.71435928344726}', 125000, 0, 0, 20),
(308, 'kinda_nice', '{\"x\":1250.8179931640626,\"y\":-1734.79296875,\"z\":51.08211135864258}', 125000, 0, 0, 20),
(309, 'lester', '{\"x\":1294.9759521484376,\"y\":-1739.7679443359376,\"z\":53.3220100402832}', 150000, 0, 0, 20),
(310, 'kinda_nice', '{\"x\":1289.490966796875,\"y\":-1711.032958984375,\"z\":54.54447937011719}', 125000, 0, 0, 20),
(311, 'lester', '{\"x\":1314.7669677734376,\"y\":-1732.9339599609376,\"z\":53.75003814697265}', 150000, 0, 0, 20),
(312, 'lester', '{\"x\":1316.885986328125,\"y\":-1698.85400390625,\"z\":57.27156066894531}', 150000, 0, 0, 20),
(313, 'kinda_nice', '{\"x\":1355.0660400390626,\"y\":-1690.5269775390626,\"z\":59.54116821289062}', 125000, 0, 0, 20),
(314, 'lester', '{\"x\":1365.324951171875,\"y\":-1721.376953125,\"z\":64.68388366699219}', 150000, 0, 0, 20),
(315, 'mansion', '{\"x\":-1135.864990234375,\"y\":375.7330017089844,\"z\":71.29975891113281}', 50000000, 0, 0, 20),
(316, 'mansion', '{\"x\":-447.6820068359375,\"y\":6271.76220703125,\"z\":33.33002090454101}', 50000000, 0, 0, 20);

-- --------------------------------------------------------

--
-- Table structure for table `kuce_oruzja`
--

DROP TABLE IF EXISTS `kuce_oruzja`;
CREATE TABLE IF NOT EXISTS `kuce_oruzja` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `kolicina` int(11) DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
  `kuca` int(11) DEFAULT NULL,
  `ime` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `kuca` (`kuca`,`owner`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `kuce_oruzja`
--

INSERT INTO `kuce_oruzja` (`ID`, `kolicina`, `owner`, `kuca`, `ime`) VALUES
(17, 200, 10000, 23, 'WEAPON_PISTOL'),
(5, 250, 10000, 23, 'WEAPON_PISTOL'),
(15, 5, 250, 10000, '23'),
(18, 250, 10000, 29, 'WEAPON_PISTOL');

-- --------------------------------------------------------

--
-- Table structure for table `kuce_outfit`
--

DROP TABLE IF EXISTS `kuce_outfit`;
CREATE TABLE IF NOT EXISTS `kuce_outfit` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ime` varchar(255) DEFAULT NULL,
  `skin` longtext DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `owner` (`owner`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `kuce_outfit`
--

INSERT INTO `kuce_outfit` (`ID`, `ime`, `skin`, `owner`) VALUES
(3, 'Otmjeni outfit', '{\"bags_1\":0,\"bproof_1\":0,\"eyebrows_3\":0,\"chest_1\":0,\"eyebrows_4\":0,\"jaw_2\":0,\"face\":19,\"bproof_2\":0,\"blush_1\":0,\"lip_thickness\":0,\"makeup_1\":0,\"chin_2\":0,\"eyebrows_1\":2,\"cheeks_1\":0,\"eye_color\":0,\"lipstick_3\":32,\"beard_3\":61,\"pants_1\":10,\"eyebrows_2\":10,\"nose_1\":0,\"nose_5\":0,\"shoes_1\":1,\"helmet_2\":-1,\"chain_1\":0,\"shoes_2\":2,\"sex\":0,\"pants_2\":0,\"beard_4\":0,\"chest_2\":0,\"lipstick_1\":0,\"sun_1\":0,\"age_1\":0,\"chain_2\":0,\"skin\":0,\"eye_squint\":0,\"neck_thickness\":0,\"bracelets_2\":0,\"bags_2\":0,\"jaw_1\":0,\"eyebrows_5\":0,\"nose_2\":0,\"sun_2\":0,\"arms_2\":0,\"chin_4\":0,\"moles_2\":0,\"chin_3\":0,\"hair_1\":0,\"cheeks_3\":0,\"blush_3\":\"2\",\"face_md_weight\":50,\"torso_2\":0,\"age_2\":0,\"mask_1\":0,\"complexion_2\":0,\"chin_1\":0,\"mask_2\":0,\"makeup_4\":0,\"ears_2\":-1,\"glasses_2\":1,\"hair_2\":0,\"chest_3\":0,\"nose_6\":0,\"lipstick_4\":0,\"blemishes_2\":0,\"glasses_1\":5,\"beard_1\":2,\"beard_2\":10,\"skin_md_weight\":50,\"decals_1\":0,\"tshirt_1\":3,\"eyebrows_6\":0,\"lipstick_2\":0,\"decals_2\":0,\"tshirt_2\":0,\"makeup_2\":0,\"cheeks_2\":0,\"bodyb_2\":0,\"hair_color_2\":0,\"watches_2\":-1,\"bodyb_1\":0,\"dad\":12,\"mom\":21,\"hair_color_1\":0,\"ears_1\":-1,\"moles_1\":0,\"watches_1\":-1,\"nose_3\":0,\"blush_2\":0,\"arms\":1,\"helmet_1\":-1,\"blemishes_1\":0,\"torso_1\":4,\"makeup_3\":0,\"complexion_1\":0,\"nose_4\":0,\"bracelets_1\":-1}', 10000),
(2, 'Drugi outfit', '{\"bags_1\":0,\"bproof_1\":0,\"eyebrows_3\":0,\"chest_1\":0,\"eyebrows_4\":0,\"jaw_2\":0,\"face\":19,\"bproof_2\":0,\"blush_1\":0,\"lip_thickness\":0,\"makeup_1\":0,\"chin_2\":0,\"eyebrows_1\":2,\"cheeks_1\":0,\"eye_color\":0,\"lipstick_3\":32,\"beard_3\":61,\"pants_1\":1,\"eyebrows_2\":10,\"nose_1\":0,\"nose_5\":0,\"shoes_1\":1,\"helmet_2\":-1,\"chain_1\":0,\"shoes_2\":2,\"sex\":0,\"pants_2\":1,\"beard_4\":0,\"chest_2\":0,\"lipstick_1\":0,\"sun_1\":0,\"age_1\":0,\"chain_2\":0,\"skin\":0,\"eye_squint\":0,\"neck_thickness\":0,\"bracelets_2\":0,\"bags_2\":0,\"jaw_1\":0,\"eyebrows_5\":0,\"nose_2\":0,\"sun_2\":0,\"arms_2\":0,\"chin_4\":0,\"moles_2\":0,\"chin_3\":0,\"hair_1\":0,\"cheeks_3\":0,\"blush_3\":\"2\",\"face_md_weight\":50,\"torso_2\":0,\"age_2\":0,\"mask_1\":0,\"complexion_2\":0,\"chin_1\":0,\"mask_2\":0,\"makeup_4\":0,\"ears_2\":-1,\"glasses_2\":1,\"hair_2\":0,\"chest_3\":0,\"nose_6\":0,\"lipstick_4\":0,\"blemishes_2\":0,\"glasses_1\":5,\"beard_1\":2,\"beard_2\":10,\"skin_md_weight\":50,\"decals_1\":0,\"tshirt_1\":0,\"eyebrows_6\":0,\"lipstick_2\":0,\"decals_2\":0,\"tshirt_2\":2,\"makeup_2\":0,\"cheeks_2\":0,\"bodyb_2\":0,\"hair_color_2\":0,\"watches_2\":-1,\"bodyb_1\":0,\"dad\":12,\"mom\":21,\"hair_color_1\":0,\"ears_1\":-1,\"moles_1\":0,\"watches_1\":-1,\"nose_3\":0,\"blush_2\":0,\"arms\":1,\"helmet_1\":-1,\"blemishes_1\":0,\"torso_1\":4,\"makeup_3\":0,\"complexion_1\":0,\"nose_4\":0,\"bracelets_1\":-1}', 10000);

-- --------------------------------------------------------

--
-- Table structure for table `kuce_stvari`
--

DROP TABLE IF EXISTS `kuce_stvari`;
CREATE TABLE IF NOT EXISTS `kuce_stvari` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `item` varchar(255) DEFAULT NULL,
  `kolicina` varchar(255) DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
  `kuca` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `item` (`item`) USING BTREE,
  KEY `owner` (`owner`) USING BTREE,
  KEY `kuca` (`kuca`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `kuce_stvari`
--

INSERT INTO `kuce_stvari` (`ID`, `item`, `kolicina`, `owner`, `kuca`) VALUES
(4, '11', '4', 10000, 23),
(8, '4', '11', 5, 10000),
(24, '156', '5', 10000, 29),
(23, '11', '1', 10000, 29),
(22, '92', '1', 10000, 23);

-- --------------------------------------------------------

--
-- Table structure for table `licenses`
--

DROP TABLE IF EXISTS `licenses`;
CREATE TABLE IF NOT EXISTS `licenses` (
  `type` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL,
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `licenses`
--

INSERT INTO `licenses` (`type`, `label`) VALUES
('chemicalslisence', 'Chemicals license'),
('dmv', 'Teorija za voznju'),
('drive', 'Vozacka dozvola'),
('drive_bike', 'Vozacka za motor'),
('drive_truck', 'Vozacka za kamion'),
('weapon', 'Dozvola za posjedovanje oruzja'),
('weed_processing', 'Weed Processing License');

-- --------------------------------------------------------

--
-- Table structure for table `mafije`
--

DROP TABLE IF EXISTS `mafije`;
CREATE TABLE IF NOT EXISTS `mafije` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Ime` varchar(60) NOT NULL,
  `Label` varchar(60) NOT NULL,
  `Rankovi` varchar(255) NOT NULL DEFAULT '{}',
  `Oruzarnica` varchar(250) NOT NULL DEFAULT '{}',
  `Lider` varchar(250) NOT NULL DEFAULT '{}',
  `SpawnV` varchar(250) NOT NULL DEFAULT '{}',
  `DeleteV` varchar(250) NOT NULL DEFAULT '{}',
  `LokVozila` varchar(250) NOT NULL DEFAULT '{}',
  `CrateDrop` varchar(250) NOT NULL DEFAULT '{}',
  `Vozila` longtext NOT NULL DEFAULT '{}',
  `Oruzja` longtext NOT NULL DEFAULT '{}',
  `Boje` varchar(255) NOT NULL DEFAULT '{}',
  `Ulaz` varchar(250) NOT NULL DEFAULT '{}',
  `Izlaz` varchar(250) NOT NULL DEFAULT '{}',
  `Gradonacelnik` int(11) NOT NULL DEFAULT 0,
  `DeleteV2` varchar(255) NOT NULL DEFAULT '{}',
  `LokVozila2` varchar(250) NOT NULL DEFAULT '{}',
  `Kokain` varchar(255) NOT NULL DEFAULT '{}',
  `KamionK` varchar(255) NOT NULL DEFAULT '{}',
  `Skladiste` int(5) NOT NULL DEFAULT 0,
  `Posao` int(11) NOT NULL DEFAULT 0,
  `KPosao` varchar(255) NOT NULL DEFAULT '{}',
  `PosaoSpawn` varchar(255) NOT NULL DEFAULT '{}',
  `Heroin` varchar(255) NOT NULL DEFAULT '{}',
  `KamionH` varchar(255) NOT NULL DEFAULT '{}',
  `Skladiste2` int(11) NOT NULL DEFAULT 0,
  `Avion` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `meh_narudzbe`
--

DROP TABLE IF EXISTS `meh_narudzbe`;
CREATE TABLE IF NOT EXISTS `meh_narudzbe` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `tablica` varchar(255) DEFAULT NULL,
  `narudzba` longtext DEFAULT NULL,
  `vrijeme` datetime DEFAULT NULL,
  `broj` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `tablica` (`tablica`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=92 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `minute`
--

DROP TABLE IF EXISTS `minute`;
CREATE TABLE IF NOT EXISTS `minute` (
  `identifier` int(11) NOT NULL,
  `minute` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`identifier`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `minute`
--

INSERT INTO `minute` (`identifier`, `minute`) VALUES
(10000, 15790),
(10003, 600),
(10006, 15),
(10007, 5),
(10008, 5),
(10010, 270),
(10011, 110);

-- --------------------------------------------------------

--
-- Table structure for table `mskladiste`
--

DROP TABLE IF EXISTS `mskladiste`;
CREATE TABLE IF NOT EXISTS `mskladiste` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ime` varchar(255) NOT NULL,
  `listovi` int(11) NOT NULL DEFAULT 0,
  `kokain` int(11) NOT NULL DEFAULT 0,
  `gljive` int(11) NOT NULL DEFAULT 0,
  `heroin` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `narudzbe`
--

DROP TABLE IF EXISTS `narudzbe`;
CREATE TABLE IF NOT EXISTS `narudzbe` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Firma` int(11) NOT NULL,
  `Dobavljac` int(11) NOT NULL,
  `Kolicina` int(11) NOT NULL,
  `Rezervirano` int(11) NOT NULL DEFAULT 0,
  `Cijena` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `owned_vehicles`
--

DROP TABLE IF EXISTS `owned_vehicles`;
CREATE TABLE IF NOT EXISTS `owned_vehicles` (
  `owner` int(11) NOT NULL,
  `state` int(11) NOT NULL DEFAULT 1 COMMENT 'State vozila',
  `plate` varchar(12) NOT NULL,
  `vehicle` longtext DEFAULT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'car',
  `job` varchar(20) DEFAULT NULL,
  `stored` int(11) NOT NULL DEFAULT 0,
  `lasthouse` int(11) DEFAULT 0,
  `mjenjac` int(11) NOT NULL DEFAULT 1,
  `brod` int(11) NOT NULL DEFAULT 0,
  `model` varchar(255) NOT NULL,
  `kilometri` float NOT NULL DEFAULT 0,
  `stage` int(11) NOT NULL DEFAULT 0,
  `motor` varchar(255) DEFAULT NULL,
  `zracni` tinyint(4) NOT NULL DEFAULT 0,
  `servis` int(11) DEFAULT NULL,
  `kvar` int(11) NOT NULL DEFAULT 0,
  `naziv` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`plate`) USING BTREE,
  KEY `plate` (`plate`) USING BTREE,
  KEY `owner` (`owner`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `owned_vehicles`
--

INSERT INTO `owned_vehicles` (`owner`, `state`, `plate`, `vehicle`, `type`, `job`, `stored`, `lasthouse`, `mjenjac`, `brod`, `model`, `kilometri`, `stage`, `motor`, `zracni`, `servis`, `kvar`, `naziv`) VALUES
(10000, 1, 'AIY 300', '{\"color1\":4,\"modGrille\":-1,\"modDoorSpeaker\":-1,\"health\":1000,\"modRightFender\":-1,\"modArmor\":-1,\"modDial\":-1,\"modHood\":-1,\"modLivery\":-1,\"bodyHealth\":1000.0,\"modSmokeEnabled\":1,\"plate\":\"AIY 300\",\"tyres\":[false,false,false,false,false,false,false],\"modTrimB\":-1,\"modExhaust\":-1,\"modTransmission\":-1,\"pearlescentColor\":4,\"modSideSkirt\":-1,\"modAPlate\":-1,\"modShifterLeavers\":-1,\"dirtLevel\":0.20720222592353,\"tyreSmokeColor\":[255,255,255],\"fuel\":64.8740005493164,\"modHorns\":-1,\"plateIndex\":4,\"model\":1152513354,\"modSteeringWheel\":-1,\"modStruts\":-1,\"modFrontBumper\":-1,\"modArchCover\":-1,\"engineHealth\":1000.0,\"modBackWheels\":-1,\"neonColor\":[255,0,255],\"modRoof\":-1,\"modSuspension\":-1,\"windowTint\":-1,\"wheelColor\":4,\"modWindows\":-1,\"modEngineBlock\":-1,\"modFrontWheels\":-1,\"modSpoilers\":-1,\"color2\":4,\"extras\":{\"2\":true,\"3\":true,\"4\":true,\"5\":true,\"11\":true,\"12\":false,\"8\":true},\"modFender\":-1,\"modSeats\":-1,\"neonEnabled\":[false,false,false,false],\"svijetlaColor\":255,\"modPlateHolder\":-1,\"modRearBumper\":-1,\"modTrimA\":-1,\"modTrunk\":-1,\"modOrnaments\":-1,\"modAirFilter\":-1,\"modDashboard\":-1,\"modTank\":-1,\"modAerials\":-1,\"modHydrolic\":-1,\"modVanityPlate\":-1,\"modFrame\":-1,\"modBrakes\":-1,\"wheels\":0,\"modTurbo\":false,\"modSpeakers\":-1,\"modEngine\":1,\"modXenon\":false,\"doors\":[false,false,false,false,false,false]}', 'car', NULL, 0, 0, 1, 0, '1152513354', 8.681, 0, NULL, 0, 30, 0, NULL),
(10010, 0, 'AJV 642', '{\"modSideSkirt\":-1,\"modFrontBumper\":-1,\"pearlescentColor\":0,\"modTurbo\":false,\"modAPlate\":-1,\"color2\":31,\"bodyHealth\":1000.0,\"modGrille\":-1,\"modSeats\":-1,\"modSuspension\":-1,\"doors\":[false,false,false,false,false,false],\"modHorns\":-1,\"health\":1000,\"modFrame\":-1,\"modArmor\":-1,\"modShifterLeavers\":-1,\"plate\":\"AJV 642\",\"modSpoilers\":-1,\"tyres\":[false,false,false,false,false,false,false],\"plateIndex\":3,\"wheelColor\":107,\"svijetlaColor\":255,\"modTank\":-1,\"modFender\":-1,\"modVanityPlate\":-1,\"tyreSmokeColor\":[255,255,255],\"modAerials\":-1,\"modBackWheels\":-1,\"modTrimB\":-1,\"modTransmission\":-1,\"neonEnabled\":[false,false,false,false],\"modEngineBlock\":-1,\"extras\":{\"1\":false},\"modSpeakers\":-1,\"modArchCover\":-1,\"color1\":31,\"modTrunk\":-1,\"modExhaust\":-1,\"modHydrolic\":-1,\"modEngine\":-1,\"modAirFilter\":-1,\"modXenon\":false,\"modRightFender\":-1,\"modSmokeEnabled\":false,\"modRoof\":-1,\"modBrakes\":-1,\"modDoorSpeaker\":-1,\"dirtLevel\":0.0,\"modPlateHolder\":-1,\"modTrimA\":-1,\"windowTint\":-1,\"modDashboard\":-1,\"modRearBumper\":-1,\"modHood\":-1,\"wheels\":1,\"model\":-1347153492,\"fuel\":64.75994873046875,\"modWindows\":-1,\"modFrontWheels\":-1,\"modLivery\":-1,\"engineHealth\":1000.0,\"modStruts\":-1,\"modDial\":-1,\"neonColor\":[255,0,255],\"modOrnaments\":-1,\"modSteeringWheel\":-1}', 'car', NULL, 0, 0, 1, 0, '-1347153492', 2.81, 0, NULL, 0, 30, 0, NULL),
(10000, 1, 'AZU 585', '{\"color1\":138,\"modGrille\":-1,\"modDoorSpeaker\":-1,\"health\":998,\"modRightFender\":-1,\"modArmor\":-1,\"modDial\":-1,\"modHood\":-1,\"modLivery\":-1,\"bodyHealth\":998.75,\"modSmokeEnabled\":1,\"plate\":\"AZU 585\",\"tyres\":[false,false,false,false,false,false,false],\"modTrimB\":-1,\"modExhaust\":-1,\"modTransmission\":-1,\"pearlescentColor\":4,\"modSideSkirt\":-1,\"modAPlate\":-1,\"modShifterLeavers\":-1,\"dirtLevel\":1.98138618469238,\"tyreSmokeColor\":[255,255,255],\"fuel\":64.5479965209961,\"modHorns\":-1,\"plateIndex\":1,\"model\":1932295607,\"modSteeringWheel\":-1,\"modStruts\":-1,\"modFrontBumper\":-1,\"modArchCover\":-1,\"engineHealth\":944.20166015625,\"modBackWheels\":-1,\"neonColor\":[255,0,255],\"modRoof\":-1,\"modSuspension\":-1,\"windowTint\":-1,\"wheelColor\":156,\"modWindows\":-1,\"modEngineBlock\":-1,\"modFrontWheels\":-1,\"modSpoilers\":-1,\"color2\":15,\"extras\":{\"1\":false},\"modFender\":-1,\"modSeats\":-1,\"neonEnabled\":[false,false,false,false],\"svijetlaColor\":255,\"modPlateHolder\":-1,\"modRearBumper\":-1,\"modTrimA\":-1,\"modTrunk\":-1,\"modOrnaments\":-1,\"modAirFilter\":-1,\"modDashboard\":-1,\"modTank\":-1,\"modAerials\":-1,\"modHydrolic\":-1,\"modVanityPlate\":-1,\"modFrame\":-1,\"modBrakes\":-1,\"wheels\":5,\"modTurbo\":false,\"modSpeakers\":-1,\"modEngine\":-1,\"modXenon\":false,\"doors\":[false,false,false,false,false,false]}', 'car', NULL, 0, 0, 1, 0, '1932295607', 10.264, 0, NULL, 0, 30, 0, NULL),
(10000, 0, 'CBV 957', '{\"modSideSkirt\":-1,\"modFrontBumper\":-1,\"pearlescentColor\":111,\"modTurbo\":false,\"modAPlate\":-1,\"color2\":6,\"bodyHealth\":1000.0,\"modGrille\":-1,\"modSeats\":-1,\"modSuspension\":-1,\"doors\":[false,false,false,false,false,false],\"modHorns\":-1,\"health\":1000,\"modFrame\":-1,\"modArmor\":-1,\"modShifterLeavers\":-1,\"plate\":\"CBV 957\",\"modSpoilers\":-1,\"tyres\":[false,false,false,false,false,false,false],\"plateIndex\":0,\"wheelColor\":156,\"svijetlaColor\":255,\"modTank\":-1,\"modFender\":-1,\"modVanityPlate\":-1,\"tyreSmokeColor\":[255,255,255],\"modAerials\":-1,\"modBackWheels\":-1,\"modTrimB\":-1,\"modTransmission\":-1,\"neonEnabled\":[false,false,false,false],\"modEngineBlock\":-1,\"extras\":{\"9\":false,\"8\":false,\"3\":true,\"2\":false,\"5\":false,\"4\":false,\"7\":false,\"1\":false},\"modSpeakers\":-1,\"modArchCover\":-1,\"color1\":6,\"modTrunk\":-1,\"modExhaust\":-1,\"modHydrolic\":-1,\"modEngine\":-1,\"modAirFilter\":-1,\"modXenon\":false,\"modRightFender\":-1,\"modSmokeEnabled\":false,\"modRoof\":-1,\"modBrakes\":-1,\"modDoorSpeaker\":-1,\"dirtLevel\":0.0,\"modPlateHolder\":-1,\"modTrimA\":-1,\"windowTint\":-1,\"modDashboard\":-1,\"modRearBumper\":-1,\"modHood\":-1,\"wheels\":7,\"model\":-243837818,\"fuel\":64.83198547363281,\"modWindows\":-1,\"modFrontWheels\":-1,\"modLivery\":0,\"engineHealth\":1000.0,\"modStruts\":-1,\"modDial\":-1,\"neonColor\":[255,0,255],\"modOrnaments\":-1,\"modSteeringWheel\":-1}', 'car', NULL, 0, 0, 1, 0, '-243837818', 1.286, 0, NULL, 0, 30, 0, NULL),
(10000, 0, 'CCO 124', '{\"modSideSkirt\":-1,\"modFrontBumper\":-1,\"pearlescentColor\":4,\"modTurbo\":false,\"modAPlate\":-1,\"color2\":28,\"bodyHealth\":1000.0,\"modGrille\":-1,\"modSeats\":-1,\"modSuspension\":-1,\"doors\":[false,false,false,false,false,false],\"modHorns\":-1,\"health\":1000,\"modFrame\":-1,\"modArmor\":-1,\"modShifterLeavers\":-1,\"plate\":\"CCO 124\",\"modSpoilers\":-1,\"tyres\":[false,false,false,false,false,false,false],\"plateIndex\":4,\"wheelColor\":14,\"svijetlaColor\":255,\"modTank\":-1,\"modFender\":-1,\"modVanityPlate\":-1,\"tyreSmokeColor\":[255,255,255],\"modAerials\":-1,\"modBackWheels\":-1,\"modTrimB\":-1,\"modTransmission\":-1,\"neonEnabled\":[false,false,false,false],\"modEngineBlock\":-1,\"extras\":{\"7\":true,\"12\":false},\"modSpeakers\":-1,\"modArchCover\":-1,\"color1\":28,\"modTrunk\":-1,\"modExhaust\":-1,\"modHydrolic\":-1,\"modEngine\":-1,\"modAirFilter\":-1,\"modXenon\":false,\"modRightFender\":-1,\"modSmokeEnabled\":false,\"modRoof\":-1,\"modBrakes\":-1,\"modDoorSpeaker\":-1,\"dirtLevel\":0.0,\"modPlateHolder\":-1,\"modTrimA\":-1,\"windowTint\":-1,\"modDashboard\":-1,\"modRearBumper\":-1,\"modHood\":-1,\"wheels\":0,\"model\":54381077,\"fuel\":64.81996154785156,\"modWindows\":-1,\"modFrontWheels\":-1,\"modLivery\":-1,\"engineHealth\":1000.0,\"modStruts\":-1,\"modDial\":-1,\"neonColor\":[255,0,255],\"modOrnaments\":-1,\"modSteeringWheel\":-1}', 'car', NULL, 0, 0, 1, 0, '54381077', 0, 0, NULL, 0, 30, 0, NULL),
(10000, 0, 'DBM 622', '{\"modSmokeEnabled\":false,\"modFrontBumper\":-1,\"pearlescentColor\":0,\"modTurbo\":false,\"modAPlate\":-1,\"color2\":53,\"bodyHealth\":1000.0,\"modGrille\":-1,\"modSeats\":-1,\"modSuspension\":-1,\"doors\":[false,false,false,false,false,false],\"modDashboard\":-1,\"health\":1000,\"modFrame\":-1,\"modArmor\":-1,\"modShifterLeavers\":-1,\"plate\":\"DBM 622\",\"modSpoilers\":-1,\"tyres\":[false,false,false,false,false,false,false],\"plateIndex\":5,\"wheelColor\":156,\"svijetlaColor\":255,\"modTank\":-1,\"modSteeringWheel\":-1,\"modVanityPlate\":-1,\"tyreSmokeColor\":[255,255,255],\"modAerials\":-1,\"modBackWheels\":-1,\"modTrimB\":-1,\"modTransmission\":-1,\"neonEnabled\":[false,false,false,false],\"modEngineBlock\":-1,\"extras\":{\"12\":false},\"modSpeakers\":-1,\"modArchCover\":-1,\"color1\":53,\"modTrunk\":-1,\"modExhaust\":-1,\"modHydrolic\":-1,\"modEngine\":-1,\"modAirFilter\":-1,\"modXenon\":false,\"modRightFender\":-1,\"modBrakes\":-1,\"modRoof\":-1,\"dirtLevel\":0.0,\"modOrnaments\":-1,\"modPlateHolder\":-1,\"modTrimA\":-1,\"modDoorSpeaker\":-1,\"windowTint\":-1,\"wheels\":0,\"neonColor\":[255,0,255],\"modHorns\":-1,\"modFender\":-1,\"model\":1462416745,\"fuel\":64.95802307128906,\"modRearBumper\":-1,\"modFrontWheels\":-1,\"modWindows\":-1,\"modLivery\":0,\"modStruts\":-1,\"modDial\":-1,\"modHood\":-1,\"engineHealth\":1000.0,\"modSideSkirt\":-1}', 'car', NULL, 0, 0, 1, 0, '1462416745', 0.059, 0, NULL, 0, 30, 0, NULL),
(10010, 0, 'EBI 256', '{\"modSideSkirt\":-1,\"modFrontBumper\":-1,\"pearlescentColor\":0,\"modTurbo\":false,\"modAPlate\":-1,\"color2\":39,\"bodyHealth\":1000.0,\"modGrille\":-1,\"modSeats\":-1,\"modSuspension\":-1,\"doors\":[false,false,false,false,false,false],\"modHorns\":-1,\"health\":1000,\"modFrame\":-1,\"modArmor\":-1,\"modShifterLeavers\":-1,\"plate\":\"EBI 256\",\"modSpoilers\":-1,\"tyres\":[false,false,false,false,false,false,false],\"plateIndex\":3,\"wheelColor\":156,\"svijetlaColor\":255,\"modTank\":-1,\"modFender\":-1,\"modVanityPlate\":-1,\"tyreSmokeColor\":[255,255,255],\"modAerials\":-1,\"modBackWheels\":-1,\"modTrimB\":-1,\"modTransmission\":-1,\"neonEnabled\":[false,false,false,false],\"modEngineBlock\":-1,\"extras\":[],\"modSpeakers\":-1,\"modArchCover\":-1,\"color1\":67,\"modTrunk\":-1,\"modExhaust\":-1,\"modHydrolic\":-1,\"modEngine\":-1,\"modAirFilter\":-1,\"modXenon\":false,\"modRightFender\":-1,\"modSmokeEnabled\":false,\"modRoof\":-1,\"modBrakes\":-1,\"modDoorSpeaker\":-1,\"dirtLevel\":0.0,\"modPlateHolder\":-1,\"modTrimA\":-1,\"windowTint\":-1,\"modDashboard\":-1,\"modRearBumper\":-1,\"modHood\":-1,\"wheels\":2,\"model\":676238631,\"fuel\":64.86207580566406,\"modWindows\":-1,\"modFrontWheels\":-1,\"modLivery\":-1,\"engineHealth\":1000.0,\"modStruts\":-1,\"modDial\":-1,\"neonColor\":[255,0,255],\"modOrnaments\":-1,\"modSteeringWheel\":-1}', 'car', NULL, 0, 0, 1, 0, '676238631', 2.819, 0, NULL, 0, 30, 0, NULL),
(10000, 0, 'FOU 131', '{\"modSideSkirt\":-1,\"modFrontBumper\":-1,\"pearlescentColor\":0,\"modTurbo\":false,\"modAPlate\":-1,\"color2\":28,\"bodyHealth\":1000.0,\"modGrille\":-1,\"modSeats\":-1,\"modSuspension\":-1,\"doors\":[false,false,false,false,false,false],\"modHorns\":-1,\"health\":1000,\"modFrame\":-1,\"modArmor\":-1,\"modShifterLeavers\":-1,\"plate\":\"FOU 131\",\"modSpoilers\":-1,\"tyres\":[false,false,false,false,false,false,false],\"plateIndex\":0,\"wheelColor\":4,\"svijetlaColor\":255,\"modTank\":-1,\"modFender\":-1,\"modVanityPlate\":-1,\"tyreSmokeColor\":[255,255,255],\"modAerials\":-1,\"modBackWheels\":-1,\"modTrimB\":-1,\"modTransmission\":-1,\"neonEnabled\":[false,false,false,false],\"modEngineBlock\":-1,\"extras\":{\"1\":false,\"4\":false,\"3\":true,\"2\":false},\"modSpeakers\":-1,\"modArchCover\":-1,\"color1\":28,\"modTrunk\":-1,\"modExhaust\":-1,\"modHydrolic\":-1,\"modEngine\":-1,\"modAirFilter\":-1,\"modXenon\":false,\"modRightFender\":-1,\"modSmokeEnabled\":false,\"modRoof\":-1,\"modBrakes\":-1,\"modDoorSpeaker\":-1,\"dirtLevel\":0.0,\"modPlateHolder\":-1,\"modTrimA\":-1,\"windowTint\":-1,\"modDashboard\":-1,\"modRearBumper\":-1,\"modHood\":-1,\"wheels\":0,\"model\":2057197469,\"fuel\":64.76200103759766,\"modWindows\":-1,\"modFrontWheels\":-1,\"modLivery\":0,\"engineHealth\":1000.0,\"modStruts\":-1,\"modDial\":-1,\"neonColor\":[255,0,255],\"modOrnaments\":-1,\"modSteeringWheel\":-1}', 'car', NULL, 0, 0, 1, 0, '2057197469', 0.09, 0, NULL, 0, 30, 0, NULL),
(10000, 0, 'HBL 461', '{\"modSideSkirt\":-1,\"modFrontBumper\":-1,\"pearlescentColor\":0,\"modTurbo\":false,\"modAPlate\":-1,\"color2\":1,\"bodyHealth\":1000.0,\"modGrille\":-1,\"modSeats\":-1,\"modSuspension\":-1,\"doors\":[false,false,false,false,false,false],\"modHorns\":-1,\"health\":1000,\"modFrame\":-1,\"modArmor\":-1,\"modShifterLeavers\":-1,\"plate\":\"HBL 461\",\"modSpoilers\":-1,\"tyres\":[false,false,false,false,false,false,false],\"plateIndex\":3,\"wheelColor\":156,\"svijetlaColor\":255,\"modTank\":-1,\"modFender\":-1,\"modVanityPlate\":-1,\"tyreSmokeColor\":[255,255,255],\"modAerials\":-1,\"modBackWheels\":-1,\"modTrimB\":-1,\"modTransmission\":-1,\"neonEnabled\":[false,false,false,false],\"modEngineBlock\":-1,\"extras\":{\"12\":false},\"modSpeakers\":-1,\"modArchCover\":-1,\"color1\":28,\"modTrunk\":-1,\"modExhaust\":-1,\"modHydrolic\":-1,\"modEngine\":-1,\"modAirFilter\":-1,\"modXenon\":false,\"modRightFender\":-1,\"modSmokeEnabled\":false,\"modRoof\":-1,\"modBrakes\":-1,\"modDoorSpeaker\":-1,\"dirtLevel\":0.0,\"modPlateHolder\":-1,\"modTrimA\":-1,\"windowTint\":-1,\"modDashboard\":-1,\"modRearBumper\":-1,\"modHood\":-1,\"wheels\":0,\"model\":343720538,\"fuel\":99.85008239746094,\"modWindows\":-1,\"modFrontWheels\":-1,\"modLivery\":0,\"engineHealth\":1000.0,\"modStruts\":-1,\"modDial\":-1,\"neonColor\":[255,0,255],\"modOrnaments\":-1,\"modSteeringWheel\":-1}', 'car', NULL, 0, 0, 1, 0, '343720538', 0.082, 0, NULL, 0, 30, 0, NULL),
(10000, 0, 'HXR 546', '{\"modSmokeEnabled\":false,\"modFrontBumper\":-1,\"pearlescentColor\":0,\"modTurbo\":false,\"modAPlate\":-1,\"color2\":10,\"modPlateHolder\":-1,\"modGrille\":-1,\"modSeats\":-1,\"modSuspension\":-1,\"doors\":[false,false,false,false,false,false],\"modDashboard\":-1,\"health\":1000,\"modFrame\":-1,\"modArmor\":-1,\"modShifterLeavers\":-1,\"plate\":\"HXR 546\",\"modSpoilers\":-1,\"tyres\":[false,false,false,false,false,false,false],\"plateIndex\":1,\"wheelColor\":156,\"svijetlaColor\":255,\"modTank\":-1,\"modSteeringWheel\":-1,\"modVanityPlate\":-1,\"tyreSmokeColor\":[255,255,255],\"modAerials\":-1,\"modBackWheels\":-1,\"modTrimB\":-1,\"modTransmission\":-1,\"neonEnabled\":[false,false,false,false],\"modEngineBlock\":-1,\"extras\":{\"1\":false},\"modSpeakers\":-1,\"modArchCover\":-1,\"color1\":10,\"modTrunk\":-1,\"modExhaust\":-1,\"modHydrolic\":-1,\"modEngine\":-1,\"modAirFilter\":-1,\"modXenon\":false,\"dirtLevel\":0.0,\"modBrakes\":-1,\"modRoof\":-1,\"bodyHealth\":1000.0,\"modTrimA\":-1,\"modHood\":-1,\"neonColor\":[255,0,255],\"wheels\":0,\"windowTint\":-1,\"modDoorSpeaker\":-1,\"modHorns\":-1,\"modWindows\":-1,\"modLivery\":-1,\"modOrnaments\":-1,\"fuel\":64.92504119873047,\"modRearBumper\":-1,\"modFrontWheels\":-1,\"modFender\":-1,\"engineHealth\":1000.0,\"modStruts\":-1,\"modDial\":-1,\"modRightFender\":-1,\"modSideSkirt\":-1,\"model\":1820016202}', 'car', NULL, 0, 0, 1, 0, '1820016202', 6.611, 0, NULL, 0, 30, 0, NULL),
(10000, 0, 'HZY 976', '{\"modSideSkirt\":-1,\"modFrontBumper\":-1,\"pearlescentColor\":0,\"modTurbo\":false,\"modAPlate\":-1,\"color2\":134,\"bodyHealth\":1000.0,\"modGrille\":-1,\"modSeats\":-1,\"modSuspension\":-1,\"doors\":[false,false,false,false,false,false],\"modHorns\":-1,\"health\":1000,\"modFrame\":-1,\"modArmor\":-1,\"modShifterLeavers\":-1,\"plate\":\"HZY 976\",\"modSpoilers\":-1,\"tyres\":[false,false,false,false,false,false,false],\"plateIndex\":0,\"wheelColor\":156,\"svijetlaColor\":255,\"modTank\":-1,\"modFender\":-1,\"modVanityPlate\":-1,\"tyreSmokeColor\":[255,255,255],\"modAerials\":-1,\"modBackWheels\":-1,\"modTrimB\":-1,\"modTransmission\":-1,\"neonEnabled\":[false,false,false,false],\"modEngineBlock\":-1,\"extras\":{\"2\":true},\"modSpeakers\":-1,\"modArchCover\":-1,\"color1\":134,\"modTrunk\":-1,\"modExhaust\":-1,\"modHydrolic\":-1,\"modEngine\":-1,\"modAirFilter\":-1,\"modXenon\":false,\"modRightFender\":-1,\"modSmokeEnabled\":false,\"modRoof\":-1,\"modBrakes\":-1,\"modDoorSpeaker\":-1,\"dirtLevel\":0.0,\"modPlateHolder\":-1,\"modTrimA\":-1,\"windowTint\":-1,\"modDashboard\":-1,\"modRearBumper\":-1,\"modHood\":-1,\"wheels\":7,\"model\":1376955328,\"fuel\":64.74800109863281,\"modWindows\":-1,\"modFrontWheels\":-1,\"modLivery\":3,\"engineHealth\":1000.0,\"modStruts\":-1,\"modDial\":-1,\"neonColor\":[255,0,255],\"modOrnaments\":-1,\"modSteeringWheel\":-1}', 'car', NULL, 0, 0, 1, 0, '1376955328', 0, 0, NULL, 0, 30, 0, NULL),
(10000, 0, 'IUY 175', '{\"modSmokeEnabled\":false,\"modFrontBumper\":-1,\"pearlescentColor\":111,\"modTurbo\":false,\"modAPlate\":-1,\"color2\":38,\"modPlateHolder\":-1,\"modGrille\":-1,\"modSeats\":-1,\"modSuspension\":-1,\"doors\":[false,false,false,false,false,false],\"modDashboard\":-1,\"health\":1000,\"modFrame\":-1,\"modArmor\":-1,\"modShifterLeavers\":-1,\"plate\":\"IUY 175\",\"modSpoilers\":-1,\"tyres\":[false,false,false,false,false,false,false],\"plateIndex\":2,\"wheelColor\":156,\"svijetlaColor\":255,\"modTank\":-1,\"modSteeringWheel\":-1,\"modVanityPlate\":-1,\"tyreSmokeColor\":[255,255,255],\"modAerials\":-1,\"modBackWheels\":-1,\"modTrimB\":-1,\"modTransmission\":-1,\"neonEnabled\":[false,false,false,false],\"modEngineBlock\":-1,\"extras\":{\"1\":false,\"3\":false,\"2\":true,\"5\":true,\"4\":true},\"modSpeakers\":-1,\"modArchCover\":-1,\"color1\":38,\"modTrunk\":-1,\"modExhaust\":-1,\"modHydrolic\":-1,\"modEngine\":-1,\"modAirFilter\":-1,\"modXenon\":false,\"dirtLevel\":0.0,\"modBrakes\":-1,\"modRoof\":-1,\"bodyHealth\":1000.0,\"modTrimA\":-1,\"modHood\":-1,\"neonColor\":[255,0,255],\"wheels\":2,\"windowTint\":-1,\"modDoorSpeaker\":-1,\"modHorns\":-1,\"modWindows\":-1,\"modLivery\":0,\"modOrnaments\":-1,\"fuel\":64.8740005493164,\"modRearBumper\":-1,\"modFrontWheels\":-1,\"modFender\":-1,\"engineHealth\":1000.0,\"modStruts\":-1,\"modDial\":-1,\"modRightFender\":-1,\"modSideSkirt\":-1,\"model\":-2147282465}', 'car', NULL, 0, 0, 1, 0, '-2147282465', 0.466, 0, NULL, 0, 30, 0, NULL),
(10000, 0, 'IUZ 411', '{\"modSideSkirt\":-1,\"modFrontBumper\":-1,\"pearlescentColor\":0,\"modTurbo\":false,\"modAPlate\":-1,\"color2\":38,\"bodyHealth\":1000.0,\"modGrille\":-1,\"modSeats\":-1,\"modSuspension\":-1,\"doors\":[false,false,false,false,false,false],\"modHorns\":-1,\"health\":1000,\"modFrame\":-1,\"modArmor\":-1,\"modShifterLeavers\":-1,\"plate\":\"IUZ 411\",\"modSpoilers\":-1,\"tyres\":[false,false,false,false,false,false,false],\"plateIndex\":0,\"wheelColor\":156,\"svijetlaColor\":255,\"modTank\":-1,\"modFender\":-1,\"modVanityPlate\":-1,\"tyreSmokeColor\":[255,255,255],\"modAerials\":-1,\"modBackWheels\":-1,\"modTrimB\":-1,\"modTransmission\":-1,\"neonEnabled\":[false,false,false,false],\"modEngineBlock\":-1,\"extras\":{\"1\":true},\"modSpeakers\":-1,\"modArchCover\":-1,\"color1\":38,\"modTrunk\":-1,\"modExhaust\":-1,\"modHydrolic\":-1,\"modEngine\":-1,\"modAirFilter\":-1,\"modXenon\":false,\"modRightFender\":-1,\"modSmokeEnabled\":false,\"modRoof\":-1,\"modBrakes\":-1,\"modDoorSpeaker\":-1,\"dirtLevel\":0.0,\"modPlateHolder\":-1,\"modTrimA\":-1,\"windowTint\":-1,\"modDashboard\":-1,\"modRearBumper\":-1,\"modHood\":-1,\"wheels\":0,\"model\":1156552856,\"fuel\":64.63600158691406,\"modWindows\":-1,\"modFrontWheels\":-1,\"modLivery\":-1,\"engineHealth\":1000.0,\"modStruts\":-1,\"modDial\":-1,\"neonColor\":[255,0,255],\"modOrnaments\":-1,\"modSteeringWheel\":-1}', 'car', NULL, 0, 0, 1, 0, '1156552856', 1.201, 0, NULL, 0, 30, 0, NULL),
(10000, 0, 'LAY 157', '{\"modSideSkirt\":-1,\"modFrontBumper\":-1,\"pearlescentColor\":4,\"modTurbo\":false,\"modAPlate\":-1,\"color2\":51,\"bodyHealth\":1000.0,\"modGrille\":-1,\"modSeats\":-1,\"modSuspension\":-1,\"doors\":[false,false,false,false,false,false],\"modHorns\":-1,\"health\":1000,\"modFrame\":-1,\"modArmor\":-1,\"modShifterLeavers\":-1,\"plate\":\"LAY 157\",\"modSpoilers\":-1,\"tyres\":[false,false,false,false,false,false,false],\"plateIndex\":4,\"wheelColor\":103,\"svijetlaColor\":255,\"modTank\":-1,\"modFender\":-1,\"modVanityPlate\":-1,\"tyreSmokeColor\":[255,255,255],\"modAerials\":-1,\"modBackWheels\":-1,\"modTrimB\":-1,\"modTransmission\":-1,\"neonEnabled\":[false,false,false,false],\"modEngineBlock\":-1,\"extras\":{\"12\":true},\"modSpeakers\":-1,\"modArchCover\":-1,\"color1\":51,\"modTrunk\":-1,\"modExhaust\":-1,\"modHydrolic\":-1,\"modEngine\":-1,\"modAirFilter\":-1,\"modXenon\":false,\"modRightFender\":-1,\"modSmokeEnabled\":false,\"modRoof\":-1,\"modBrakes\":-1,\"modDoorSpeaker\":-1,\"dirtLevel\":0.0,\"modPlateHolder\":-1,\"modTrimA\":-1,\"windowTint\":-1,\"modDashboard\":-1,\"modRearBumper\":-1,\"modHood\":-1,\"wheels\":0,\"model\":-834393917,\"fuel\":64.81996154785156,\"modWindows\":-1,\"modFrontWheels\":-1,\"modLivery\":2,\"engineHealth\":1000.0,\"modStruts\":-1,\"modDial\":-1,\"neonColor\":[255,0,255],\"modOrnaments\":-1,\"modSteeringWheel\":-1}', 'car', NULL, 0, 0, 1, 0, '-834393917', 0.83, 0, NULL, 0, 30, 0, NULL),
(10000, 0, 'LKU 646', '{\"modSideSkirt\":-1,\"modFrontBumper\":-1,\"pearlescentColor\":0,\"modTurbo\":false,\"modAPlate\":-1,\"color2\":111,\"bodyHealth\":1000.0,\"modGrille\":-1,\"modSeats\":-1,\"modSuspension\":-1,\"doors\":[false,false,false,false,false,false],\"modHorns\":-1,\"health\":1000,\"modFrame\":-1,\"modArmor\":-1,\"modShifterLeavers\":-1,\"plate\":\"LKU 646\",\"modSpoilers\":-1,\"tyres\":[false,false,false,false,false,false,false],\"plateIndex\":2,\"wheelColor\":60,\"svijetlaColor\":255,\"modTank\":-1,\"modFender\":-1,\"modVanityPlate\":-1,\"tyreSmokeColor\":[255,255,255],\"modAerials\":-1,\"modBackWheels\":-1,\"modTrimB\":-1,\"modTransmission\":-1,\"neonEnabled\":[false,false,false,false],\"modEngineBlock\":-1,\"extras\":{\"3\":false,\"2\":true,\"5\":false,\"12\":false,\"11\":false},\"modSpeakers\":-1,\"modArchCover\":-1,\"color1\":49,\"modTrunk\":-1,\"modExhaust\":-1,\"modHydrolic\":-1,\"modEngine\":-1,\"modAirFilter\":-1,\"modXenon\":false,\"modRightFender\":-1,\"modSmokeEnabled\":false,\"modRoof\":-1,\"modBrakes\":-1,\"modDoorSpeaker\":-1,\"dirtLevel\":0.0,\"modPlateHolder\":-1,\"modTrimA\":-1,\"windowTint\":-1,\"modDashboard\":-1,\"modRearBumper\":-1,\"modHood\":-1,\"wheels\":2,\"model\":1148527416,\"fuel\":64.95099639892578,\"modWindows\":-1,\"modFrontWheels\":-1,\"modLivery\":-1,\"engineHealth\":1000.0,\"modStruts\":-1,\"modDial\":-1,\"neonColor\":[255,0,255],\"modOrnaments\":-1,\"modSteeringWheel\":-1}', 'car', NULL, 0, 0, 1, 0, '1148527416', 0.323, 0, NULL, 1, 30, 0, NULL),
(10000, 1, 'LOQ 483', '{\"modSmokeEnabled\":false,\"modFrontBumper\":-1,\"pearlescentColor\":0,\"modTurbo\":false,\"modAPlate\":-1,\"color2\":138,\"bodyHealth\":1000.0,\"modGrille\":-1,\"modSeats\":-1,\"modSuspension\":-1,\"doors\":[false,false,false,false,false,false],\"modDashboard\":-1,\"health\":1000,\"modFrame\":-1,\"modArmor\":-1,\"modShifterLeavers\":-1,\"plate\":\"LOQ 483\",\"modSpoilers\":-1,\"tyres\":[false,false,false,false,false,false,false],\"plateIndex\":5,\"wheelColor\":156,\"svijetlaColor\":255,\"modTank\":-1,\"modSteeringWheel\":-1,\"modVanityPlate\":-1,\"tyreSmokeColor\":[255,255,255],\"modAerials\":-1,\"modBackWheels\":-1,\"modTrimB\":-1,\"modTransmission\":-1,\"neonEnabled\":[false,false,false,false],\"modEngineBlock\":-1,\"extras\":{\"12\":true},\"modSpeakers\":-1,\"modArchCover\":-1,\"color1\":138,\"modTrunk\":-1,\"modExhaust\":-1,\"modHydrolic\":-1,\"modEngine\":-1,\"modAirFilter\":-1,\"modXenon\":false,\"modRightFender\":-1,\"modBrakes\":-1,\"modRoof\":-1,\"dirtLevel\":0.0,\"modOrnaments\":-1,\"modPlateHolder\":-1,\"modTrimA\":-1,\"modDoorSpeaker\":-1,\"windowTint\":-1,\"wheels\":0,\"neonColor\":[255,0,255],\"modHorns\":-1,\"modFender\":-1,\"model\":1462416745,\"fuel\":64.97601318359375,\"modRearBumper\":-1,\"modFrontWheels\":-1,\"modWindows\":-1,\"modLivery\":0,\"modStruts\":-1,\"modDial\":-1,\"modHood\":-1,\"engineHealth\":1000.0,\"modSideSkirt\":-1}', 'car', NULL, 0, 0, 1, 0, '1462416745', 0, 0, NULL, 0, 30, 0, NULL),
(10000, 0, 'LQU 876', '{\"modSideSkirt\":-1,\"modFrontBumper\":-1,\"pearlescentColor\":4,\"modTurbo\":false,\"modAPlate\":-1,\"color2\":15,\"modPlateHolder\":-1,\"modGrille\":-1,\"modSeats\":-1,\"modSuspension\":-1,\"doors\":[false,false,false,false,false,false],\"modDashboard\":-1,\"health\":1000,\"modFrame\":-1,\"modArmor\":-1,\"modShifterLeavers\":-1,\"plate\":\"LQU 876\",\"modSpoilers\":-1,\"tyres\":[false,false,false,false,false,false,false],\"plateIndex\":3,\"wheelColor\":156,\"svijetlaColor\":255,\"modTank\":-1,\"modFender\":-1,\"modVanityPlate\":-1,\"tyreSmokeColor\":[255,255,255],\"modAerials\":-1,\"modBackWheels\":-1,\"modTrimB\":-1,\"modTransmission\":-1,\"neonEnabled\":[false,false,false,false],\"modEngineBlock\":-1,\"extras\":{\"1\":false},\"modSpeakers\":-1,\"modArchCover\":-1,\"color1\":138,\"modTrunk\":-1,\"modExhaust\":-1,\"modRearBumper\":-1,\"modHydrolic\":-1,\"modAirFilter\":-1,\"modXenon\":false,\"modRightFender\":-1,\"modEngine\":-1,\"modRoof\":-1,\"modSmokeEnabled\":false,\"modBrakes\":-1,\"neonColor\":[255,0,255],\"bodyHealth\":1000.0,\"modTrimA\":-1,\"windowTint\":-1,\"modOrnaments\":-1,\"modHood\":-1,\"modDoorSpeaker\":-1,\"modHorns\":-1,\"model\":1932295607,\"fuel\":64.95198059082031,\"modWindows\":-1,\"modFrontWheels\":-1,\"wheels\":5,\"modLivery\":-1,\"modStruts\":-1,\"modDial\":-1,\"engineHealth\":1000.0,\"dirtLevel\":0.0,\"modSteeringWheel\":-1}', 'car', NULL, 0, 0, 1, 0, '1932295607', 0, 0, NULL, 0, 30, 0, NULL),
(10000, 1, 'MAF 770', '{\"modSideSkirt\":-1,\"modFrontBumper\":-1,\"pearlescentColor\":123,\"modTurbo\":false,\"modAPlate\":-1,\"color2\":123,\"bodyHealth\":1000.0,\"modGrille\":-1,\"modSeats\":-1,\"modSuspension\":-1,\"doors\":[false,false,false,false,false,false],\"modHorns\":-1,\"health\":1000,\"modFrame\":-1,\"modArmor\":-1,\"modShifterLeavers\":-1,\"plate\":\"MAF 770\",\"modSpoilers\":-1,\"tyres\":[false,false,false,false,false,false,false],\"plateIndex\":0,\"wheelColor\":156,\"svijetlaColor\":255,\"modTank\":-1,\"modFender\":-1,\"modVanityPlate\":-1,\"tyreSmokeColor\":[255,255,255],\"modAerials\":-1,\"modBackWheels\":-1,\"modTrimB\":-1,\"modTransmission\":-1,\"neonEnabled\":[false,false,false,false],\"modEngineBlock\":-1,\"extras\":{\"1\":true,\"12\":false,\"11\":false,\"2\":true},\"modSpeakers\":-1,\"modArchCover\":-1,\"color1\":123,\"modTrunk\":-1,\"modExhaust\":-1,\"modHydrolic\":-1,\"modEngine\":-1,\"modAirFilter\":-1,\"modXenon\":false,\"modRightFender\":-1,\"modSmokeEnabled\":false,\"modRoof\":-1,\"modBrakes\":-1,\"modDoorSpeaker\":-1,\"dirtLevel\":0.0,\"modPlateHolder\":-1,\"modTrimA\":-1,\"windowTint\":-1,\"modDashboard\":-1,\"modRearBumper\":-1,\"modHood\":-1,\"wheels\":2,\"model\":-1727242524,\"fuel\":64.8399658203125,\"modWindows\":-1,\"modFrontWheels\":-1,\"modLivery\":-1,\"engineHealth\":1000.0,\"modStruts\":-1,\"modDial\":-1,\"neonColor\":[255,0,255],\"modOrnaments\":-1,\"modSteeringWheel\":-1}', 'car', NULL, 0, 0, 1, 0, '-1727242524', 0.018, 0, NULL, 0, 30, 0, NULL),
(10000, 1, 'MAN 322', '{\"modSideSkirt\":-1,\"modFrontBumper\":-1,\"pearlescentColor\":0,\"modTurbo\":false,\"modAPlate\":-1,\"color2\":129,\"bodyHealth\":1000.0,\"modGrille\":-1,\"modSeats\":-1,\"modSuspension\":-1,\"doors\":[false,false,false,false,false,false],\"modHorns\":-1,\"health\":1000,\"modFrame\":-1,\"modArmor\":-1,\"modShifterLeavers\":-1,\"plate\":\"MAN 322\",\"modSpoilers\":-1,\"tyres\":[false,false,false,false,false,false,false],\"plateIndex\":4,\"wheelColor\":156,\"svijetlaColor\":255,\"modTank\":-1,\"modFender\":-1,\"modVanityPlate\":-1,\"tyreSmokeColor\":[255,255,255],\"modAerials\":-1,\"modBackWheels\":-1,\"modTrimB\":-1,\"modTransmission\":-1,\"neonEnabled\":[false,false,false,false],\"modEngineBlock\":-1,\"extras\":{\"3\":true,\"12\":true},\"modSpeakers\":-1,\"modArchCover\":-1,\"color1\":129,\"modTrunk\":-1,\"modExhaust\":-1,\"modHydrolic\":-1,\"modEngine\":-1,\"modAirFilter\":-1,\"modXenon\":false,\"modRightFender\":-1,\"modSmokeEnabled\":false,\"modRoof\":-1,\"modBrakes\":-1,\"modDoorSpeaker\":-1,\"dirtLevel\":0.0,\"modPlateHolder\":-1,\"modTrimA\":-1,\"windowTint\":-1,\"modDashboard\":-1,\"modRearBumper\":-1,\"modHood\":-1,\"wheels\":0,\"model\":1049637452,\"fuel\":64.8399658203125,\"modWindows\":-1,\"modFrontWheels\":-1,\"modLivery\":1,\"engineHealth\":1000.0,\"modStruts\":-1,\"modDial\":-1,\"neonColor\":[255,0,255],\"modOrnaments\":-1,\"modSteeringWheel\":-1}', 'car', NULL, 0, 0, 1, 0, '1049637452', 0, 0, NULL, 0, 30, 0, NULL),
(10000, 1, 'NRV 438', '{\"modSideSkirt\":-1,\"modFrontBumper\":-1,\"pearlescentColor\":0,\"modTurbo\":false,\"modAPlate\":-1,\"color2\":134,\"bodyHealth\":1000.0,\"modGrille\":-1,\"modSeats\":-1,\"modSuspension\":-1,\"doors\":[false,false,false,false,false,false],\"modHorns\":-1,\"health\":1000,\"modFrame\":-1,\"modArmor\":-1,\"modShifterLeavers\":-1,\"plate\":\"NRV 438\",\"modSpoilers\":-1,\"tyres\":[false,false,false,false,false,false,false],\"plateIndex\":3,\"wheelColor\":156,\"svijetlaColor\":255,\"modTank\":-1,\"modFender\":-1,\"modVanityPlate\":-1,\"tyreSmokeColor\":[255,255,255],\"modAerials\":-1,\"modBackWheels\":-1,\"modTrimB\":-1,\"modTransmission\":-1,\"neonEnabled\":[false,false,false,false],\"modEngineBlock\":-1,\"extras\":{\"12\":false,\"4\":true,\"11\":false,\"10\":false},\"modSpeakers\":-1,\"modArchCover\":-1,\"color1\":134,\"modTrunk\":-1,\"modExhaust\":-1,\"modHydrolic\":-1,\"modEngine\":-1,\"modAirFilter\":-1,\"modXenon\":false,\"modRightFender\":-1,\"modSmokeEnabled\":false,\"modRoof\":-1,\"modBrakes\":-1,\"modDoorSpeaker\":-1,\"dirtLevel\":0.0,\"modPlateHolder\":-1,\"modTrimA\":-1,\"windowTint\":-1,\"modDashboard\":-1,\"modRearBumper\":-1,\"modHood\":-1,\"wheels\":5,\"model\":613402935,\"fuel\":64.69200134277344,\"modWindows\":-1,\"modFrontWheels\":-1,\"modLivery\":0,\"engineHealth\":1000.0,\"modStruts\":-1,\"modDial\":-1,\"neonColor\":[255,0,255],\"modOrnaments\":-1,\"modSteeringWheel\":-1}', 'car', NULL, 0, 0, 1, 0, '613402935', 0, 0, NULL, 0, 30, 0, NULL),
(10000, 1, 'NUG 310', '{\"modSideSkirt\":-1,\"modFrontBumper\":-1,\"pearlescentColor\":0,\"modTurbo\":false,\"modAPlate\":-1,\"color2\":6,\"bodyHealth\":1000.0,\"modGrille\":-1,\"modSeats\":-1,\"modSuspension\":-1,\"doors\":[false,false,false,false,false,false],\"modHorns\":-1,\"health\":1000,\"modFrame\":-1,\"modArmor\":-1,\"modShifterLeavers\":-1,\"plate\":\"NUG 310\",\"modSpoilers\":-1,\"tyres\":[false,false,false,false,false,false,false],\"plateIndex\":0,\"wheelColor\":112,\"svijetlaColor\":255,\"modTank\":-1,\"modFender\":-1,\"modVanityPlate\":-1,\"tyreSmokeColor\":[255,255,255],\"modAerials\":-1,\"modBackWheels\":-1,\"modTrimB\":-1,\"modTransmission\":-1,\"neonEnabled\":[false,false,false,false],\"modEngineBlock\":-1,\"extras\":[],\"modSpeakers\":-1,\"modArchCover\":-1,\"color1\":27,\"modTrunk\":-1,\"modExhaust\":-1,\"modHydrolic\":-1,\"modEngine\":-1,\"modAirFilter\":-1,\"modXenon\":false,\"modRightFender\":-1,\"modSmokeEnabled\":false,\"modRoof\":-1,\"modBrakes\":-1,\"modDoorSpeaker\":-1,\"dirtLevel\":0.0,\"modPlateHolder\":-1,\"modTrimA\":-1,\"windowTint\":-1,\"modDashboard\":-1,\"modRearBumper\":-1,\"modHood\":-1,\"wheels\":1,\"model\":1352183536,\"fuel\":59.62200164794922,\"modWindows\":-1,\"modFrontWheels\":-1,\"modLivery\":-1,\"engineHealth\":1000.0,\"modStruts\":-1,\"modDial\":-1,\"neonColor\":[255,0,255],\"modOrnaments\":-1,\"modSteeringWheel\":-1}', 'car', NULL, 0, 0, 1, 0, '1352183536', 0, 0, NULL, 0, 30, 0, NULL),
(10000, 1, 'NUO 048', '{\"modSideSkirt\":-1,\"modFrontBumper\":-1,\"pearlescentColor\":4,\"modTurbo\":false,\"modAPlate\":-1,\"color2\":1,\"bodyHealth\":1000.0,\"modGrille\":-1,\"modSeats\":-1,\"modSuspension\":-1,\"doors\":[false,false,false,false,false,false],\"modHorns\":-1,\"health\":1000,\"modFrame\":-1,\"modArmor\":-1,\"modShifterLeavers\":-1,\"plate\":\"NUO 048\",\"modSpoilers\":-1,\"tyres\":[false,false,false,false,false,false,false],\"plateIndex\":1,\"wheelColor\":156,\"svijetlaColor\":255,\"modTank\":-1,\"modFender\":-1,\"modVanityPlate\":-1,\"tyreSmokeColor\":[255,255,255],\"modAerials\":-1,\"modBackWheels\":-1,\"modTrimB\":-1,\"modTransmission\":-1,\"neonEnabled\":[false,false,false,false],\"modEngineBlock\":-1,\"extras\":{\"1\":false,\"3\":false,\"2\":true},\"modSpeakers\":-1,\"modArchCover\":-1,\"color1\":1,\"modTrunk\":-1,\"modExhaust\":-1,\"modHydrolic\":-1,\"modEngine\":-1,\"modAirFilter\":-1,\"modXenon\":false,\"modRightFender\":-1,\"modSmokeEnabled\":false,\"modRoof\":-1,\"modBrakes\":-1,\"modDoorSpeaker\":-1,\"dirtLevel\":0.0,\"modPlateHolder\":-1,\"modTrimA\":-1,\"windowTint\":-1,\"modDashboard\":-1,\"modRearBumper\":-1,\"modHood\":-1,\"wheels\":7,\"model\":1469861679,\"fuel\":64.78398132324219,\"modWindows\":-1,\"modFrontWheels\":-1,\"modLivery\":3,\"engineHealth\":1000.0,\"modStruts\":-1,\"modDial\":-1,\"neonColor\":[255,0,255],\"modOrnaments\":-1,\"modSteeringWheel\":-1}', 'car', NULL, 0, 0, 1, 0, '1469861679', 0, 0, NULL, 0, 30, 0, NULL),
(10000, 1, 'OCQ 284', '{\"modSmokeEnabled\":false,\"modFrontBumper\":-1,\"pearlescentColor\":111,\"modTurbo\":false,\"modAPlate\":-1,\"color2\":6,\"modPlateHolder\":-1,\"modGrille\":-1,\"modSeats\":-1,\"modSuspension\":-1,\"doors\":[false,false,false,false,false,false],\"modDashboard\":-1,\"health\":1000,\"modFrame\":-1,\"modArmor\":-1,\"modShifterLeavers\":-1,\"plate\":\"OCQ 284\",\"modSpoilers\":-1,\"tyres\":[false,false,false,false,false,false,false],\"plateIndex\":0,\"wheelColor\":156,\"svijetlaColor\":255,\"modTank\":-1,\"modSteeringWheel\":-1,\"modVanityPlate\":-1,\"tyreSmokeColor\":[255,255,255],\"modAerials\":-1,\"modBackWheels\":-1,\"modTrimB\":-1,\"modTransmission\":-1,\"neonEnabled\":[false,false,false,false],\"modEngineBlock\":-1,\"extras\":{\"1\":false,\"8\":false,\"3\":true,\"2\":false,\"5\":false,\"4\":false,\"7\":false,\"9\":false},\"modSpeakers\":-1,\"modArchCover\":-1,\"color1\":6,\"modTrunk\":-1,\"modExhaust\":-1,\"modHydrolic\":-1,\"modEngine\":-1,\"modAirFilter\":-1,\"modXenon\":false,\"dirtLevel\":0.0,\"modBrakes\":-1,\"modRoof\":-1,\"modRightFender\":-1,\"modHood\":-1,\"bodyHealth\":1000.0,\"modTrimA\":-1,\"neonColor\":[255,0,255],\"windowTint\":-1,\"modDoorSpeaker\":-1,\"wheels\":7,\"modFender\":-1,\"modHorns\":-1,\"model\":-243837818,\"fuel\":64.97000122070313,\"modRearBumper\":-1,\"modFrontWheels\":-1,\"modWindows\":-1,\"modLivery\":0,\"modStruts\":-1,\"modDial\":-1,\"engineHealth\":1000.0,\"modSideSkirt\":-1,\"modOrnaments\":-1}', 'car', NULL, 0, 0, 1, 0, '-243837818', 4.243, 0, NULL, 0, 30, 0, NULL),
(10000, 1, 'PQL 575', '{\"modSideSkirt\":-1,\"modFrontBumper\":-1,\"pearlescentColor\":111,\"modTurbo\":false,\"modAPlate\":-1,\"color2\":0,\"bodyHealth\":1000.0,\"modGrille\":-1,\"modSeats\":-1,\"modSuspension\":-1,\"doors\":[false,false,false,false,false,false],\"modHorns\":-1,\"health\":1000,\"modFrame\":-1,\"modArmor\":-1,\"modShifterLeavers\":-1,\"plate\":\"PQL 575\",\"modSpoilers\":-1,\"tyres\":[false,false,false,false,false,false,false],\"plateIndex\":2,\"wheelColor\":156,\"svijetlaColor\":255,\"modTank\":-1,\"modFender\":-1,\"modVanityPlate\":-1,\"tyreSmokeColor\":[255,255,255],\"modAerials\":-1,\"modBackWheels\":-1,\"modTrimB\":-1,\"modTransmission\":-1,\"neonEnabled\":[false,false,false,false],\"modEngineBlock\":-1,\"extras\":{\"1\":true,\"3\":false,\"2\":true,\"5\":true,\"4\":true},\"modSpeakers\":-1,\"modArchCover\":-1,\"color1\":5,\"modTrunk\":-1,\"modExhaust\":-1,\"modHydrolic\":-1,\"modEngine\":-1,\"modAirFilter\":-1,\"modXenon\":false,\"modRightFender\":-1,\"modSmokeEnabled\":false,\"modRoof\":-1,\"modBrakes\":-1,\"modDoorSpeaker\":-1,\"dirtLevel\":0.0,\"modPlateHolder\":-1,\"modTrimA\":-1,\"windowTint\":-1,\"modDashboard\":-1,\"modRearBumper\":-1,\"modHood\":-1,\"wheels\":2,\"model\":-2147282465,\"fuel\":64.53800201416016,\"modWindows\":-1,\"modFrontWheels\":-1,\"modLivery\":0,\"engineHealth\":1000.0,\"modStruts\":-1,\"modDial\":-1,\"neonColor\":[255,0,255],\"modOrnaments\":-1,\"modSteeringWheel\":-1}', 'car', NULL, 0, 0, 1, 0, '-2147282465', 0, 0, NULL, 0, 30, 0, NULL),
(10000, 1, 'PSO 533', '{\"modSideSkirt\":-1,\"modFrontBumper\":-1,\"pearlescentColor\":4,\"modTurbo\":false,\"modAPlate\":-1,\"color2\":12,\"bodyHealth\":1000.0,\"modGrille\":-1,\"modSeats\":-1,\"modSuspension\":-1,\"doors\":[false,false,false,false,false,false],\"modHorns\":-1,\"health\":1000,\"modFrame\":-1,\"modArmor\":-1,\"modShifterLeavers\":-1,\"plate\":\"PSO 533\",\"modSpoilers\":-1,\"tyres\":[false,false,false,false,false,false,false],\"plateIndex\":3,\"wheelColor\":156,\"svijetlaColor\":255,\"modTank\":-1,\"modFender\":-1,\"modVanityPlate\":-1,\"tyreSmokeColor\":[255,255,255],\"modAerials\":-1,\"modBackWheels\":-1,\"modTrimB\":-1,\"modTransmission\":-1,\"neonEnabled\":[false,false,false,false],\"modEngineBlock\":-1,\"extras\":{\"12\":true,\"4\":true,\"11\":false,\"10\":false},\"modSpeakers\":-1,\"modArchCover\":-1,\"color1\":4,\"modTrunk\":-1,\"modExhaust\":-1,\"modHydrolic\":-1,\"modEngine\":-1,\"modAirFilter\":-1,\"modXenon\":false,\"modRightFender\":-1,\"modSmokeEnabled\":false,\"modRoof\":-1,\"modBrakes\":-1,\"modDoorSpeaker\":-1,\"dirtLevel\":0.0,\"modPlateHolder\":-1,\"modTrimA\":-1,\"windowTint\":-1,\"modDashboard\":-1,\"modRearBumper\":-1,\"modHood\":-1,\"wheels\":5,\"model\":336238405,\"fuel\":49.82003021240234,\"modWindows\":-1,\"modFrontWheels\":-1,\"modLivery\":-1,\"engineHealth\":1000.0,\"modStruts\":-1,\"modDial\":-1,\"neonColor\":[255,0,255],\"modOrnaments\":-1,\"modSteeringWheel\":-1}', 'car', NULL, 0, 0, 1, 0, '336238405', 0, 0, NULL, 0, 30, 0, NULL),
(10000, 1, 'QCA 555', '{\"modSideSkirt\":-1,\"modFrontBumper\":-1,\"pearlescentColor\":0,\"modTurbo\":false,\"modAPlate\":-1,\"color2\":100,\"bodyHealth\":1000.0,\"modGrille\":-1,\"modSeats\":-1,\"modSuspension\":-1,\"doors\":[false,false,false,false,false,false],\"modHorns\":-1,\"health\":1000,\"modFrame\":-1,\"modArmor\":-1,\"modShifterLeavers\":-1,\"plate\":\"QCA 555\",\"modSpoilers\":-1,\"tyres\":[false,false,false,false,false,false,false],\"plateIndex\":1,\"wheelColor\":103,\"svijetlaColor\":255,\"modTank\":-1,\"modFender\":-1,\"modVanityPlate\":-1,\"tyreSmokeColor\":[255,255,255],\"modAerials\":-1,\"modBackWheels\":-1,\"modTrimB\":-1,\"modTransmission\":-1,\"neonEnabled\":[false,false,false,false],\"modEngineBlock\":-1,\"extras\":{\"12\":false},\"modSpeakers\":-1,\"modArchCover\":-1,\"color1\":100,\"modTrunk\":-1,\"modExhaust\":-1,\"modHydrolic\":-1,\"modEngine\":-1,\"modAirFilter\":-1,\"modXenon\":false,\"modRightFender\":-1,\"modSmokeEnabled\":false,\"modRoof\":-1,\"modBrakes\":-1,\"modDoorSpeaker\":-1,\"dirtLevel\":0.0,\"modPlateHolder\":-1,\"modTrimA\":-1,\"windowTint\":-1,\"modDashboard\":-1,\"modRearBumper\":-1,\"modHood\":-1,\"wheels\":0,\"model\":-1825007226,\"fuel\":64.88006591796875,\"modWindows\":-1,\"modFrontWheels\":-1,\"modLivery\":-1,\"engineHealth\":1000.0,\"modStruts\":-1,\"modDial\":-1,\"neonColor\":[255,0,255],\"modOrnaments\":-1,\"modSteeringWheel\":-1}', 'car', NULL, 0, 0, 1, 0, '-1825007226', 0, 0, NULL, 0, 30, 0, NULL),
(10000, 1, 'RAV 323', '{\"modSideSkirt\":-1,\"modFrontBumper\":-1,\"pearlescentColor\":112,\"modTurbo\":false,\"modAPlate\":-1,\"color2\":31,\"bodyHealth\":1000.0,\"modGrille\":-1,\"modSeats\":-1,\"modSuspension\":-1,\"doors\":[false,false,false,false,false,false],\"modHorns\":-1,\"health\":1000,\"modFrame\":-1,\"modArmor\":-1,\"modShifterLeavers\":-1,\"plate\":\"RAV 323\",\"modSpoilers\":-1,\"tyres\":[false,false,false,false,false,false,false],\"plateIndex\":4,\"wheelColor\":0,\"svijetlaColor\":255,\"modTank\":-1,\"modFender\":-1,\"modVanityPlate\":-1,\"tyreSmokeColor\":[255,255,255],\"modAerials\":-1,\"modBackWheels\":-1,\"modTrimB\":-1,\"modTransmission\":-1,\"neonEnabled\":[false,false,false,false],\"modEngineBlock\":-1,\"extras\":[],\"modSpeakers\":-1,\"modArchCover\":-1,\"color1\":4,\"modTrunk\":-1,\"modExhaust\":-1,\"modHydrolic\":-1,\"modEngine\":-1,\"modAirFilter\":-1,\"modXenon\":false,\"modRightFender\":-1,\"modSmokeEnabled\":false,\"modRoof\":-1,\"modBrakes\":-1,\"modDoorSpeaker\":-1,\"dirtLevel\":0.0,\"modPlateHolder\":-1,\"modTrimA\":-1,\"windowTint\":-1,\"modDashboard\":-1,\"modRearBumper\":-1,\"modHood\":-1,\"wheels\":1,\"model\":-526983904,\"fuel\":59.53800201416015,\"modWindows\":-1,\"modFrontWheels\":-1,\"modLivery\":1,\"engineHealth\":1000.0,\"modStruts\":-1,\"modDial\":-1,\"neonColor\":[255,0,255],\"modOrnaments\":-1,\"modSteeringWheel\":-1}', 'car', NULL, 0, 0, 1, 0, '-526983904', 0, 0, NULL, 0, 30, 0, NULL),
(10000, 1, 'RGS 911', '{\"modSideSkirt\":-1,\"modFrontBumper\":-1,\"pearlescentColor\":0,\"modTurbo\":false,\"modAPlate\":-1,\"color2\":111,\"bodyHealth\":1000.0,\"modGrille\":-1,\"modSeats\":-1,\"modSuspension\":-1,\"doors\":[false,false,false,false,false,false],\"modHorns\":-1,\"health\":1000,\"modFrame\":-1,\"modArmor\":-1,\"modShifterLeavers\":-1,\"plate\":\"RGS 911\",\"modSpoilers\":-1,\"tyres\":[false,false,false,false,false,false,false],\"plateIndex\":3,\"wheelColor\":68,\"svijetlaColor\":255,\"modTank\":-1,\"modFender\":-1,\"modVanityPlate\":-1,\"tyreSmokeColor\":[255,255,255],\"modAerials\":-1,\"modBackWheels\":-1,\"modTrimB\":-1,\"modTransmission\":-1,\"neonEnabled\":[false,false,false,false],\"modEngineBlock\":-1,\"extras\":{\"1\":false,\"2\":true,\"12\":false,\"11\":false,\"10\":true},\"modSpeakers\":-1,\"modArchCover\":-1,\"color1\":67,\"modTrunk\":-1,\"modExhaust\":-1,\"modHydrolic\":-1,\"modEngine\":-1,\"modAirFilter\":-1,\"modXenon\":false,\"modRightFender\":-1,\"modSmokeEnabled\":false,\"modRoof\":-1,\"modBrakes\":-1,\"modDoorSpeaker\":-1,\"dirtLevel\":0.0,\"modPlateHolder\":-1,\"modTrimA\":-1,\"windowTint\":-1,\"modDashboard\":-1,\"modRearBumper\":-1,\"modHood\":-1,\"wheels\":2,\"model\":640012156,\"fuel\":64.73400115966797,\"modWindows\":-1,\"modFrontWheels\":-1,\"modLivery\":-1,\"engineHealth\":1000.0,\"modStruts\":-1,\"modDial\":-1,\"neonColor\":[255,0,255],\"modOrnaments\":-1,\"modSteeringWheel\":-1}', 'car', NULL, 0, 0, 1, 0, '640012156', 0.014, 0, NULL, 0, 30, 0, NULL),
(10000, 0, 'SGA 921', '{\"modSideSkirt\":-1,\"modFrontBumper\":-1,\"pearlescentColor\":0,\"modTurbo\":false,\"modAPlate\":-1,\"color2\":138,\"bodyHealth\":1000.0,\"modGrille\":-1,\"modSeats\":-1,\"modSuspension\":-1,\"doors\":[false,false,false,false,false,false],\"modHorns\":-1,\"health\":1000,\"modFrame\":-1,\"modArmor\":-1,\"modShifterLeavers\":-1,\"plate\":\"SGA 921\",\"modSpoilers\":-1,\"tyres\":[false,false,false,false,false,false,false],\"plateIndex\":5,\"wheelColor\":156,\"svijetlaColor\":255,\"modTank\":-1,\"modFender\":-1,\"modVanityPlate\":-1,\"tyreSmokeColor\":[255,255,255],\"modAerials\":-1,\"modBackWheels\":-1,\"modTrimB\":-1,\"modTransmission\":-1,\"neonEnabled\":[false,false,false,false],\"modEngineBlock\":-1,\"extras\":{\"12\":true},\"modSpeakers\":-1,\"modArchCover\":-1,\"color1\":138,\"modTrunk\":-1,\"modExhaust\":-1,\"modHydrolic\":-1,\"modEngine\":-1,\"modAirFilter\":-1,\"modXenon\":false,\"modRightFender\":-1,\"modSmokeEnabled\":false,\"modRoof\":-1,\"modBrakes\":-1,\"modDoorSpeaker\":-1,\"dirtLevel\":0.0,\"modPlateHolder\":-1,\"modTrimA\":-1,\"windowTint\":-1,\"modDashboard\":-1,\"modRearBumper\":-1,\"modHood\":-1,\"wheels\":0,\"model\":1462416745,\"fuel\":64.92204284667969,\"modWindows\":-1,\"modFrontWheels\":-1,\"modLivery\":0,\"engineHealth\":1000.0,\"modStruts\":-1,\"modDial\":-1,\"neonColor\":[255,0,255],\"modOrnaments\":-1,\"modSteeringWheel\":-1}', 'car', NULL, 0, 0, 1, 0, '1462416745', 0.124, 0, NULL, 0, 30, 0, NULL),
(10000, 1, 'SKE 718', '{\"modSideSkirt\":-1,\"modFrontBumper\":-1,\"pearlescentColor\":4,\"modTurbo\":false,\"modAPlate\":-1,\"color2\":51,\"bodyHealth\":1000.0,\"modGrille\":-1,\"modSeats\":-1,\"modSuspension\":-1,\"doors\":[false,false,false,false,false,false],\"modHorns\":-1,\"health\":1000,\"modFrame\":-1,\"modArmor\":-1,\"modShifterLeavers\":-1,\"plate\":\"SKE 718\",\"modSpoilers\":-1,\"tyres\":[false,false,false,false,false,false,false],\"plateIndex\":4,\"wheelColor\":105,\"svijetlaColor\":255,\"modTank\":-1,\"modFender\":-1,\"modVanityPlate\":-1,\"tyreSmokeColor\":[255,255,255],\"modAerials\":-1,\"modBackWheels\":-1,\"modTrimB\":-1,\"modTransmission\":-1,\"neonEnabled\":[false,false,false,false],\"modEngineBlock\":-1,\"extras\":{\"12\":false,\"7\":true,\"2\":true},\"modSpeakers\":-1,\"modArchCover\":-1,\"color1\":51,\"modTrunk\":-1,\"modExhaust\":-1,\"modHydrolic\":-1,\"modEngine\":-1,\"modAirFilter\":-1,\"modXenon\":false,\"modRightFender\":-1,\"modSmokeEnabled\":false,\"modRoof\":-1,\"modBrakes\":-1,\"modDoorSpeaker\":-1,\"dirtLevel\":0.0,\"modPlateHolder\":-1,\"modTrimA\":-1,\"windowTint\":-1,\"modDashboard\":-1,\"modRearBumper\":-1,\"modHood\":-1,\"wheels\":2,\"model\":545326235,\"fuel\":64.8699722290039,\"modWindows\":-1,\"modFrontWheels\":-1,\"modLivery\":-1,\"engineHealth\":1000.0,\"modStruts\":-1,\"modDial\":-1,\"neonColor\":[255,0,255],\"modOrnaments\":-1,\"modSteeringWheel\":-1}', 'car', NULL, 0, 0, 1, 0, '545326235', 0, 0, NULL, 0, 30, 0, NULL),
(10000, 1, 'SRX 150', '{\"modAirFilter\":-1,\"doors\":[false,false,false,false,false,false],\"extras\":{\"12\":false,\"10\":false,\"11\":true},\"modSteeringWheel\":-1,\"modWindows\":-1,\"modStruts\":-1,\"modOrnaments\":-1,\"modDial\":-1,\"modExhaust\":-1,\"wheels\":2,\"plate\":\"SRX 150\",\"modPlateHolder\":-1,\"svijetlaColor\":255,\"modHydrolic\":-1,\"color1\":4,\"modSideSkirt\":-1,\"color2\":12,\"modTrimB\":-1,\"modSuspension\":-1,\"modSeats\":-1,\"health\":996,\"modAPlate\":-1,\"pearlescentColor\":4,\"windowTint\":-1,\"neonColor\":[255,0,255],\"modFrame\":-1,\"bodyHealth\":996.75,\"model\":-58956387,\"tyres\":[false,false,false,false,false,false,false],\"modFender\":-1,\"modArmor\":-1,\"dirtLevel\":0.06516183167695,\"modBrakes\":-1,\"modRightFender\":-1,\"modSpoilers\":-1,\"modSmokeEnabled\":1,\"modXenon\":false,\"modFrontBumper\":-1,\"modLivery\":-1,\"modGrille\":-1,\"modFrontWheels\":-1,\"modBackWheels\":-1,\"modHorns\":-1,\"modRoof\":-1,\"modTrimA\":-1,\"plateIndex\":3,\"modRearBumper\":-1,\"modVanityPlate\":-1,\"engineHealth\":995.875,\"wheelColor\":156,\"tyreSmokeColor\":[255,255,255],\"modTransmission\":-1,\"modSpeakers\":-1,\"modDoorSpeaker\":-1,\"modDashboard\":-1,\"modHood\":-1,\"fuel\":64.04922485351563,\"modEngine\":-1,\"modTank\":-1,\"modTrunk\":-1,\"neonEnabled\":[false,false,false,false],\"modAerials\":-1,\"modShifterLeavers\":-1,\"modEngineBlock\":-1,\"modArchCover\":-1,\"modTurbo\":false}', 'car', NULL, 0, 0, 1, 0, '-58956387', 0.307, 0, NULL, 0, 30, 0, NULL),
(10000, 1, 'UWX 023', '{\"modHood\":-1,\"modRightFender\":-1,\"modStruts\":-1,\"modWindows\":-1,\"modRoof\":-1,\"modFrontWheels\":-1,\"tyres\":[false,false,false,false,false,false,false],\"modBackWheels\":-1,\"modDial\":-1,\"modSpoilers\":-1,\"modXenon\":false,\"modSpeakers\":-1,\"color1\":0,\"engineHealth\":998.875,\"modSideSkirt\":-1,\"modFrame\":-1,\"modGrille\":-1,\"modArchCover\":-1,\"doors\":[false,false,false,false,false,false],\"wheels\":0,\"modFender\":-1,\"modTurbo\":false,\"neonColor\":[255,0,255],\"bodyHealth\":999.25,\"modDoorSpeaker\":-1,\"modSeats\":-1,\"modAerials\":-1,\"modTransmission\":-1,\"modSmokeEnabled\":1,\"modEngineBlock\":-1,\"tyreSmokeColor\":[255,255,255],\"modAirFilter\":-1,\"health\":1000,\"modHorns\":-1,\"svijetlaColor\":255,\"neonEnabled\":[false,false,false,false],\"windowTint\":-1,\"color2\":0,\"wheelColor\":4,\"extras\":{\"4\":false,\"1\":true,\"2\":false,\"3\":false},\"modTrimB\":-1,\"modRearBumper\":-1,\"modExhaust\":-1,\"modShifterLeavers\":-1,\"modTrimA\":-1,\"modSteeringWheel\":-1,\"modFrontBumper\":-1,\"modArmor\":-1,\"modPlateHolder\":-1,\"modEngine\":-1,\"modTrunk\":-1,\"modBrakes\":-1,\"modOrnaments\":-1,\"modSuspension\":-1,\"dirtLevel\":0.25937604904174,\"modTank\":-1,\"modDashboard\":-1,\"model\":2057197469,\"plate\":\"UWX 023\",\"modAPlate\":-1,\"modVanityPlate\":-1,\"fuel\":59.4209976196289,\"modHydrolic\":-1,\"pearlescentColor\":0,\"modLivery\":0,\"plateIndex\":3}', 'car', NULL, 0, 0, 1, 0, '2057197469', 3.89, 0, 'ta019b58', 0, 30, 0, NULL),
(10000, 1, 'VKS 585', '{\"modSuspension\":-1,\"modXenon\":false,\"modRightFender\":-1,\"modBackWheels\":-1,\"wheels\":1,\"modTank\":-1,\"dirtLevel\":0.91369575262069,\"modSpeakers\":-1,\"bodyHealth\":995.0,\"plate\":\"VKS 585\",\"modEngine\":-1,\"modWindows\":-1,\"modSpoilers\":-1,\"neonEnabled\":[false,false,false,false],\"modFrontBumper\":-1,\"modSeats\":-1,\"engineHealth\":840.63232421875,\"modSteeringWheel\":-1,\"modAirFilter\":-1,\"modTrimA\":-1,\"modSmokeEnabled\":1,\"fuel\":37.3930549621582,\"modGrille\":-1,\"modFender\":-1,\"pearlescentColor\":68,\"color1\":0,\"modStruts\":-1,\"modLivery\":2,\"doors\":[false,false,false,false,false,false],\"modDial\":-1,\"modDoorSpeaker\":-1,\"modAPlate\":-1,\"modBrakes\":-1,\"color2\":0,\"svijetlaColor\":255,\"extras\":{\"6\":false,\"4\":false,\"5\":false,\"2\":false,\"3\":true,\"1\":false},\"plateIndex\":1,\"neonColor\":[255,0,255],\"modTurbo\":false,\"modRearBumper\":-1,\"modHood\":-1,\"modEngineBlock\":-1,\"modFrontWheels\":-1,\"modTransmission\":-1,\"health\":997,\"modFrame\":-1,\"modRoof\":-1,\"modTrunk\":-1,\"modArmor\":-1,\"model\":-1066214505,\"modTrimB\":-1,\"modExhaust\":-1,\"windowTint\":0,\"modVanityPlate\":-1,\"modAerials\":-1,\"tyreSmokeColor\":[255,255,255],\"modSideSkirt\":-1,\"modOrnaments\":-1,\"modArchCover\":-1,\"modPlateHolder\":-1,\"modHorns\":-1,\"wheelColor\":0,\"modShifterLeavers\":-1,\"modDashboard\":-1,\"tyres\":[false,false,false,false,false,false,false],\"modHydrolic\":-1}', 'car', NULL, 0, 0, 1, 0, '-1066214505', 4.506, 0, NULL, 0, 26534, 0, 'Alfa Giulia Sprint');
INSERT INTO `owned_vehicles` (`owner`, `state`, `plate`, `vehicle`, `type`, `job`, `stored`, `lasthouse`, `mjenjac`, `brod`, `model`, `kilometri`, `stage`, `motor`, `zracni`, `servis`, `kvar`, `naziv`) VALUES
(10000, 1, 'WZK 607', '{\"modSideSkirt\":-1,\"modFrontBumper\":-1,\"pearlescentColor\":29,\"modTurbo\":false,\"modAPlate\":-1,\"color2\":29,\"bodyHealth\":1000.0,\"modGrille\":-1,\"modSeats\":-1,\"modSuspension\":-1,\"doors\":[false,false,false,false,false,false],\"modHorns\":-1,\"health\":1000,\"modFrame\":-1,\"modArmor\":-1,\"modShifterLeavers\":-1,\"plate\":\"WZK 607\",\"modSpoilers\":-1,\"tyres\":[false,false,false,false,false,false,false],\"plateIndex\":4,\"wheelColor\":29,\"svijetlaColor\":255,\"modTank\":-1,\"modFender\":-1,\"modVanityPlate\":-1,\"tyreSmokeColor\":[255,255,255],\"modAerials\":-1,\"modBackWheels\":-1,\"modTrimB\":-1,\"modTransmission\":-1,\"neonEnabled\":[false,false,false,false],\"modEngineBlock\":-1,\"extras\":{\"8\":true,\"3\":true,\"2\":true,\"5\":true,\"12\":false,\"11\":false,\"4\":true},\"modSpeakers\":-1,\"modArchCover\":-1,\"color1\":29,\"modTrunk\":-1,\"modExhaust\":-1,\"modHydrolic\":-1,\"modEngine\":-1,\"modAirFilter\":-1,\"modXenon\":false,\"modRightFender\":-1,\"modSmokeEnabled\":false,\"modRoof\":-1,\"modBrakes\":-1,\"modDoorSpeaker\":-1,\"dirtLevel\":0.0,\"modPlateHolder\":-1,\"modTrimA\":-1,\"windowTint\":-1,\"modDashboard\":-1,\"modRearBumper\":-1,\"modHood\":-1,\"wheels\":0,\"model\":1152513354,\"fuel\":64.89805603027344,\"modWindows\":-1,\"modFrontWheels\":-1,\"modLivery\":-1,\"engineHealth\":1000.0,\"modStruts\":-1,\"modDial\":-1,\"neonColor\":[255,0,255],\"modOrnaments\":-1,\"modSteeringWheel\":-1}', 'car', NULL, 0, 0, 1, 0, '1152513354', 0, 0, NULL, 0, 30, 0, NULL),
(10000, 0, 'XXF 098', '{\"modSideSkirt\":-1,\"modFrontBumper\":-1,\"pearlescentColor\":0,\"modTurbo\":false,\"modAPlate\":-1,\"color2\":63,\"bodyHealth\":1000.0,\"modGrille\":-1,\"modSeats\":-1,\"modSuspension\":-1,\"doors\":[false,false,false,false,false,false],\"modHorns\":-1,\"health\":1000,\"modFrame\":-1,\"modArmor\":-1,\"modShifterLeavers\":-1,\"plate\":\"XXF 098\",\"modSpoilers\":-1,\"tyres\":[false,false,false,false,false,false,false],\"plateIndex\":1,\"wheelColor\":156,\"svijetlaColor\":255,\"modTank\":-1,\"modFender\":-1,\"modVanityPlate\":-1,\"tyreSmokeColor\":[255,255,255],\"modAerials\":-1,\"modBackWheels\":-1,\"modTrimB\":-1,\"modTransmission\":-1,\"neonEnabled\":[false,false,false,false],\"modEngineBlock\":-1,\"extras\":{\"1\":false,\"12\":true,\"11\":false,\"10\":false},\"modSpeakers\":-1,\"modArchCover\":-1,\"color1\":63,\"modTrunk\":-1,\"modExhaust\":-1,\"modHydrolic\":-1,\"modEngine\":-1,\"modAirFilter\":-1,\"modXenon\":false,\"modRightFender\":-1,\"modSmokeEnabled\":false,\"modRoof\":-1,\"modBrakes\":-1,\"modDoorSpeaker\":-1,\"dirtLevel\":0.0,\"modPlateHolder\":-1,\"modTrimA\":-1,\"windowTint\":-1,\"modDashboard\":-1,\"modRearBumper\":-1,\"modHood\":-1,\"wheels\":5,\"model\":1525524859,\"fuel\":49.96000671386719,\"modWindows\":-1,\"modFrontWheels\":-1,\"modLivery\":-1,\"engineHealth\":1000.0,\"modStruts\":-1,\"modDial\":-1,\"neonColor\":[255,0,255],\"modOrnaments\":-1,\"modSteeringWheel\":-1}', 'car', NULL, 0, 0, 1, 0, '1525524859', 0, 0, NULL, 0, 30, 0, NULL),
(10010, 0, 'YEJ 388', '{\"modSideSkirt\":-1,\"modFrontBumper\":-1,\"pearlescentColor\":0,\"modTurbo\":false,\"modAPlate\":-1,\"color2\":0,\"bodyHealth\":1000.0,\"modGrille\":-1,\"modSeats\":-1,\"modSuspension\":-1,\"doors\":[false,false,false,false,false,false],\"modHorns\":-1,\"health\":1000,\"modFrame\":-1,\"modArmor\":-1,\"modShifterLeavers\":-1,\"plate\":\"YEJ 388\",\"modSpoilers\":-1,\"tyres\":[false,false,false,false,false,false,false],\"plateIndex\":0,\"wheelColor\":0,\"svijetlaColor\":255,\"modTank\":-1,\"modFender\":-1,\"modVanityPlate\":-1,\"tyreSmokeColor\":[255,255,255],\"modAerials\":-1,\"modBackWheels\":-1,\"modTrimB\":-1,\"modTransmission\":-1,\"neonEnabled\":[false,false,false,false],\"modEngineBlock\":-1,\"extras\":{\"12\":false},\"modSpeakers\":-1,\"modArchCover\":-1,\"color1\":0,\"modTrunk\":-1,\"modExhaust\":-1,\"modHydrolic\":-1,\"modEngine\":-1,\"modAirFilter\":-1,\"modXenon\":false,\"modRightFender\":-1,\"modSmokeEnabled\":false,\"modRoof\":-1,\"modBrakes\":-1,\"modDoorSpeaker\":-1,\"dirtLevel\":0.0,\"modPlateHolder\":-1,\"modTrimA\":-1,\"windowTint\":-1,\"modDashboard\":-1,\"modRearBumper\":-1,\"modHood\":-1,\"wheels\":7,\"model\":615801459,\"fuel\":64.80400085449219,\"modWindows\":-1,\"modFrontWheels\":-1,\"modLivery\":-1,\"engineHealth\":1000.0,\"modStruts\":-1,\"modDial\":-1,\"neonColor\":[255,0,255],\"modOrnaments\":-1,\"modSteeringWheel\":-1}', 'car', NULL, 0, 0, 1, 0, '615801459', 0.322, 0, NULL, 0, 30, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `phone_app_chat`
--

DROP TABLE IF EXISTS `phone_app_chat`;
CREATE TABLE IF NOT EXISTS `phone_app_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(20) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `identifier` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `phone_app_chat`
--

INSERT INTO `phone_app_chat` (`id`, `channel`, `message`, `time`, `identifier`) VALUES
(1, 'test', 'test', '2021-04-01 18:37:53', 'steam:110000100242687'),
(2, 'test', 'aaaa', '2021-04-01 18:41:04', 'steam:11000010441bee9'),
(3, 'ulicnetrke', 'aaaa', '2021-04-01 18:41:30', 'steam:11000010441bee9'),
(4, 'ulicnetrke', 'test', '2021-04-01 18:46:32', 'steam:11000010441bee9'),
(5, 'ulicnetrke', 'test', '2021-04-01 18:46:55', 'steam:11000010441bee9'),
(6, 'ulicnetrke', 'opaa', '2021-04-01 18:47:39', 'steam:11000010441bee9'),
(7, 'ulicnetrke', 'ko si ti jbt', '2021-04-01 18:47:43', 'steam:11000010441bee9'),
(8, 'ulicnetrke', 'ko je tebe zvao ovdje', '2021-04-01 18:47:47', 'steam:11000010441bee9'),
(9, 'ulicnetrke', 'otkud tebe majke ti ga nabijem', '2021-04-01 18:47:52', 'steam:11000010441bee9'),
(10, 'test', 'mamaa', '2021-04-01 18:50:00', 'steam:11000010441bee9'),
(11, 'test', 'aaa', '2021-04-01 18:53:42', 'steam:11000010441bee9'),
(12, 'ulicnetrke', 'aaaaaaaa', '2021-04-01 18:54:42', 'steam:11000010441bee9'),
(13, 'ulicnetrke', 'opaaaaa', '2021-04-01 18:55:20', 'steam:11000010441bee9'),
(14, 'test', 'eeeeeee', '2021-04-01 18:55:24', 'steam:11000010441bee9'),
(15, 'novikanal', 'otkud tebe ovdje', '2021-04-01 18:55:31', 'steam:11000010441bee9'),
(16, 'novikanal', 'sta ti ovdje radis koji kurac ono, ko je tebe jebeno zvao ovdjwe', '2021-04-01 18:55:55', 'steam:11000010441bee9'),
(17, 'mama', 'di si', '2021-12-23 11:31:56', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `phone_calls`
--

DROP TABLE IF EXISTS `phone_calls`;
CREATE TABLE IF NOT EXISTS `phone_calls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(10) NOT NULL COMMENT 'Name',
  `num` varchar(10) NOT NULL COMMENT 'Phone Number',
  `incoming` int(11) NOT NULL COMMENT 'Define Incoming Call',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `accepts` int(11) NOT NULL COMMENT 'Accept Call',
  PRIMARY KEY (`id`),
  KEY `owner` (`owner`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `phone_messages`
--

DROP TABLE IF EXISTS `phone_messages`;
CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transmitter` int(11) NOT NULL,
  `receiver` int(11) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `isRead` int(11) NOT NULL DEFAULT 0,
  `owner` int(11) NOT NULL DEFAULT 0,
  `coord` varchar(150) DEFAULT NULL,
  `orgBroj` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `time` (`time`),
  KEY `rec` (`receiver`) USING BTREE,
  KEY `tran` (`transmitter`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=82 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `phone_messages`
--

INSERT INTO `phone_messages` (`id`, `transmitter`, `receiver`, `message`, `time`, `isRead`, `owner`, `coord`, `orgBroj`) VALUES
(81, 9717088, 3555299, 'dobar ', '2022-04-02 11:07:33', 0, 0, NULL, NULL),
(80, 3555299, 9717088, 'Valjal v8', '2022-04-02 11:07:06', 0, 0, NULL, NULL),
(79, 3555299, 9717088, 'Stigli dijelovi', '2022-04-02 11:00:47', 0, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `phone_users_contacts`
--

DROP TABLE IF EXISTS `phone_users_contacts`;
CREATE TABLE IF NOT EXISTS `phone_users_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` int(11) DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  `display` varchar(64) CHARACTER SET utf8mb4 NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`),
  KEY `number` (`number`) USING BTREE,
  KEY `ident` (`identifier`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `phone_users_contacts`
--

INSERT INTO `phone_users_contacts` (`id`, `identifier`, `number`, `display`) VALUES
(5, 10000, 555, 'Sikora 2'),
(8, 10000, 9717088, 'Chame');

-- --------------------------------------------------------

--
-- Table structure for table `poslovi`
--

DROP TABLE IF EXISTS `poslovi`;
CREATE TABLE IF NOT EXISTS `poslovi` (
  `pID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  `whitelisted` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `id` int(255) NOT NULL DEFAULT 1,
  PRIMARY KEY (`name`),
  KEY `whitelisted` (`whitelisted`),
  KEY `pID` (`pID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `poslovi`
--

INSERT INTO `poslovi` (`pID`, `name`, `label`, `whitelisted`, `id`) VALUES
(2, 'farmer', 'Farmer', 0, 1),
(3, 'kamion', 'Kamiondzija', 0, 1),
(4, 'kosac', 'Kosac trave', 0, 0),
(6, 'kran', 'Kranista', 0, 1),
(5, 'luka', 'Lucki radnik', 0, 1),
(1, 'unemployed', 'Nezaposlen', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `praone`
--

DROP TABLE IF EXISTS `praone`;
CREATE TABLE IF NOT EXISTS `praone` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `vlasnik` int(11) DEFAULT NULL,
  `pranje` varchar(255) DEFAULT NULL,
  `koord` varchar(255) DEFAULT NULL,
  `cijena` int(11) DEFAULT NULL,
  `sef` int(11) DEFAULT 0,
  `kcijena` int(11) DEFAULT 0,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `praone`
--

INSERT INTO `praone` (`ID`, `vlasnik`, `pranje`, `koord`, `cijena`, `sef`, `kcijena`) VALUES
(1, NULL, '{\"x\":25.20756912231445,\"y\":-1391.8756103515626,\"z\":28.33451271057129}', '{\"x\":-1.5900136232376,\"y\":-1400.3079833984376,\"z\":28.27205467224121}', 50, 0, 70000),
(2, NULL, '{\"x\":-699.8239135742188,\"y\":-932.6240234375,\"z\":18.01389694213867}', '{\"x\":-703.8509521484375,\"y\":-941.4659423828125,\"z\":18.27253723144531}', 50, 0, 67000),
(3, NULL, '{\"x\":168.01113891601563,\"y\":-1715.1614990234376,\"z\":28.29169845581054}', '{\"x\":167.40232849121095,\"y\":-1709.40869140625,\"z\":28.29169845581054}', 50, 0, 55000);

-- --------------------------------------------------------

--
-- Table structure for table `prijatelji`
--

DROP TABLE IF EXISTS `prijatelji`;
CREATE TABLE IF NOT EXISTS `prijatelji` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `VlasnikID` int(11) NOT NULL,
  `PrijateljID` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `priority`
--

DROP TABLE IF EXISTS `priority`;
CREATE TABLE IF NOT EXISTS `priority` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(100) NOT NULL,
  `power` int(11) NOT NULL,
  `ime` varchar(255) DEFAULT NULL,
  `datum` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `priority`
--

INSERT INTO `priority` (`ID`, `identifier`, `power`, `ime`, `datum`) VALUES
(1, 'steam:110000142bd57ad', 10, 'SaSuKe', '03/15/21 22:39:34'),
(2, 'steam:110000136ababbf', 10, 'KarlitoR1', '03/15/21 22:39:51'),
(3, 'steam:11000013f954fd9', 10, 'MrZenzify', '03/15/21 22:40:05'),
(4, 'steam:1100001423beac6', 10, 'MrZengaa', '03/15/21 22:45:49'),
(5, 'steam:11000013f19f16f', 10, 'Stefuri', '03/15/21 22:46:56'),
(6, 'steam:11000010e76d26f', 10, 'marketinja', '03/15/21 22:47:17'),
(7, 'steam:11000010b4f617b', 10, 'menkavac', '03/15/21 23:03:35'),
(8, 'steam:1100001193a8deb', 10, 'DOM1NO', '03/15/21 23:03:58'),
(9, 'steam:110000117cdb4d1', 10, 'DuLeLega', '03/15/21 23:04:16'),
(10, 'steam:11000013d37140e', 10, 'S3doX', '03/15/21 23:04:33'),
(11, 'steam:110000106cd50b7', 10, 'RATAMATA', '03/15/21 23:04:53'),
(12, 'steam:110000118fe4a37', 10, 'Deni2k', '03/15/21 23:05:06'),
(13, 'steam:11000010818616c', 10, 'TheWitch', '03/15/21 23:05:20'),
(14, 'steam:11000013c4e1c46', 10, 'NBGD', '03/15/21 23:10:00');

-- --------------------------------------------------------

--
-- Table structure for table `pumpe`
--

DROP TABLE IF EXISTS `pumpe`;
CREATE TABLE IF NOT EXISTS `pumpe` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ime` varchar(255) NOT NULL,
  `koord` varchar(255) NOT NULL DEFAULT '{}',
  `vlasnik` int(11) DEFAULT NULL,
  `cijena` int(11) NOT NULL,
  `sef` int(11) NOT NULL,
  `gcijena` double NOT NULL DEFAULT 1.5,
  `kcijena` double NOT NULL DEFAULT 250,
  `gorivo` int(11) NOT NULL DEFAULT 500,
  `narudzba` int(2) NOT NULL DEFAULT 0,
  `dostava` varchar(255) NOT NULL DEFAULT '{}',
  `kapacitet` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pumpe`
--

INSERT INTO `pumpe` (`ID`, `ime`, `koord`, `vlasnik`, `cijena`, `sef`, `gcijena`, `kcijena`, `gorivo`, `narudzba`, `dostava`, `kapacitet`) VALUES
(5, 'Pumpa 1', '{\"x\":288.7102966308594,\"y\":-1266.9971923828126,\"z\":29.44075202941894}', 10000, 1600000, 0, 1.5, 250, 918, 0, '{\"x\":284.2962341308594,\"y\":-1251.5218505859376,\"z\":29.25572204589843}', 1),
(6, 'Pumpa 2', '{\"x\":46.5079116821289,\"y\":2789.208740234375,\"z\":57.87831497192383}', NULL, 600000, 0, 1.5, 250, 500, 0, '{\"x\":65.29000854492188,\"y\":2782.740966796875,\"z\":57.8783073425293}', 0),
(7, 'Pumpa 3', '{\"x\":265.904296875,\"y\":2598.3525390625,\"z\":44.83026885986328}', NULL, 500000, 0, 1.5, 250, 500, 0, '{\"x\":243.4324493408203,\"y\":2599.6689453125,\"z\":45.12274551391601}', 0),
(8, 'Pumpa 4', '{\"x\":1039.33837890625,\"y\":2664.4296875,\"z\":39.55110931396484}', NULL, 700000, 0, 1.5, 250, 500, 0, '{\"x\":1057.305908203125,\"y\":2657.41064453125,\"z\":39.55492782592773}', 0),
(9, 'Pumpa 5', '{\"x\":1204.728759765625,\"y\":2663.441162109375,\"z\":37.80981826782226}', NULL, 700000, 389, 1.5, 250, 500, 0, '{\"x\":1208.5582275390626,\"y\":2642.334228515625,\"z\":37.83019256591797}', 0),
(10, 'Pumpa 6', '{\"x\":2545.087646484375,\"y\":2592.07177734375,\"z\":37.95740509033203}', NULL, 200000, 0, 1.5, 250, 500, 0, '{\"x\":2537.218017578125,\"y\":2587.263427734375,\"z\":37.94486999511719}', 0),
(11, 'Pumpa 7', '{\"x\":2673.765625,\"y\":3267.038330078125,\"z\":55.24057006835937}', NULL, 800000, 0, 1.5, 250, 500, 0, '{\"x\":2685.82470703125,\"y\":3259.474853515625,\"z\":55.24052047729492}', 0),
(12, 'Pumpa 8', '{\"x\":2001.4554443359376,\"y\":3779.962890625,\"z\":32.18083190917969}', NULL, 700000, 0, 1.5, 250, 500, 0, '{\"x\":1985.66357421875,\"y\":3757.26171875,\"z\":32.17351150512695}', 0),
(13, 'Pumpa 9', '{\"x\":1693.9664306640626,\"y\":4924.24267578125,\"z\":42.07815170288086}', NULL, 700000, 54, 1.5, 250, 500, 0, '{\"x\":1699.9659423828126,\"y\":4942.923828125,\"z\":42.1611213684082}', 0),
(14, 'Pumpa 10', '{\"x\":1706.0556640625,\"y\":6425.56298828125,\"z\":32.76841735839844}', NULL, 800000, 0, 1.5, 250, 500, 0, '{\"x\":1685.691650390625,\"y\":6435.3154296875,\"z\":32.35713958740234}', 0),
(15, 'Pumpa 11', '{\"x\":179.8773956298828,\"y\":6602.54345703125,\"z\":31.86820411682129}', NULL, 1000000, 0, 1.5, 250, 500, 0, '{\"x\":201.42800903320313,\"y\":6622.1669921875,\"z\":31.57495498657226}', 0),
(16, 'Pumpa 12', '{\"x\":-92.73368072509766,\"y\":6409.70263671875,\"z\":31.64035034179687}', 10003, 900000, 61, 1.5, 250, 460, 0, '{\"x\":-79.52699279785156,\"y\":6431.9990234375,\"z\":31.49045944213867}', 0),
(17, 'Pumpa 13', '{\"x\":-2544.21923828125,\"y\":2316.140380859375,\"z\":33.21610641479492}', NULL, 1100000, 0, 1.5, 250, 500, 0, '{\"x\":-2544.855224609375,\"y\":2323.4072265625,\"z\":33.0599250793457}', 0),
(18, 'Pumpa 14', '{\"x\":-1801.026611328125,\"y\":804.757080078125,\"z\":138.4710693359375}', NULL, 1200000, 0, 1.5, 250, 500, 0, '{\"x\":-1813.795654296875,\"y\":799.1516723632813,\"z\":138.47694396972657}', 0),
(19, 'Pumpa 15', '{\"x\":-1427.7933349609376,\"y\":-268.3453674316406,\"z\":46.2274169921875}', NULL, 1300000, 1813364, 11, 250, 1000, 0, '{\"x\":-1408.90771484375,\"y\":-276.75555419921877,\"z\":46.37263870239258}', 1),
(20, 'Pumpa 16', '{\"x\":-2073.2041015625,\"y\":-327.2723083496094,\"z\":13.31596565246582}', 10003, 1300000, 90500899, 1000000, 600, 268, 1, '{\"x\":-2064.948974609375,\"y\":-305.96405029296877,\"z\":13.142915725708}', 0),
(21, 'Pumpa 17', '{\"x\":-724.0491333007813,\"y\":-937.43115234375,\"z\":19.03470802307129}', NULL, 1400000, 1901301, 4, 250, 1000, 0, '{\"x\":-711.2090454101563,\"y\":-927.6903686523438,\"z\":19.01409339904785}', 1),
(22, 'Pumpa 18', '{\"x\":-531.4134521484375,\"y\":-1220.990234375,\"z\":18.45499420166015}', NULL, 1100000, 0, 1.5, 250, 500, 0, '{\"x\":-520.8833618164063,\"y\":-1201.466796875,\"z\":18.56760597229004}', 0),
(23, 'Pumpa 19', '{\"x\":-71.19830322265625,\"y\":-1763.1817626953126,\"z\":29.3459243774414}', NULL, 1300000, 0, 1.5, 250, 500, 0, '{\"x\":-62.38230514526367,\"y\":-1745.2607421875,\"z\":29.33869361877441}', 0),
(24, 'Pumpa 20', '{\"x\":818.1276245117188,\"y\":-1040.5389404296876,\"z\":26.75078582763672}', NULL, 1400000, 0, 1.5, 250, 500, 0, '{\"x\":817.4137573242188,\"y\":-1035.2459716796876,\"z\":26.3928050994873}', 0),
(25, 'Pumpa 21', '{\"x\":1211.0872802734376,\"y\":-1389.131591796875,\"z\":35.37686920166015}', NULL, 1200000, 0, 1.5, 250, 500, 0, '{\"x\":1205.057861328125,\"y\":-1406.123291015625,\"z\":35.22417449951172}', 0),
(26, 'Pumpa 22', '{\"x\":1182.912353515625,\"y\":-329.9923095703125,\"z\":69.17447662353516}', NULL, 1400000, 250250, 5, 250, 450, 0, '{\"x\":1173.80419921875,\"y\":-317.5242614746094,\"z\":69.17607879638672}', 0),
(27, 'Pumpa 23', '{\"x\":646.076904296875,\"y\":267.31439208984377,\"z\":103.25042724609375}', NULL, 1500000, 0, 1.5, 250, 500, 0, '{\"x\":638.5718383789063,\"y\":274.66485595703127,\"z\":103.08860778808594}', 0),
(28, 'Pumpa 24', '{\"x\":2559.566650390625,\"y\":373.7714538574219,\"z\":108.62117767333985}', NULL, 1300000, 0, 1.5, 250, 500, 0, '{\"x\":2565.124267578125,\"y\":357.2509765625,\"z\":108.46162414550781}', 0),
(29, 'Pumpa 25', '{\"x\":167.09417724609376,\"y\":-1553.5196533203126,\"z\":29.26177215576172}', NULL, 1200000, 0, 1.5, 250, 500, 0, '{\"x\":173.6867218017578,\"y\":-1553.2872314453126,\"z\":29.21279525756836}', 0),
(30, 'Pumpa 26', '{\"x\":-341.90545654296877,\"y\":-1482.9364013671876,\"z\":30.69084167480468}', NULL, 1200000, 0, 1.5, 250, 500, 0, '{\"x\":-336.7940673828125,\"y\":-1486.441162109375,\"z\":30.59874725341797}', 0),
(31, 'Pumpa 27', '{\"x\":1776.7811279296876,\"y\":3327.733642578125,\"z\":41.4331169128418}', NULL, 800000, 0, 1.5, 250, 500, 0, '{\"x\":1776.112548828125,\"y\":3337.34912109375,\"z\":41.1572380065918}', 0);

-- --------------------------------------------------------

--
-- Table structure for table `qalle_brottsregister`
--

DROP TABLE IF EXISTS `qalle_brottsregister`;
CREATE TABLE IF NOT EXISTS `qalle_brottsregister` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `dateofcrime` varchar(255) NOT NULL,
  `crime` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rent`
--

DROP TABLE IF EXISTS `rent`;
CREATE TABLE IF NOT EXISTS `rent` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ime` varchar(255) DEFAULT NULL,
  `koord` varchar(255) DEFAULT NULL,
  `vlasnik` int(11) DEFAULT NULL,
  `sef` int(11) DEFAULT 0,
  `vozila` longtext DEFAULT NULL,
  `cijena` int(11) DEFAULT 0,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `rent`
--

INSERT INTO `rent` (`ID`, `ime`, `koord`, `vlasnik`, `sef`, `vozila`, `cijena`) VALUES
(10, 'Rent 1', '{\"x\":-1054.64697265625,\"y\":-2650.354736328125,\"z\":13.83067226409912}', NULL, 0, NULL, 77000),
(11, 'Rent 2', '{\"x\":302.8141784667969,\"y\":-1360.2646484375,\"z\":31.82571411132812}', NULL, 0, NULL, 110000),
(12, 'Rent 3', '{\"x\":1875.635986328125,\"y\":2595.276123046875,\"z\":45.67189025878906}', NULL, 0, NULL, 110000),
(13, 'Rent 4', '{\"x\":776.5717163085938,\"y\":-294.40673828125,\"z\":59.89569854736328}', NULL, 0, NULL, 105000);

-- --------------------------------------------------------

--
-- Table structure for table `safezone`
--

DROP TABLE IF EXISTS `safezone`;
CREATE TABLE IF NOT EXISTS `safezone` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ime` varchar(100) NOT NULL,
  `koord` longtext NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `safezone`
--

INSERT INTO `safezone` (`ID`, `ime`, `koord`) VALUES
(10, 'glavna', '[{\"x\":239.93370056152345,\"y\":-820.5496215820313},{\"x\":252.9431610107422,\"y\":-784.9127807617188},{\"x\":258.3884582519531,\"y\":-786.8402709960938},{\"x\":271.971435546875,\"y\":-748.6876831054688},{\"x\":271.0832214355469,\"y\":-748.18896484375},{\"x\":273.9598693847656,\"y\":-740.0704956054688},{\"x\":230.616943359375,\"y\":-725.1278686523438},{\"x\":228.08004760742188,\"y\":-733.128662109375},{\"x\":226.43548583984376,\"y\":-733.0758056640625},{\"x\":200.08319091796876,\"y\":-805.68408203125}]'),
(11, 'autosalon', '[{\"x\":-53.24832153320312,\"y\":-1070.0604248046876},{\"x\":-69.05958557128906,\"y\":-1112.1873779296876},{\"x\":-70.43431854248047,\"y\":-1117.7276611328126},{\"x\":-65.0376968383789,\"y\":-1122.7342529296876},{\"x\":-15.5457592010498,\"y\":-1119.916748046875},{\"x\":-6.6758337020874,\"y\":-1095.316650390625},{\"x\":-9.83181190490722,\"y\":-1094.0692138671876},{\"x\":-7.35445833206176,\"y\":-1087.0889892578126},{\"x\":-4.17888164520263,\"y\":-1087.8802490234376},{\"x\":-1.7010498046875,\"y\":-1081.6832275390626},{\"x\":-19.44866561889648,\"y\":-1075.230224609375},{\"x\":-21.92529106140136,\"y\":-1081.390869140625}]'),
(12, 'bolnica', '[{\"x\":301.5224914550781,\"y\":-580.6475219726563},{\"x\":295.1348571777344,\"y\":-598.2900390625},{\"x\":309.683349609375,\"y\":-603.6087036132813},{\"x\":310.2927551269531,\"y\":-601.929931640625},{\"x\":309.4479675292969,\"y\":-601.6220703125},{\"x\":309.0680236816406,\"y\":-601.9281616210938},{\"x\":308.369384765625,\"y\":-601.5979614257813},{\"x\":309.099609375,\"y\":-599.4801025390625},{\"x\":310.9760437011719,\"y\":-599.8125610351563},{\"x\":310.83624267578127,\"y\":-597.642333984375},{\"x\":309.7562561035156,\"y\":-596.654052734375},{\"x\":307.5167236328125,\"y\":-596.6908569335938},{\"x\":307.11041259765627,\"y\":-595.835693359375},{\"x\":309.0647277832031,\"y\":-595.1116943359375},{\"x\":314.92376708984377,\"y\":-597.0712280273438},{\"x\":315.0846252441406,\"y\":-598.5751342773438},{\"x\":320.0685729980469,\"y\":-600.3942260742188},{\"x\":320.6708984375,\"y\":-599.5848999023438},{\"x\":322.2093200683594,\"y\":-600.088134765625},{\"x\":324.7198181152344,\"y\":-600.4616088867188},{\"x\":326.26629638671877,\"y\":-596.3926391601563},{\"x\":328.18585205078127,\"y\":-590.5992431640625},{\"x\":327.2596740722656,\"y\":-590.041748046875},{\"x\":327.38043212890627,\"y\":-589.4888916015625},{\"x\":340.135009765625,\"y\":-593.9307861328125},{\"x\":340.9674072265625,\"y\":-591.7803344726563},{\"x\":335.1116638183594,\"y\":-589.5942993164063},{\"x\":335.03173828125,\"y\":-588.8463134765625},{\"x\":332.26763916015627,\"y\":-586.6532592773438},{\"x\":335.6513366699219,\"y\":-586.967041015625},{\"x\":337.17486572265627,\"y\":-583.317626953125},{\"x\":337.7951354980469,\"y\":-583.4755249023438},{\"x\":337.6179504394531,\"y\":-584.6915893554688},{\"x\":344.7341613769531,\"y\":-587.3118286132813},{\"x\":343.9301452636719,\"y\":-590.0260620117188},{\"x\":345.3067321777344,\"y\":-591.1328735351563},{\"x\":361.43316650390627,\"y\":-596.2994384765625},{\"x\":362.63665771484377,\"y\":-594.9241333007813},{\"x\":364.3063659667969,\"y\":-595.152099609375},{\"x\":365.3849182128906,\"y\":-594.5413818359375},{\"x\":365.9935302734375,\"y\":-592.6533203125},{\"x\":364.03350830078127,\"y\":-590.7156982421875},{\"x\":364.1548156738281,\"y\":-588.1041259765625},{\"x\":348.8278503417969,\"y\":-581.4805908203125},{\"x\":340.3348693847656,\"y\":-578.9035034179688},{\"x\":339.6134033203125,\"y\":-579.18310546875},{\"x\":339.04205322265627,\"y\":-580.0820922851563},{\"x\":338.374267578125,\"y\":-579.6240844726563},{\"x\":337.8008117675781,\"y\":-579.1429443359375},{\"x\":332.705322265625,\"y\":-577.01953125},{\"x\":335.39794921875,\"y\":-569.6507568359375},{\"x\":333.3100891113281,\"y\":-568.8583374023438},{\"x\":330.5888366699219,\"y\":-576.2100830078125},{\"x\":319.1648254394531,\"y\":-572.3121948242188},{\"x\":318.3216247558594,\"y\":-574.5162963867188},{\"x\":317.1072082519531,\"y\":-580.1129760742188},{\"x\":320.8567810058594,\"y\":-581.556884765625},{\"x\":328.4813232421875,\"y\":-584.4320068359375},{\"x\":328.30682373046877,\"y\":-585.5811767578125},{\"x\":316.16009521484377,\"y\":-581.4279174804688},{\"x\":314.93182373046877,\"y\":-584.6820068359375},{\"x\":323.79595947265627,\"y\":-588.331298828125},{\"x\":323.282958984375,\"y\":-588.7969970703125},{\"x\":315.45391845703127,\"y\":-586.2540893554688},{\"x\":313.95855712890627,\"y\":-588.2510986328125},{\"x\":311.9985656738281,\"y\":-586.8328857421875},{\"x\":312.2513122558594,\"y\":-584.552001953125}]'),
(13, 'zatvor', '[{\"x\":1717.608642578125,\"y\":2620.87939453125},{\"x\":1753.0115966796876,\"y\":2620.19775390625},{\"x\":1752.0853271484376,\"y\":2653.36376953125},{\"x\":1717.3988037109376,\"y\":2652.41357421875}]'),
(14, 'ilegalni_spawn', '[{\"x\":1839.854736328125,\"y\":2520.874267578125},{\"x\":1888.5780029296876,\"y\":2521.9765625},{\"x\":1890.042724609375,\"y\":2688.80517578125},{\"x\":1844.316162109375,\"y\":2685.1474609375}]'),
(15, 'spawn', '[{\"x\":447.3916931152344,\"y\":-665.4242553710938},{\"x\":467.1252136230469,\"y\":-665.395263671875},{\"x\":482.904541015625,\"y\":-577.4111938476563},{\"x\":433.0160827636719,\"y\":-568.398193359375},{\"x\":396.25439453125,\"y\":-621.6254272460938},{\"x\":384.4376220703125,\"y\":-646.1737670898438},{\"x\":383.411376953125,\"y\":-657.136962890625},{\"x\":391.5892028808594,\"y\":-664.6533813476563},{\"x\":417.5921936035156,\"y\":-665.3952026367188}]');

-- --------------------------------------------------------

--
-- Table structure for table `saloni`
--

DROP TABLE IF EXISTS `saloni`;
CREATE TABLE IF NOT EXISTS `saloni` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Ime` varchar(255) NOT NULL,
  `Cijena` int(11) NOT NULL,
  `Vlasnik` int(11) DEFAULT NULL,
  `Kupovina` varchar(255) NOT NULL DEFAULT '{}',
  `Sef` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `saloni_vozila`
--

DROP TABLE IF EXISTS `saloni_vozila`;
CREATE TABLE IF NOT EXISTS `saloni_vozila` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Tablica` varchar(255) NOT NULL,
  `SalonID` int(11) NOT NULL,
  `Cijena` int(11) NOT NULL,
  `Prop` longtext NOT NULL,
  `Model` varchar(255) NOT NULL,
  `Mjenjac` int(11) NOT NULL,
  `Lokacija` varchar(255) NOT NULL DEFAULT '{}',
  `Heading` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `shops`
--

DROP TABLE IF EXISTS `shops`;
CREATE TABLE IF NOT EXISTS `shops` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `store` varchar(100) NOT NULL,
  `item` varchar(100) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `item` (`item`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `shops`
--

INSERT INTO `shops` (`id`, `store`, `item`, `price`) VALUES
(1, 'TwentyFourSeven', 'bread', 7),
(2, 'TwentyFourSeven', 'water', 5),
(8, 'TwentyFourSeven', 'bandage', 50),
(9, 'TwentyFourSeven', 'burek', 10),
(15, 'TwentyFourSeven', 'rakija', 17),
(17, 'TwentyFourSeven', 'pizza', 9),
(18, 'TwentyFourSeven', 'kola', 7),
(23, 'TwentyFourSeven', 'contract', 1),
(27, 'TwentyFourSeven', 'repairkit', 2500),
(64, 'TwentyFourSeven', 'milk', 10),
(73, 'TwentyFourSeven', 'ukosnica', 10),
(76, 'TwentyFourSeven', 'petarde', 10),
(82, 'TwentyFourSeven', 'mobitel', 250),
(99, 'TwentyFourSeven', 'novine', 2),
(101, 'TwentyFourSeven', 'fishingrod', 50),
(102, 'TwentyFourSeven', 'fishbait', 5),
(103, 'Bar', 'beer', 30),
(104, 'Bar', 'wine', 25),
(105, 'Bar', 'vodka', 60),
(106, 'Bar', 'tequila', 40),
(107, 'Bar', 'whisky', 50),
(108, 'Bar', 'cigarett', 30),
(109, 'Bar', 'lighter', 25);

-- --------------------------------------------------------

--
-- Table structure for table `shops2`
--

DROP TABLE IF EXISTS `shops2`;
CREATE TABLE IF NOT EXISTS `shops2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `store` varchar(100) NOT NULL,
  `owner` varchar(60) DEFAULT NULL,
  `sef` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `owstore` (`owner`,`store`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `shops_itemi`
--

DROP TABLE IF EXISTS `shops_itemi`;
CREATE TABLE IF NOT EXISTS `shops_itemi` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `trgovina` varchar(250) NOT NULL,
  `item` varchar(250) NOT NULL,
  `cijena` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `shops_itemi`
--

INSERT INTO `shops_itemi` (`ID`, `trgovina`, `item`, `cijena`) VALUES
(20, 'firma47', 'wine', 30),
(19, 'firma47', 'whisky', 55),
(18, 'firma47', 'vodka', 65),
(17, 'firma47', 'tequila', 45),
(16, 'firma47', 'lighter', 30),
(15, 'firma47', 'cigarett', 35),
(14, 'firma47', 'beer', 55);

-- --------------------------------------------------------

--
-- Table structure for table `truck_inventory`
--

DROP TABLE IF EXISTS `truck_inventory`;
CREATE TABLE IF NOT EXISTS `truck_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item` varchar(100) NOT NULL,
  `itemt` varchar(100) NOT NULL,
  `count` int(11) NOT NULL,
  `plate` varchar(8) NOT NULL,
  `name` varchar(255) NOT NULL,
  `owned` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `item` (`item`,`plate`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `truck_inventory`
--

INSERT INTO `truck_inventory` (`id`, `item`, `itemt`, `count`, `plate`, `name`, `owned`) VALUES
(1, 'gljive', 'item_standard', 5, 'XIB 746 ', 'Gljive', '0'),
(3, 'gljive', 'item_standard', 5, 'LKU 646 ', 'Gljive', '0');

-- --------------------------------------------------------

--
-- Table structure for table `twitter_accounts`
--

DROP TABLE IF EXISTS `twitter_accounts`;
CREATE TABLE IF NOT EXISTS `twitter_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `password` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `avatar_url` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Dumping data for table `twitter_accounts`
--

INSERT INTO `twitter_accounts` (`id`, `username`, `password`, `avatar_url`) VALUES
(1, 'Sikora', 'antonioas123', 'https://media.discordapp.net/attachments/923544204397920256/923551465950298112/screenshot.jpg'),
(2, 'TonyVk', 'antonioas123', 'https://media.discordapp.net/attachments/923544204397920256/923551230393987092/screenshot.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `twitter_likes`
--

DROP TABLE IF EXISTS `twitter_likes`;
CREATE TABLE IF NOT EXISTS `twitter_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) DEFAULT NULL,
  `tweetId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_twitter_likes_twitter_accounts` (`authorId`),
  KEY `FK_twitter_likes_twitter_tweets` (`tweetId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Dumping data for table `twitter_likes`
--

INSERT INTO `twitter_likes` (`id`, `authorId`, `tweetId`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `twitter_tweets`
--

DROP TABLE IF EXISTS `twitter_tweets`;
CREATE TABLE IF NOT EXISTS `twitter_tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) NOT NULL,
  `realUser` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `likes` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FK_twitter_tweets_twitter_accounts` (`authorId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `twitter_tweets`
--

INSERT INTO `twitter_tweets` (`id`, `authorId`, `realUser`, `message`, `time`, `likes`) VALUES
(1, 1, 'steam:11000010441bee9', 'aaaa', '2021-12-23 11:09:27', 1),
(2, 1, 'steam:11000010441bee9', '@Sikora opaaa', '2021-12-23 11:09:33', 0),
(3, 1, 'steam:11000010441bee9', 'https://media.discordapp.net/attachments/817846698671341631/923543947350011914/screenshot.jpg', '2021-12-23 11:53:55', 0),
(4, 1, 'steam:11000010441bee9', 'https://media.discordapp.net/attachments/923544204397920256/923544605524365342/screenshot.jpg', '2021-12-23 11:56:32', 0),
(5, 1, 'steam:11000010441bee9', 'https://media.discordapp.net/attachments/923544204397920256/923548261208444948/screenshot.jpg', '2021-12-23 12:11:04', 0),
(6, 1, 'steam:11000010441bee9', '@Sikora dobar', '2021-12-23 12:11:15', 0),
(7, 1, 'steam:11000010441bee9', 'https://media.discordapp.net/attachments/923544204397920256/923558661505318963/screenshot.jpg', '2021-12-23 12:52:23', 0);

-- --------------------------------------------------------

--
-- Table structure for table `ukradeni`
--

DROP TABLE IF EXISTS `ukradeni`;
CREATE TABLE IF NOT EXISTS `ukradeni` (
  `tablica` varchar(50) NOT NULL,
  `datum` varchar(50) NOT NULL,
  PRIMARY KEY (`tablica`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `license` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `money` int(11) DEFAULT NULL,
  `name` varchar(50) COLLATE utf8mb4_bin DEFAULT '',
  `skin` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `job` int(50) DEFAULT 1,
  `job_grade` int(11) DEFAULT 0,
  `loadout` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `position` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `bank` int(11) DEFAULT NULL,
  `permission_level` int(11) DEFAULT NULL,
  `group` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `phone_number` int(11) DEFAULT NULL,
  `status` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `firstname` varchar(50) COLLATE utf8mb4_bin DEFAULT '',
  `lastname` varchar(50) COLLATE utf8mb4_bin DEFAULT '',
  `dateofbirth` varchar(25) COLLATE utf8mb4_bin DEFAULT '',
  `sex` varchar(10) COLLATE utf8mb4_bin DEFAULT '',
  `height` varchar(5) COLLATE utf8mb4_bin DEFAULT '',
  `jail` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `last_property` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `is_dead` tinyint(1) DEFAULT 0,
  `armour` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `house` longtext COLLATE utf8mb4_bin NOT NULL DEFAULT '{"owns":false,"furniture":[],"houseId":0}',
  `bought_furniture` longtext COLLATE utf8mb4_bin NOT NULL DEFAULT '{}',
  `last_house` int(11) DEFAULT 0,
  `mute` int(11) NOT NULL DEFAULT 0,
  `kpljacka` int(11) NOT NULL DEFAULT 0,
  `zadnji_login` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `kredit` int(100) NOT NULL DEFAULT 0,
  `rata` int(100) NOT NULL DEFAULT 0,
  `brplaca` int(100) NOT NULL DEFAULT 0,
  `lov` int(11) NOT NULL DEFAULT 0,
  `stamina` int(11) NOT NULL DEFAULT 20,
  `vjezbanje` int(11) NOT NULL DEFAULT 0,
  `exp` int(11) NOT NULL DEFAULT 0,
  `level` int(11) NOT NULL DEFAULT 1,
  `posao` int(11) NOT NULL DEFAULT 1,
  `firma` int(11) NOT NULL DEFAULT 0,
  `rentKuca` int(11) DEFAULT NULL,
  `rentDatum` date DEFAULT NULL,
  `tattoos` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`identifier`),
  UNIQUE KEY `phone` (`phone_number`) USING BTREE,
  KEY `ident` (`identifier`),
  KEY `ID` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10012 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`ID`, `identifier`, `license`, `money`, `name`, `skin`, `job`, `job_grade`, `loadout`, `position`, `bank`, `permission_level`, `group`, `phone_number`, `status`, `firstname`, `lastname`, `dateofbirth`, `sex`, `height`, `jail`, `last_property`, `is_dead`, `armour`, `house`, `bought_furniture`, `last_house`, `mute`, `kpljacka`, `zadnji_login`, `kredit`, `rata`, `brplaca`, `lov`, `stamina`, `vjezbanje`, `exp`, `level`, `posao`, `firma`, `rentKuca`, `rentDatum`, `tattoos`) VALUES
(10000, 'steam:11000010441bee9', 'license:23735c7344bc9f32a2137cba6cbd67751184a27f', 300, 'Sikora', '{\"shoes_2\":2,\"blush_1\":0,\"torso_2\":0,\"eye_color\":0,\"beard_4\":0,\"ears_2\":-1,\"bracelets_2\":0,\"eye_squint\":0,\"mask_1\":0,\"cheeks_2\":0,\"makeup_3\":0,\"lipstick_3\":32,\"jaw_2\":0,\"watches_1\":-1,\"chain_2\":0,\"chin_1\":0,\"nose_6\":0,\"bracelets_1\":-1,\"skin\":0,\"decals_2\":0,\"beard_1\":2,\"age_1\":0,\"nose_5\":0,\"bproof_2\":0,\"nose_1\":0,\"chin_3\":0,\"cheeks_1\":0,\"watches_2\":-1,\"dad\":12,\"complexion_2\":0,\"eyebrows_3\":0,\"lipstick_1\":0,\"blush_2\":0,\"beard_3\":61,\"makeup_2\":0,\"skin_md_weight\":50,\"blemishes_1\":0,\"nose_4\":0,\"chin_4\":0,\"eyebrows_2\":10,\"eyebrows_1\":2,\"neck_thickness\":0,\"pants_1\":10,\"hair_color_2\":0,\"cheeks_3\":0,\"hair_1\":0,\"bags_2\":0,\"glasses_2\":1,\"tshirt_2\":0,\"lipstick_2\":0,\"eyebrows_6\":0,\"nose_2\":0,\"chin_2\":0,\"face_md_weight\":50,\"hair_color_1\":0,\"bodyb_2\":0,\"arms_2\":0,\"decals_1\":0,\"sex\":0,\"mask_2\":0,\"nose_3\":0,\"pants_2\":0,\"face\":19,\"chain_1\":0,\"sun_1\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"hair_2\":0,\"chest_2\":0,\"bodyb_1\":0,\"glasses_1\":5,\"age_2\":0,\"eyebrows_5\":0,\"chest_1\":0,\"torso_1\":4,\"makeup_1\":0,\"bproof_1\":0,\"chest_3\":0,\"moles_1\":0,\"moles_2\":0,\"shoes_1\":1,\"blemishes_2\":0,\"mom\":21,\"lipstick_4\":0,\"sun_2\":0,\"helmet_1\":-1,\"complexion_1\":0,\"arms\":1,\"jaw_1\":0,\"tshirt_1\":3,\"bags_1\":0,\"helmet_2\":-1,\"lip_thickness\":0,\"blush_3\":\"2\",\"ears_1\":-1,\"beard_2\":10}', 3, 4, '[]', '{\"x\":142.0,\"y\":-362.8,\"z\":43.2}', -840062, 69, 'superadmin', 3555299, '[{\"name\":\"hunger\",\"percent\":41,\"val\":0},{\"name\":\"thirst\",\"percent\":32,\"val\":0},{\"name\":\"drunk\",\"percent\":0,\"val\":0}]', 'Tony', 'Sikora', '25.9.1998', 'm', '', 0, NULL, 0, 0, '{\"owns\":false,\"houseId\":29,\"furniture\":[{\"object\":\"prop_tv_cabinet_03\",\"offset\":[7.640869140625,3.6422119140625,-2.42674255371093],\"heading\":0.0,\"name\":\"TV Stol\"}]}', '{\"prop_ld_farm_table01\":{\"amount\":1,\"name\":\"Farm Stol 2\"}}', 0, 0, 0, '08/11/2022 21:46:52', 0, 0, 512, 0, 20, 0, 5, 9, 6, 0, NULL, '2022-06-04', '[{\"nameHash\":\"MP_Buis_M_Neck_000\",\"Count\":1,\"collection\":\"mpbusiness_overlays\"}]'),
(10001, 'steam:110000106921eea', 'license:1a17700fb3ebe57d0e8179efdd6e6e1ccb43168b', 0, 'Ficho', '{\"bags_2\":0,\"arms\":0,\"bracelets_2\":0,\"bodyb_1\":0,\"age_2\":0,\"pants_1\":0,\"complexion_2\":0,\"hair_1\":11,\"makeup_4\":0,\"bproof_1\":0,\"torso_1\":6,\"glasses_2\":0,\"makeup_1\":0,\"arms_2\":0,\"eyebrows_3\":0,\"chest_3\":0,\"moles_1\":0,\"helmet_1\":-1,\"torso_2\":0,\"sun_2\":0,\"eyebrows_1\":0,\"chain_2\":0,\"age_1\":0,\"decals_1\":0,\"watches_1\":-1,\"beard_4\":0,\"bodyb_2\":0,\"chain_1\":0,\"complexion_1\":0,\"moles_2\":0,\"glasses_1\":0,\"beard_1\":0,\"beard_3\":0,\"blush_3\":0,\"tshirt_2\":0,\"eyebrows_2\":0,\"makeup_2\":0,\"decals_2\":0,\"hair_2\":4,\"chest_2\":0,\"helmet_2\":0,\"lipstick_3\":0,\"shoes_1\":0,\"blush_2\":0,\"tshirt_1\":24,\"makeup_3\":0,\"blemishes_1\":0,\"eyebrows_4\":0,\"ears_1\":-1,\"mask_1\":0,\"pants_2\":0,\"hair_color_2\":0,\"blemishes_2\":0,\"bproof_2\":0,\"bracelets_1\":-1,\"chest_1\":0,\"hair_color_1\":3,\"eye_color\":0,\"lipstick_4\":0,\"ears_2\":0,\"watches_2\":0,\"blush_1\":0,\"lipstick_1\":0,\"face\":0,\"bags_1\":0,\"shoes_2\":0,\"beard_2\":0,\"sex\":0,\"sun_1\":0,\"skin\":1,\"lipstick_2\":0,\"mask_2\":0}', 1, 0, '[{\"label\":\"Pistol\",\"name\":\"WEAPON_PISTOL\",\"ammo\":250,\"components\":[\"clip_default\"]},{\"label\":\"Micro SMG\",\"name\":\"WEAPON_MICROSMG\",\"ammo\":188,\"components\":[\"clip_default\"]},{\"label\":\"Pump shotgun\",\"name\":\"WEAPON_PUMPSHOTGUN\",\"ammo\":250,\"components\":[]},{\"label\":\"Assault rifle\",\"name\":\"WEAPON_ASSAULTRIFLE\",\"ammo\":250,\"components\":[\"clip_default\"]},{\"label\":\"Sniper rifle\",\"name\":\"WEAPON_SNIPERRIFLE\",\"ammo\":248,\"components\":[\"scope\"]}]', '{\"z\":544.6000000000931,\"y\":-4500.0,\"x\":-502.4000000000233}', 999946950, 69, 'superadmin', 973, '[{\"val\":456000,\"percent\":45.6,\"name\":\"hunger\"},{\"val\":467000,\"percent\":46.7,\"name\":\"thirst\"},{\"val\":0,\"percent\":0.0,\"name\":\"drunk\"}]', 'Filip', 'Wizzy', '19980208', 'm', '180', 0, NULL, 0, 0, '{\"owns\":false,\"furniture\":[],\"houseId\":0}', '{}', 0, 0, 0, '04/11/2021 21:27:40', 0, 0, 17, 0, 20, 0, 5, 2, 1, 0, NULL, NULL, NULL),
(10011, 'steam:11000010a1d1042', 'license:c7a857dcd5b4160c69d1671f02e52332bd339733', 176, 'chame', '{\"mask_1\":0,\"skin\":3,\"watches_1\":-1,\"lipstick_1\":0,\"beard_3\":0,\"eyebrows_4\":0,\"makeup_3\":0,\"beard_1\":0,\"makeup_4\":0,\"makeup_1\":0,\"watches_2\":0,\"sun_2\":0,\"decals_1\":0,\"age_2\":0,\"blush_2\":0,\"shoes_2\":0,\"hair_2\":3,\"bags_1\":0,\"pants_1\":0,\"beard_2\":0,\"complexion_1\":0,\"eyebrows_2\":0,\"torso_2\":0,\"glasses_1\":0,\"helmet_1\":-1,\"blush_1\":0,\"hair_color_2\":1,\"shoes_1\":0,\"arms\":0,\"blemishes_1\":0,\"blemishes_2\":0,\"helmet_2\":0,\"tshirt_1\":1,\"eyebrows_3\":0,\"arms_2\":0,\"beard_4\":0,\"sun_1\":0,\"eyebrows_1\":0,\"moles_2\":0,\"lipstick_2\":0,\"pants_2\":0,\"lipstick_4\":0,\"chain_1\":0,\"bproof_2\":0,\"eye_color\":0,\"decals_2\":0,\"mask_2\":0,\"chest_2\":0,\"ears_2\":0,\"hair_1\":3,\"chain_2\":0,\"sex\":0,\"hair_color_1\":2,\"chest_3\":0,\"bags_2\":0,\"bodyb_2\":0,\"makeup_2\":0,\"moles_1\":0,\"bproof_1\":0,\"glasses_2\":0,\"age_1\":0,\"face\":2,\"bracelets_2\":0,\"ears_1\":-1,\"chest_1\":0,\"lipstick_3\":0,\"bodyb_1\":0,\"blush_3\":0,\"tshirt_2\":0,\"torso_1\":3,\"complexion_2\":0,\"bracelets_1\":-1}', 4, 4, '[]', '{\"x\":5103.2,\"y\":-4835.5,\"z\":8.1}', 100, 69, 'superadmin', 9717088, '[{\"percent\":59,\"val\":0,\"name\":\"hunger\"},{\"percent\":59,\"val\":0,\"name\":\"thirst\"}]', 'Murga', 'Vrtiprah', '2.1.1984', 'z', '', 0, NULL, 0, 0, '{\"owns\":false,\"furniture\":[],\"houseId\":0}', '{}', 0, 0, 0, '02/04/2022 13:54:38', 0, 0, 2, 0, 20, 0, 2, 1, 5, 0, NULL, NULL, NULL),
(10002, 'steam:11000010ad5cf80', 'license:104849bd70250f8f538fb51379f5a4a258f6e960', 0, 'MaZz', '{\"bags_2\":0,\"arms\":0,\"bracelets_2\":0,\"bodyb_1\":0,\"age_2\":0,\"pants_1\":6,\"complexion_2\":0,\"hair_1\":9,\"makeup_4\":0,\"bproof_1\":4,\"torso_1\":0,\"glasses_2\":0,\"makeup_1\":0,\"arms_2\":0,\"eyebrows_3\":0,\"chest_3\":0,\"moles_1\":2,\"helmet_1\":-1,\"torso_2\":0,\"sun_2\":0,\"eyebrows_1\":0,\"chain_2\":0,\"age_1\":0,\"decals_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"bodyb_2\":0,\"chain_1\":0,\"complexion_1\":4,\"pants_2\":0,\"glasses_1\":0,\"beard_1\":0,\"beard_3\":0,\"shoes_2\":0,\"tshirt_2\":2,\"mask_2\":0,\"makeup_2\":0,\"decals_2\":0,\"hair_2\":0,\"chest_2\":0,\"helmet_2\":0,\"lipstick_3\":0,\"shoes_1\":0,\"blush_2\":0,\"tshirt_1\":22,\"chest_1\":0,\"blemishes_1\":0,\"eyebrows_4\":0,\"sun_1\":0,\"mask_1\":0,\"lipstick_4\":0,\"hair_color_2\":0,\"blemishes_2\":0,\"bproof_2\":0,\"moles_2\":0,\"blush_1\":0,\"hair_color_1\":0,\"eye_color\":0,\"makeup_3\":0,\"ears_2\":0,\"watches_2\":0,\"blush_3\":0,\"lipstick_1\":0,\"bags_1\":0,\"ears_1\":-1,\"beard_2\":0,\"watches_1\":-1,\"sex\":0,\"face\":44,\"skin\":2,\"eyebrows_2\":0,\"bracelets_1\":-1}', 1, 0, '[{\"label\":\"Pistol .50\",\"components\":[\"clip_default\"],\"name\":\"WEAPON_PISTOL50\",\"ammo\":130},{\"label\":\"Pump shotgun\",\"components\":[],\"name\":\"WEAPON_PUMPSHOTGUN\",\"ammo\":39},{\"label\":\"Assault rifle\",\"components\":[\"clip_default\"],\"name\":\"WEAPON_ASSAULTRIFLE\",\"ammo\":59},{\"label\":\"Carbine rifle\",\"components\":[\"clip_default\"],\"name\":\"WEAPON_CARBINERIFLE\",\"ammo\":59},{\"label\":\"Advanced rifle\",\"components\":[\"clip_default\"],\"name\":\"WEAPON_ADVANCEDRIFLE\",\"ammo\":59},{\"label\":\"Taser\",\"components\":[],\"name\":\"WEAPON_STUNGUN\",\"ammo\":200},{\"label\":\"Flashlight\",\"components\":[],\"name\":\"WEAPON_FLASHLIGHT\",\"ammo\":0}]', '{\"z\":40.39999999999418,\"y\":3213.4000000003727,\"x\":1569.3999999999069}', 100020599, 69, 'superadmin', 12345, '[{\"val\":994100,\"name\":\"hunger\",\"percent\":99.41},{\"val\":995575,\"name\":\"thirst\",\"percent\":99.5575},{\"val\":0,\"name\":\"drunk\",\"percent\":0.0}]', 'Max', 'Cigarett', '0611199', 'm', '180', 0, NULL, 0, 30, '{\"owns\":false,\"furniture\":[],\"houseId\":0}', '{}', 0, 0, 0, '01/11/2021 22:19:53', 0, 0, 45, 0, 20, 0, 2, 1, 1, 22, NULL, NULL, NULL),
(10003, 'steam:11000010e086b7e', 'license:ebdfe690c597862ea966a6893ad2fe9aaddcc873', 4481549, 'LJANTU', '{\"moles_1\":0,\"sun_1\":0,\"age_2\":0,\"eyebrows_1\":0,\"hair_2\":0,\"chest_2\":0,\"mask_2\":0,\"decals_2\":0,\"bproof_2\":0,\"makeup_3\":0,\"glasses_2\":0,\"eyebrows_2\":0,\"mask_1\":0,\"bodyb_1\":0,\"makeup_1\":0,\"watches_1\":2,\"face\":19,\"makeup_2\":0,\"hair_color_2\":0,\"tshirt_1\":0,\"chest_1\":0,\"shoes_2\":0,\"helmet_2\":0,\"chain_2\":0,\"lipstick_3\":0,\"blemishes_1\":0,\"hair_color_1\":29,\"eye_color\":0,\"shoes\":35,\"torso_2\":0,\"bodyb_2\":0,\"complexion_1\":0,\"sex\":0,\"ears_1\":-1,\"torso_1\":381,\"beard_2\":0,\"moles_2\":0,\"beard_3\":0,\"blush_2\":0,\"blush_1\":0,\"bracelets_2\":0,\"blush_3\":0,\"chest_3\":0,\"hair_1\":22,\"age_1\":0,\"bags_1\":0,\"bags_2\":0,\"shoes_1\":24,\"pants_2\":0,\"lipstick_4\":0,\"chain_1\":0,\"glasses_1\":30,\"blemishes_2\":0,\"bproof_1\":54,\"eyebrows_3\":0,\"eyebrows_4\":0,\"lipstick_1\":0,\"beard_4\":0,\"makeup_4\":0,\"helmet_1\":-1,\"decals_1\":0,\"tshirt_2\":2,\"skin\":18,\"ears_2\":0,\"watches_2\":0,\"arms\":28,\"pants_1\":130,\"lipstick_2\":0,\"bracelets_1\":-1,\"complexion_2\":0,\"arms_2\":0,\"beard_1\":0,\"sun_2\":0}', 3, 4, '[{\"label\":\"Pistol\",\"components\":[\"clip_default\"],\"ammo\":147,\"name\":\"WEAPON_PISTOL\"}]', '{\"z\":29.0,\"x\":-68.7,\"y\":-1722.6}', 99936001, 69, 'superadmin', 5799678, '[{\"percent\":88,\"val\":465400,\"name\":\"hunger\"},{\"percent\":88,\"val\":474050,\"name\":\"thirst\"},{\"percent\":0.0,\"val\":0,\"name\":\"drunk\"}]', 'Tuljan', 'Ljantu', '33333333', 'm', '195', 0, NULL, 0, 100, '{\"owns\":false,\"furniture\":[],\"houseId\":0}', '{}', 0, 0, 0, '20/01/2022 21:03:41', 0, 0, 141, 0, 20, 2, 12, 6, 7, 22, NULL, NULL, NULL),
(10004, 'steam:110000111cd0aa0', 'license:e4090a08909875dbb99f15633c3ec4ef87d9e9f8', 0, 'GABO', '{\"arms\":1,\"makeup_3\":0,\"hair_1\":19,\"ears_1\":-1,\"eye_color\":0,\"arms_2\":0,\"skin\":1,\"beard_1\":0,\"torso_1\":4,\"ears_2\":0,\"bproof_1\":0,\"hair_color_1\":5,\"age_2\":0,\"lipstick_2\":0,\"sun_2\":0,\"age_1\":0,\"eyebrows_2\":0,\"lipstick_3\":0,\"makeup_1\":0,\"blemishes_2\":0,\"watches_1\":-1,\"bodyb_2\":0,\"tshirt_1\":3,\"beard_3\":0,\"sex\":0,\"glasses_2\":0,\"bags_1\":0,\"helmet_1\":-1,\"pants_1\":7,\"watches_2\":0,\"chain_2\":0,\"blemishes_1\":0,\"tshirt_2\":0,\"decals_2\":0,\"chest_3\":0,\"shoes_1\":1,\"shoes_2\":0,\"glasses_1\":0,\"eyebrows_3\":0,\"blush_3\":0,\"makeup_4\":0,\"sun_1\":0,\"bracelets_2\":0,\"helmet_2\":0,\"bags_2\":0,\"moles_2\":0,\"hair_2\":4,\"lipstick_1\":0,\"bracelets_1\":-1,\"beard_2\":0,\"mask_2\":0,\"mask_1\":0,\"face\":12,\"blush_2\":0,\"lipstick_4\":0,\"chain_1\":0,\"beard_4\":0,\"eyebrows_1\":0,\"bproof_2\":0,\"moles_1\":0,\"makeup_2\":0,\"eyebrows_4\":0,\"complexion_2\":0,\"complexion_1\":0,\"torso_2\":3,\"blush_1\":0,\"hair_color_2\":0,\"decals_1\":0,\"chest_1\":0,\"pants_2\":0,\"bodyb_1\":0,\"chest_2\":0}', 1, 0, '[{\"name\":\"WEAPON_MG\",\"label\":\"MG\",\"components\":[\"clip_default\"],\"ammo\":190}]', '{\"z\":68.39999999999418,\"y\":354.5999999999767,\"x\":-1107.3999999999069}', 3035100, 69, 'superadmin', 5375773, '[{\"val\":314000,\"percent\":31.4,\"name\":\"hunger\"},{\"val\":360500,\"percent\":36.05,\"name\":\"thirst\"},{\"val\":0,\"percent\":0.0,\"name\":\"drunk\"}]', 'Daniel', 'Deacon', '03.11.1997', 'm', '180', 0, NULL, 0, 0, '{\"owns\":false,\"furniture\":[],\"houseId\":0}', '{}', 0, 0, 0, '04/11/2021 20:47:33', 0, 0, 16, 0, 20, 0, 1, 2, 1, 0, NULL, NULL, NULL),
(10010, 'steam:11000011aee96e0', 'license:23735c7344bc9f32a2137cba6cbd67751184a27f', 514260, 'hashtag.sikora', '{\"arms_2\":0,\"bodyb_2\":0,\"sex\":0,\"complexion_1\":0,\"eyebrows_2\":0,\"hair_color_2\":0,\"bodyb_1\":0,\"pants_2\":0,\"blush_3\":0,\"lipstick_2\":0,\"watches_1\":-1,\"age_2\":0,\"decals_2\":0,\"bags_2\":0,\"arms\":0,\"decals_1\":0,\"face\":0,\"beard_2\":0,\"lipstick_1\":0,\"blush_1\":0,\"hair_color_1\":0,\"hair_2\":0,\"watches_2\":0,\"chest_1\":0,\"torso_1\":0,\"blemishes_1\":0,\"age_1\":0,\"chain_1\":0,\"bproof_1\":0,\"eyebrows_1\":0,\"tshirt_1\":0,\"glasses_1\":0,\"pants_1\":0,\"mask_1\":0,\"mask_2\":0,\"blemishes_2\":0,\"complexion_2\":0,\"beard_4\":0,\"chest_2\":0,\"chain_2\":0,\"glasses_2\":0,\"bproof_2\":0,\"sun_1\":0,\"makeup_2\":0,\"ears_2\":0,\"torso_2\":0,\"sun_2\":0,\"shoes_2\":0,\"skin\":0,\"shoes_1\":0,\"eyebrows_3\":0,\"eyebrows_4\":0,\"helmet_1\":-1,\"helmet_2\":0,\"ears_1\":-1,\"blush_2\":0,\"bracelets_1\":-1,\"hair_1\":0,\"makeup_1\":0,\"lipstick_4\":0,\"bags_1\":0,\"tshirt_2\":0,\"eye_color\":0,\"beard_3\":0,\"moles_1\":0,\"bracelets_2\":0,\"moles_2\":0,\"makeup_4\":0,\"beard_1\":0,\"makeup_3\":0,\"chest_3\":0,\"lipstick_3\":0}', 3, 1, '[]', '{\"z\":30.6,\"y\":-786.6,\"x\":231.4}', 100, 0, 'user', 555, '[{\"percent\":46,\"name\":\"hunger\",\"val\":0},{\"percent\":0,\"name\":\"thirst\",\"val\":0}]', 'Toni', 'Sikora', '9.3.2022', 'm', '', 0, NULL, 0, 0, '{\"owns\":false,\"furniture\":[],\"houseId\":0}', '{}', 0, 0, 0, '12/06/2022 16:50:59', 0, 0, 5, 0, 20, 0, 1, 2, 1, 0, NULL, '2022-06-04', NULL),
(10009, 'steam:1100001453fc4a4', 'license:28b3a93ce930a76bb21c53788d5a938c86ed7160', 20, '~r~Owner | ~w~Fuezify', '{\"hair_color_2\":0,\"ears_1\":-1,\"makeup_4\":0,\"tshirt_2\":0,\"skin\":2,\"eyebrows_1\":0,\"complexion_2\":0,\"chain_1\":0,\"hair_color_1\":0,\"chest_1\":0,\"hair_1\":12,\"bracelets_1\":-1,\"bags_1\":0,\"blush_1\":0,\"mask_2\":0,\"shoes_1\":0,\"sex\":0,\"makeup_1\":0,\"tshirt_1\":0,\"blemishes_2\":0,\"decals_1\":2,\"watches_2\":0,\"lipstick_3\":0,\"complexion_1\":0,\"chest_3\":0,\"moles_2\":0,\"pants_1\":0,\"bodyb_2\":0,\"helmet_1\":-1,\"mask_1\":0,\"chain_2\":0,\"shoes_2\":0,\"arms_2\":0,\"moles_1\":0,\"lipstick_2\":0,\"pants_2\":0,\"sun_2\":0,\"face\":0,\"blush_2\":0,\"lipstick_1\":0,\"bproof_1\":0,\"arms\":0,\"beard_4\":0,\"blemishes_1\":0,\"torso_1\":0,\"watches_1\":-1,\"helmet_2\":0,\"hair_2\":0,\"bracelets_2\":0,\"decals_2\":0,\"bodyb_1\":0,\"age_2\":0,\"age_1\":0,\"bags_2\":0,\"beard_1\":0,\"torso_2\":0,\"makeup_2\":0,\"bproof_2\":0,\"blush_3\":0,\"beard_2\":0,\"eyebrows_4\":0,\"eyebrows_3\":0,\"eyebrows_2\":0,\"makeup_3\":0,\"lipstick_4\":0,\"sun_1\":0,\"beard_3\":0,\"glasses_1\":0,\"ears_2\":0,\"eye_color\":0,\"chest_2\":0,\"glasses_2\":0}', 1, 0, '[]', '{\"z\":45.7,\"y\":2592.9,\"x\":1882.1}', 100, 0, 'user', 5721548, '[{\"percent\":98,\"val\":0,\"name\":\"hunger\"},{\"percent\":98,\"val\":0,\"name\":\"thirst\"}]', 'Uzzi', 'Owner', '10.11.1111', 'z', '', 0, NULL, 0, 0, '{\"owns\":false,\"furniture\":[],\"houseId\":0}', '{}', 0, 0, 0, '31/01/2022 21:24:24', 0, 0, 0, 0, 20, 0, 0, 1, 1, 0, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_inventory`
--

DROP TABLE IF EXISTS `user_inventory`;
CREATE TABLE IF NOT EXISTS `user_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` int(11) NOT NULL,
  `item` varchar(50) NOT NULL,
  `count` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1400 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_inventory`
--

INSERT INTO `user_inventory` (`id`, `identifier`, `item`, `count`) VALUES
(1, 10000, 'heartpump', 0),
(2, 10000, 'croquettes', 0),
(3, 10000, 'weapon_musket', 0),
(4, 10000, 'moneywash', 0),
(5, 10000, 'clothe', 0),
(6, 10000, 'weapon_minismg', 0),
(7, 10000, 'odznaka', 0),
(8, 10000, 'scijev', 0),
(9, 10000, 'ukosnica', 0),
(10, 10000, 'mobitel', 0),
(11, 10000, 'milk', 0),
(12, 10000, 'weapon_fireextinguisher', 0),
(13, 10000, 'kcijev', 0),
(14, 10000, 'marijuana', 0),
(15, 10000, 'narukvica', 0),
(16, 10000, 'weapon_marksmanrifle_mk2', 0),
(17, 10000, 'cannabis', 0),
(18, 10000, 'ccijev', 0),
(19, 10000, 'gym_membership', 0),
(20, 10000, 'sodium', 0),
(21, 10000, 'weapon_wrench', 0),
(22, 10000, 'packaged_plank', 0),
(23, 10000, 'petarda', 0),
(24, 10000, 'elektronika', 0),
(25, 10000, 'weapon_knife', 0),
(26, 10000, 'acid', 0),
(27, 10000, 'kola', 0),
(28, 10000, 'weapon_firework', 0),
(29, 10000, 'blowpipe', 0),
(30, 10000, 'weapon_flashlight', 0),
(31, 10000, 'wood', 0),
(32, 10000, 'koza', 0),
(33, 10000, 'ronjenje', 0),
(34, 10000, 'weapon_advancedrifle', 0),
(35, 10000, 'clip', 0),
(36, 10000, 'grebalica', 0),
(37, 10000, 'gazbottle', 0),
(38, 10000, 'weapon_appistol', 0),
(39, 10000, 'saksija', 0),
(40, 10000, 'finjectori', 0),
(41, 10000, 'burek', 0),
(42, 10000, 'medikit', 0),
(43, 10000, 'gljive', 0),
(44, 10000, 'zemlja', 0),
(45, 10000, 'weapon_snspistol', 0),
(46, 10000, 'stijelo', 0),
(47, 10000, 'essence', 0),
(48, 10000, 'weapon_pumpshotgun', 0),
(49, 10000, 'ktijelo', 0),
(50, 10000, 'weapon_revolver_mk2', 0),
(51, 10000, 'weapon_pistol', 0),
(52, 10000, 'ctijelo', 0),
(53, 10000, 'bread', 0),
(54, 10000, 'contract', 0),
(55, 10000, 'intercooler', 0),
(56, 10000, 'weapon_nightstick', 0),
(57, 10000, 'weapon_bullpupshotgun', 0),
(58, 10000, 'kmotor', 0),
(59, 10000, 'fish', 0),
(60, 10000, 'cutted_wood', 0),
(61, 10000, 'weapon_mg', 0),
(62, 10000, 'zeton', 0),
(63, 10000, 'petarde', 0),
(64, 10000, 'stone', 0),
(65, 10000, 'cocaine', 0),
(66, 10000, 'slaughtered_chicken', 0),
(67, 10000, 'ckundak', 0),
(68, 10000, 'petrol_raffin', 0),
(69, 10000, 'bandage', 0),
(70, 10000, 'kkundak', 0),
(71, 10000, 'pizza', 0),
(72, 10000, 'coke', 0),
(73, 10000, 'weapon_heavysniper', 0),
(74, 10000, 'skundak', 0),
(75, 10000, 'alive_chicken', 0),
(76, 10000, 'meth', 0),
(77, 10000, 'seed', 0),
(78, 10000, 'wool', 0),
(79, 10000, 'water', 0),
(80, 10000, 'weapon_battleaxe', 0),
(81, 10000, 'autobomba', 0),
(82, 10000, 'whisky', 0),
(83, 10000, 'auspuh', 0),
(84, 10000, 'weapon_vintagepistol', 0),
(85, 10000, 'weapon_assaultrifle', 0),
(86, 10000, 'weapon_hatchet', 0),
(87, 10000, 'weapon_smg', 0),
(88, 10000, 'weapon_specialcarbine', 0),
(89, 10000, 'weapon_sniperrifle', 0),
(90, 10000, 'weapon_switchblade', 0),
(91, 10000, 'jewels', 0),
(92, 10000, 'weapon_revolver', 0),
(93, 10000, 'weapon_poolcue', 0),
(94, 10000, 'LSD', 0),
(95, 10000, 'weapon_pistol50', 0),
(96, 10000, 'weapon_microsmg', 0),
(97, 10000, 'smcijev', 0),
(98, 10000, 'weapon_dbshotgun', 0),
(99, 10000, 'weapon_heavyshotgun', 0),
(100, 10000, 'weapon_marksmanpistol', 0),
(101, 10000, 'weapon_machete', 0),
(102, 10000, 'weapon_gusenberg', 0),
(103, 10000, 'meso', 0),
(104, 10000, 'champagne', 0),
(105, 10000, 'packaged_chicken', 0),
(106, 10000, 'weapon_marksmanrifle', 0),
(107, 10000, 'weapon_heavypistol', 0),
(108, 10000, 'weapon_hammer', 0),
(109, 10000, 'weapon_machinepsitol', 0),
(110, 10000, 'smtijelo', 0),
(111, 10000, 'gold', 0),
(112, 10000, 'kvacilo', 0),
(113, 10000, 'filter', 0),
(114, 10000, 'copper', 0),
(115, 10000, 'weapon_combatpdw', 0),
(116, 10000, 'heroin', 0),
(117, 10000, 'sulfuric_acid', 0),
(118, 10000, 'lancic', 0),
(119, 10000, 'weapon_combatpistol', 0),
(120, 10000, 'biser', 0),
(121, 10000, 'weapon_doubleaction', 0),
(122, 10000, 'chemicals', 0),
(123, 10000, 'weapon_crowbar', 0),
(124, 10000, 'petrol', 0),
(125, 10000, 'iron', 0),
(126, 10000, 'kemija', 0),
(127, 10000, 'lighter', 0),
(128, 10000, 'gintonic', 0),
(129, 10000, 'ljudi', 0),
(130, 10000, 'weapon_carbinerifle_mk2', 0),
(131, 10000, 'net_cracker', 0),
(132, 10000, 'weapon_carbinerifle', 0),
(133, 10000, 'diamond', 0),
(134, 10000, 'cigarett', 0),
(135, 10000, 'beer', 0),
(136, 10000, 'repairkit', 0),
(137, 10000, 'methlab', 0),
(138, 10000, 'drone_flyer_7', 0),
(139, 10000, 'fixtool', 0),
(140, 10000, 'weapon_sawnoffshotgun', 0),
(141, 10000, 'weapon_combatmg', 0),
(142, 10000, 'wine', 0),
(143, 10000, 'chemicalslisence', 0),
(144, 10000, 'weapon_compactrifle', 0),
(145, 10000, 'weapon_bat', 0),
(146, 10000, 'hydrochloric_acid', 0),
(147, 10000, 'carokit', 0),
(148, 10000, 'speed', 0),
(149, 10000, 'weapon_autoshotgun', 0),
(150, 10000, 'weapon_assaultsmg', 0),
(151, 10000, 'loto', 0),
(152, 10000, 'weapon_assaultshotgun', 0),
(153, 10000, 'weapon_assaultrifle_mk2', 0),
(154, 10000, 'turbo', 0),
(155, 10000, 'thermite', 0),
(156, 10000, 'lithium', 0),
(157, 10000, 'washed_stone', 0),
(158, 10000, 'acetone', 0),
(159, 10000, 'vodka', 0),
(160, 10000, 'vatromet', 0),
(161, 10000, 'headbag', 0),
(162, 10000, 'smkundak', 0),
(163, 10000, 'thionyl_chloride', 0),
(164, 10000, 'fixkit', 0),
(165, 10000, 'tequila', 0),
(166, 10000, 'duhan', 0),
(167, 10000, 'fabric', 0),
(168, 10000, 'weapon_golfclub', 0),
(169, 10000, 'skoljka', 0),
(170, 10000, 'absinthe', 0),
(171, 10000, 'weapon_bullpuprifle', 0),
(172, 10000, 'rakija', 0),
(173, 10000, 'carotool', 0),
(174, 10000, 'poppyresin', 0),
(175, 10003, 'lighter', 0),
(176, 10003, 'pizza', 0),
(177, 10003, 'cocaine', 0),
(178, 10003, 'grebalica', 0),
(179, 10003, 'copper', 0),
(180, 10003, 'carotool', 0),
(181, 10003, 'blowpipe', 0),
(182, 10003, 'absinthe', 0),
(183, 10003, 'fish', 0),
(184, 10003, 'weapon_combatpistol', 0),
(185, 10003, 'carokit', 0),
(186, 10003, 'weapon_carbinerifle', 0),
(187, 10003, 'champagne', 0),
(188, 10003, 'weapon_assaultsmg', 0),
(189, 10003, 'headbag', 0),
(190, 10003, 'weapon_dbshotgun', 0),
(191, 10003, 'weapon_appistol', 0),
(192, 10003, 'gazbottle', 0),
(193, 10003, 'speed', 0),
(194, 10003, 'thermite', 0),
(195, 10003, 'weapon_knife', 0),
(196, 10003, 'kola', 0),
(197, 10003, 'sodium', 0),
(198, 10003, 'ronjenje', 0),
(199, 10003, 'mobitel', 1),
(200, 10003, 'weapon_wrench', 0),
(201, 10003, 'bandage', 0),
(202, 10003, 'washed_stone', 0),
(203, 10003, 'meso', 0),
(204, 10003, 'cannabis', 0),
(205, 10003, 'marijuana', 0),
(206, 10003, 'alive_chicken', 0),
(207, 10003, 'weapon_marksmanpistol', 0),
(208, 10003, 'weapon_carbinerifle_mk2', 0),
(209, 10003, 'clothe', 0),
(210, 10003, 'weapon_firework', 0),
(211, 10003, 'heroin', 0),
(212, 10003, 'croquettes', 0),
(213, 10003, 'acid', 0),
(214, 10003, 'stone', 0),
(215, 10003, 'weapon_minismg', 0),
(216, 10003, 'bread', 0),
(217, 10003, 'filter', 0),
(218, 10003, 'intercooler', 0),
(219, 10003, 'heartpump', 0),
(220, 10003, 'ljudi', 0),
(221, 10003, 'duhan', 0),
(222, 10003, 'weapon_revolver_mk2', 0),
(223, 10003, 'finjectori', 0),
(224, 10003, 'sulfuric_acid', 0),
(225, 10003, 'essence', 0),
(226, 10003, 'weapon_assaultrifle_mk2', 0),
(227, 10003, 'fixkit', 0),
(228, 10003, 'autobomba', 0),
(229, 10003, 'wine', 0),
(230, 10003, 'meth', 0),
(231, 10003, 'net_cracker', 0),
(232, 10003, 'packaged_chicken', 0),
(233, 10003, 'weapon_assaultshotgun', 0),
(234, 10003, 'weapon_pistol50', 0),
(235, 10003, 'weapon_hammer', 0),
(236, 10003, 'whisky', 0),
(237, 10003, 'lancic', 0),
(238, 10003, 'petrol', 0),
(239, 10003, 'zeton', 0),
(240, 10003, 'hydrochloric_acid', 0),
(241, 10003, 'water', 0),
(242, 10003, 'wood', 0),
(243, 10003, 'weapon_advancedrifle', 0),
(244, 10003, 'auspuh', 0),
(245, 10003, 'weapon_marksmanrifle', 0),
(246, 10003, 'weapon_combatpdw', 0),
(247, 10003, 'ukosnica', 0),
(248, 10003, 'fixtool', 0),
(249, 10003, 'diamond', 0),
(250, 10003, 'weapon_autoshotgun', 0),
(251, 10003, 'elektronika', 0),
(252, 10003, 'gljive', 0),
(253, 10003, 'weapon_nightstick', 0),
(254, 10003, 'smkundak', 0),
(255, 10003, 'weapon_specialcarbine', 0),
(256, 10003, 'drone_flyer_7', 0),
(257, 10003, 'weapon_snspistol', 0),
(258, 10003, 'saksija', 0),
(259, 10003, 'lithium', 0),
(260, 10003, 'weapon_smg', 0),
(261, 10003, 'ckundak', 0),
(262, 10003, 'vatromet', 1),
(263, 10003, 'weapon_sawnoffshotgun', 0),
(264, 10003, 'weapon_revolver', 0),
(265, 10003, 'burek', 0),
(266, 10003, 'weapon_pumpshotgun', 0),
(267, 10003, 'weapon_poolcue', 0),
(268, 10003, 'milk', 0),
(269, 10003, 'kkundak', 0),
(270, 10003, 'koza', 0),
(271, 10003, 'weapon_fireextinguisher', 0),
(272, 10003, 'weapon_switchblade', 0),
(273, 10003, 'ktijelo', 0),
(274, 10003, 'weapon_musket', 0),
(275, 10003, 'weapon_microsmg', 0),
(276, 10003, 'weapon_vintagepistol', 0),
(277, 10003, 'skundak', 0),
(278, 10003, 'weapon_marksmanrifle_mk2', 0),
(279, 10003, 'weapon_heavyshotgun', 0),
(280, 10003, 'weapon_machete', 0),
(281, 10003, 'kmotor', 0),
(282, 10003, 'smcijev', 0),
(283, 10003, 'petrol_raffin', 0),
(284, 10003, 'weapon_heavysniper', 0),
(285, 10003, 'kcijev', 0),
(286, 10003, 'seed', 0),
(287, 10003, 'weapon_machinepsitol', 0),
(288, 10003, 'gintonic', 0),
(289, 10003, 'iron', 0),
(290, 10003, 'contract', 0),
(291, 10003, 'weapon_hatchet', 0),
(292, 10003, 'weapon_gusenberg', 0),
(293, 10003, 'scijev', 0),
(294, 10003, 'loto', 0),
(295, 10003, 'weapon_flashlight', 0),
(296, 10003, 'weapon_doubleaction', 0),
(297, 10003, 'ctijelo', 0),
(298, 10003, 'weapon_crowbar', 0),
(299, 10003, 'cutted_wood', 0),
(300, 10003, 'weapon_compactrifle', 0),
(301, 10003, 'jewels', 0),
(302, 10003, 'petarde', 0),
(303, 10003, 'odznaka', 0),
(304, 10003, 'weapon_combatmg', 0),
(305, 10003, 'vodka', 0),
(306, 10003, 'kvacilo', 0),
(307, 10003, 'weapon_bullpupshotgun', 0),
(308, 10003, 'beer', 0),
(309, 10003, 'biser', 0),
(310, 10003, 'petarda', 0),
(311, 10003, 'weapon_bullpuprifle', 0),
(312, 10003, 'gold', 0),
(313, 10003, 'chemicals', 0),
(314, 10003, 'weapon_mg', 0),
(315, 10003, 'weapon_assaultrifle', 0),
(316, 10003, 'wool', 0),
(317, 10003, 'clip', 0),
(318, 10003, 'LSD', 0),
(319, 10003, 'chemicalslisence', 0),
(320, 10003, 'medikit', 0),
(321, 10003, 'turbo', 0),
(322, 10003, 'thionyl_chloride', 0),
(323, 10003, 'tequila', 0),
(324, 10003, 'coke', 0),
(325, 10003, 'gym_membership', 0),
(326, 10003, 'stijelo', 0),
(327, 10003, 'moneywash', 0),
(328, 10003, 'smtijelo', 0),
(329, 10003, 'narukvica', 0),
(330, 10003, 'slaughtered_chicken', 0),
(331, 10003, 'weapon_heavypistol', 0),
(332, 10003, 'packaged_plank', 0),
(333, 10003, 'skoljka', 0),
(334, 10003, 'zemlja', 0),
(335, 10003, 'fabric', 0),
(336, 10003, 'kemija', 0),
(337, 10003, 'weapon_sniperrifle', 0),
(338, 10003, 'weapon_battleaxe', 0),
(339, 10003, 'cigarett', 0),
(340, 10003, 'acetone', 0),
(341, 10003, 'ccijev', 0),
(342, 10003, 'rakija', 0),
(343, 10003, 'repairkit', 0),
(344, 10003, 'poppyresin', 0),
(345, 10003, 'weapon_pistol', 0),
(346, 10003, 'methlab', 0),
(347, 10003, 'weapon_golfclub', 0),
(348, 10003, 'weapon_bat', 0),
(349, 10006, 'heartpump', 0),
(350, 10006, 'weapon_assaultrifle', 0),
(351, 10006, 'filter', 0),
(352, 10006, 'meso', 0),
(353, 10006, 'headbag', 0),
(354, 10006, 'grebalica', 0),
(355, 10006, 'zemlja', 0),
(356, 10006, 'rakija', 0),
(357, 10006, 'sodium', 0),
(358, 10006, 'iron', 0),
(359, 10006, 'weapon_assaultshotgun', 0),
(360, 10006, 'hydrochloric_acid', 0),
(361, 10006, 'weapon_combatmg', 0),
(362, 10006, 'fixtool', 0),
(363, 10006, 'weapon_vintagepistol', 0),
(364, 10006, 'weapon_heavysniper', 0),
(365, 10006, 'milk', 0),
(366, 10006, 'water', 0),
(367, 10006, 'weapon_bullpupshotgun', 0),
(368, 10006, 'weapon_specialcarbine', 0),
(369, 10006, 'clip', 0),
(370, 10006, 'duhan', 0),
(371, 10006, 'loto', 0),
(372, 10006, 'cutted_wood', 0),
(373, 10006, 'vatromet', 0),
(374, 10006, 'lithium', 0),
(375, 10006, 'weapon_flashlight', 0),
(376, 10006, 'biser', 0),
(377, 10006, 'weapon_marksmanrifle_mk2', 0),
(378, 10006, 'lighter', 0),
(379, 10006, 'wool', 0),
(380, 10006, 'essence', 0),
(381, 10006, 'odznaka', 0),
(382, 10006, 'moneywash', 0),
(383, 10006, 'weapon_carbinerifle', 0),
(384, 10006, 'weapon_heavyshotgun', 0),
(385, 10006, 'ctijelo', 0),
(386, 10006, 'weapon_bullpuprifle', 0),
(387, 10006, 'weapon_knife', 0),
(388, 10006, 'net_cracker', 0),
(389, 10006, 'intercooler', 0),
(390, 10006, 'bread', 0),
(391, 10006, 'ktijelo', 0),
(392, 10006, 'weapon_combatpdw', 0),
(393, 10006, 'contract', 0),
(394, 10006, 'gold', 0),
(395, 10006, 'gym_membership', 0),
(396, 10006, 'fish', 0),
(397, 10006, 'stijelo', 0),
(398, 10006, 'gazbottle', 0),
(399, 10006, 'weapon_revolver', 0),
(400, 10006, 'gintonic', 0),
(401, 10006, 'repairkit', 0),
(402, 10006, 'stone', 0),
(403, 10006, 'kola', 0),
(404, 10006, 'medikit', 0),
(405, 10006, 'weapon_musket', 0),
(406, 10006, 'scijev', 0),
(407, 10006, 'petarde', 0),
(408, 10006, 'packaged_plank', 0),
(409, 10006, 'skoljka', 0),
(410, 10006, 'chemicalslisence', 0),
(411, 10006, 'smtijelo', 0),
(412, 10006, 'bandage', 0),
(413, 10006, 'ccijev', 0),
(414, 10006, 'lancic', 0),
(415, 10006, 'wine', 0),
(416, 10006, 'seed', 0),
(417, 10006, 'kemija', 0),
(418, 10006, 'kcijev', 0),
(419, 10006, 'wood', 0),
(420, 10006, 'weapon_sniperrifle', 0),
(421, 10006, 'kmotor', 0),
(422, 10006, 'weapon_smg', 0),
(423, 10006, 'LSD', 0),
(424, 10006, 'petarda', 0),
(425, 10006, 'weapon_hatchet', 0),
(426, 10006, 'zeton', 0),
(427, 10006, 'thermite', 0),
(428, 10006, 'weapon_heavypistol', 0),
(429, 10006, 'kkundak', 0),
(430, 10006, 'clothe', 0),
(431, 10006, 'weapon_machete', 0),
(432, 10006, 'cannabis', 0),
(433, 10006, 'burek', 0),
(434, 10006, 'ronjenje', 0),
(435, 10006, 'weapon_switchblade', 0),
(436, 10006, 'koza', 0),
(437, 10006, 'whisky', 0),
(438, 10006, 'weapon_wrench', 0),
(439, 10006, 'weapon_combatpistol', 0),
(440, 10006, 'skundak', 0),
(441, 10006, 'methlab', 0),
(442, 10006, 'absinthe', 0),
(443, 10006, 'weapon_revolver_mk2', 0),
(444, 10006, 'poppyresin', 0),
(445, 10006, 'weapon_sawnoffshotgun', 0),
(446, 10006, 'weapon_pistol50', 0),
(447, 10006, 'weapon_minismg', 0),
(448, 10006, 'weapon_poolcue', 0),
(449, 10006, 'weapon_pistol', 0),
(450, 10006, 'weapon_nightstick', 0),
(451, 10006, 'packaged_chicken', 0),
(452, 10006, 'acid', 0),
(453, 10006, 'weapon_mg', 0),
(454, 10006, 'cigarett', 0),
(455, 10006, 'weapon_marksmanpistol', 0),
(456, 10006, 'weapon_machinepsitol', 0),
(457, 10006, 'weapon_assaultrifle_mk2', 0),
(458, 10006, 'petrol', 0),
(459, 10006, 'fixkit', 0),
(460, 10006, 'turbo', 0),
(461, 10006, 'saksija', 0),
(462, 10006, 'weapon_gusenberg', 0),
(463, 10006, 'weapon_advancedrifle', 0),
(464, 10006, 'kvacilo', 0),
(465, 10006, 'weapon_carbinerifle_mk2', 0),
(466, 10006, 'weapon_golfclub', 0),
(467, 10006, 'weapon_firework', 0),
(468, 10006, 'weapon_pumpshotgun', 0),
(469, 10006, 'weapon_doubleaction', 0),
(470, 10006, 'weapon_dbshotgun', 0),
(471, 10006, 'weapon_crowbar', 0),
(472, 10006, 'weapon_compactrifle', 0),
(473, 10006, 'finjectori', 0),
(474, 10006, 'weapon_snspistol', 0),
(475, 10006, 'smkundak', 0),
(476, 10006, 'narukvica', 0),
(477, 10006, 'ukosnica', 0),
(478, 10006, 'autobomba', 0),
(479, 10006, 'mobitel', 0),
(480, 10006, 'croquettes', 0),
(481, 10006, 'blowpipe', 0),
(482, 10006, 'jewels', 0),
(483, 10006, 'acetone', 0),
(484, 10006, 'diamond', 0),
(485, 10006, 'copper', 0),
(486, 10006, 'carokit', 0),
(487, 10006, 'auspuh', 0),
(488, 10006, 'weapon_bat', 0),
(489, 10006, 'petrol_raffin', 0),
(490, 10006, 'weapon_autoshotgun', 0),
(491, 10006, 'beer', 0),
(492, 10006, 'gljive', 0),
(493, 10006, 'ljudi', 0),
(494, 10006, 'pizza', 0),
(495, 10006, 'weapon_appistol', 0),
(496, 10006, 'chemicals', 0),
(497, 10006, 'weapon_assaultsmg', 0),
(498, 10006, 'weapon_hammer', 0),
(499, 10006, 'carotool', 0),
(500, 10006, 'marijuana', 0),
(501, 10006, 'weapon_battleaxe', 0),
(502, 10006, 'ckundak', 0),
(503, 10006, 'washed_stone', 0),
(504, 10006, 'slaughtered_chicken', 0),
(505, 10006, 'tequila', 0),
(506, 10006, 'weapon_marksmanrifle', 0),
(507, 10006, 'elektronika', 0),
(508, 10006, 'smcijev', 0),
(509, 10006, 'fabric', 0),
(510, 10006, 'thionyl_chloride', 0),
(511, 10006, 'weapon_microsmg', 0),
(512, 10006, 'speed', 0),
(513, 10006, 'drone_flyer_7', 0),
(514, 10006, 'vodka', 0),
(515, 10006, 'alive_chicken', 0),
(516, 10006, 'meth', 0),
(517, 10006, 'sulfuric_acid', 0),
(518, 10006, 'weapon_fireextinguisher', 0),
(519, 10006, 'heroin', 0),
(520, 10006, 'coke', 0),
(521, 10006, 'champagne', 0),
(522, 10006, 'cocaine', 0),
(523, 10007, 'weapon_assaultrifle', 0),
(524, 10007, 'meso', 0),
(525, 10007, 'headbag', 0),
(526, 10007, 'heartpump', 0),
(527, 10007, 'filter', 0),
(528, 10007, 'rakija', 0),
(529, 10007, 'iron', 0),
(530, 10007, 'zemlja', 0),
(531, 10007, 'grebalica', 0),
(532, 10007, 'sodium', 0),
(533, 10007, 'fixtool', 0),
(534, 10007, 'weapon_assaultshotgun', 0),
(535, 10007, 'weapon_combatmg', 0),
(536, 10007, 'hydrochloric_acid', 0),
(537, 10007, 'weapon_vintagepistol', 0),
(538, 10007, 'weapon_heavysniper', 0),
(539, 10007, 'milk', 0),
(540, 10007, 'weapon_specialcarbine', 0),
(541, 10007, 'water', 0),
(542, 10007, 'weapon_bullpupshotgun', 0),
(543, 10007, 'clip', 0),
(544, 10007, 'duhan', 0),
(545, 10007, 'loto', 0),
(546, 10007, 'cutted_wood', 0),
(547, 10007, 'vatromet', 0),
(548, 10007, 'lithium', 0),
(549, 10007, 'weapon_flashlight', 0),
(550, 10007, 'biser', 0),
(551, 10007, 'weapon_marksmanrifle_mk2', 0),
(552, 10007, 'lighter', 0),
(553, 10007, 'wool', 0),
(554, 10007, 'essence', 0),
(555, 10007, 'weapon_carbinerifle', 0),
(556, 10007, 'odznaka', 0),
(557, 10007, 'moneywash', 0),
(558, 10007, 'weapon_heavyshotgun', 0),
(559, 10007, 'weapon_bullpuprifle', 0),
(560, 10007, 'ctijelo', 0),
(561, 10007, 'weapon_knife', 0),
(562, 10007, 'net_cracker', 0),
(563, 10007, 'intercooler', 0),
(564, 10007, 'ktijelo', 0),
(565, 10007, 'bread', 0),
(566, 10007, 'weapon_combatpdw', 0),
(567, 10007, 'contract', 0),
(568, 10007, 'gym_membership', 0),
(569, 10007, 'gold', 0),
(570, 10007, 'stijelo', 0),
(571, 10007, 'fish', 0),
(572, 10007, 'gazbottle', 0),
(573, 10007, 'weapon_revolver', 0),
(574, 10007, 'gintonic', 0),
(575, 10007, 'repairkit', 0),
(576, 10007, 'kola', 0),
(577, 10007, 'stone', 0),
(578, 10007, 'medikit', 0),
(579, 10007, 'weapon_musket', 0),
(580, 10007, 'scijev', 0),
(581, 10007, 'petarde', 0),
(582, 10007, 'packaged_plank', 0),
(583, 10007, 'skoljka', 0),
(584, 10007, 'smtijelo', 0),
(585, 10007, 'chemicalslisence', 0),
(586, 10007, 'bandage', 0),
(587, 10007, 'ccijev', 0),
(588, 10007, 'lancic', 0),
(589, 10007, 'seed', 0),
(590, 10007, 'wine', 0),
(591, 10007, 'kemija', 0),
(592, 10007, 'kcijev', 0),
(593, 10007, 'wood', 0),
(594, 10007, 'weapon_sniperrifle', 0),
(595, 10007, 'kmotor', 0),
(596, 10007, 'LSD', 0),
(597, 10007, 'weapon_smg', 0),
(598, 10007, 'petarda', 0),
(599, 10007, 'zeton', 0),
(600, 10007, 'weapon_hatchet', 0),
(601, 10007, 'thermite', 0),
(602, 10007, 'weapon_heavypistol', 0),
(603, 10007, 'kkundak', 0),
(604, 10007, 'cannabis', 0),
(605, 10007, 'clothe', 0),
(606, 10007, 'weapon_machete', 0),
(607, 10007, 'burek', 0),
(608, 10007, 'ronjenje', 0),
(609, 10007, 'weapon_switchblade', 0),
(610, 10007, 'koza', 0),
(611, 10007, 'whisky', 0),
(612, 10007, 'weapon_wrench', 0),
(613, 10007, 'weapon_combatpistol', 0),
(614, 10007, 'methlab', 0),
(615, 10007, 'skundak', 0),
(616, 10007, 'absinthe', 0),
(617, 10007, 'weapon_revolver_mk2', 0),
(618, 10007, 'poppyresin', 0),
(619, 10007, 'weapon_sawnoffshotgun', 0),
(620, 10007, 'weapon_minismg', 0),
(621, 10007, 'weapon_poolcue', 0),
(622, 10007, 'weapon_pistol50', 0),
(623, 10007, 'weapon_pistol', 0),
(624, 10007, 'weapon_nightstick', 0),
(625, 10007, 'acid', 0),
(626, 10007, 'weapon_mg', 0),
(627, 10007, 'packaged_chicken', 0),
(628, 10007, 'cigarett', 0),
(629, 10007, 'weapon_marksmanpistol', 0),
(630, 10007, 'weapon_machinepsitol', 0),
(631, 10007, 'weapon_assaultrifle_mk2', 0),
(632, 10007, 'petrol', 0),
(633, 10007, 'turbo', 0),
(634, 10007, 'fixkit', 0),
(635, 10007, 'saksija', 0),
(636, 10007, 'weapon_gusenberg', 0),
(637, 10007, 'weapon_advancedrifle', 0),
(638, 10007, 'kvacilo', 0),
(639, 10007, 'weapon_carbinerifle_mk2', 0),
(640, 10007, 'weapon_golfclub', 0),
(641, 10007, 'weapon_firework', 0),
(642, 10007, 'weapon_pumpshotgun', 0),
(643, 10007, 'weapon_doubleaction', 0),
(644, 10007, 'weapon_dbshotgun', 0),
(645, 10007, 'weapon_crowbar', 0),
(646, 10007, 'weapon_compactrifle', 0),
(647, 10007, 'finjectori', 0),
(648, 10007, 'weapon_snspistol', 0),
(649, 10007, 'narukvica', 0),
(650, 10007, 'smkundak', 0),
(651, 10007, 'ukosnica', 0),
(652, 10007, 'autobomba', 0),
(653, 10007, 'mobitel', 0),
(654, 10007, 'croquettes', 0),
(655, 10007, 'blowpipe', 0),
(656, 10007, 'jewels', 0),
(657, 10007, 'acetone', 0),
(658, 10007, 'diamond', 0),
(659, 10007, 'carokit', 0),
(660, 10007, 'copper', 0),
(661, 10007, 'auspuh', 0),
(662, 10007, 'weapon_bat', 0),
(663, 10007, 'petrol_raffin', 0),
(664, 10007, 'weapon_autoshotgun', 0),
(665, 10007, 'beer', 0),
(666, 10007, 'gljive', 0),
(667, 10007, 'ljudi', 0),
(668, 10007, 'pizza', 0),
(669, 10007, 'weapon_appistol', 0),
(670, 10007, 'chemicals', 0),
(671, 10007, 'weapon_assaultsmg', 0),
(672, 10007, 'weapon_hammer', 0),
(673, 10007, 'carotool', 0),
(674, 10007, 'marijuana', 0),
(675, 10007, 'weapon_battleaxe', 0),
(676, 10007, 'ckundak', 0),
(677, 10007, 'washed_stone', 0),
(678, 10007, 'tequila', 0),
(679, 10007, 'smcijev', 0),
(680, 10007, 'slaughtered_chicken', 0),
(681, 10007, 'weapon_marksmanrifle', 0),
(682, 10007, 'elektronika', 0),
(683, 10007, 'fabric', 0),
(684, 10007, 'thionyl_chloride', 0),
(685, 10007, 'weapon_microsmg', 0),
(686, 10007, 'speed', 0),
(687, 10007, 'drone_flyer_7', 0),
(688, 10007, 'vodka', 0),
(689, 10007, 'alive_chicken', 0),
(690, 10007, 'sulfuric_acid', 0),
(691, 10007, 'meth', 0),
(692, 10007, 'weapon_fireextinguisher', 0),
(693, 10007, 'coke', 0),
(694, 10007, 'heroin', 0),
(695, 10007, 'champagne', 0),
(696, 10007, 'cocaine', 0),
(697, 10008, 'headbag', 0),
(698, 10008, 'weapon_assaultrifle', 0),
(699, 10008, 'heartpump', 0),
(700, 10008, 'filter', 0),
(701, 10008, 'meso', 0),
(702, 10008, 'grebalica', 0),
(703, 10008, 'zemlja', 0),
(704, 10008, 'rakija', 0),
(705, 10008, 'iron', 0),
(706, 10008, 'sodium', 0),
(707, 10008, 'weapon_assaultshotgun', 0),
(708, 10008, 'hydrochloric_acid', 0),
(709, 10008, 'fixtool', 0),
(710, 10008, 'weapon_vintagepistol', 0),
(711, 10008, 'weapon_combatmg', 0),
(712, 10008, 'weapon_heavysniper', 0),
(713, 10008, 'milk', 0),
(714, 10008, 'weapon_specialcarbine', 0),
(715, 10008, 'water', 0),
(716, 10008, 'weapon_bullpupshotgun', 0),
(717, 10008, 'duhan', 0),
(718, 10008, 'clip', 0),
(719, 10008, 'cutted_wood', 0),
(720, 10008, 'loto', 0),
(721, 10008, 'vatromet', 0),
(722, 10008, 'weapon_flashlight', 0),
(723, 10008, 'lithium', 0),
(724, 10008, 'weapon_marksmanrifle_mk2', 0),
(725, 10008, 'lighter', 0),
(726, 10008, 'biser', 0),
(727, 10008, 'essence', 0),
(728, 10008, 'odznaka', 0),
(729, 10008, 'wool', 0),
(730, 10008, 'weapon_carbinerifle', 0),
(731, 10008, 'moneywash', 0),
(732, 10008, 'weapon_heavyshotgun', 0),
(733, 10008, 'ctijelo', 0),
(734, 10008, 'weapon_bullpuprifle', 0),
(735, 10008, 'weapon_knife', 0),
(736, 10008, 'net_cracker', 0),
(737, 10008, 'intercooler', 0),
(738, 10008, 'bread', 0),
(739, 10008, 'weapon_combatpdw', 0),
(740, 10008, 'ktijelo', 0),
(741, 10008, 'contract', 0),
(742, 10008, 'gold', 0),
(743, 10008, 'gym_membership', 0),
(744, 10008, 'fish', 0),
(745, 10008, 'stijelo', 0),
(746, 10008, 'gazbottle', 0),
(747, 10008, 'weapon_revolver', 0),
(748, 10008, 'gintonic', 0),
(749, 10008, 'repairkit', 0),
(750, 10008, 'stone', 0),
(751, 10008, 'kola', 0),
(752, 10008, 'medikit', 0),
(753, 10008, 'weapon_musket', 0),
(754, 10008, 'scijev', 0),
(755, 10008, 'petarde', 0),
(756, 10008, 'packaged_plank', 0),
(757, 10008, 'skoljka', 0),
(758, 10008, 'smtijelo', 0),
(759, 10008, 'chemicalslisence', 0),
(760, 10008, 'bandage', 0),
(761, 10008, 'ccijev', 0),
(762, 10008, 'lancic', 0),
(763, 10008, 'wine', 0),
(764, 10008, 'seed', 0),
(765, 10008, 'kemija', 0),
(766, 10008, 'kcijev', 0),
(767, 10008, 'wood', 0),
(768, 10008, 'weapon_sniperrifle', 0),
(769, 10008, 'LSD', 0),
(770, 10008, 'kmotor', 0),
(771, 10008, 'weapon_smg', 0),
(772, 10008, 'petarda', 0),
(773, 10008, 'zeton', 0),
(774, 10008, 'weapon_hatchet', 0),
(775, 10008, 'thermite', 0),
(776, 10008, 'weapon_heavypistol', 0),
(777, 10008, 'kkundak', 0),
(778, 10008, 'clothe', 0),
(779, 10008, 'weapon_machete', 0),
(780, 10008, 'cannabis', 0),
(781, 10008, 'burek', 0),
(782, 10008, 'ronjenje', 0),
(783, 10008, 'weapon_switchblade', 0),
(784, 10008, 'koza', 0),
(785, 10008, 'weapon_wrench', 0),
(786, 10008, 'whisky', 0),
(787, 10008, 'weapon_combatpistol', 0),
(788, 10008, 'skundak', 0),
(789, 10008, 'methlab', 0),
(790, 10008, 'absinthe', 0),
(791, 10008, 'weapon_revolver_mk2', 0),
(792, 10008, 'poppyresin', 0),
(793, 10008, 'weapon_sawnoffshotgun', 0),
(794, 10008, 'weapon_minismg', 0),
(795, 10008, 'weapon_poolcue', 0),
(796, 10008, 'weapon_pistol50', 0),
(797, 10008, 'weapon_nightstick', 0),
(798, 10008, 'weapon_pistol', 0),
(799, 10008, 'packaged_chicken', 0),
(800, 10008, 'weapon_mg', 0),
(801, 10008, 'acid', 0),
(802, 10008, 'cigarett', 0),
(803, 10008, 'weapon_marksmanpistol', 0),
(804, 10008, 'weapon_machinepsitol', 0),
(805, 10008, 'weapon_assaultrifle_mk2', 0),
(806, 10008, 'petrol', 0),
(807, 10008, 'fixkit', 0),
(808, 10008, 'turbo', 0),
(809, 10008, 'saksija', 0),
(810, 10008, 'weapon_gusenberg', 0),
(811, 10008, 'weapon_advancedrifle', 0),
(812, 10008, 'kvacilo', 0),
(813, 10008, 'weapon_carbinerifle_mk2', 0),
(814, 10008, 'weapon_golfclub', 0),
(815, 10008, 'weapon_pumpshotgun', 0),
(816, 10008, 'weapon_firework', 0),
(817, 10008, 'weapon_doubleaction', 0),
(818, 10008, 'weapon_dbshotgun', 0),
(819, 10008, 'weapon_crowbar', 0),
(820, 10008, 'weapon_compactrifle', 0),
(821, 10008, 'finjectori', 0),
(822, 10008, 'weapon_snspistol', 0),
(823, 10008, 'narukvica', 0),
(824, 10008, 'smkundak', 0),
(825, 10008, 'ukosnica', 0),
(826, 10008, 'autobomba', 0),
(827, 10008, 'mobitel', 0),
(828, 10008, 'croquettes', 0),
(829, 10008, 'blowpipe', 0),
(830, 10008, 'jewels', 0),
(831, 10008, 'acetone', 0),
(832, 10008, 'diamond', 0),
(833, 10008, 'copper', 0),
(834, 10008, 'carokit', 0),
(835, 10008, 'auspuh', 0),
(836, 10008, 'weapon_bat', 0),
(837, 10008, 'petrol_raffin', 0),
(838, 10008, 'weapon_autoshotgun', 0),
(839, 10008, 'beer', 0),
(840, 10008, 'gljive', 0),
(841, 10008, 'ljudi', 0),
(842, 10008, 'weapon_appistol', 0),
(843, 10008, 'pizza', 0),
(844, 10008, 'weapon_assaultsmg', 0),
(845, 10008, 'chemicals', 0),
(846, 10008, 'weapon_hammer', 0),
(847, 10008, 'carotool', 0),
(848, 10008, 'marijuana', 0),
(849, 10008, 'weapon_battleaxe', 0),
(850, 10008, 'ckundak', 0),
(851, 10008, 'washed_stone', 0),
(852, 10008, 'tequila', 0),
(853, 10008, 'slaughtered_chicken', 0),
(854, 10008, 'weapon_marksmanrifle', 0),
(855, 10008, 'elektronika', 0),
(856, 10008, 'smcijev', 0),
(857, 10008, 'fabric', 0),
(858, 10008, 'thionyl_chloride', 0),
(859, 10008, 'weapon_microsmg', 0),
(860, 10008, 'speed', 0),
(861, 10008, 'drone_flyer_7', 0),
(862, 10008, 'vodka', 0),
(863, 10008, 'alive_chicken', 0),
(864, 10008, 'meth', 0),
(865, 10008, 'weapon_fireextinguisher', 0),
(866, 10008, 'sulfuric_acid', 0),
(867, 10008, 'heroin', 0),
(868, 10008, 'coke', 0),
(869, 10008, 'champagne', 0),
(870, 10008, 'cocaine', 0),
(871, 10009, 'clip', 0),
(872, 10009, 'ckundak', 0),
(873, 10009, 'weapon_combatmg', 0),
(874, 10009, 'vatromet', 0),
(875, 10009, 'weapon_machete', 0),
(876, 10009, 'wool', 0),
(877, 10009, 'kkundak', 0),
(878, 10009, 'weapon_sawnoffshotgun', 0),
(879, 10009, 'filter', 0),
(880, 10009, 'weapon_musket', 0),
(881, 10009, 'diamond', 0),
(882, 10009, 'absinthe', 0),
(883, 10009, 'bread', 0),
(884, 10009, 'marijuana', 0),
(885, 10009, 'kvacilo', 0),
(886, 10009, 'slaughtered_chicken', 0),
(887, 10009, 'lighter', 0),
(888, 10009, 'mobitel', 0),
(889, 10009, 'koza', 0),
(890, 10009, 'thionyl_chloride', 0),
(891, 10009, 'chemicalslisence', 0),
(892, 10009, 'methlab', 0),
(893, 10009, 'ljudi', 0),
(894, 10009, 'ronjenje', 0),
(895, 10009, 'weapon_switchblade', 0),
(896, 10009, 'acetone', 0),
(897, 10009, 'hydrochloric_acid', 0),
(898, 10009, 'beer', 0),
(899, 10009, 'contract', 0),
(900, 10009, 'jewels', 0),
(901, 10009, 'grebalica', 0),
(902, 10009, 'seed', 0),
(903, 10009, 'weapon_pumpshotgun', 0),
(904, 10009, 'weapon_assaultshotgun', 0),
(905, 10009, 'iron', 0),
(906, 10009, 'intercooler', 0),
(907, 10009, 'drone_flyer_7', 0),
(908, 10009, 'water', 0),
(909, 10009, 'weapon_bullpupshotgun', 0),
(910, 10009, 'fabric', 0),
(911, 10009, 'cigarett', 0),
(912, 10009, 'weapon_minismg', 0),
(913, 10009, 'smcijev', 0),
(914, 10009, 'scijev', 0),
(915, 10009, 'weapon_firework', 0),
(916, 10009, 'smtijelo', 0),
(917, 10009, 'weapon_revolver', 0),
(918, 10009, 'weapon_smg', 0),
(919, 10009, 'weapon_fireextinguisher', 0),
(920, 10009, 'ccijev', 0),
(921, 10009, 'net_cracker', 0),
(922, 10009, 'loto', 0),
(923, 10009, 'carotool', 0),
(924, 10009, 'turbo', 0),
(925, 10009, 'kcijev', 0),
(926, 10009, 'chemicals', 0),
(927, 10009, 'weapon_doubleaction', 0),
(928, 10009, 'petrol_raffin', 0),
(929, 10009, 'packaged_plank', 0),
(930, 10009, 'cutted_wood', 0),
(931, 10009, 'weapon_assaultsmg', 0),
(932, 10009, 'weapon_bat', 0),
(933, 10009, 'duhan', 0),
(934, 10009, 'pizza', 0),
(935, 10009, 'weapon_flashlight', 0),
(936, 10009, 'weapon_crowbar', 0),
(937, 10009, 'auspuh', 0),
(938, 10009, 'weapon_bullpuprifle', 0),
(939, 10009, 'cocaine', 0),
(940, 10009, 'copper', 0),
(941, 10009, 'ukosnica', 0),
(942, 10009, 'carokit', 0),
(943, 10009, 'ctijelo', 0),
(944, 10009, 'repairkit', 0),
(945, 10009, 'washed_stone', 0),
(946, 10009, 'coke', 0),
(947, 10009, 'moneywash', 0),
(948, 10009, 'burek', 0),
(949, 10009, 'weapon_compactrifle', 0),
(950, 10009, 'weapon_marksmanpistol', 0),
(951, 10009, 'gljive', 0),
(952, 10009, 'weapon_assaultrifle_mk2', 0),
(953, 10009, 'weapon_carbinerifle_mk2', 0),
(954, 10009, 'sulfuric_acid', 0),
(955, 10009, 'weapon_hammer', 0),
(956, 10009, 'medikit', 0),
(957, 10009, 'weapon_assaultrifle', 0),
(958, 10009, 'weapon_sniperrifle', 0),
(959, 10009, 'weapon_revolver_mk2', 0),
(960, 10009, 'weapon_mg', 0),
(961, 10009, 'weapon_snspistol', 0),
(962, 10009, 'cannabis', 0),
(963, 10009, 'zeton', 0),
(964, 10009, 'zemlja', 0),
(965, 10009, 'weapon_advancedrifle', 0),
(966, 10009, 'weapon_microsmg', 0),
(967, 10009, 'packaged_chicken', 0),
(968, 10009, 'sodium', 0),
(969, 10009, 'whisky', 0),
(970, 10009, 'weapon_golfclub', 0),
(971, 10009, 'LSD', 0),
(972, 10009, 'tequila', 0),
(973, 10009, 'champagne', 0),
(974, 10009, 'meso', 0),
(975, 10009, 'weapon_pistol', 0),
(976, 10009, 'weapon_combatpdw', 0),
(977, 10009, 'weapon_wrench', 0),
(978, 10009, 'weapon_vintagepistol', 0),
(979, 10009, 'milk', 0),
(980, 10009, 'ktijelo', 0),
(981, 10009, 'weapon_combatpistol', 0),
(982, 10009, 'weapon_heavyshotgun', 0),
(983, 10009, 'weapon_pistol50', 0),
(984, 10009, 'odznaka', 0),
(985, 10009, 'weapon_poolcue', 0),
(986, 10009, 'weapon_autoshotgun', 0),
(987, 10009, 'weapon_nightstick', 0),
(988, 10009, 'biser', 0),
(989, 10009, 'wine', 0),
(990, 10009, 'fixkit', 0),
(991, 10009, 'lancic', 0),
(992, 10009, 'speed', 0),
(993, 10009, 'weapon_machinepsitol', 0),
(994, 10009, 'weapon_knife', 0),
(995, 10009, 'weapon_heavysniper', 0),
(996, 10009, 'weapon_heavypistol', 0),
(997, 10009, 'weapon_hatchet', 0),
(998, 10009, 'kola', 0),
(999, 10009, 'weapon_dbshotgun', 0),
(1000, 10009, 'autobomba', 0),
(1001, 10009, 'weapon_specialcarbine', 0),
(1002, 10009, 'weapon_marksmanrifle', 0),
(1003, 10009, 'headbag', 0),
(1004, 10009, 'blowpipe', 0),
(1005, 10009, 'weapon_carbinerifle', 0),
(1006, 10009, 'kmotor', 0),
(1007, 10009, 'gintonic', 0),
(1008, 10009, 'weapon_battleaxe', 0),
(1009, 10009, 'meth', 0),
(1010, 10009, 'gold', 0),
(1011, 10009, 'gym_membership', 0),
(1012, 10009, 'petarda', 0),
(1013, 10009, 'lithium', 0),
(1014, 10009, 'smkundak', 0),
(1015, 10009, 'finjectori', 0),
(1016, 10009, 'alive_chicken', 0),
(1017, 10009, 'gazbottle', 0),
(1018, 10009, 'weapon_appistol', 0),
(1019, 10009, 'wood', 0),
(1020, 10009, 'vodka', 0),
(1021, 10009, 'kemija', 0),
(1022, 10009, 'elektronika', 0),
(1023, 10009, 'poppyresin', 0),
(1024, 10009, 'clothe', 0),
(1025, 10009, 'petarde', 0),
(1026, 10009, 'bandage', 0),
(1027, 10009, 'thermite', 0),
(1028, 10009, 'stijelo', 0),
(1029, 10009, 'essence', 0),
(1030, 10009, 'fixtool', 0),
(1031, 10009, 'acid', 0),
(1032, 10009, 'croquettes', 0),
(1033, 10009, 'narukvica', 0),
(1034, 10009, 'stone', 0),
(1035, 10009, 'heartpump', 0),
(1036, 10009, 'fish', 0),
(1037, 10009, 'skundak', 0),
(1038, 10009, 'skoljka', 0),
(1039, 10009, 'saksija', 0),
(1040, 10009, 'rakija', 0),
(1041, 10009, 'heroin', 0),
(1042, 10009, 'weapon_gusenberg', 0),
(1043, 10009, 'petrol', 0),
(1044, 10009, 'weapon_marksmanrifle_mk2', 0),
(1045, 10010, 'iron', 0),
(1046, 10010, 'mobitel', 0),
(1047, 10010, 'weapon_combatpdw', 0),
(1048, 10010, 'contract', 0),
(1049, 10010, 'pizza', 0),
(1050, 10010, 'weapon_smg', 0),
(1051, 10010, 'weapon_gusenberg', 0),
(1052, 10010, 'chemicalslisence', 0),
(1053, 10010, 'slaughtered_chicken', 0),
(1054, 10010, 'weapon_switchblade', 0),
(1055, 10010, 'tequila', 0),
(1056, 10010, 'sodium', 0),
(1057, 10010, 'ukosnica', 0),
(1058, 10010, 'thionyl_chloride', 0),
(1059, 10010, 'weapon_musket', 0),
(1060, 10010, 'narukvica', 0),
(1061, 10010, 'weapon_sniperrifle', 0),
(1062, 10010, 'weapon_assaultrifle', 0),
(1063, 10010, 'weapon_microsmg', 0),
(1064, 10010, 'weapon_poolcue', 0),
(1065, 10010, 'weapon_bullpupshotgun', 0),
(1066, 10010, 'copper', 0),
(1067, 10010, 'weapon_combatmg', 0),
(1068, 10010, 'weapon_heavyshotgun', 0),
(1069, 10010, 'repairkit', 0),
(1070, 10010, 'kvacilo', 0),
(1071, 10010, 'weapon_golfclub', 0),
(1072, 10010, 'gljive', 0),
(1073, 10010, 'carokit', 0),
(1074, 10010, 'fabric', 0),
(1075, 10010, 'loto', 0),
(1076, 10010, 'meso', 0),
(1077, 10010, 'weapon_firework', 0),
(1078, 10010, 'weapon_sawnoffshotgun', 0),
(1079, 10010, 'smcijev', 0),
(1080, 10010, 'weapon_nightstick', 0),
(1081, 10010, 'packaged_chicken', 0),
(1082, 10010, 'petrol_raffin', 0),
(1083, 10010, 'fish', 0),
(1084, 10010, 'coke', 0),
(1085, 10010, 'grebalica', 0),
(1086, 10010, 'milk', 0),
(1087, 10010, 'ctijelo', 0),
(1088, 10010, 'ronjenje', 0),
(1089, 10010, 'hydrochloric_acid', 0),
(1090, 10010, 'methlab', 0),
(1091, 10010, 'blowpipe', 0),
(1092, 10010, 'essence', 0),
(1093, 10010, 'stijelo', 0),
(1094, 10010, 'chemicals', 0),
(1095, 10010, 'auspuh', 0),
(1096, 10010, 'medikit', 0),
(1097, 10010, 'ktijelo', 0),
(1098, 10010, 'heartpump', 0),
(1099, 10010, 'elektronika', 0),
(1100, 10010, 'kola', 0),
(1101, 10010, 'weapon_hammer', 0),
(1102, 10010, 'weapon_combatpistol', 0),
(1103, 10010, 'weapon_specialcarbine', 0),
(1104, 10010, 'scijev', 0),
(1105, 10010, 'vatromet', 0),
(1106, 10010, 'burek', 0),
(1107, 10010, 'weapon_marksmanpistol', 0),
(1108, 10010, 'petarda', 0),
(1109, 10010, 'weapon_doubleaction', 0),
(1110, 10010, 'weapon_autoshotgun', 0),
(1111, 10010, 'ccijev', 0),
(1112, 10010, 'acid', 0),
(1113, 10010, 'croquettes', 0),
(1114, 10010, 'filter', 0),
(1115, 10010, 'LSD', 0),
(1116, 10010, 'absinthe', 0),
(1117, 10010, 'weapon_fireextinguisher', 0),
(1118, 10010, 'skundak', 0),
(1119, 10010, 'skoljka', 0),
(1120, 10010, 'weapon_compactrifle', 0),
(1121, 10010, 'thermite', 0),
(1122, 10010, 'zeton', 0),
(1123, 10010, 'cannabis', 0),
(1124, 10010, 'weapon_battleaxe', 0),
(1125, 10010, 'weapon_bullpuprifle', 0),
(1126, 10010, 'rakija', 0),
(1127, 10010, 'ckundak', 0),
(1128, 10010, 'weapon_marksmanrifle_mk2', 0),
(1129, 10010, 'kkundak', 0),
(1130, 10010, 'lighter', 0),
(1131, 10010, 'weapon_bat', 0),
(1132, 10010, 'weapon_vintagepistol', 0),
(1133, 10010, 'sulfuric_acid', 0),
(1134, 10010, 'carotool', 0),
(1135, 10010, 'wool', 0),
(1136, 10010, 'alive_chicken', 0),
(1137, 10010, 'wine', 0),
(1138, 10010, 'whisky', 0),
(1139, 10010, 'weapon_wrench', 0),
(1140, 10010, 'speed', 0),
(1141, 10010, 'marijuana', 0),
(1142, 10010, 'weapon_assaultrifle_mk2', 0),
(1143, 10010, 'weapon_revolver', 0),
(1144, 10010, 'weapon_machete', 0),
(1145, 10010, 'autobomba', 0),
(1146, 10010, 'weapon_pumpshotgun', 0),
(1147, 10010, 'gold', 0),
(1148, 10010, 'weapon_pistol50', 0),
(1149, 10010, 'bandage', 0),
(1150, 10010, 'water', 0),
(1151, 10010, 'weapon_pistol', 0),
(1152, 10010, 'beer', 0),
(1153, 10010, 'weapon_carbinerifle_mk2', 0),
(1154, 10010, 'biser', 0),
(1155, 10010, 'weapon_minismg', 0),
(1156, 10010, 'clip', 0),
(1157, 10010, 'kmotor', 0),
(1158, 10010, 'poppyresin', 0),
(1159, 10010, 'moneywash', 0),
(1160, 10010, 'odznaka', 0),
(1161, 10010, 'weapon_dbshotgun', 0),
(1162, 10010, 'weapon_machinepsitol', 0),
(1163, 10010, 'gintonic', 0),
(1164, 10010, 'weapon_heavysniper', 0),
(1165, 10010, 'cocaine', 0),
(1166, 10010, 'net_cracker', 0),
(1167, 10010, 'weapon_heavypistol', 0),
(1168, 10010, 'washed_stone', 0),
(1169, 10010, 'gym_membership', 0),
(1170, 10010, 'weapon_flashlight', 0),
(1171, 10010, 'turbo', 0),
(1172, 10010, 'weapon_crowbar', 0),
(1173, 10010, 'acetone', 0),
(1174, 10010, 'wood', 0),
(1175, 10010, 'cigarett', 0),
(1176, 10010, 'vodka', 0),
(1177, 10010, 'seed', 0),
(1178, 10010, 'jewels', 0),
(1179, 10010, 'finjectori', 0),
(1180, 10010, 'weapon_carbinerifle', 0),
(1181, 10010, 'meth', 0),
(1182, 10010, 'weapon_advancedrifle', 0),
(1183, 10010, 'koza', 0),
(1184, 10010, 'petrol', 0),
(1185, 10010, 'weapon_assaultshotgun', 0),
(1186, 10010, 'bread', 0),
(1187, 10010, 'weapon_revolver_mk2', 0),
(1188, 10010, 'lancic', 0),
(1189, 10010, 'weapon_appistol', 0),
(1190, 10010, 'lithium', 0),
(1191, 10010, 'weapon_hatchet', 0),
(1192, 10010, 'packaged_plank', 0),
(1193, 10010, 'zemlja', 0),
(1194, 10010, 'cutted_wood', 0),
(1195, 10010, 'diamond', 0),
(1196, 10010, 'gazbottle', 0),
(1197, 10010, 'intercooler', 0),
(1198, 10010, 'stone', 0),
(1199, 10010, 'kemija', 0),
(1200, 10010, 'duhan', 0),
(1201, 10010, 'headbag', 0),
(1202, 10010, 'weapon_snspistol', 0),
(1203, 10010, 'weapon_assaultsmg', 0),
(1204, 10010, 'smtijelo', 0),
(1205, 10010, 'smkundak', 0),
(1206, 10010, 'champagne', 0),
(1207, 10010, 'weapon_mg', 0),
(1208, 10010, 'clothe', 0),
(1209, 10010, 'fixkit', 0),
(1210, 10010, 'saksija', 0),
(1211, 10010, 'heroin', 0),
(1212, 10010, 'petarde', 0),
(1213, 10010, 'drone_flyer_7', 0),
(1214, 10010, 'ljudi', 0),
(1215, 10010, 'weapon_marksmanrifle', 0),
(1216, 10010, 'weapon_knife', 0),
(1217, 10010, 'fixtool', 0),
(1218, 10010, 'kcijev', 0),
(1219, 10011, 'pizza', 0),
(1220, 10011, 'fabric', 0),
(1221, 10011, 'loto', 0),
(1222, 10011, 'repairkit', 0),
(1223, 10011, 'weapon_pistol50', 0),
(1224, 10011, 'water', 0),
(1225, 10011, 'elektronika', 0),
(1226, 10011, 'packaged_plank', 0),
(1227, 10011, 'zemlja', 0),
(1228, 10011, 'smtijelo', 0),
(1229, 10011, 'hydrochloric_acid', 0),
(1230, 10011, 'petrol', 0),
(1231, 10011, 'fixkit', 0),
(1232, 10011, 'lighter', 0),
(1233, 10011, 'washed_stone', 0),
(1234, 10011, 'turbo', 0),
(1235, 10011, 'sodium', 0),
(1236, 10011, 'weapon_microsmg', 0),
(1237, 10011, 'weapon_minismg', 0),
(1238, 10011, 'meth', 0),
(1239, 10011, 'carokit', 0),
(1240, 10011, 'slaughtered_chicken', 0),
(1241, 10011, 'cocaine', 0),
(1242, 10011, 'diamond', 0),
(1243, 10011, 'fish', 0),
(1244, 10011, 'narukvica', 0),
(1245, 10011, 'contract', 0),
(1246, 10011, 'smcijev', 0),
(1247, 10011, 'weapon_crowbar', 0),
(1248, 10011, 'copper', 0),
(1249, 10011, 'absinthe', 0),
(1250, 10011, 'weapon_machete', 0),
(1251, 10011, 'gljive', 0),
(1252, 10011, 'biser', 0),
(1253, 10011, 'marijuana', 0),
(1254, 10011, 'coke', 0),
(1255, 10011, 'medikit', 0),
(1256, 10011, 'burek', 0),
(1257, 10011, 'rakija', 0),
(1258, 10011, 'grebalica', 0),
(1259, 10011, 'blowpipe', 0),
(1260, 10011, 'speed', 0),
(1261, 10011, 'heartpump', 0),
(1262, 10011, 'sulfuric_acid', 0),
(1263, 10011, 'stone', 0),
(1264, 10011, 'alive_chicken', 0),
(1265, 10011, 'weapon_fireextinguisher', 0),
(1266, 10011, 'kola', 0),
(1267, 10011, 'ccijev', 0),
(1268, 10011, 'petarda', 0),
(1269, 10011, 'chemicals', 0),
(1270, 10011, 'koza', 0),
(1271, 10011, 'chemicalslisence', 0),
(1272, 10011, 'gintonic', 0),
(1273, 10011, 'weapon_assaultrifle', 0),
(1274, 10011, 'ukosnica', 0),
(1275, 10011, 'scijev', 0),
(1276, 10011, 'weapon_marksmanrifle_mk2', 0),
(1277, 10011, 'weapon_revolver', 0),
(1278, 10011, 'methlab', 0),
(1279, 10011, 'weapon_combatmg', 0),
(1280, 10011, 'weapon_heavysniper', 0),
(1281, 10011, 'kcijev', 0),
(1282, 10011, 'weapon_switchblade', 0),
(1283, 10011, 'finjectori', 0),
(1284, 10011, 'weapon_marksmanpistol', 0),
(1285, 10011, 'poppyresin', 0),
(1286, 10011, 'drone_flyer_7', 0),
(1287, 10011, 'weapon_battleaxe', 0),
(1288, 10011, 'weapon_combatpdw', 0),
(1289, 10011, 'zeton', 0),
(1290, 10011, 'wool', 0),
(1291, 10011, 'wood', 0),
(1292, 10011, 'wine', 0),
(1293, 10011, 'weapon_golfclub', 0),
(1294, 10011, 'whisky', 0),
(1295, 10011, 'skoljka', 0),
(1296, 10011, 'autobomba', 0),
(1297, 10011, 'filter', 0),
(1298, 10011, 'cutted_wood', 0),
(1299, 10011, 'weapon_knife', 0),
(1300, 10011, 'weapon_autoshotgun', 0),
(1301, 10011, 'weapon_musket', 0),
(1302, 10011, 'vatromet', 0),
(1303, 10011, 'weapon_vintagepistol', 0),
(1304, 10011, 'weapon_specialcarbine', 0),
(1305, 10011, 'weapon_snspistol', 0),
(1306, 10011, 'weapon_hatchet', 0),
(1307, 10011, 'weapon_sniperrifle', 0),
(1308, 10011, 'weapon_heavyshotgun', 0),
(1309, 10011, 'weapon_smg', 0),
(1310, 10011, 'weapon_sawnoffshotgun', 0),
(1311, 10011, 'weapon_heavypistol', 0),
(1312, 10011, 'weapon_revolver_mk2', 0),
(1313, 10011, 'weapon_pumpshotgun', 0),
(1314, 10011, 'weapon_poolcue', 0),
(1315, 10011, 'weapon_pistol', 0),
(1316, 10011, 'weapon_nightstick', 0),
(1317, 10011, 'seed', 0),
(1318, 10011, 'weapon_marksmanrifle', 0),
(1319, 10011, 'weapon_machinepsitol', 0),
(1320, 10011, 'gold', 0),
(1321, 10011, 'essence', 0),
(1322, 10011, 'meso', 0),
(1323, 10011, 'ljudi', 0),
(1324, 10011, 'thionyl_chloride', 0),
(1325, 10011, 'cannabis', 0),
(1326, 10011, 'weapon_gusenberg', 0),
(1327, 10011, 'gym_membership', 0),
(1328, 10011, 'bread', 0),
(1329, 10011, 'weapon_firework', 0),
(1330, 10011, 'auspuh', 0),
(1331, 10011, 'milk', 0),
(1332, 10011, 'kemija', 0),
(1333, 10011, 'LSD', 0),
(1334, 10011, 'weapon_dbshotgun', 0),
(1335, 10011, 'weapon_compactrifle', 0),
(1336, 10011, 'clothe', 0),
(1337, 10011, 'duhan', 0),
(1338, 10011, 'weapon_combatpistol', 0),
(1339, 10011, 'lithium', 0),
(1340, 10011, 'ktijelo', 0),
(1341, 10011, 'packaged_chicken', 0),
(1342, 10011, 'moneywash', 0),
(1343, 10011, 'net_cracker', 0),
(1344, 10011, 'iron', 0),
(1345, 10011, 'weapon_assaultshotgun', 0),
(1346, 10011, 'weapon_carbinerifle_mk2', 0),
(1347, 10011, 'acetone', 0),
(1348, 10011, 'weapon_carbinerifle', 0),
(1349, 10011, 'weapon_bullpupshotgun', 0),
(1350, 10011, 'weapon_bullpuprifle', 0),
(1351, 10011, 'weapon_assaultrifle_mk2', 0),
(1352, 10011, 'headbag', 0),
(1353, 10011, 'champagne', 0),
(1354, 10011, 'weapon_bat', 0),
(1355, 10011, 'kkundak', 0),
(1356, 10011, 'fixtool', 0),
(1357, 10011, 'ronjenje', 0),
(1358, 10011, 'weapon_wrench', 0),
(1359, 10011, 'thermite', 0),
(1360, 10011, 'beer', 0),
(1361, 10011, 'petarde', 0),
(1362, 10011, 'lancic', 0),
(1363, 10011, 'jewels', 0),
(1364, 10011, 'ctijelo', 0),
(1365, 10011, 'gazbottle', 0),
(1366, 10011, 'acid', 0),
(1367, 10011, 'clip', 0),
(1368, 10011, 'weapon_appistol', 0),
(1369, 10011, 'cigarett', 0),
(1370, 10011, 'weapon_doubleaction', 0),
(1371, 10011, 'vodka', 0),
(1372, 10011, 'smkundak', 0),
(1373, 10011, 'kvacilo', 0),
(1374, 10011, 'weapon_hammer', 0),
(1375, 10011, 'weapon_advancedrifle', 0),
(1376, 10011, 'mobitel', 0),
(1377, 10011, 'tequila', 0),
(1378, 10011, 'heroin', 0),
(1379, 10011, 'bandage', 0),
(1380, 10011, 'stijelo', 0),
(1381, 10011, 'skundak', 0),
(1382, 10011, 'carotool', 0),
(1383, 10011, 'weapon_mg', 0),
(1384, 10011, 'kmotor', 0),
(1385, 10011, 'saksija', 0),
(1386, 10011, 'petrol_raffin', 0),
(1387, 10011, 'croquettes', 0),
(1388, 10011, 'ckundak', 0),
(1389, 10011, 'intercooler', 0),
(1390, 10011, 'odznaka', 0),
(1391, 10011, 'weapon_flashlight', 0),
(1392, 10011, 'weapon_assaultsmg', 0),
(1393, 10000, 'sarafciger', 0),
(1394, 10010, 'sarafciger', 0),
(1395, 10000, 'novine', 0),
(1396, 10010, 'novine', 0),
(1397, 10000, 'fishingrod', 0),
(1398, 10000, 'fishbait', 0),
(1399, 10000, 'spikestrip', 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_licenses`
--

DROP TABLE IF EXISTS `user_licenses`;
CREATE TABLE IF NOT EXISTS `user_licenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(60) NOT NULL,
  `owner` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_licenses`
--

INSERT INTO `user_licenses` (`id`, `type`, `owner`) VALUES
(8, 'drive', 10000),
(11, 'weapon', 10000),
(16, 'weapon', 10010);

-- --------------------------------------------------------

--
-- Table structure for table `user_races`
--

DROP TABLE IF EXISTS `user_races`;
CREATE TABLE IF NOT EXISTS `user_races` (
  `name` varchar(50) NOT NULL,
  `time` double NOT NULL,
  `race` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `uteknark`
--

DROP TABLE IF EXISTS `uteknark`;
CREATE TABLE IF NOT EXISTS `uteknark` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `stage` int(3) UNSIGNED NOT NULL DEFAULT 1,
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `soil` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `stage` (`stage`,`time`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

DROP TABLE IF EXISTS `vehicles`;
CREATE TABLE IF NOT EXISTS `vehicles` (
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL,
  `brod` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vehicles`
--

INSERT INTO `vehicles` (`name`, `model`, `price`, `category`, `brod`) VALUES
('Opel Rekord Coupe', '2dopelr3', 12, 'opel', 0),
('Opel Rekord', '4dopelr3', 14, 'opel', 0),
('Porsche 718', '718', 53, 'porsche', 0),
('Alfa Giulia Sprint', 'agta', 500, 'alfa', 0),
('Alfa Romeo 75', 'alfa75', 300, 'alfa', 0),
('Audi 100 Coupe S', 'audi100sc1', 5, 'audi', 0),
('Audi Union', 'audif103', 9, 'audi', 0),
('Audi Quattro', 'audquattros', 8, 'audi', 0),
('Austin Mini Cooper', 'austminlhd', 23, 'austin', 0),
('BMW 2002t', 'bmw2002t', 26, 'bmw', 0),
('Ferrari California 250GT', 'cali57', 23, 'ferrari', 0),
('Dinghy', 'dinghy', 800000, 'gliser', 1),
('Ferrari Dino', 'dino', 35, 'ferrari', 0),
('BMW E21', 'e21', 15, 'bmw', 0),
('Zastava 1300', 'fiat1300', 233, 'zastava', 0),
('Zastava 750', 'fiat600', 26, 'zastava', 0),
('BMW E24', 'm686eu', 17, 'bmw', 0),
('Porsche 904GTS', 'p904', 235, 'porsche', 0),
('Porsche 928', 'p928', 634, 'porsche', 0),
('Peugeot 204', 'peugeot204', 23, 'peugeot', 0),
('Porsche 911', 'porrs73', 63, 'porsche', 0),
('NSU Prinz 1000TT', 'prinztt', 12, 'nsu', 0),
('Renault 4', 'renault4', 12, 'renault', 0),
('Jet Ski', 'seashark', 500000, 'jetski', 1),
('Simca 1100', 'simca1100', 43, 'simca', 0),
('Skoda 100', 'skoda100', 23, 'skoda', 0),
('Alfa Romeo Spider 115', 'spider115', 100, 'alfa', 0),
('Squalo', 'squalo', 1500000, 'gliser', 1),
('Podmornica', 'submersible', 5000000, 'podmornica', 1),
('Podmornica 2', 'submersible2', 5000000, 'podmornica', 1),
('Suntrap', 'suntrap', 700000, 'gliser', 1),
('Tropic', 'tropic2', 1000000, 'gliser', 1),
('VW Type 3', 'type3fast', 443, 'vw', 0),
('Volvo 142', 'volvo142', 12, 'volvo', 0),
('Volvo 144', 'volvo144', 15, 'volvo', 0),
('Volvo 145', 'volvo145', 43, 'volvo', 0),
('Mercedes W115', 'w115200d', 45, 'mercedes', 0),
('Wartburg 353', 'wartburg353', 43, 'wartburg', 0),
('Zastava 101', 'zastava101', 23, 'zastava', 0);

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_categories`
--

DROP TABLE IF EXISTS `vehicle_categories`;
CREATE TABLE IF NOT EXISTS `vehicle_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL,
  `brod` int(11) NOT NULL DEFAULT 0,
  `slika` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vehicle_categories`
--

INSERT INTO `vehicle_categories` (`name`, `label`, `brod`, `slika`) VALUES
('alfa', 'Alfa Romeo', 0, 'alfa.png'),
('audi', 'Audi', 0, 'audi.png'),
('austin', 'Austin', 0, 'austin.png'),
('bmw', 'BMW', 0, 'bmw.png'),
('ferrari', 'Ferrari', 0, 'ferrari.png'),
('gliser', 'Gliser', 1, 'gtav.png'),
('jetski', 'Jet Ski', 1, 'gtav.png'),
('mercedes', 'Mercedes', 0, 'mercedes.png'),
('nsu', 'NSU', 0, 'nsu.png'),
('obrisani', 'Obrisani', 0, NULL),
('opel', 'Opel', 0, 'opel.png'),
('peugeot', 'Peugeot', 0, 'peugeot.png'),
('podmornica', 'Podmornice', 1, 'gtav.png'),
('porsche', 'Porsche', 0, 'porsche.png'),
('renault', 'Renault', 0, 'renault.png'),
('simca', 'Simca', 0, 'simca.png'),
('skoda', 'Skoda', 0, 'skoda.png'),
('volvo', 'Volvo', 0, 'volvo.png'),
('vw', 'VW', 0, 'vw.png'),
('wartburg', 'Wartburg', 0, 'wartburg.png'),
('zastava', 'Zastava', 0, 'zastava.png');

-- --------------------------------------------------------

--
-- Table structure for table `vijesti`
--

DROP TABLE IF EXISTS `vijesti`;
CREATE TABLE IF NOT EXISTS `vijesti` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Naziv` varchar(255) CHARACTER SET latin1 NOT NULL,
  `Clanak` longtext CHARACTER SET latin1 NOT NULL,
  `Autor` varchar(255) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci;

--
-- Dumping data for table `vijesti`
--

INSERT INTO `vijesti` (`ID`, `Naziv`, `Clanak`, `Autor`) VALUES
(1, 'Sikora najvolji skripter', 'Sickora je najbolj iskripter na balkanu, ostale ko jebe ! ', 'GABO'),
(2, 'Slika', '<img src=&quot;https://i.imgur.com/s3V8w2q.png&quot;>', '#Sikora'),
(3, 'Slika 2', '<img src=&quot;https://i.imgur.com/FMD4QIl.png&quot;>', '#Sikora'),
(4, 'Slika 2', '<img src=&quot;https://i.imgur.com/FMD4QIl.png&quot; width=&quot;500px&quot;>', '#Sikora'),
(5, 'Slika 2', '<img src=&quot;https://i.imgur.com/FMD4QIl.png&quot; style=&quot;width=\'500px\'&quot;>', '#Sikora'),
(6, 'Slika 2', '<img src=&quot;https://i.imgur.com/FMD4QIl.png&quot; style=&quot;width: 500px&quot;>', '#Sikora'),
(7, 'Slika 2', '<img src=&quot;https://i.imgur.com/FMD4QIl.png&quot; style=&quot;min-width: 500px&quot;>', '#Sikora');

-- --------------------------------------------------------

--
-- Table structure for table `vrata`
--

DROP TABLE IF EXISTS `vrata`;
CREATE TABLE IF NOT EXISTS `vrata` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ime` varchar(20) NOT NULL,
  `koord` varchar(200) NOT NULL DEFAULT '{}',
  `posao` int(11) DEFAULT NULL,
  `dist` double(4,1) NOT NULL,
  `model` varchar(100) NOT NULL,
  `banka` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `vrata`
--

INSERT INTO `vrata` (`ID`, `ime`, `koord`, `posao`, `dist`, `model`, `banka`) VALUES
(40, 'vrata_16', '{\"x\":464.361328125,\"y\":-984.6780395507813,\"z\":43.83443450927734}', 4, 2.0, '-340230128', 0),
(39, 'vrata_15', '{\"x\":461.2864990234375,\"y\":-985.320556640625,\"z\":30.83926391601562}', 4, 2.0, '749848321', 0),
(38, 'vrata_14', '{\"x\":488.894775390625,\"y\":-1017.2102661132813,\"z\":27.14793968200683}', 4, 10.0, '-1603817716', 0),
(37, 'vrata_13', '{\"x\":469.9678955078125,\"y\":-1014.4520263671875,\"z\":26.5362319946289}', 4, 2.0, '-2023754432', 0),
(36, 'vrata_12', '{\"x\":467.37164306640627,\"y\":-1014.4520263671875,\"z\":26.5362319946289}', 4, 2.0, '-2023754432', 0),
(35, 'vrata_11', '{\"x\":463.4782409667969,\"y\":-1003.5381469726563,\"z\":25.00598907470703}', 4, 2.0, '-1033001619', 0),
(34, 'vrata_10', '{\"x\":461.8065185546875,\"y\":-1001.301513671875,\"z\":25.06442642211914}', 4, 2.0, '631614199', 0),
(33, 'vrata_9', '{\"x\":461.8064880371094,\"y\":-997.6583251953125,\"z\":25.06442642211914}', 4, 2.0, '631614199', 0),
(32, 'vrata_8', '{\"x\":461.8065185546875,\"y\":-994.4085693359375,\"z\":25.06442642211914}', 4, 2.0, '631614199', 0),
(31, 'vrata_7', '{\"x\":464.57012939453127,\"y\":-992.6640625,\"z\":25.06442642211914}', 4, 2.0, '631614199', 0),
(30, 'vrata_6', '{\"x\":443.0298156738281,\"y\":-994.5411987304688,\"z\":30.83930206298828}', 4, 2.0, '-131296141', 0),
(29, 'vrata_5', '{\"x\":443.0298156738281,\"y\":-991.9410400390625,\"z\":30.83930206298828}', 4, 2.0, '-131296141', 0),
(28, 'vrata_4', '{\"x\":443.40777587890627,\"y\":-989.4454345703125,\"z\":30.83930206298828}', 4, 2.0, '185711165', 0),
(27, 'vrata_3', '{\"x\":446.0079345703125,\"y\":-989.4454345703125,\"z\":30.83930206298828}', 4, 2.0, '185711165', 0),
(26, 'vrata_2', '{\"x\":450.1041259765625,\"y\":-985.7384033203125,\"z\":30.83930206298828}', 4, 2.0, '1557126584', 0),
(25, 'vrata_1', '{\"x\":434.74786376953127,\"y\":-980.618408203125,\"z\":30.83926391601562}', 4, 2.0, '-1215222675', 0),
(24, 'vrata_0', '{\"x\":434.74786376953127,\"y\":-983.215087890625,\"z\":30.83926391601562}', 4, 2.0, '320433149', 0),
(41, 'vrata_17', '{\"x\":446.57281494140627,\"y\":-980.0105590820313,\"z\":30.83930206298828}', 4, 2.0, '-1320876379', 0),
(42, 'vrata_18', '{\"x\":452.29931640625,\"y\":-1001.1792602539063,\"z\":26.75753021240234}', 4, 5.0, '-190780785', 0),
(43, 'vrata_19', '{\"x\":447.48602294921877,\"y\":-1001.1807861328125,\"z\":26.75554847717285}', 4, 5.0, '-190780785', 0),
(45, 'vrata_20', '{\"x\":-1104.6572265625,\"y\":-1638.4814453125,\"z\":4.67540407180786}', 2, 3.0, '-502195954', 0),
(46, 'vrata_21', '{\"x\":256.3115539550781,\"y\":220.65785217285157,\"z\":106.42955780029297}', 4, 3.0, '-222270721', 1),
(47, 'vrata_22', '{\"x\":262.1980895996094,\"y\":222.518798828125,\"z\":106.42955780029297}', 4, 3.0, '746855201', 1),
(48, 'vrata_23', '{\"x\":251.85757446289063,\"y\":221.0654754638672,\"z\":101.83240509033203}', 4, 3.0, '1655182495', 1),
(49, 'vrata_24', '{\"x\":261.3004150390625,\"y\":214.50514221191407,\"z\":101.83240509033203}', 4, 3.0, '-1508355822', 1),
(50, 'vrata_25', '{\"x\":266.36236572265627,\"y\":217.5697479248047,\"z\":110.43282318115235}', 4, 3.0, '1956494919', 1);

-- --------------------------------------------------------

--
-- Table structure for table `waroruzja`
--

DROP TABLE IF EXISTS `waroruzja`;
CREATE TABLE IF NOT EXISTS `waroruzja` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` char(60) NOT NULL,
  `data` longtext NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `warovi`
--

DROP TABLE IF EXISTS `warovi`;
CREATE TABLE IF NOT EXISTS `warovi` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Ime` tinytext DEFAULT NULL,
  `Win` int(11) DEFAULT 0,
  `Lose` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `weashops`
--

DROP TABLE IF EXISTS `weashops`;
CREATE TABLE IF NOT EXISTS `weashops` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `item` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `weashops`
--

INSERT INTO `weashops` (`id`, `name`, `item`, `price`) VALUES
(1, 'GunShop', 'WEAPON_PISTOL', 1000),
(5, 'GunShop', 'WEAPON_MACHETE', 100),
(11, 'GunShop', 'WEAPON_STUNGUN', 200),
(41, 'GunShop', 'WEAPON_KNIFE', 50),
(42, 'GunShop', 'WEAPON_CROWBAR', 75),
(43, 'GunShop', 'WEAPON_DAGGER', 75),
(44, 'GunShop', 'WEAPON_KNUCKLE', 45),
(45, 'GunShop', 'WEAPON_SWITCHBLADE', 75),
(46, 'GunShop', 'WEAPON_PISTOL_MK2', 1200),
(47, 'GunShop', 'WEAPON_PISTOL50', 1400),
(48, 'GunShop', 'WEAPON_MICROSMG', 25000),
(49, 'GunShop', 'WEAPON_COMBATPISTOL', 5000);

-- --------------------------------------------------------

--
-- Table structure for table `weashops2`
--

DROP TABLE IF EXISTS `weashops2`;
CREATE TABLE IF NOT EXISTS `weashops2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `owner` varchar(60) DEFAULT NULL,
  `sef` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `owname` (`owner`,`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `weashops2`
--

INSERT INTO `weashops2` (`id`, `name`, `owner`, `sef`) VALUES
(1, 'GunShop1', NULL, 0),
(2, 'GunShop2', NULL, 0),
(3, 'GunShop3', 'steam:11000010e086b7e', 11850),
(4, 'GunShop4', 'steam:11000010e086b7e', 161238),
(5, 'GunShop5', NULL, 0),
(6, 'GunShop6', 'steam:11000010441bee9', 56462),
(7, 'GunShop7', NULL, 0),
(8, 'GunShop8', NULL, 0),
(9, 'GunShop9', NULL, 0),
(10, 'GunShop10', 'steam:11000010441bee9', 18100);

-- --------------------------------------------------------

--
-- Table structure for table `yellow_tweets`
--

DROP TABLE IF EXISTS `yellow_tweets`;
CREATE TABLE IF NOT EXISTS `yellow_tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `firstname` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `novine` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `novine` (`novine`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `yellow_tweets`
--

INSERT INTO `yellow_tweets` (`id`, `phone_number`, `firstname`, `lastname`, `message`, `time`, `novine`) VALUES
(1, '185-9995', 'Tony', 'Sikora', 'aaa bbb ccc ddd eee', '2021-10-17 14:41:40', 1),
(2, '579-9678', 'Tuljan', 'Ljantu', 'Prodajem 10 crvenih dijamanata', '2021-10-23 23:00:18', 1),
(3, '579-9678', 'Tuljan', 'Ljantu', 'moze zamjena za plave', '2021-10-23 23:00:28', 1),
(4, '530-0343', 'Max', 'Cigarett', 'Pusis kurac', '2021-10-23 23:01:02', 1),
(5, '579-9678', 'Tuljan', 'Ljantu', 'Kupujem ferrari', '2021-10-28 20:29:24', 1),
(6, '185-9995', 'Tony', 'Sikora', 'dgfdgdf fdsgf', '2021-12-23 11:58:24', 1),
(7, '185-9995', 'Tony', 'Sikora', 'dfsfsdfd sdsdfs', '2021-12-23 12:15:27', 1),
(8, '185-9995', 'Tony', 'Sikora', 'Prodajem corsu', '2021-12-23 12:44:11', 1),
(9, '185-9995', 'Tony', 'Sikora', 'gfdg sdfsdf', '2021-12-23 15:59:55', 1),
(10, '185-9995', 'Tony', 'Sikora', 'h gdghdfgfds fs', '2021-12-23 22:47:32', 1),
(11, '185-9995', 'Tony', 'Sikora', ' gfdgsfd dfsfdsf', '2021-12-23 23:18:53', 1),
(12, '185-9995', 'Tony', 'Sikora', ' hdgfhdfg sgffs', '2021-12-23 23:19:27', 1),
(13, '185-9995', 'Tony', 'Sikora', 'https://media.discordapp.net/attachments/923544204397920256/923722215487307926/screenshot.jpg', '2021-12-23 23:42:17', 1),
(14, '185-9995', 'Tony', 'Sikora', 'https://media.discordapp.net/attachments/923544204397920256/924023616771866654/screenshot.jpg', '2021-12-24 19:39:56', 1),
(15, '185-9995', 'Tony', 'Sikora', 'https://media.discordapp.net/attachments/923544204397920256/925473260777394306/screenshot.jpg', '2021-12-28 19:40:20', 1),
(16, '579-9678', 'Tuljan', 'Ljantu', 'alo', '2022-01-09 18:00:40', 1),
(17, '579-9678', 'Tuljan', 'Ljantu', 'https://media.discordapp.net/attachments/923544204397920256/929813748015829142/screenshot.jpg', '2022-01-09 19:07:51', 1),
(18, '185-9995', 'Tony', 'Sikora', 'https://media.discordapp.net/attachments/923544204397920256/931949644471226478/screenshot.jpg', '2022-01-15 16:35:10', 1),
(19, '579-9678', 'Tuljan', 'Ljantu', 'https://media.discordapp.net/attachments/923544204397920256/931950397101338684/screenshot.jpg', '2022-01-15 16:38:10', 1),
(20, '185-9995', 'Tony', 'Sikora', 'https://media.discordapp.net/attachments/923544204397920256/932045967757299752/screenshot.jpg', '2022-01-15 22:57:55', 1),
(21, '185-9995', 'Tony', 'Sikora', 'https://media.discordapp.net/attachments/923544204397920256/932046930404585472/screenshot.jpg', '2022-01-15 23:01:44', 1),
(22, '185-9995', 'Tony', 'Sikora', 'https://media.discordapp.net/attachments/923544204397920256/933107734629453904/screenshot.jpg', '2022-01-18 21:17:00', 1),
(23, '185-9995', 'Tony', 'Sikora', 'https://media.discordapp.net/attachments/923544204397920256/933110193250783412/screenshot.jpg', '2022-01-18 21:26:46', 1),
(24, '185-9995', 'Tony', 'Sikora', 'https://media.discordapp.net/attachments/923544204397920256/933116659894480986/screenshot.jpg', '2022-01-18 21:52:27', 1),
(25, '579-9678', 'Tuljan', 'Ljantu', 'https://media.discordapp.net/attachments/923544204397920256/933478241623236628/screenshot.jpg', '2022-01-19 21:49:14', 1),
(26, '3555299', 'Tony', 'Sikora', 'Testiram nove oglase hehe', '2022-05-23 20:10:14', 1),
(27, '3555299', 'Tony', 'Sikora', 'Prodajem Yugo volim ga puno! Samo dobre ponude', '2022-05-23 20:26:55', 1),
(28, '3555299', 'Tony', 'Sikora', 'Imal ko para da posalje?', '2022-05-23 20:43:04', 1),
(29, '3555299', 'Tony', 'Sikora', 'Hvala Tony Sikora na 50000 dolara', '2022-05-23 20:43:32', 1),
(30, '3555299', 'Tony', 'Sikora', 'Evo mi je jos love poslao lik', '2022-05-23 20:44:00', 1),
(31, '3555299', 'Tony', 'Sikora', 'Prodajem Yuga. $500', '2022-05-24 18:57:07', 1);

-- --------------------------------------------------------

--
-- Table structure for table `zemljista`
--

DROP TABLE IF EXISTS `zemljista`;
CREATE TABLE IF NOT EXISTS `zemljista` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Ime` varchar(255) NOT NULL,
  `Koord1` longtext NOT NULL DEFAULT '{}',
  `Koord2` longtext NOT NULL DEFAULT '{}',
  `Cijena` int(11) NOT NULL DEFAULT 0,
  `Vlasnik` int(11) DEFAULT NULL,
  `Kuca` varchar(255) DEFAULT NULL,
  `KKoord` longtext NOT NULL DEFAULT '{}',
  `MKoord` longtext NOT NULL DEFAULT '{}',
  `KucaID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `zemljista`
--

INSERT INTO `zemljista` (`ID`, `Ime`, `Koord1`, `Koord2`, `Cijena`, `Vlasnik`, `Kuca`, `KKoord`, `MKoord`, `KucaID`) VALUES
(9, 'Zemljiste 1', '[203.828125,3219.237548828125,41.32288360595703]', '[187.4740753173828,3200.868896484375,41.16582870483398]', 120000, NULL, NULL, '{}', '{\"x\":207.5401153564453,\"y\":3218.24755859375,\"z\":42.37691497802734}', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `zone`
--

DROP TABLE IF EXISTS `zone`;
CREATE TABLE IF NOT EXISTS `zone` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ime` varchar(250) NOT NULL,
  `koord` varchar(255) NOT NULL,
  `velicina` int(11) NOT NULL,
  `rotacija` int(11) NOT NULL,
  `boja` int(11) NOT NULL DEFAULT 0,
  `vlasnik` varchar(35) DEFAULT NULL,
  `label` varchar(250) DEFAULT NULL,
  `vrijeme` int(11) NOT NULL DEFAULT 0,
  `vrijednost` int(11) NOT NULL DEFAULT 30000,
  `PedKoord` varchar(255) DEFAULT NULL,
  `PedHead` double(11,2) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `zone`
--

INSERT INTO `zone` (`ID`, `ime`, `koord`, `velicina`, `rotacija`, `boja`, `vlasnik`, `label`, `vrijeme`, `vrijednost`, `PedKoord`, `PedHead`) VALUES
(1, 'zona1', '{\"x\":105.22411346435547,\"y\":-1940.76611328125,\"z\":20.23876953125}', 300, 51, 0, NULL, NULL, 0, 40000, '{\"x\":75.71347045898438,\"y\":-1970.0006103515626,\"z\":21.12518119812011}', 140.85),
(2, 'zona2', '{\"x\":1297.9000244140626,\"y\":-1724.8807373046876,\"z\":53.41697311401367}', 200, 115, 0, NULL, NULL, 0, 30000, NULL, NULL),
(3, 'zona3', '{\"x\":8.01981258392334,\"y\":-2478.081787109375,\"z\":5.44206237792968}', 200, -123, 0, NULL, NULL, 0, 30000, NULL, NULL),
(4, 'zona4', '{\"x\":-1048.6021728515626,\"y\":-1143.892578125,\"z\":1.55892622470855}', 100, 121, 0, NULL, NULL, 0, 20000, NULL, NULL),
(5, 'zona5', '{\"x\":-956.7833862304688,\"y\":-1090.5233154296876,\"z\":1.65182423591613}', 100, 122, 0, NULL, NULL, 0, 20000, NULL, NULL),
(6, 'zona6', '{\"x\":-113.91008758544922,\"y\":923.5415649414063,\"z\":235.12802124023438}', 200, 39, 0, NULL, NULL, 0, 30000, NULL, NULL),
(7, 'zona7', '{\"x\":1829.34326171875,\"y\":3860.934814453125,\"z\":33.62311553955078}', 200, 31, 0, NULL, NULL, 0, 30000, NULL, NULL),
(8, 'zona8', '{\"x\":-210.73080444335938,\"y\":6362.62939453125,\"z\":31.49229049682617}', 200, -44, 0, NULL, NULL, 0, 30000, NULL, NULL),
(9, 'zona9', '{\"x\":-1054.79931640625,\"y\":-1576.043212890625,\"z\":4.77379131317138}', 200, -147, 0, NULL, NULL, 0, 30000, NULL, NULL),
(10, 'zona10', '{\"x\":2862.156005859375,\"y\":2823.3935546875,\"z\":53.36796569824219}', 400, -121, 0, NULL, NULL, 0, 50000, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `zpostavke`
--

DROP TABLE IF EXISTS `zpostavke`;
CREATE TABLE IF NOT EXISTS `zpostavke` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idzone` int(11) NOT NULL,
  `mafije` longtext NOT NULL,
  `vrijeme` int(11) NOT NULL,
  `sat` int(11) NOT NULL DEFAULT 0,
  `minuta` int(11) NOT NULL DEFAULT 0,
  `zauzimanje` int(11) NOT NULL DEFAULT 10,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `zpostavke`
--

INSERT INTO `zpostavke` (`id`, `idzone`, `mafije`, `vrijeme`, `sat`, `minuta`, `zauzimanje`) VALUES
(1, 11, '[]', 10, 0, 0, 10);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `twitter_likes`
--
ALTER TABLE `twitter_likes`
  ADD CONSTRAINT `FK_twitter_likes_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`),
  ADD CONSTRAINT `FK_twitter_likes_twitter_tweets` FOREIGN KEY (`tweetId`) REFERENCES `twitter_tweets` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `twitter_tweets`
--
ALTER TABLE `twitter_tweets`
  ADD CONSTRAINT `FK_twitter_tweets_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
