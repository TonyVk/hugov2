-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Feb 13, 2023 at 08:51 PM
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
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `addon_account`
--

INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('society_mechanic', 'Mehanicar', 1),
('society_omerta', 'omerta', 1),
('society_montana', 'montana', 1),
('society_panthers', 'panthers', 1),
('society_ambulance', 'Bolnica', 1),
('society_police', 'Policija', 1),
('society_sinaloa', 'sinaloa', 1),
('society_pollos', 'pollos', 1),
('society_zemunski', 'zemunski', 1),
('society_devilzeye', 'devilzeye', 1),
('society_fake', 'fake', 1);

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
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `index_addon_account_data_account_name_owner` (`account_name`,`owner`) USING BTREE,
  KEY `index_addon_account_data_account_name` (`account_name`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `addon_account_data`
--

INSERT INTO `addon_account_data` (`id`, `account_name`, `money`, `owner`) VALUES
(1, 'society_mechanic', 232755, NULL),
(24, 'society_omerta', 68401, NULL),
(25, 'society_montana', 15000, NULL),
(26, 'society_panthers', 0, NULL),
(27, 'society_ambulance', 342299, NULL),
(41, 'society_zemunski', 30000, NULL),
(39, 'society_sinaloa', 15000, NULL),
(40, 'society_pollos', 0, NULL),
(42, 'society_devilzeye', 0, NULL),
(38, 'society_police', 71680, NULL),
(43, 'society_fake', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `addon_inventory`
--

DROP TABLE IF EXISTS `addon_inventory`;
CREATE TABLE IF NOT EXISTS `addon_inventory` (
  `name` int(11) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `addon_inventory`
--

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
(3, 'Mehanicar', 1),
(7, 'omerta', 1),
(8, 'montana', 1),
(9, 'panthers', 1),
(10, 'sinaloa', 1),
(11, 'pollos', 1),
(12, 'zemunski', 1),
(13, 'devilzeye', 1),
(14, 'fake', 1);

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
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_addon_inventory_items_inventory_name_name` (`inventory_name`,`name`) USING BTREE,
  KEY `index_addon_inventory_items_inventory_name_name_owner` (`inventory_name`,`name`,`owner`) USING BTREE,
  KEY `index_addon_inventory_inventory_name` (`inventory_name`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=81 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `addon_inventory_items`
--

INSERT INTO `addon_inventory_items` (`id`, `inventory_name`, `name`, `count`, `owner`) VALUES
(70, 7, 'narukvica', 1, NULL),
(69, 7, 'diamond', 0, NULL),
(53, 7, 'clip', 13, NULL),
(54, 7, 'cocaine', 2, NULL),
(74, 10, 'kola', 10, NULL),
(56, 10, 'cocaine', 24, NULL),
(73, 10, 'burek', 10, NULL),
(58, 10, 'gljive', 60, NULL),
(59, 10, 'clip', 40, NULL),
(72, 12, 'clip', 6, NULL),
(61, 10, 'fishbait', 5, NULL),
(62, 10, 'novine', 0, NULL),
(63, 10, 'ukosnica', 8, NULL),
(64, 10, 'water', 11, NULL),
(65, 10, 'fishingrod', 1, NULL),
(71, 7, 'lancic', 2, NULL),
(75, 10, 'bread', 13, NULL),
(76, 10, 'contract', 2, NULL),
(77, 10, 'milk', 18, NULL),
(78, 10, 'petarde', 6, NULL),
(79, 12, 'cocaine', 1, NULL),
(80, 7, 'gljive', 2, NULL);

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
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=70 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

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
(67, '{\"x\":327.63372802734377,\"y\":-1373.388671875,\"z\":31.90983009338379}', '{\"x\":328.00469970703127,\"y\":-1372.8931884765626,\"z\":30.91242218017578}', 50000, 319.79721069336, 'prop_atm_01'),
(68, '{\"x\":-42.71115493774414,\"y\":-1108.6986083984376,\"z\":26.4374713897705}', '{\"x\":-42.41256713867187,\"y\":-1107.8775634765626,\"z\":25.40389060974121}', 50000, 342.39886474609, 'prop_atm_01');

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
  PRIMARY KEY (`identifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;


--
-- Table structure for table `banka_transakcije`
--

DROP TABLE IF EXISTS `banka_transakcije`;
CREATE TABLE IF NOT EXISTS `banka_transakcije` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Vlasnik` int(11) DEFAULT NULL,
  `Tekst` varchar(255) DEFAULT NULL,
  `Iznos` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `vlasnik` (`Vlasnik`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1322 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

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
  `permanent` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`identifier`) USING BTREE,
  KEY `target` (`targetplayername`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

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
  `permanent` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

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
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=175 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Table structure for table `biznisi`
--

DROP TABLE IF EXISTS `biznisi`;
CREATE TABLE IF NOT EXISTS `biznisi` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Ime` text NOT NULL,
  `Label` text NOT NULL,
  `Koord` longtext NOT NULL,
  `Sef` int(11) NOT NULL DEFAULT 0,
  `Vlasnik` int(11) DEFAULT NULL,
  `Posao` varchar(100) DEFAULT NULL,
  `Sati` longtext NOT NULL,
  `Tjedan` int(11) NOT NULL DEFAULT 0,
  `Cijena` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `biznisi`
--

INSERT INTO `biznisi` (`ID`, `Ime`, `Label`, `Koord`, `Sef`, `Vlasnik`, `Posao`, `Sati`, `Tjedan`, `Cijena`) VALUES
(1, 'kosac', 'Kosac trave', '[-1366.4168701171876,56.53075408935547,53.09845733642578]', 28391, NULL, 'kosac', '[{\"Ture\":71,\"Identifier\":\"steam:1100001471ff8c3\",\"Ime\":\"Mr_Kamata34\",\"Posao\":\"kosac\"},{\"Ture\":62,\"Identifier\":\"steam:110000143e51bb0\",\"Ime\":\"tare\",\"Posao\":\"kosac\"},{\"Ture\":98,\"Identifier\":\"steam:11000014988d699\",\"Ime\":\"muskodijete\",\"Posao\":\"kosac\"},{\"Ture\":96,\"Identifier\":\"steam:11000014178fc90\",\"Ime\":\"ZvakanZi\",\"Posao\":\"kosac\"},{\"Ture\":226,\"Identifier\":\"steam:110000154a6fede\",\"Ime\":\"RENTA\",\"Posao\":\"kosac\"},{\"Ture\":48,\"Identifier\":\"steam:110000112dff0ee\",\"Ime\":\"s1mple\",\"Posao\":\"kosac\"},{\"Ture\":171,\"Identifier\":\"steam:1100001195a665a\",\"Ime\":\"CaseOpening.com\",\"Posao\":\"kosac\"},{\"Ture\":41,\"Identifier\":\"steam:110000142b42c97\",\"Ime\":\"canadi15\",\"Posao\":\"kosac\"},{\"Ture\":146,\"Identifier\":\"steam:11000011b516642\",\"Ime\":\"F1K0\",\"Posao\":\"kosac\"},{\"Ture\":79,\"Identifier\":\"steam:11000011538e683\",\"Ime\":\"Dioniz\",\"Posao\":\"kosac\"},{\"Ture\":48,\"Identifier\":\"steam:11000013f2cd9cb\",\"Ime\":\"BABKELA\",\"Posao\":\"kosac\"},{\"Ture\":23,\"Identifier\":\"steam:110000143f7d0ef\",\"Ime\":\"archinjo\",\"Posao\":\"kosac\"},{\"Ture\":48,\"Identifier\":\"steam:11000014501a284\",\"Ime\":\"Keksic\",\"Posao\":\"kosac\"},{\"Ture\":2,\"Identifier\":\"steam:110000143fd66c6\",\"Ime\":\"keno\",\"Posao\":\"kosac\"},{\"Ture\":23,\"Identifier\":\"steam:110000143474ffb\",\"Ime\":\"Agony_\",\"Posao\":\"kosac\"},{\"Ture\":296,\"Identifier\":\"steam:1100001439b7091\",\"Ime\":\"Nicknarmam\",\"Posao\":\"kosac\"},{\"Ture\":25,\"Identifier\":\"steam:11000014665c310\",\"Ime\":\"Aezakmi\",\"Posao\":\"kosac\"},{\"Ture\":48,\"Identifier\":\"steam:110000157982204\",\"Ime\":\"roksonnn\",\"Posao\":\"kosac\"},{\"Ture\":25,\"Identifier\":\"steam:11000013e28a1b4\",\"Ime\":\"tobq\",\"Posao\":\"kosac\"},{\"Ture\":23,\"Identifier\":\"steam:11000014001f43b\",\"Ime\":\"N1KKOLIC\",\"Posao\":\"kosac\"},{\"Ture\":48,\"Identifier\":\"steam:11000011b25fb24\",\"Ime\":\"Guffy\",\"Posao\":\"kosac\"},{\"Ture\":25,\"Identifier\":\"steam:11000013ef89181\",\"Ime\":\"Milenko\",\"Posao\":\"kosac\"},{\"Ture\":48,\"Identifier\":\"steam:11000013f8072dd\",\"Ime\":\"LeoG16\",\"Posao\":\"kosac\"},{\"Ture\":25,\"Identifier\":\"steam:110000140dca7b2\",\"Ime\":\"nemanya\",\"Posao\":\"kosac\"},{\"Ture\":25,\"Identifier\":\"steam:11000013d2e6edd\",\"Ime\":\"XD Automaticbox\",\"Posao\":\"kosac\"},{\"Ture\":4,\"Identifier\":\"steam:110000145ba7112\",\"Ime\":\"Gazda Elo\",\"Posao\":\"kosac\"},{\"Ture\":25,\"Identifier\":\"steam:11000010086a31a\",\"Ime\":\"taylor\",\"Posao\":\"kosac\"},{\"Ture\":27,\"Identifier\":\"steam:110000147a321ac\",\"Ime\":\"Mareee\",\"Posao\":\"kosac\"},{\"Ture\":50,\"Identifier\":\"steam:11000014d54f2a4\",\"Ime\":\"dusan.marcinko\",\"Posao\":\"kosac\"},{\"Ture\":28,\"Identifier\":\"steam:11000014a135db2\",\"Ime\":\"KILA\",\"Posao\":\"kosac\"},{\"Ture\":50,\"Identifier\":\"steam:1100001404f5e8f\",\"Ime\":\"z\",\"Posao\":\"kosac\"},{\"Ture\":5,\"Identifier\":\"steam:11000011bf21bf4\",\"Ime\":\"Gabac Soliteri\",\"Posao\":\"kosac\"},{\"Ture\":313,\"Identifier\":\"steam:110000157f83eb8\",\"Ime\":\"SeboX\",\"Posao\":\"kosac\"},{\"Ture\":48,\"Identifier\":\"steam:11000014504a368\",\"Ime\":\"NIKOLA\",\"Posao\":\"kosac\"},{\"Ture\":48,\"Identifier\":\"steam:1100001323281be\",\"Ime\":\"KeNo\",\"Posao\":\"kosac\"},{\"Ture\":75,\"Identifier\":\"steam:11000014a6ba4ca\",\"Ime\":\"Hajko\",\"Posao\":\"kosac\"},{\"Ture\":7,\"Identifier\":\"steam:1100001549cf4ac\",\"Ime\":\"?et private\",\"Posao\":\"kosac\"},{\"Ture\":46,\"Identifier\":\"steam:11000013d34658b\",\"Ime\":\"Vajdic81\",\"Posao\":\"kosac\"},{\"Ture\":25,\"Identifier\":\"steam:11000013f04c5a1\",\"Ime\":\"Nujic\",\"Posao\":\"kosac\"},{\"Ture\":23,\"Identifier\":\"steam:1100001419c278c\",\"Ime\":\"RoKY\",\"Posao\":\"kosac\"},{\"Ture\":48,\"Identifier\":\"steam:110000153e7aada\",\"Ime\":\"0rale3\",\"Posao\":\"kosac\"},{\"Ture\":48,\"Identifier\":\"steam:11000014ac39013\",\"Ime\":\"jocke\",\"Posao\":\"kosac\"},{\"Ture\":75,\"Identifier\":\"steam:11000013b469395\",\"Ime\":\"Antara\",\"Posao\":\"kosac\"},{\"Ture\":48,\"Identifier\":\"steam:11000013c62d09d\",\"Ime\":\"Faksic\",\"Posao\":\"kosac\"},{\"Ture\":198,\"Identifier\":\"steam:11000014b267b6c\",\"Ime\":\"_DeNA\",\"Posao\":\"kosac\"},{\"Ture\":100,\"Identifier\":\"steam:11000014b944a74\",\"Ime\":\"loxyrr\",\"Posao\":\"kosac\"},{\"Ture\":73,\"Identifier\":\"steam:110000143f405aa\",\"Ime\":\"Stefann\",\"Posao\":\"kosac\"},{\"Ture\":50,\"Identifier\":\"steam:11000013c32bab2\",\"Ime\":\"guccigangster04\",\"Posao\":\"kosac\"},{\"Ture\":73,\"Identifier\":\"steam:1100001352d4005\",\"Ime\":\"pwrt\",\"Posao\":\"kosac\"},{\"Ture\":48,\"Identifier\":\"steam:110000135249a26\",\"Ime\":\"kice\",\"Posao\":\"kosac\"},{\"Ture\":48,\"Identifier\":\"steam:1100001131c708a\",\"Ime\":\"Arsic\",\"Posao\":\"kosac\"},{\"Ture\":38,\"Identifier\":\"steam:11000013fda9870\",\"Ime\":\"AleksaGromovnik\",\"Posao\":\"kosac\"},{\"Ture\":42,\"Identifier\":\"steam:110000149f91290\",\"Ime\":\"Cico\",\"Posao\":\"kosac\"},{\"Ture\":48,\"Identifier\":\"steam:11000014129d133\",\"Ime\":\"Marche\",\"Posao\":\"kosac\"},{\"Ture\":29,\"Identifier\":\"steam:11000014427c89d\",\"Ime\":\"konj\",\"Posao\":\"kosac\"},{\"Ture\":71,\"Identifier\":\"steam:110000141620722\",\"Ime\":\"matonja\",\"Posao\":\"kosac\"},{\"Ture\":25,\"Identifier\":\"steam:11000013e823f33\",\"Ime\":\"! pakas\",\"Posao\":\"kosac\"},{\"Ture\":18,\"Identifier\":\"steam:1100001455abc11\",\"Ime\":\"Mirza Hatic\",\"Posao\":\"kosac\"},{\"Ture\":28,\"Identifier\":\"steam:1100001096e21ac\",\"Ime\":\"_Puja_\",\"Posao\":\"kosac\"},{\"Ture\":261,\"Identifier\":\"steam:11000014980e634\",\"Ime\":\"Denii2012\",\"Posao\":\"kosac\"},{\"Ture\":1,\"Identifier\":\"steam:11000014792d68c\",\"Ime\":\"Hardy\",\"Posao\":\"kosac\"},{\"Ture\":71,\"Identifier\":\"steam:110000149eb3f3b\",\"Ime\":\"tinoo\",\"Posao\":\"kosac\"},{\"Ture\":75,\"Identifier\":\"steam:11000013dd3535b\",\"Ime\":\"Papsonja\",\"Posao\":\"kosac\"},{\"Ture\":48,\"Identifier\":\"steam:11000013fe2ac61\",\"Ime\":\"hoko\",\"Posao\":\"kosac\"},{\"Ture\":71,\"Identifier\":\"steam:110000110ebee4a\",\"Ime\":\"Buttcrack\",\"Posao\":\"kosac\"},{\"Ture\":25,\"Identifier\":\"steam:11000013221d9cd\",\"Ime\":\"Bruske\",\"Posao\":\"kosac\"},{\"Ture\":26,\"Identifier\":\"steam:110000143299a98\",\"Ime\":\"šime\",\"Posao\":\"kosac\"},{\"Ture\":25,\"Identifier\":\"steam:11000014b913dbd\",\"Ime\":\"Tom Shelby\",\"Posao\":\"kosac\"},{\"Ture\":30,\"Identifier\":\"steam:11000014be8e349\",\"Ime\":\"MKD Gopas\",\"Posao\":\"kosac\"},{\"Ture\":98,\"Identifier\":\"steam:11000013684104a\",\"Ime\":\"Borko\",\"Posao\":\"kosac\"},{\"Ture\":50,\"Identifier\":\"steam:110000145e6bd52\",\"Ime\":\"..hamza00..\",\"Posao\":\"kosac\"},{\"Ture\":48,\"Identifier\":\"steam:1100001498d569d\",\"Ime\":\"Medo_-\",\"Posao\":\"kosac\"},{\"Ture\":23,\"Identifier\":\"steam:110000141672269\",\"Ime\":\"BOT Edvard\",\"Posao\":\"kosac\"},{\"Ture\":80,\"Identifier\":\"steam:11000013e993ebd\",\"Ime\":\"Pajser\",\"Posao\":\"kosac\"},{\"Ture\":25,\"Identifier\":\"steam:1100001470e6e2a\",\"Ime\":\"Sandev\",\"Posao\":\"kosac\"},{\"Ture\":26,\"Identifier\":\"steam:110000118a1c645\",\"Ime\":\"Brutinq\",\"Posao\":\"kosac\"},{\"Ture\":25,\"Identifier\":\"steam:110000148197aa9\",\"Ime\":\"Shefw_jurkke\",\"Posao\":\"kosac\"},{\"Ture\":48,\"Identifier\":\"steam:11000014ab75335\",\"Ime\":\"Miloica\",\"Posao\":\"kosac\"},{\"Ture\":48,\"Identifier\":\"steam:1100001566c578c\",\"Ime\":\"ludifran\",\"Posao\":\"kosac\"},{\"Ture\":23,\"Identifier\":\"steam:110000116f468b2\",\"Ime\":\"Bot4real\",\"Posao\":\"kosac\"},{\"Ture\":23,\"Identifier\":\"steam:11000013c1c0eeb\",\"Ime\":\"LokiStršljen\",\"Posao\":\"kosac\"},{\"Ture\":23,\"Identifier\":\"steam:11000013ffe149a\",\"Ime\":\"Kak ti Stara!!\",\"Posao\":\"kosac\"},{\"Ture\":48,\"Identifier\":\"steam:11000014e763e71\",\"Ime\":\"Crni\",\"Posao\":\"kosac\"},{\"Ture\":54,\"Identifier\":\"steam:11000013d3ed284\",\"Ime\":\"farisozza\",\"Posao\":\"kosac\"},{\"Ture\":48,\"Identifier\":\"steam:11000011cd15099\",\"Ime\":\"Trstmat\",\"Posao\":\"kosac\"},{\"Ture\":48,\"Identifier\":\"steam:1100001466217e8\",\"Ime\":\"loweLLLLLL\",\"Posao\":\"kosac\"},{\"Ture\":46,\"Identifier\":\"steam:110000148ee1c95\",\"Ime\":\"Skeva\",\"Posao\":\"kosac\"},{\"Ture\":97,\"Identifier\":\"steam:1100001581cccef\",\"Ime\":\"Bax1921\",\"Posao\":\"kosac\"},{\"Ture\":297,\"Identifier\":\"steam:1100001419dbf65\",\"Ime\":\"reef\",\"Posao\":\"kosac\"},{\"Ture\":42,\"Identifier\":\"steam:110000157b7b7b7\",\"Ime\":\"BabaMarac\",\"Posao\":\"kosac\"},{\"Ture\":30,\"Identifier\":\"steam:110000149a19b0b\",\"Ime\":\"?????\",\"Posao\":\"kosac\"},{\"Ture\":98,\"Identifier\":\"steam:110000145777785\",\"Ime\":\"Dela\",\"Posao\":\"kosac\"},{\"Ture\":25,\"Identifier\":\"steam:110000140751fb3\",\"Ime\":\"Savo barašnov\",\"Posao\":\"kosac\"},{\"Ture\":23,\"Identifier\":\"steam:11000011a71b4df\",\"Ime\":\"Antich\",\"Posao\":\"kosac\"},{\"Ture\":114,\"Identifier\":\"steam:11000014877a3eb\",\"Ime\":\"DyL3 ??  csgocases_com\",\"Posao\":\"kosac\"},{\"Ture\":48,\"Identifier\":\"steam:11000014b92d4c5\",\"Ime\":\"SaNtIc\",\"Posao\":\"kosac\"},{\"Ture\":48,\"Identifier\":\"steam:11000014548a27c\",\"Ime\":\"NiKo\",\"Posao\":\"kosac\"},{\"Ture\":48,\"Identifier\":\"steam:1100001434beeed\",\"Ime\":\"stefkeew\",\"Posao\":\"kosac\"},{\"Ture\":48,\"Identifier\":\"steam:110000144a66db3\",\"Ime\":\"ArminFast\",\"Posao\":\"kosac\"},{\"Ture\":48,\"Identifier\":\"steam:1100001421a3628\",\"Ime\":\"???? ??????? ??\",\"Posao\":\"kosac\"},{\"Ture\":23,\"Identifier\":\"steam:11000014351e483\",\"Ime\":\"Bruno16\",\"Posao\":\"kosac\"},{\"Ture\":26,\"Identifier\":\"steam:110000141f34ed6\",\"Ime\":\"NeRkOo_\",\"Posao\":\"kosac\"},{\"Ture\":48,\"Identifier\":\"steam:11000013e088bea\",\"Ime\":\"Nindza12322\",\"Posao\":\"kosac\"},{\"Ture\":48,\"Identifier\":\"steam:11000014782ea7b\",\"Ime\":\"Qly\",\"Posao\":\"kosac\"},{\"Ture\":48,\"Identifier\":\"steam:11000014390e118\",\"Ime\":\"Mehaa\",\"Posao\":\"kosac\"},{\"Ture\":25,\"Identifier\":\"steam:110000108f04a6e\",\"Ime\":\"ado\",\"Posao\":\"kosac\"},{\"Ture\":25,\"Identifier\":\"steam:1100001192d4a5b\",\"Ime\":\"Zoro\",\"Posao\":\"kosac\"},{\"Ture\":41,\"Identifier\":\"steam:11000013c535e36\",\"Ime\":\"vidan\",\"Posao\":\"kosac\"},{\"Ture\":1,\"Identifier\":\"steam:110000142c15d21\",\"Ime\":\"MERCI_Nevera\",\"Posao\":\"kosac\"},{\"Ture\":23,\"Identifier\":\"steam:11000013b5b46ef\",\"Ime\":\"Lek1\",\"Posao\":\"kosac\"},{\"Ture\":25,\"Identifier\":\"steam:1100001376c455f\",\"Ime\":\"•Cone•\",\"Posao\":\"kosac\"},{\"Ture\":25,\"Identifier\":\"steam:110000141dde053\",\"Ime\":\"merzuk\",\"Posao\":\"kosac\"},{\"Ture\":25,\"Identifier\":\"steam:11000014247b9cd\",\"Ime\":\"Ar?iii\",\"Posao\":\"kosac\"},{\"Ture\":25,\"Identifier\":\"steam:110000145d8eacf\",\"Ime\":\"Ado\",\"Posao\":\"kosac\"},{\"Ture\":56,\"Identifier\":\"steam:1100001581a35da\",\"Ime\":\"Ahbab\",\"Posao\":\"kosac\"},{\"Ture\":25,\"Identifier\":\"steam:11000014d7e470e\",\"Ime\":\"imran\",\"Posao\":\"kosac\"},{\"Ture\":1,\"Identifier\":\"steam:1100001363263fd\",\"Ime\":\"ItsMata\",\"Posao\":\"kosac\"},{\"Ture\":11,\"Identifier\":\"steam:11000010441bee9\",\"Ime\":\"Sikora\",\"Posao\":\"kosac\"}]', 28391, 300000),
(2, 'farmer', 'Farmer', '[2415.745849609375,4993.283203125,45.2213249206543]', 43447, NULL, 'farmer', '[{\"Ture\":568,\"Identifier\":\"steam:110000140dca7b2\",\"Ime\":\"nemanya\",\"Posao\":\"farmer\"},{\"Ture\":166,\"Identifier\":\"steam:11000014a1d5760\",\"Ime\":\"Spinbot\",\"Posao\":\"farmer\"},{\"Ture\":381,\"Identifier\":\"steam:110000147ad0736\",\"Ime\":\"Radle\",\"Posao\":\"farmer\"},{\"Ture\":351,\"Identifier\":\"steam:11000014e514e24\",\"Ime\":\"Bade\",\"Posao\":\"farmer\"},{\"Ture\":343,\"Identifier\":\"steam:1100001549cf4ac\",\"Ime\":\"?et private\",\"Posao\":\"farmer\"},{\"Ture\":101,\"Identifier\":\"steam:1100001466473bf\",\"Ime\":\"Divlji Joe\",\"Posao\":\"farmer\"},{\"Ture\":115,\"Identifier\":\"steam:11000013cef2da1\",\"Ime\":\"Frnky420\",\"Posao\":\"farmer\"},{\"Ture\":62,\"Identifier\":\"steam:11000013908ef65\",\"Ime\":\"T1hac_\",\"Posao\":\"farmer\"},{\"Ture\":66,\"Identifier\":\"steam:1100001471ff8c3\",\"Ime\":\"Mr_Kamata34\",\"Posao\":\"farmer\"},{\"Ture\":126,\"Identifier\":\"steam:11000013dd3146a\",\"Ime\":\"Ezz - Mat1ja\",\"Posao\":\"farmer\"},{\"Ture\":275,\"Identifier\":\"steam:1100001393f0178\",\"Ime\":\"Smoke Mardeljano\",\"Posao\":\"farmer\"},{\"Ture\":159,\"Identifier\":\"steam:1100001138f654a\",\"Ime\":\"ottizzzzooo\",\"Posao\":\"farmer\"},{\"Ture\":105,\"Identifier\":\"steam:11000015462d5d6\",\"Ime\":\"Krle\",\"Posao\":\"farmer\"},{\"Ture\":2128,\"Identifier\":\"steam:110000143e51bb0\",\"Ime\":\"tare\",\"Posao\":\"farmer\"},{\"Ture\":138,\"Identifier\":\"steam:11000013df9a11e\",\"Ime\":\"Dinos\",\"Posao\":\"farmer\"},{\"Ture\":493,\"Identifier\":\"steam:11000015605bef0\",\"Ime\":\"Semso\",\"Posao\":\"farmer\"},{\"Ture\":144,\"Identifier\":\"steam:11000014a6ba4ca\",\"Ime\":\"Hajko\",\"Posao\":\"farmer\"},{\"Ture\":234,\"Identifier\":\"steam:11000013704a11e\",\"Ime\":\"Prle\",\"Posao\":\"farmer\"},{\"Ture\":124,\"Identifier\":\"steam:11000014211508c\",\"Ime\":\"baka vanga\",\"Posao\":\"farmer\"},{\"Ture\":20,\"Identifier\":\"steam:110000149f91290\",\"Ime\":\"Cico\",\"Posao\":\"farmer\"},{\"Ture\":101,\"Identifier\":\"steam:110000149e59253\",\"Ime\":\"Anonymous\",\"Posao\":\"farmer\"},{\"Ture\":61,\"Identifier\":\"steam:11000015619ce28\",\"Ime\":\"CaseOpening.com\",\"Posao\":\"farmer\"},{\"Ture\":335,\"Identifier\":\"steam:1100001470e6e2a\",\"Ime\":\"Sandev\",\"Posao\":\"farmer\"},{\"Ture\":286,\"Identifier\":\"steam:1100001581a35da\",\"Ime\":\"Ahbab\",\"Posao\":\"farmer\"},{\"Ture\":72,\"Identifier\":\"steam:11000010086a31a\",\"Ime\":\"taylor\",\"Posao\":\"farmer\"},{\"Ture\":179,\"Identifier\":\"steam:1100001323281be\",\"Ime\":\"KeNo\",\"Posao\":\"farmer\"},{\"Ture\":60,\"Identifier\":\"steam:11000014ac39013\",\"Ime\":\"jocke\",\"Posao\":\"farmer\"},{\"Ture\":96,\"Identifier\":\"steam:110000153e7aada\",\"Ime\":\"0rale3\",\"Posao\":\"farmer\"},{\"Ture\":6,\"Identifier\":\"steam:110000118a1c645\",\"Ime\":\"Brutinq\",\"Posao\":\"farmer\"},{\"Ture\":20,\"Identifier\":\"steam:11000013ef89181\",\"Ime\":\"Milenko\",\"Posao\":\"farmer\"},{\"Ture\":1681,\"Identifier\":\"steam:110000136ac44ae\",\"Ime\":\"Slasher\",\"Posao\":\"farmer\"},{\"Ture\":61,\"Identifier\":\"steam:11000014affe777\",\"Ime\":\"dzmy\",\"Posao\":\"farmer\"},{\"Ture\":43,\"Identifier\":\"steam:11000011bf6bcf1\",\"Ime\":\"ZemunaC\",\"Posao\":\"farmer\"},{\"Ture\":1095,\"Identifier\":\"steam:11000011cd15099\",\"Ime\":\"Trstmat\",\"Posao\":\"farmer\"},{\"Ture\":165,\"Identifier\":\"steam:110000147147ec8\",\"Ime\":\"Seksi\",\"Posao\":\"farmer\"},{\"Ture\":176,\"Identifier\":\"steam:11000013f8072dd\",\"Ime\":\"LeoG16\",\"Posao\":\"farmer\"},{\"Ture\":43,\"Identifier\":\"steam:11000013c62d09d\",\"Ime\":\"Faksic\",\"Posao\":\"farmer\"},{\"Ture\":72,\"Identifier\":\"steam:110000143fb98c5\",\"Ime\":\"Stefan\",\"Posao\":\"farmer\"},{\"Ture\":61,\"Identifier\":\"steam:110000143474ffb\",\"Ime\":\"Agony_\",\"Posao\":\"farmer\"},{\"Ture\":20,\"Identifier\":\"steam:11000014501a284\",\"Ime\":\"Keksic\",\"Posao\":\"farmer\"},{\"Ture\":20,\"Identifier\":\"steam:110000143f7d0ef\",\"Ime\":\"archinjo\",\"Posao\":\"farmer\"},{\"Ture\":41,\"Identifier\":\"steam:11000013e28a1b4\",\"Ime\":\"tobq\",\"Posao\":\"farmer\"},{\"Ture\":7,\"Identifier\":\"steam:11000013cc390b8\",\"Ime\":\"??\",\"Posao\":\"farmer\"},{\"Ture\":62,\"Identifier\":\"steam:11000014988d699\",\"Ime\":\"muskodijete\",\"Posao\":\"farmer\"},{\"Ture\":61,\"Identifier\":\"steam:11000014178fc90\",\"Ime\":\"ZvakanZi\",\"Posao\":\"farmer\"},{\"Ture\":40,\"Identifier\":\"steam:11000013d608254\",\"Ime\":\"Dzevad\",\"Posao\":\"farmer\"},{\"Ture\":119,\"Identifier\":\"steam:110000141c032c1\",\"Ime\":\"nawx\",\"Posao\":\"farmer\"},{\"Ture\":427,\"Identifier\":\"steam:1100001434beeed\",\"Ime\":\"stefkeew\",\"Posao\":\"farmer\"},{\"Ture\":38,\"Identifier\":\"steam:11000014b267b6c\",\"Ime\":\"_DeNA\",\"Posao\":\"farmer\"},{\"Ture\":16,\"Identifier\":\"steam:11000014bb1a305\",\"Ime\":\"M1elis\",\"Posao\":\"farmer\"},{\"Ture\":161,\"Identifier\":\"steam:1100001580bcf5e\",\"Ime\":\"Tefa\",\"Posao\":\"farmer\"},{\"Ture\":453,\"Identifier\":\"steam:110000143bb205f\",\"Ime\":\"DOMA_C\",\"Posao\":\"farmer\"},{\"Ture\":649,\"Identifier\":\"steam:11000011b516642\",\"Ime\":\"F1K0\",\"Posao\":\"farmer\"},{\"Ture\":176,\"Identifier\":\"steam:110000142b42c97\",\"Ime\":\"canadi15\",\"Posao\":\"farmer\"},{\"Ture\":244,\"Identifier\":\"steam:11000013c5250c9\",\"Ime\":\"Patro\",\"Posao\":\"farmer\"},{\"Ture\":66,\"Identifier\":\"steam:110000157982204\",\"Ime\":\"roksonnn\",\"Posao\":\"farmer\"},{\"Ture\":837,\"Identifier\":\"steam:110000118d561be\",\"Ime\":\"mixa\",\"Posao\":\"farmer\"},{\"Ture\":528,\"Identifier\":\"steam:11000011a71b4df\",\"Ime\":\"?????\",\"Posao\":\"farmer\"},{\"Ture\":119,\"Identifier\":\"steam:110000142b6e9ea\",\"Ime\":\"Markan\",\"Posao\":\"farmer\"},{\"Ture\":81,\"Identifier\":\"steam:11000011d58c5a6\",\"Ime\":\"Efendija Kapucino\",\"Posao\":\"farmer\"},{\"Ture\":40,\"Identifier\":\"steam:110000145777785\",\"Ime\":\"Dela\",\"Posao\":\"farmer\"},{\"Ture\":698,\"Identifier\":\"steam:110000145328363\",\"Ime\":\"Dusan\",\"Posao\":\"farmer\"},{\"Ture\":170,\"Identifier\":\"steam:110000148d34fc7\",\"Ime\":\"ourmoney\",\"Posao\":\"farmer\"},{\"Ture\":44,\"Identifier\":\"steam:110000145ba7112\",\"Ime\":\"Gazda Elo\",\"Posao\":\"farmer\"},{\"Ture\":149,\"Identifier\":\"steam:11000013f04824c\",\"Ime\":\"ROKSHI ?\",\"Posao\":\"farmer\"},{\"Ture\":42,\"Identifier\":\"steam:11000014504a368\",\"Ime\":\"NIKOLA\",\"Posao\":\"farmer\"},{\"Ture\":180,\"Identifier\":\"steam:11000013d9e72ad\",\"Ime\":\"MiXy\",\"Posao\":\"farmer\"},{\"Ture\":26,\"Identifier\":\"steam:110000145115a5c\",\"Ime\":\"Tuckavac\",\"Posao\":\"farmer\"},{\"Ture\":81,\"Identifier\":\"steam:1100001474c2973\",\"Ime\":\"fortniterecon28\",\"Posao\":\"farmer\"},{\"Ture\":78,\"Identifier\":\"steam:11000011d4abec2\",\"Ime\":\"Amm3R\",\"Posao\":\"farmer\"},{\"Ture\":58,\"Identifier\":\"steam:1100001155d31b2\",\"Ime\":\"Dovla_X\",\"Posao\":\"farmer\"},{\"Ture\":30,\"Identifier\":\"steam:110000144b5fe47\",\"Ime\":\"MALI EFENDIJA DERE DECU\",\"Posao\":\"farmer\"},{\"Ture\":2,\"Identifier\":\"steam:11000013d34658b\",\"Ime\":\"Vajdic81\",\"Posao\":\"farmer\"},{\"Ture\":518,\"Identifier\":\"steam:11000014a135db2\",\"Ime\":\"KILA\",\"Posao\":\"farmer\"},{\"Ture\":1019,\"Identifier\":\"steam:110000147a321ac\",\"Ime\":\"Mareee\",\"Posao\":\"farmer\"},{\"Ture\":52,\"Identifier\":\"steam:1100001075f356a\",\"Ime\":\"Amir Burnic\",\"Posao\":\"farmer\"},{\"Ture\":376,\"Identifier\":\"steam:1100001404f5e8f\",\"Ime\":\"z\",\"Posao\":\"farmer\"},{\"Ture\":210,\"Identifier\":\"steam:11000014d54f2a4\",\"Ime\":\"dusan.marcinko\",\"Posao\":\"farmer\"},{\"Ture\":67,\"Identifier\":\"steam:1100001465f0f99\",\"Ime\":\"Domy148\",\"Posao\":\"farmer\"},{\"Ture\":1956,\"Identifier\":\"steam:1100001419dbf65\",\"Ime\":\"reef\",\"Posao\":\"farmer\"},{\"Ture\":50,\"Identifier\":\"steam:11000013d2e6edd\",\"Ime\":\"XD Automaticbox\",\"Posao\":\"farmer\"},{\"Ture\":584,\"Identifier\":\"steam:110000146630595\",\"Ime\":\"+381 mihajlo\",\"Posao\":\"farmer\"},{\"Ture\":168,\"Identifier\":\"steam:11000014af2a50d\",\"Ime\":\"Arijann\",\"Posao\":\"farmer\"},{\"Ture\":656,\"Identifier\":\"steam:110000140ea24d2\",\"Ime\":\"P1rinidzaaa\",\"Posao\":\"farmer\"},{\"Ture\":109,\"Identifier\":\"steam:1100001352d4005\",\"Ime\":\"pwrt\",\"Posao\":\"farmer\"},{\"Ture\":92,\"Identifier\":\"steam:110000143f405aa\",\"Ime\":\"Stefann\",\"Posao\":\"farmer\"},{\"Ture\":113,\"Identifier\":\"steam:11000013c32bab2\",\"Ime\":\"guccigangster04\",\"Posao\":\"farmer\"},{\"Ture\":81,\"Identifier\":\"steam:11000014b944a74\",\"Ime\":\"loxyrr\",\"Posao\":\"farmer\"},{\"Ture\":54,\"Identifier\":\"steam:1100001363263fd\",\"Ime\":\"ItsMata\",\"Posao\":\"farmer\"},{\"Ture\":20,\"Identifier\":\"steam:110000107f46c73\",\"Ime\":\"Varga\",\"Posao\":\"farmer\"},{\"Ture\":422,\"Identifier\":\"steam:110000142194db8\",\"Ime\":\"popoviich\",\"Posao\":\"farmer\"},{\"Ture\":416,\"Identifier\":\"steam:11000013684104a\",\"Ime\":\"Borko\",\"Posao\":\"farmer\"},{\"Ture\":242,\"Identifier\":\"steam:11000013e823f33\",\"Ime\":\"! pakas\",\"Posao\":\"farmer\"},{\"Ture\":733,\"Identifier\":\"steam:1100001358e5b76\",\"Ime\":\"Ante\",\"Posao\":\"farmer\"},{\"Ture\":211,\"Identifier\":\"steam:11000014da6f9d3\",\"Ime\":\"????\",\"Posao\":\"farmer\"},{\"Ture\":106,\"Identifier\":\"steam:1100001327fd441\",\"Ime\":\"_Maky\",\"Posao\":\"farmer\"},{\"Ture\":25,\"Identifier\":\"steam:1100001455abc11\",\"Ime\":\"Mirza Hatic\",\"Posao\":\"farmer\"},{\"Ture\":505,\"Identifier\":\"steam:110000140c8e80e\",\"Ime\":\"banche\",\"Posao\":\"farmer\"},{\"Ture\":958,\"Identifier\":\"steam:110000137325b74\",\"Ime\":\"ExTasY\",\"Posao\":\"farmer\"},{\"Ture\":230,\"Identifier\":\"steam:1100001096e21ac\",\"Ime\":\"_Puja_\",\"Posao\":\"farmer\"},{\"Ture\":331,\"Identifier\":\"steam:11000013221d9cd\",\"Ime\":\"Bruske\",\"Posao\":\"farmer\"},{\"Ture\":190,\"Identifier\":\"steam:11000014a9a69ee\",\"Ime\":\"Legija\",\"Posao\":\"farmer\"},{\"Ture\":3060,\"Identifier\":\"steam:1100001336b94fa\",\"Ime\":\"?oki\",\"Posao\":\"farmer\"},{\"Ture\":107,\"Identifier\":\"steam:1100001422b6cbd\",\"Ime\":\"Franko\",\"Posao\":\"farmer\"},{\"Ture\":141,\"Identifier\":\"steam:1100001335dd02c\",\"Ime\":\"ldu youtuber 65\",\"Posao\":\"farmer\"},{\"Ture\":362,\"Identifier\":\"steam:110000154a6fede\",\"Ime\":\"RENTA\",\"Posao\":\"farmer\"},{\"Ture\":61,\"Identifier\":\"steam:11000013e3684ba\",\"Ime\":\"Ganny\",\"Posao\":\"farmer\"},{\"Ture\":52,\"Identifier\":\"steam:11000014a7043db\",\"Ime\":\"vidpetric2\",\"Posao\":\"farmer\"},{\"Ture\":3228,\"Identifier\":\"steam:11000014253944b\",\"Ime\":\"ALAJICA\",\"Posao\":\"farmer\"},{\"Ture\":332,\"Identifier\":\"steam:11000010c7cdf6d\",\"Ime\":\"Žuti\",\"Posao\":\"farmer\"},{\"Ture\":242,\"Identifier\":\"steam:11000013f04c5a1\",\"Ime\":\"Nujic\",\"Posao\":\"farmer\"},{\"Ture\":150,\"Identifier\":\"steam:110000158203b2a\",\"Ime\":\"Dulenzi\",\"Posao\":\"farmer\"},{\"Ture\":63,\"Identifier\":\"steam:110000131f0d21e\",\"Ime\":\"bogdanbrat\",\"Posao\":\"farmer\"},{\"Ture\":497,\"Identifier\":\"steam:1100001400a6934\",\"Ime\":\"Boogy Batina\",\"Posao\":\"farmer\"},{\"Ture\":104,\"Identifier\":\"steam:1100001419c278c\",\"Ime\":\"RoKY\",\"Posao\":\"farmer\"},{\"Ture\":214,\"Identifier\":\"steam:1100001356f5168\",\"Ime\":\"PowerDoesMeth\",\"Posao\":\"farmer\"},{\"Ture\":347,\"Identifier\":\"steam:110000144be88c4\",\"Ime\":\"Kurajber19\",\"Posao\":\"farmer\"},{\"Ture\":210,\"Identifier\":\"steam:110000141f34ed6\",\"Ime\":\"NeRkOo_\",\"Posao\":\"farmer\"},{\"Ture\":101,\"Identifier\":\"steam:110000148cabccb\",\"Ime\":\"BAJRAM\",\"Posao\":\"farmer\"},{\"Ture\":20,\"Identifier\":\"steam:110000135714930\",\"Ime\":\"R.I.P. MATTA???\",\"Posao\":\"farmer\"},{\"Ture\":329,\"Identifier\":\"steam:110000141dde053\",\"Ime\":\"merzuk\",\"Posao\":\"farmer\"},{\"Ture\":372,\"Identifier\":\"steam:110000148197aa9\",\"Ime\":\"Shefw_jurkke\",\"Posao\":\"farmer\"},{\"Ture\":61,\"Identifier\":\"steam:110000141672269\",\"Ime\":\"BOT Edvard\",\"Posao\":\"farmer\"},{\"Ture\":77,\"Identifier\":\"steam:11000013c3b31c8\",\"Ime\":\"covekilijebac\",\"Posao\":\"farmer\"},{\"Ture\":139,\"Identifier\":\"steam:11000013e993ebd\",\"Ime\":\"Pajser\",\"Posao\":\"farmer\"},{\"Ture\":355,\"Identifier\":\"steam:110000144af08be\",\"Ime\":\"Iskra\",\"Posao\":\"farmer\"},{\"Ture\":260,\"Identifier\":\"steam:110000149eb3f3b\",\"Ime\":\"tinoo\",\"Posao\":\"farmer\"},{\"Ture\":46,\"Identifier\":\"steam:110000119043648\",\"Ime\":\"kristo_ante\",\"Posao\":\"farmer\"},{\"Ture\":370,\"Identifier\":\"steam:11000013dcf7164\",\"Ime\":\"Ranko Djurisic\",\"Posao\":\"farmer\"},{\"Ture\":147,\"Identifier\":\"steam:1100001581cccef\",\"Ime\":\"Bax1921\",\"Posao\":\"farmer\"},{\"Ture\":85,\"Identifier\":\"steam:11000014247b9cd\",\"Ime\":\"Ar?iii\",\"Posao\":\"farmer\"},{\"Ture\":54,\"Identifier\":\"steam:11000014c753e34\",\"Ime\":\"Medo Brundo\",\"Posao\":\"farmer\"},{\"Ture\":40,\"Identifier\":\"steam:110000107df1c54\",\"Ime\":\"Kilazzk\",\"Posao\":\"farmer\"},{\"Ture\":111,\"Identifier\":\"steam:110000145e6bd52\",\"Ime\":\"..hamza00..\",\"Posao\":\"farmer\"},{\"Ture\":375,\"Identifier\":\"steam:11000014385fba7\",\"Ime\":\"trajko\",\"Posao\":\"farmer\"},{\"Ture\":52,\"Identifier\":\"steam:11000013213cfe6\",\"Ime\":\"Cikeee\",\"Posao\":\"farmer\"},{\"Ture\":516,\"Identifier\":\"steam:11000011778ac83\",\"Ime\":\"f05t3\",\"Posao\":\"farmer\"},{\"Ture\":58,\"Identifier\":\"steam:11000011ccffbb6\",\"Ime\":\"Stankov\",\"Posao\":\"farmer\"},{\"Ture\":66,\"Identifier\":\"steam:1100001131c708a\",\"Ime\":\"Arsic\",\"Posao\":\"farmer\"},{\"Ture\":293,\"Identifier\":\"steam:1100001432f9270\",\"Ime\":\"gospodin\",\"Posao\":\"farmer\"},{\"Ture\":46,\"Identifier\":\"steam:11000010439eaa1\",\"Ime\":\"darko216\",\"Posao\":\"farmer\"},{\"Ture\":56,\"Identifier\":\"steam:11000014550bf41\",\"Ime\":\"Patofna\",\"Posao\":\"farmer\"},{\"Ture\":225,\"Identifier\":\"steam:11000013f650f47\",\"Ime\":\"Folija69\",\"Posao\":\"farmer\"},{\"Ture\":65,\"Identifier\":\"steam:1100001381496cc\",\"Ime\":\"lukaa\",\"Posao\":\"farmer\"},{\"Ture\":127,\"Identifier\":\"steam:110000149a19b0b\",\"Ime\":\"?????\",\"Posao\":\"farmer\"},{\"Ture\":56,\"Identifier\":\"steam:1100001566c578c\",\"Ime\":\"ludifran\",\"Posao\":\"farmer\"},{\"Ture\":360,\"Identifier\":\"steam:11000014264352a\",\"Ime\":\"bvnee.\",\"Posao\":\"farmer\"},{\"Ture\":142,\"Identifier\":\"steam:110000145fa28ee\",\"Ime\":\"BIC SEF\",\"Posao\":\"farmer\"},{\"Ture\":98,\"Identifier\":\"steam:11000013ceaa1d7\",\"Ime\":\"baxy\",\"Posao\":\"farmer\"},{\"Ture\":202,\"Identifier\":\"steam:11000013e088bea\",\"Ime\":\"Nindza12322\",\"Posao\":\"farmer\"},{\"Ture\":46,\"Identifier\":\"steam:11000010441bee9\",\"Ime\":\"Sikora\",\"Posao\":\"farmer\"},{\"Ture\":87,\"Identifier\":\"steam:11000014548a27c\",\"Ime\":\"NiKo\",\"Posao\":\"farmer\"},{\"Ture\":58,\"Identifier\":\"steam:110000148a0670a\",\"Ime\":\"cana\",\"Posao\":\"farmer\"},{\"Ture\":46,\"Identifier\":\"steam:11000014170085b\",\"Ime\":\"Django\",\"Posao\":\"farmer\"},{\"Ture\":65,\"Identifier\":\"steam:110000116f468b2\",\"Ime\":\"Bot4real\",\"Posao\":\"farmer\"},{\"Ture\":160,\"Identifier\":\"steam:11000013ea2617f\",\"Ime\":\"ZokiSvirka *********_com\",\"Posao\":\"farmer\"},{\"Ture\":669,\"Identifier\":\"steam:11000014d7e470e\",\"Ime\":\"imran\",\"Posao\":\"farmer\"},{\"Ture\":67,\"Identifier\":\"steam:110000154e41b29\",\"Ime\":\"Pepesprej\",\"Posao\":\"farmer\"},{\"Ture\":46,\"Identifier\":\"steam:110000154f7dbe3\",\"Ime\":\"mitro\",\"Posao\":\"farmer\"},{\"Ture\":9,\"Identifier\":\"steam:110000143b08236\",\"Ime\":\"David\",\"Posao\":\"farmer\"},{\"Ture\":122,\"Identifier\":\"steam:11000013d5c168e\",\"Ime\":\"Lugha2k\",\"Posao\":\"farmer\"},{\"Ture\":81,\"Identifier\":\"steam:11000013d6020d6\",\"Ime\":\"?Luka?\",\"Posao\":\"farmer\"},{\"Ture\":20,\"Identifier\":\"steam:110000146754a7a\",\"Ime\":\"Samba\",\"Posao\":\"farmer\"},{\"Ture\":67,\"Identifier\":\"steam:11000011aba973c\",\"Ime\":\"Damboo\",\"Posao\":\"farmer\"},{\"Ture\":56,\"Identifier\":\"steam:11000013c535e36\",\"Ime\":\"vidan\",\"Posao\":\"farmer\"},{\"Ture\":87,\"Identifier\":\"steam:110000108f04a6e\",\"Ime\":\"ado\",\"Posao\":\"farmer\"},{\"Ture\":25,\"Identifier\":\"steam:11000014390e118\",\"Ime\":\"Mehaa\",\"Posao\":\"farmer\"},{\"Ture\":40,\"Identifier\":\"steam:11000013ef2a705\",\"Ime\":\"Petrinko\",\"Posao\":\"farmer\"}]', 43447, 300000),
(3, 'kamion', 'Kamiondzija', '[1183.4019775390626,-3303.89501953125,5.9168572425842289]', 11679, NULL, 'kamion', '[{\"Ture\":1,\"Identifier\":\"steam:11000011cd15099\",\"Ime\":\"Trstmat\",\"Posao\":\"kamion\"},{\"Ture\":2,\"Identifier\":\"steam:110000136ac44ae\",\"Ime\":\"Slasher\",\"Posao\":\"kamion\"},{\"Ture\":4,\"Identifier\":\"steam:11000014129d133\",\"Ime\":\"Marche\",\"Posao\":\"kamion\"},{\"Ture\":2,\"Identifier\":\"steam:110000135249a26\",\"Ime\":\"kice\",\"Posao\":\"kamion\"},{\"Ture\":2,\"Identifier\":\"steam:11000014548a27c\",\"Ime\":\"NiKo\",\"Posao\":\"kamion\"},{\"Ture\":3,\"Identifier\":\"steam:11000013c5250c9\",\"Ime\":\"Patro\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:11000013e28a1b4\",\"Ime\":\"tobq\",\"Posao\":\"kamion\"},{\"Ture\":2,\"Identifier\":\"steam:1100001455d1d72\",\"Ime\":\"jks\",\"Posao\":\"kamion\"},{\"Ture\":4,\"Identifier\":\"steam:1100001472a5ee8\",\"Ime\":\"HooX1\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:110000145bf3868\",\"Ime\":\"xdgabi2106\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:110000148673a78\",\"Ime\":\"TrLe\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:11000013d27e4d1\",\"Ime\":\"Tarik\",\"Posao\":\"kamion\"},{\"Ture\":6,\"Identifier\":\"steam:1100001351bf14e\",\"Ime\":\"Nadir Cebic\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:11000011a42d486\",\"Ime\":\"tmflight\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:1100001466473bf\",\"Ime\":\"Divlji Joe\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:11000011d58c5a6\",\"Ime\":\"Efendija Kapucino\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:110000142b6e9ea\",\"Ime\":\"Markan\",\"Posao\":\"kamion\"},{\"Ture\":3,\"Identifier\":\"steam:11000011d4abec2\",\"Ime\":\"Amm3R\",\"Posao\":\"kamion\"},{\"Ture\":4,\"Identifier\":\"steam:110000144b5fe47\",\"Ime\":\"MALI EFENDIJA DERE DECU\",\"Posao\":\"kamion\"},{\"Ture\":2,\"Identifier\":\"steam:1100001465f0f99\",\"Ime\":\"Domy148\",\"Posao\":\"kamion\"},{\"Ture\":2,\"Identifier\":\"steam:1100001075f356a\",\"Ime\":\"Amir Burnic\",\"Posao\":\"kamion\"},{\"Ture\":5,\"Identifier\":\"steam:11000013704a11e\",\"Ime\":\"Prle\",\"Posao\":\"kamion\"},{\"Ture\":2,\"Identifier\":\"steam:11000014211508c\",\"Ime\":\"baka vanga\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:110000143fb98c5\",\"Ime\":\"Stefan\",\"Posao\":\"kamion\"},{\"Ture\":2,\"Identifier\":\"steam:110000144f22a56\",\"Ime\":\"? +387 ssubasicch\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:11000013c62d09d\",\"Ime\":\"Faksic\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:11000013f8072dd\",\"Ime\":\"LeoG16\",\"Posao\":\"kamion\"},{\"Ture\":2,\"Identifier\":\"steam:11000014427c89d\",\"Ime\":\"konj\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:11000014988d699\",\"Ime\":\"muskodijete\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:11000014bb1a305\",\"Ime\":\"M1elis\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:110000112dff0ee\",\"Ime\":\"s1mple\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:11000014534ebfe\",\"Ime\":\"DaCo.\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:1100001363263fd\",\"Ime\":\"ItsMata\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:110000140dca7b2\",\"Ime\":\"nemanya\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:11000014a1d5760\",\"Ime\":\"Spinbot\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:1100001434beeed\",\"Ime\":\"stefkeew\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:110000137325b74\",\"Ime\":\"ExTasY\",\"Posao\":\"kamion\"},{\"Ture\":7,\"Identifier\":\"steam:1100001455abc11\",\"Ime\":\"Mirza Hatic\",\"Posao\":\"kamion\"},{\"Ture\":7,\"Identifier\":\"steam:1100001096e21ac\",\"Ime\":\"_Puja_\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:11000013dd3535b\",\"Ime\":\"Papsonja\",\"Posao\":\"kamion\"},{\"Ture\":3,\"Identifier\":\"steam:1100001434ca47a\",\"Ime\":\"v?u?k?\",\"Posao\":\"kamion\"},{\"Ture\":2,\"Identifier\":\"steam:11000011075cff4\",\"Ime\":\"kordi\",\"Posao\":\"kamion\"},{\"Ture\":3,\"Identifier\":\"steam:110000110ebee4a\",\"Ime\":\"Buttcrack\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:11000013fe2ac61\",\"Ime\":\"hoko\",\"Posao\":\"kamion\"},{\"Ture\":2,\"Identifier\":\"steam:110000149eb3f3b\",\"Ime\":\"tinoo\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:11000013f04c5a1\",\"Ime\":\"Nujic\",\"Posao\":\"kamion\"},{\"Ture\":2,\"Identifier\":\"steam:1100001562fc0b9\",\"Ime\":\"!\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:110000143474ffb\",\"Ime\":\"Agony_\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:11000014ac39013\",\"Ime\":\"jocke\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:11000014da6f9d3\",\"Ime\":\"????\",\"Posao\":\"kamion\"},{\"Ture\":9,\"Identifier\":\"steam:1100001323281be\",\"Ime\":\"KeNo\",\"Posao\":\"kamion\"},{\"Ture\":3,\"Identifier\":\"steam:110000142b42c97\",\"Ime\":\"canadi15\",\"Posao\":\"kamion\"},{\"Ture\":5,\"Identifier\":\"steam:1100001427bd76f\",\"Ime\":\"Hamzo Uzbrdica\",\"Posao\":\"kamion\"},{\"Ture\":2,\"Identifier\":\"steam:11000014170085b\",\"Ime\":\"Django\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:110000145e6bd52\",\"Ime\":\"..hamza00..\",\"Posao\":\"kamion\"},{\"Ture\":4,\"Identifier\":\"steam:110000142c0a696\",\"Ime\":\"Putin\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:11000014e763e71\",\"Ime\":\"Crni\",\"Posao\":\"kamion\"},{\"Ture\":7,\"Identifier\":\"steam:110000146630595\",\"Ime\":\"+381 mihajlo\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:11000011b4869ce\",\"Ime\":\"Ficho\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:110000147147ec8\",\"Ime\":\"Seksi\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:1100001419c278c\",\"Ime\":\"RoKY\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:11000013e993ebd\",\"Ime\":\"Pajser\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:11000014ab75335\",\"Ime\":\"Miloica\",\"Posao\":\"kamion\"},{\"Ture\":3,\"Identifier\":\"steam:11000014190172c\",\"Ime\":\"Krsmanovic\",\"Posao\":\"kamion\"},{\"Ture\":2,\"Identifier\":\"steam:110000142793fa5\",\"Ime\":\"Rodjo\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:110000143797678\",\"Ime\":\"fisriba\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:1100001581cccef\",\"Ime\":\"Bax1921\",\"Posao\":\"kamion\"},{\"Ture\":2,\"Identifier\":\"steam:110000132a2b8f0\",\"Ime\":\"Jez\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:11000011ccffbb6\",\"Ime\":\"Stankov\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:11000014af645c9\",\"Ime\":\"Zelje69\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:11000014c3c6ae0\",\"Ime\":\"B0ss1\",\"Posao\":\"kamion\"},{\"Ture\":2,\"Identifier\":\"steam:11000010dc2a8fd\",\"Ime\":\"ReFa hellcase.org\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:11000014877a3eb\",\"Ime\":\"DyL3 ??  csgocases_com\",\"Posao\":\"kamion\"},{\"Ture\":2,\"Identifier\":\"steam:11000010b5ed66b\",\"Ime\":\"bwenjoooo\",\"Posao\":\"kamion\"},{\"Ture\":2,\"Identifier\":\"steam:1100001466217e8\",\"Ime\":\"loweLLLLLL\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:1100001155d31b2\",\"Ime\":\"Dovla_X\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:110000149a19b0b\",\"Ime\":\"?????\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:1100001192d4a5b\",\"Ime\":\"Zoro\",\"Posao\":\"kamion\"},{\"Ture\":3,\"Identifier\":\"steam:110000116f468b2\",\"Ime\":\"Bot4real\",\"Posao\":\"kamion\"},{\"Ture\":3,\"Identifier\":\"steam:1100001581a35da\",\"Ime\":\"Ahbab\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:11000013df9a11e\",\"Ime\":\"Dinos\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:110000144554229\",\"Ime\":\"lazar\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:11000014d7e470e\",\"Ime\":\"imran\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:11000014247b9cd\",\"Ime\":\"Ar?iii\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:11000014390e118\",\"Ime\":\"Mehaa\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:11000014b944a74\",\"Ime\":\"loxyrr\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:1100001470e6e2a\",\"Ime\":\"Sandev\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:11000010086a31a\",\"Ime\":\"taylor\",\"Posao\":\"kamion\"},{\"Ture\":1,\"Identifier\":\"steam:110000108f04a6e\",\"Ime\":\"ado\",\"Posao\":\"kamion\"},{\"Ture\":2,\"Identifier\":\"steam:11000010441bee9\",\"Ime\":\"Sikora\",\"Posao\":\"kamion\"}]', 11679, 300000),
(4, 'luka', 'Lucki radnik', '[926.2833862304688,-2935.85009765625,4.90115547180175]', 101640, NULL, 'luka', '[{\"Ture\":3,\"Identifier\":\"steam:11000011cd15099\",\"Ime\":\"Trstmat\",\"Posao\":\"luka\"},{\"Ture\":3,\"Identifier\":\"steam:110000136ac44ae\",\"Ime\":\"Slasher\",\"Posao\":\"luka\"},{\"Ture\":9,\"Identifier\":\"steam:110000135249a26\",\"Ime\":\"kice\",\"Posao\":\"luka\"},{\"Ture\":6,\"Identifier\":\"steam:11000014ed659f8\",\"Ime\":\"PerKanMDFK\",\"Posao\":\"luka\"},{\"Ture\":3,\"Identifier\":\"steam:11000011d58c5a6\",\"Ime\":\"Efendija Kapucino\",\"Posao\":\"luka\"},{\"Ture\":3,\"Identifier\":\"steam:110000142b6e9ea\",\"Ime\":\"Markan\",\"Posao\":\"luka\"},{\"Ture\":6,\"Identifier\":\"steam:11000013f3e9244\",\"Ime\":\"gospodin kaktus\",\"Posao\":\"luka\"},{\"Ture\":1,\"Identifier\":\"steam:110000145bf3868\",\"Ime\":\"xdgabi2106\",\"Posao\":\"luka\"},{\"Ture\":3,\"Identifier\":\"steam:11000014129d133\",\"Ime\":\"Marche\",\"Posao\":\"luka\"},{\"Ture\":10,\"Identifier\":\"steam:11000014548a27c\",\"Ime\":\"NiKo\",\"Posao\":\"luka\"},{\"Ture\":1,\"Identifier\":\"steam:1100001428164b3\",\"Ime\":\"Leiyzi\",\"Posao\":\"luka\"},{\"Ture\":1,\"Identifier\":\"steam:11000010450ac75\",\"Ime\":\"grazyzz\",\"Posao\":\"luka\"},{\"Ture\":3,\"Identifier\":\"steam:11000013ef89181\",\"Ime\":\"Milenko\",\"Posao\":\"luka\"},{\"Ture\":1,\"Identifier\":\"steam:1100001351bf14e\",\"Ime\":\"Nadir Cebic\",\"Posao\":\"luka\"},{\"Ture\":2,\"Identifier\":\"steam:11000013908ef65\",\"Ime\":\"T1hac_\",\"Posao\":\"luka\"},{\"Ture\":2,\"Identifier\":\"steam:1100001466473bf\",\"Ime\":\"Divlji Joe\",\"Posao\":\"luka\"},{\"Ture\":3,\"Identifier\":\"steam:11000013cef2da1\",\"Ime\":\"Frnky420\",\"Posao\":\"luka\"},{\"Ture\":3,\"Identifier\":\"steam:11000011bf6bcf1\",\"Ime\":\"ZemunaC\",\"Posao\":\"luka\"},{\"Ture\":3,\"Identifier\":\"steam:11000014001f43b\",\"Ime\":\"N1KKOLIC\",\"Posao\":\"luka\"},{\"Ture\":3,\"Identifier\":\"steam:11000014ac39013\",\"Ime\":\"jocke\",\"Posao\":\"luka\"},{\"Ture\":13,\"Identifier\":\"steam:1100001075f356a\",\"Ime\":\"Amir Burnic\",\"Posao\":\"luka\"},{\"Ture\":28,\"Identifier\":\"steam:1100001465f0f99\",\"Ime\":\"Domy148\",\"Posao\":\"luka\"},{\"Ture\":6,\"Identifier\":\"steam:11000013c62d09d\",\"Ime\":\"Faksic\",\"Posao\":\"luka\"},{\"Ture\":1,\"Identifier\":\"steam:11000011d4abec2\",\"Ime\":\"Amm3R\",\"Posao\":\"luka\"},{\"Ture\":1,\"Identifier\":\"steam:110000153e7aada\",\"Ime\":\"0rale3\",\"Posao\":\"luka\"},{\"Ture\":341,\"Identifier\":\"steam:1100001434beeed\",\"Ime\":\"stefkeew\",\"Posao\":\"luka\"},{\"Ture\":3,\"Identifier\":\"steam:110000112dff0ee\",\"Ime\":\"s1mple\",\"Posao\":\"luka\"},{\"Ture\":6,\"Identifier\":\"steam:11000010086a31a\",\"Ime\":\"taylor\",\"Posao\":\"luka\"},{\"Ture\":5,\"Identifier\":\"steam:11000011bf21bf4\",\"Ime\":\"Gabac Soliteri\",\"Posao\":\"luka\"},{\"Ture\":4,\"Identifier\":\"steam:11000014170085b\",\"Ime\":\"Django\",\"Posao\":\"luka\"},{\"Ture\":3,\"Identifier\":\"steam:11000014504a368\",\"Ime\":\"NIKOLA\",\"Posao\":\"luka\"},{\"Ture\":6,\"Identifier\":\"steam:110000140cca2ba\",\"Ime\":\"seksi\",\"Posao\":\"luka\"},{\"Ture\":21,\"Identifier\":\"steam:11000014e00f71a\",\"Ime\":\"Vappone\",\"Posao\":\"luka\"},{\"Ture\":93,\"Identifier\":\"steam:11000014da6f9d3\",\"Ime\":\"????\",\"Posao\":\"luka\"},{\"Ture\":2,\"Identifier\":\"steam:11000014211508c\",\"Ime\":\"baka vanga\",\"Posao\":\"luka\"},{\"Ture\":1,\"Identifier\":\"steam:11000015605bef0\",\"Ime\":\"Semso\",\"Posao\":\"luka\"},{\"Ture\":3,\"Identifier\":\"steam:1100001471ff8c3\",\"Ime\":\"Mr_Kamata34\",\"Posao\":\"luka\"},{\"Ture\":3,\"Identifier\":\"steam:110000140dca7b2\",\"Ime\":\"nemanya\",\"Posao\":\"luka\"},{\"Ture\":28,\"Identifier\":\"steam:1100001434ca47a\",\"Ime\":\"v?u?k?\",\"Posao\":\"luka\"},{\"Ture\":3,\"Identifier\":\"steam:11000014427c89d\",\"Ime\":\"konj\",\"Posao\":\"luka\"},{\"Ture\":3,\"Identifier\":\"steam:1100001455abc11\",\"Ime\":\"Mirza Hatic\",\"Posao\":\"luka\"},{\"Ture\":27,\"Identifier\":\"steam:1100001096e21ac\",\"Ime\":\"_Puja_\",\"Posao\":\"luka\"},{\"Ture\":41,\"Identifier\":\"steam:11000014792d68c\",\"Ime\":\"Hardy\",\"Posao\":\"luka\"},{\"Ture\":11,\"Identifier\":\"steam:11000013fc7165a\",\"Ime\":\"Emirr\",\"Posao\":\"luka\"},{\"Ture\":3,\"Identifier\":\"steam:110000145e6bd52\",\"Ime\":\"..hamza00..\",\"Posao\":\"luka\"},{\"Ture\":9,\"Identifier\":\"steam:1100001455d1d72\",\"Ime\":\"jks\",\"Posao\":\"luka\"},{\"Ture\":3,\"Identifier\":\"steam:110000149eb3f3b\",\"Ime\":\"tinoo\",\"Posao\":\"luka\"},{\"Ture\":9,\"Identifier\":\"steam:11000011075cff4\",\"Ime\":\"kordi\",\"Posao\":\"luka\"},{\"Ture\":18,\"Identifier\":\"steam:11000013dd3535b\",\"Ime\":\"Papsonja\",\"Posao\":\"luka\"},{\"Ture\":10,\"Identifier\":\"steam:11000013221d9cd\",\"Ime\":\"Bruske\",\"Posao\":\"luka\"},{\"Ture\":1,\"Identifier\":\"steam:11000014c5db3cf\",\"Ime\":\"_mujkolone\",\"Posao\":\"luka\"},{\"Ture\":8,\"Identifier\":\"steam:110000118a1c645\",\"Ime\":\"Brutinq\",\"Posao\":\"luka\"},{\"Ture\":5,\"Identifier\":\"steam:1100001470e6e2a\",\"Ime\":\"Sandev\",\"Posao\":\"luka\"},{\"Ture\":3,\"Identifier\":\"steam:110000143474ffb\",\"Ime\":\"Agony_\",\"Posao\":\"luka\"},{\"Ture\":39,\"Identifier\":\"steam:11000013e3684ba\",\"Ime\":\"Ganny\",\"Posao\":\"luka\"},{\"Ture\":2,\"Identifier\":\"steam:1100001562fc0b9\",\"Ime\":\"!\",\"Posao\":\"luka\"},{\"Ture\":2,\"Identifier\":\"steam:11000011b4869ce\",\"Ime\":\"Ficho\",\"Posao\":\"luka\"},{\"Ture\":1,\"Identifier\":\"steam:110000147147ec8\",\"Ime\":\"Seksi\",\"Posao\":\"luka\"},{\"Ture\":1,\"Identifier\":\"steam:110000141672269\",\"Ime\":\"BOT Edvard\",\"Posao\":\"luka\"},{\"Ture\":10,\"Identifier\":\"steam:110000142c0a696\",\"Ime\":\"Putin\",\"Posao\":\"luka\"},{\"Ture\":3,\"Identifier\":\"steam:1100001427bd76f\",\"Ime\":\"Hamzo Uzbrdica\",\"Posao\":\"luka\"},{\"Ture\":2,\"Identifier\":\"steam:11000013e993ebd\",\"Ime\":\"Pajser\",\"Posao\":\"luka\"},{\"Ture\":3,\"Identifier\":\"steam:11000013cc390b8\",\"Ime\":\"??\",\"Posao\":\"luka\"},{\"Ture\":3,\"Identifier\":\"steam:11000014178fc90\",\"Ime\":\"ZvakanZi\",\"Posao\":\"luka\"},{\"Ture\":1,\"Identifier\":\"steam:11000013dcf7164\",\"Ime\":\"Ranko Djurisic\",\"Posao\":\"luka\"},{\"Ture\":2,\"Identifier\":\"steam:110000116f468b2\",\"Ime\":\"Bot4real\",\"Posao\":\"luka\"},{\"Ture\":2,\"Identifier\":\"steam:11000013c1c0eeb\",\"Ime\":\"LokiStršljen\",\"Posao\":\"luka\"},{\"Ture\":2,\"Identifier\":\"steam:11000013ffe149a\",\"Ime\":\"Kak ti Stara!!\",\"Posao\":\"luka\"},{\"Ture\":4,\"Identifier\":\"steam:1100001439b7091\",\"Ime\":\"Nicknarmam\",\"Posao\":\"luka\"},{\"Ture\":10,\"Identifier\":\"steam:110000119043648\",\"Ime\":\"kristo_ante\",\"Posao\":\"luka\"},{\"Ture\":3,\"Identifier\":\"steam:110000147b85779\",\"Ime\":\"Blagi Umak\",\"Posao\":\"luka\"},{\"Ture\":3,\"Identifier\":\"steam:1100001381496cc\",\"Ime\":\"lukaa\",\"Posao\":\"luka\"},{\"Ture\":3,\"Identifier\":\"steam:110000137325b74\",\"Ime\":\"ExTasY\",\"Posao\":\"luka\"},{\"Ture\":2,\"Identifier\":\"steam:1100001155d31b2\",\"Ime\":\"Dovla_X\",\"Posao\":\"luka\"},{\"Ture\":1,\"Identifier\":\"steam:11000015815b306\",\"Ime\":\"misomali301\",\"Posao\":\"luka\"},{\"Ture\":2,\"Identifier\":\"steam:11000014877a3eb\",\"Ime\":\"DyL3 ??  csgocases_com\",\"Posao\":\"luka\"},{\"Ture\":2,\"Identifier\":\"steam:110000149a19b0b\",\"Ime\":\"?????\",\"Posao\":\"luka\"},{\"Ture\":8,\"Identifier\":\"steam:11000011778ac83\",\"Ime\":\"f05t3\",\"Posao\":\"luka\"},{\"Ture\":2,\"Identifier\":\"steam:1100001432f9270\",\"Ime\":\"gospodin\",\"Posao\":\"luka\"},{\"Ture\":3,\"Identifier\":\"steam:11000010439eaa1\",\"Ime\":\"darko216\",\"Posao\":\"luka\"},{\"Ture\":2,\"Identifier\":\"steam:11000014b92d4c5\",\"Ime\":\"SaNtIc\",\"Posao\":\"luka\"},{\"Ture\":10,\"Identifier\":\"steam:110000140751fb3\",\"Ime\":\"Savo barašnov\",\"Posao\":\"luka\"},{\"Ture\":1,\"Identifier\":\"steam:110000147a321ac\",\"Ime\":\"Mareee\",\"Posao\":\"luka\"},{\"Ture\":3,\"Identifier\":\"steam:11000011a71b4df\",\"Ime\":\"Antich\",\"Posao\":\"luka\"},{\"Ture\":2,\"Identifier\":\"steam:110000144a66db3\",\"Ime\":\"ArminFast\",\"Posao\":\"luka\"},{\"Ture\":1,\"Identifier\":\"steam:110000141f34ed6\",\"Ime\":\"NeRkOo_\",\"Posao\":\"luka\"},{\"Ture\":3,\"Identifier\":\"steam:110000117937b01\",\"Ime\":\"Piksel NPC\",\"Posao\":\"luka\"},{\"Ture\":5,\"Identifier\":\"steam:1100001419dbf65\",\"Ime\":\"reef\",\"Posao\":\"luka\"},{\"Ture\":6,\"Identifier\":\"steam:110000148cabccb\",\"Ime\":\"BAJRAM\",\"Posao\":\"luka\"},{\"Ture\":5,\"Identifier\":\"steam:1100001421a3628\",\"Ime\":\"???? ??????? ??\",\"Posao\":\"luka\"},{\"Ture\":4,\"Identifier\":\"steam:11000014c6ac345\",\"Ime\":\"kurtoazija\",\"Posao\":\"luka\"},{\"Ture\":3,\"Identifier\":\"steam:1100001335dd02c\",\"Ime\":\"shuki\",\"Posao\":\"luka\"},{\"Ture\":3,\"Identifier\":\"steam:11000013c3b31c8\",\"Ime\":\"covekilijebac\",\"Posao\":\"luka\"},{\"Ture\":3,\"Identifier\":\"steam:11000014c6f54a0\",\"Ime\":\"KimaDOCA\",\"Posao\":\"luka\"},{\"Ture\":1,\"Identifier\":\"steam:11000013e0ef42e\",\"Ime\":\"Straxe\",\"Posao\":\"luka\"},{\"Ture\":1,\"Identifier\":\"steam:11000014264352a\",\"Ime\":\"bvnee.\",\"Posao\":\"luka\"},{\"Ture\":1,\"Identifier\":\"steam:11000013cd09481\",\"Ime\":\"vukajlovich\",\"Posao\":\"luka\"},{\"Ture\":3,\"Identifier\":\"steam:110000145ba7112\",\"Ime\":\"Gazda Elo\",\"Posao\":\"luka\"},{\"Ture\":1,\"Identifier\":\"steam:11000014b944a74\",\"Ime\":\"loxyrr\",\"Posao\":\"luka\"},{\"Ture\":2,\"Identifier\":\"steam:11000013df9a11e\",\"Ime\":\"Dinos\",\"Posao\":\"luka\"},{\"Ture\":1,\"Identifier\":\"steam:11000014390e118\",\"Ime\":\"Mehaa\",\"Posao\":\"luka\"},{\"Ture\":1,\"Identifier\":\"steam:11000010441bee9\",\"Ime\":\"Sikora\",\"Posao\":\"luka\"}]', 101640, 300000);

-- --------------------------------------------------------

--
-- Table structure for table `bought_houses`
--

DROP TABLE IF EXISTS `bought_houses`;
CREATE TABLE IF NOT EXISTS `bought_houses` (
  `houseid` int(11) NOT NULL,
  `vlasnik` int(11) DEFAULT NULL,
  PRIMARY KEY (`houseid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `communityservice`
--

DROP TABLE IF EXISTS `communityservice`;
CREATE TABLE IF NOT EXISTS `communityservice` (
  `identifier` int(11) NOT NULL,
  `actions_remaining` int(11) NOT NULL,
  PRIMARY KEY (`identifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Table structure for table `datastore`
--

DROP TABLE IF EXISTS `datastore`;
CREATE TABLE IF NOT EXISTS `datastore` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `datastore`
--

INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
('society_omerta', 'omerta', 1),
('society_montana', 'montana', 1),
('society_panthers', 'panthers', 1),
('society_sinaloa', 'sinaloa', 1),
('society_pollos', 'pollos', 1),
('society_zemunski', 'zemunski', 1),
('society_devilzeye', 'devilzeye', 1),
('user_ears', 'Ears', 0),
('user_glasses', 'Glasses', 0),
('user_helmet', 'Helmet', 0),
('user_mask', 'Mask', 0),
('society_fake', 'fake', 1);

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
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `index_datastore_data_name_owner` (`name`,`owner`) USING BTREE,
  KEY `index_datastore_data_name` (`name`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `datastore_data`
--

INSERT INTO `datastore_data` (`id`, `name`, `owner`, `data`) VALUES
(19, 'society_omerta', NULL, '{\"weapons\":[{\"ammo\":0,\"count\":0,\"name\":\"weapon_crowbar\"},{\"ammo\":0,\"count\":0,\"name\":\"WEAPON_KNIFE\"},{\"ammo\":42,\"count\":1,\"name\":\"WEAPON_PISTOL\"},{\"ammo\":0,\"count\":1,\"name\":\"WEAPON_DAGGER\"},{\"ammo\":0,\"count\":1,\"name\":\"WEAPON_KNUCKLE\"}]}'),
(20, 'society_montana', NULL, '{}'),
(21, 'society_panthers', NULL, '{\"weapons\":[{\"name\":\"WEAPON_PISTOL\",\"count\":3,\"ammo\":0},{\"name\":\"WEAPON_MACHETE\",\"count\":1,\"ammo\":0},{\"name\":\"WEAPON_PISTOL50\",\"count\":0,\"ammo\":0},{\"name\":\"WEAPON_MICROSMG\",\"count\":1,\"ammo\":39},{\"name\":\"WEAPON_CROWBAR\",\"count\":0,\"ammo\":0}]}'),
(22, 'society_sinaloa', NULL, '{\"weapons\":[{\"name\":\"WEAPON_PUMPSHOTGUN\",\"count\":1,\"ammo\":0},{\"name\":\"WEAPON_APPISTOL\",\"count\":1,\"ammo\":210},{\"name\":\"WEAPON_NIGHTSTICK\",\"count\":1,\"ammo\":0},{\"name\":\"WEAPON_CROWBAR\",\"count\":3,\"ammo\":0},{\"name\":\"WEAPON_KNIFE\",\"count\":1,\"ammo\":0},{\"name\":\"WEAPON_PETROLCAN\",\"count\":1,\"ammo\":30},{\"name\":\"weapon_crowbar\",\"count\":1,\"ammo\":250},{\"name\":\"WEAPON_COMBATPISTOL\",\"count\":2,\"ammo\":250},{\"name\":\"WEAPON_PISTOL50\",\"count\":2,\"ammo\":0},{\"name\":\"WEAPON_PISTOL\",\"count\":9,\"ammo\":1475},{\"name\":\"WEAPON_MICROSMG\",\"count\":4,\"ammo\":584},{\"name\":\"WEAPON_DAGGER\",\"count\":1,\"ammo\":0},{\"name\":\"WEAPON_STUNGUN\",\"count\":1,\"ammo\":42},{\"name\":\"WEAPON_KNUCKLE\",\"count\":1,\"ammo\":0},{\"name\":\"WEAPON_MACHETE\",\"count\":1,\"ammo\":0},{\"name\":\"WEAPON_SWITCHBLADE\",\"count\":1,\"ammo\":0}]}'),
(23, 'society_pollos', NULL, '{}'),
(24, 'society_zemunski', NULL, '{\"weapons\":[{\"name\":\"WEAPON_CROWBAR\",\"count\":0,\"ammo\":0}]}'),
(25, 'society_devilzeye', NULL, '{}'),
(26, 'society_fake', NULL, '{}');

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
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `droge`
--

INSERT INTO `droge` (`ID`, `vrsta`, `branje`, `heading`) VALUES
(1, 1, '{\"x\":3101.51123046875,\"y\":6036.728515625,\"z\":122.19019317626953}', NULL),
(2, 2, '{\"x\":3481.6748046875,\"y\":2582.458740234375,\"z\":13.55680179595947}', NULL),
(3, 3, '{\"x\":-1298.0008544921876,\"y\":4492.7373046875,\"z\":16.9282054901123}', '316.02');

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
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=47 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

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
  PRIMARY KEY (`id`) USING BTREE,
  KEY `category` (`category`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `fine_types`
--

INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
(1, 'Krivo koristenje trube', 150, 0),
(2, 'Gazenje pune linije', 150, 0),
(3, 'Voznja krivom stranom ceste', 750, 0),
(4, 'Nelegalno okretanje', 500, 0),
(5, 'Ilegalna voznja izvan ceste', 750, 0),
(6, 'Odbijanje zakonite naredbe', 300, 0),
(7, 'Nelegalno zaustavljanje vozila', 150, 0),
(8, 'Nelegalno parkiranje', 150, 0),
(9, 'Ne propustanje sluzbenog vozila', 300, 0),
(10, 'Vozilo ne odgovara papirima', 750, 0),
(11, 'Ne zaustavljanje na stop znak', 500, 0),
(12, 'Ne zaustavljanje na crveno svjetlo', 1000, 0),
(13, 'Nelegalno obilazenje', 300, 0),
(14, 'Voznja neregistriranog vozila', 750, 0),
(15, 'Voznja bez vozacke dozvole', 1500, 0),
(16, 'Napustanje mjesta prometne nesrece', 350, 0),
(17, 'Prekoracenje brzine > 5 km/h', 100, 0),
(18, 'Prekoracenje brzine izmedju 5 i 15 km/h', 200, 0),
(19, 'Prekoracenje brzine izmedju 15 i 30 km/h', 350, 0),
(20, 'Prekoracenje brzine vise od 30 km/h', 600, 0),
(21, 'Ometanje tijeka prometa', 750, 1),
(22, 'Javno pijan', 200, 1),
(23, 'Neprimjereno ponasanje', 200, 1),
(24, 'Ometanje pravnih sluzbi', 300, 1),
(25, 'Vrijedjanje osobe', 150, 1),
(26, 'Nepostivanaje pravne osobe', 300, 1),
(27, 'Verbalna prijetnja civilu', 250, 1),
(28, 'Verbalna prijetnja sluzbenoj osobi', 350, 1),
(29, 'Davanje laznih podataka', 350, 1),
(30, 'Pokusaj korupcije', 800, 1),
(31, 'Javno pokazivanje oruzja unutar grada', 600, 2),
(32, 'Javno pokazivanje smrtonosnog oruzja unutar grada', 1000, 2),
(33, 'Nema dozvole za oruzje', 1500, 2),
(34, 'Posjedovanje nelegalnog oruzja', 2000, 2),
(35, 'Posjedovanje alata za provaljivanje', 750, 2),
(36, 'Kradja vozila', 800, 2),
(37, 'Namjera prodaje/distribucije ilegalnih substanci', 800, 2),
(38, 'Proizvodnja ilegalnih substanci', 1000, 2),
(39, 'Posjedovanje ilegalne substance', 750, 2),
(40, 'Otmica civila', 1750, 2),
(41, 'Otmica sluzbene osobe', 2250, 2),
(42, 'Pljacka', 2000, 2),
(43, 'Oruzana pljacka trgovine', 2350, 2),
(44, 'Oruzana pljacka banke', 2500, 2),
(45, 'Napad na civila', 1300, 3),
(46, 'Napad na sluzbenu osobu', 1600, 3),
(47, 'Pokusaj ubojstva civila', 2000, 3),
(48, 'Pokusaj ubojstva sluzbene osobe', 2500, 3),
(49, 'Ubojstvo civila', 3000, 3),
(50, 'Ubojstvo sluzbene osobe', 3500, 3),
(51, 'Ubojstvo iz nehaja', 2750, 3),
(52, 'Prevara', 1500, 2),
(53, 'Nepropisno parkiranje osobnog vozila.', 150, 2),
(54, 'Pljacka Banke.', 2500, 2),
(55, 'Pljacka trgovine.', 2350, 2),
(56, 'Pljacka zlatare.', 2200, 2),
(57, 'Organizirani Kriminal.', 2000, 2);

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
(51, 'firma9', 'Firma 9', 1, '{\"x\":1135.608642578125,\"y\":-982.2374877929688,\"z\":46.41579055786133}', '{}', '{}', '{\"x\":1130.785400390625,\"y\":-983.2907104492188,\"z\":46.41579055786133}', NULL, 441, 1000000, 0, 0, 0, '{}', '[]'),
(50, 'firma8', 'Firma 8', 1, '{\"x\":25.74614143371582,\"y\":-1346.8341064453126,\"z\":29.49701118469238}', '{}', '{}', '{\"x\":30.63790321350097,\"y\":-1339.8995361328126,\"z\":29.49701118469238}', NULL, 15483, 1000000, 0, 0, 0, '{}', '[]'),
(49, 'firma7', 'Firma 7', 1, '{\"x\":1729.101806640625,\"y\":6415.0322265625,\"z\":35.03721237182617}', '{}', '{}', '{\"x\":1736.4447021484376,\"y\":6419.095703125,\"z\":35.03721237182617}', NULL, 4461, 1000000, 0, 0, 0, '{}', '[]'),
(48, 'firma6', 'Firma 6', 1, '{\"x\":2678.23388671875,\"y\":3280.870849609375,\"z\":55.24111938476562}', '{}', '{}', '{\"x\":2674.646240234375,\"y\":3288.287353515625,\"z\":55.24111938476562}', NULL, 1669, 1000000, 0, 0, 0, '{}', '[]'),
(47, 'firma5', 'Firma 5', 1, '{\"x\":1960.943603515625,\"y\":3741.1650390625,\"z\":32.34373092651367}', '{}', '{}', '{\"x\":1961.6397705078126,\"y\":3749.4482421875,\"z\":32.34373092651367}', NULL, 1136, 1000000, 0, 0, 0, '{}', '[]'),
(46, 'firma4', 'Firma 4', 1, '{\"x\":547.8786010742188,\"y\":2670.676513671875,\"z\":42.1564826965332}', '{}', '{}', '{\"x\":543.9300537109375,\"y\":2663.234375,\"z\":42.1564826965332}', NULL, 965, 1000000, 0, 0, 0, '{}', '[]'),
(45, 'firma3', 'Firma 3', 1, '{\"x\":-3242.785400390625,\"y\":1001.221923828125,\"z\":12.83070373535156}', '{}', '{}', '{\"x\":-3248.99658203125,\"y\":1006.9669799804688,\"z\":12.83070373535156}', NULL, 107, 1000000, 0, 0, 0, '{}', '[]'),
(44, 'firma2', 'Firma 2', 1, '{\"x\":-3039.935791015625,\"y\":585.5108032226563,\"z\":7.90892839431762}', '{}', '{}', '{\"x\":-3047.92138671875,\"y\":588.3067626953125,\"z\":7.90892839431762}', NULL, 0, 1000000, 0, 0, 0, '{}', '[]'),
(43, 'firma1', 'Firma 1', 1, '{\"x\":2556.7587890625,\"y\":382.1427307128906,\"z\":108.6229248046875}', '{}', '{}', '{\"x\":2550.07763671875,\"y\":387.1881408691406,\"z\":108.6229248046875}', NULL, 1346, 1000000, 0, 0, 0, '{}', '[]'),
(42, 'firma0', 'Firma 0', 1, '{\"x\":373.9737854003906,\"y\":326.5569152832031,\"z\":103.56635284423828}', '{}', '{}', '{\"x\":380.04425048828127,\"y\":332.1336975097656,\"z\":103.56635284423828}', NULL, 8012, 1000000, 0, 0, 0, '{}', '[]'),
(52, 'firma10', 'Firma 10', 1, '{\"x\":-1222.769287109375,\"y\":-907.1284790039063,\"z\":12.32633876800537}', '{}', '{}', '{\"x\":-1219.471923828125,\"y\":-910.6727905273438,\"z\":12.32676029205322}', NULL, 335, 1000000, 0, 0, 0, '{}', '[]'),
(53, 'firma11', 'Firma 11', 1, '{\"x\":-1487.2860107421876,\"y\":-378.93603515625,\"z\":40.16337203979492}', '{}', '{}', '{\"x\":-1484.6513671875,\"y\":-374.9789123535156,\"z\":40.16360855102539}', NULL, 4622, 1000000, 0, 0, 0, '{}', '[]'),
(54, 'firma12', 'Firma 12', 1, '{\"x\":-2968.155029296875,\"y\":390.91717529296877,\"z\":15.04329872131347}', '{}', '{}', '{\"x\":-2963.06787109375,\"y\":391.6311340332031,\"z\":15.04332065582275}', NULL, 532, 1000000, 0, 0, 0, '{}', '[]'),
(55, 'firma13', 'Firma 13', 1, '{\"x\":1166.02197265625,\"y\":2708.996826171875,\"z\":38.15761947631836}', '{}', '{}', '{\"x\":1164.896240234375,\"y\":2714.0908203125,\"z\":38.15814590454101}', NULL, 431, 1000000, 0, 0, 0, '{}', '[]'),
(56, 'firma14', 'Firma 14', 1, '{\"x\":1392.4520263671876,\"y\":3604.804443359375,\"z\":34.98087692260742}', '{}', '{}', '{\"x\":1393.780517578125,\"y\":3609.297119140625,\"z\":34.98087692260742}', NULL, 778, 1000000, 0, 0, 0, '{}', '[]'),
(57, 'firma15', 'Firma 15', 1, '{\"x\":-47.98810958862305,\"y\":-1757.4256591796876,\"z\":29.42098808288574}', '{}', '{}', '{\"x\":-45.04561233520508,\"y\":-1750.4444580078126,\"z\":29.42101860046386}', NULL, 3750, 1000000, 0, 0, 0, '{}', '[]'),
(58, 'firma16', 'Firma 16', 1, '{\"x\":1163.539306640625,\"y\":-323.42889404296877,\"z\":69.20502471923828}', '{}', '{}', '{\"x\":1160.241455078125,\"y\":-316.27947998046877,\"z\":69.20502471923828}', NULL, 1555, 1000000, 0, 0, 0, '{}', '[]'),
(59, 'firma17', 'Firma 17', 1, '{\"x\":-707.3284301757813,\"y\":-914.1729125976563,\"z\":19.2155818939209}', '{}', '{}', '{\"x\":-709.3485107421875,\"y\":-906.6134643554688,\"z\":19.2155818939209}', NULL, 1837, 1000000, 0, 0, 0, '{}', '[]'),
(60, 'firma18', 'Firma 18', 1, '{\"x\":-1820.8211669921876,\"y\":793.1325073242188,\"z\":138.11141967773438}', '{}', '{}', '{\"x\":-1827.2333984375,\"y\":797.1124267578125,\"z\":138.17434692382813}', NULL, 859, 1000000, 0, 0, 0, '{}', '[]'),
(61, 'firma19', 'Firma 19', 1, '{\"x\":1698.5770263671876,\"y\":4924.3095703125,\"z\":42.06361389160156}', '{}', '{}', '{\"x\":1705.5875244140626,\"y\":4921.49462890625,\"z\":42.06361389160156}', NULL, 2447, 1000000, 0, 0, 0, '{}', '[]'),
(62, 'firma20', 'Firma 20', 2, '{\"x\":-814.3079833984375,\"y\":-183.82350158691407,\"z\":37.54518508911133}', '{}', '{}', '{\"x\":-809.01513671875,\"y\":-180.4512939453125,\"z\":37.56887817382812}', NULL, 50, 1000000, 0, 0, 0, '{}', '[]'),
(63, 'firma21', 'Firma 21', 2, '{\"x\":136.82125854492188,\"y\":-1708.3829345703126,\"z\":29.29155158996582}', '{}', '{}', '{\"x\":141.14288330078126,\"y\":-1706.326171875,\"z\":29.29162979125976}', NULL, 0, 1000000, 0, 0, 0, '{}', '[]'),
(64, 'firma22', 'Firma 22', 2, '{\"x\":-1282.60400390625,\"y\":-1116.7569580078126,\"z\":6.99002647399902}', '{}', '{}', '{\"x\":-1278.7142333984376,\"y\":-1119.0989990234376,\"z\":6.9901213645935}', NULL, 150, 1000000, 0, 0, 0, '{}', '[]'),
(65, 'firma23', 'Firma 23', 2, '{\"x\":1931.512939453125,\"y\":3729.6708984375,\"z\":32.84412002563476}', '{}', '{}', '{\"x\":1931.2784423828126,\"y\":3734.667724609375,\"z\":32.84447860717773}', NULL, 150, 1000000, 0, 0, 0, '{}', '[]'),
(66, 'firma24', 'Firma 24', 2, '{\"x\":1212.8399658203126,\"y\":-472.9211730957031,\"z\":66.20800018310547}', '{}', '{}', '{\"x\":1215.8123779296876,\"y\":-475.5716247558594,\"z\":66.20800018310547}', NULL, 0, 1000000, 0, 0, 0, '{}', '[]'),
(67, 'firma25', 'Firma 25', 2, '{\"x\":-32.88523864746094,\"y\":-152.3190460205078,\"z\":57.0761489868164}', '{}', '{}', '{\"x\":-36.25354766845703,\"y\":-155.8475799560547,\"z\":57.07655715942383}', NULL, 350, 1000000, 0, 0, 0, '{}', '[]'),
(68, 'firma26', 'Firma 26', 2, '{\"x\":-278.0769958496094,\"y\":6228.462890625,\"z\":31.69512939453125}', '{}', '{}', '{\"x\":-276.7023620605469,\"y\":6224.1083984375,\"z\":31.69554138183593}', NULL, 0, 1000000, 0, 0, 0, '{}', '[]'),
(69, 'firma27', 'Firma 27', 3, '{\"x\":72.24475860595703,\"y\":-1399.10205078125,\"z\":29.37605667114257}', '{}', '{}', '{\"x\":71.25747680664063,\"y\":-1391.0709228515626,\"z\":29.37615394592285}', NULL, 1150, 1000000, 0, 0, 0, '{}', '[]'),
(70, 'firma28', 'Firma 28', 3, '{\"x\":-703.7697143554688,\"y\":-152.24977111816407,\"z\":37.41505813598633}', '{}', '{}', '{\"x\":-708.8536376953125,\"y\":-151.46649169921876,\"z\":37.41512298583984}', NULL, 400, 1000000, 0, 0, 0, '{}', '[]'),
(71, 'firma29', 'Firma 29', 3, '{\"x\":-167.86314392089845,\"y\":-298.96905517578127,\"z\":39.73307418823242}', '{}', '{}', '{\"x\":-164.94041442871095,\"y\":-302.9537658691406,\"z\":39.73327255249023}', NULL, 250, 1000000, 0, 0, 0, '{}', '[]'),
(72, 'firma30', 'Firma 30', 3, '{\"x\":428.69403076171877,\"y\":-800.1060180664063,\"z\":29.49103546142578}', '{}', '{}', '{\"x\":429.4186096191406,\"y\":-808.0657958984375,\"z\":29.49115753173828}', NULL, 750, 1000000, 0, 0, 0, '{}', '[]'),
(73, 'firma31', 'Firma 31', 3, '{\"x\":-829.4130859375,\"y\":-1073.7099609375,\"z\":11.32802772521972}', '{}', '{}', '{\"x\":-822.722900390625,\"y\":-1069.21630859375,\"z\":11.32811546325683}', NULL, 150, 1000000, 0, 0, 0, '{}', '[]'),
(74, 'firma32', 'Firma 32', 3, '{\"x\":-1447.7969970703126,\"y\":-242.4613037109375,\"z\":49.8082389831543}', '{}', '{}', '{\"x\":-1448.7855224609376,\"y\":-237.90692138671876,\"z\":49.81341552734375}', NULL, 150, 1000000, 0, 0, 0, '{}', '[]'),
(75, 'firma33', 'Firma 33', 3, '{\"x\":11.6318244934082,\"y\":6514.22412109375,\"z\":31.87721443176269}', '{}', '{}', '{\"x\":6.26214742660522,\"y\":6508.384765625,\"z\":31.87786102294922}', NULL, 400, 1000000, 0, 0, 0, '{}', '[]'),
(76, 'firma34', 'Firma 34', 3, '{\"x\":123.63652038574219,\"y\":-219.4370880126953,\"z\":54.55775833129883}', '{}', '{}', '{\"x\":117.81684875488281,\"y\":-233.59048461914063,\"z\":54.55780029296875}', NULL, 2250, 1000000, 0, 0, 0, '{}', '[]'),
(77, 'firma35', 'Firma 35', 3, '{\"x\":1696.291015625,\"y\":4829.31201171875,\"z\":42.06302261352539}', '{}', '{}', '{\"x\":1698.141357421875,\"y\":4821.568359375,\"z\":42.06315994262695}', NULL, 0, 1000000, 0, 0, 0, '{}', '[]'),
(78, 'firma36', 'Firma 36', 3, '{\"x\":618.0931396484375,\"y\":2759.62890625,\"z\":42.0880241394043}', '{}', '{}', '{\"x\":617.5364990234375,\"y\":2775.14794921875,\"z\":42.08807373046875}', NULL, 0, 1000000, 0, 0, 0, '{}', '[]'),
(79, 'firma37', 'Firma 37', 3, '{\"x\":1190.550048828125,\"y\":2713.44091796875,\"z\":38.22215270996094}', '{}', '{}', '{\"x\":1198.62841796875,\"y\":2714.277099609375,\"z\":38.22265625}', NULL, 250, 1000000, 0, 0, 0, '{}', '[]'),
(80, 'firma38', 'Firma 38', 3, '{\"x\":-1193.428955078125,\"y\":-772.2621459960938,\"z\":17.32410812377929}', '{}', '{}', '{\"x\":-1180.7735595703126,\"y\":-764.0654907226563,\"z\":17.32663345336914}', NULL, 300, 1000000, 0, 0, 0, '{}', '[]'),
(81, 'firma39', 'Firma 39', 3, '{\"x\":-3172.49609375,\"y\":1048.133056640625,\"z\":20.86305999755859}', '{}', '{}', '{\"x\":-3179.291259765625,\"y\":1034.1827392578126,\"z\":20.86320686340332}', NULL, 100, 1000000, 0, 0, 0, '{}', '[]'),
(82, 'firma40', 'Firma 40', 3, '{\"x\":-1108.4410400390626,\"y\":2708.923095703125,\"z\":19.09982681274414}', '{}', '{}', '{\"x\":-1102.66162109375,\"y\":2714.638671875,\"z\":19.1078872680664}', NULL, 0, 1000000, 0, 0, 0, '{}', '[]'),
(83, 'firma41', 'Firma 41', 6, '{\"x\":1322.5963134765626,\"y\":-1651.894287109375,\"z\":52.27481079101562}', '{}', '{}', '{\"x\":1324.929931640625,\"y\":-1650.32861328125,\"z\":52.27517318725586}', NULL, 0, 1000000, 0, 0, 0, '{}', '[]'),
(84, 'firma42', 'Firma 42', 6, '{\"x\":-1153.5999755859376,\"y\":-1425.612060546875,\"z\":4.95368719100952}', '{}', '{}', '{\"x\":-1151.9586181640626,\"y\":-1423.6500244140626,\"z\":4.95445775985717}', NULL, 0, 1000000, 0, 0, 0, '{}', '[]'),
(85, 'firma43', 'Firma 43', 6, '{\"x\":322.0897216796875,\"y\":180.39585876464845,\"z\":103.58580017089844}', '{}', '{}', '{\"x\":319.534912109375,\"y\":181.13531494140626,\"z\":103.58647155761719}', NULL, 6296, 1000000, 0, 0, 0, '{}', '[]'),
(86, 'firma44', 'Firma 44', 6, '{\"x\":-3170.0,\"y\":1074.988037109375,\"z\":20.82843208312988}', '{}', '{}', '{\"x\":-3170.63623046875,\"y\":1072.7921142578126,\"z\":20.82915878295898}', NULL, 0, 1000000, 0, 0, 0, '{}', '[]'),
(87, 'firma45', 'Firma 45', 6, '{\"x\":1864.610595703125,\"y\":3747.699951171875,\"z\":33.03106689453125}', '{}', '{}', '{\"x\":1862.3421630859376,\"y\":3748.359619140625,\"z\":33.03609848022461}', NULL, 0, 1000000, 0, 0, 0, '{}', '[]'),
(88, 'firma46', 'Firma 46', 6, '{\"x\":-293.7037048339844,\"y\":6200.0,\"z\":31.4818058013916}', '{}', '{}', '{\"x\":-291.94317626953127,\"y\":6199.90869140625,\"z\":31.4883918762207}', NULL, 0, 1000000, 0, 0, 0, '{}', '[]'),
(89, 'firma47', 'Firma 47', 7, '{\"x\":934.3333129882813,\"y\":-2952.836669921875,\"z\":5.87173986434936}', '{}', '{}', '{\"x\":933.8359375,\"y\":-2957.855712890625,\"z\":5.90115642547607}', NULL, 165, 1000000, 0, 0, 0, '{}', '[]');

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
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `imanja`
--

DROP TABLE IF EXISTS `imanja`;
CREATE TABLE IF NOT EXISTS `imanja` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Ime` varchar(255) NOT NULL,
  `Koord` longtext NOT NULL,
  `Cijena` int(11) NOT NULL DEFAULT 0,
  `Vlasnik` int(11) DEFAULT NULL,
  `Kuca` varchar(255) DEFAULT NULL,
  `KKoord` longtext NOT NULL,
  `MKoord` longtext NOT NULL,
  `KucaID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

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
  `weight` int(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=183 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

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
(180, 'fish', 'Riba', 50, 0, 1, 1000),
(182, 'pboca', 'Plinska boca', 1, 0, 1, 5000);

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
  `id` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`name`) USING BTREE,
  KEY `whitelisted` (`whitelisted`) USING BTREE,
  KEY `pID` (`pID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`pID`, `name`, `label`, `whitelisted`, `id`) VALUES
(2, 'ambulance', 'LSMD', 1, 0),
(13, 'devilzeye', 'devilzeye', 1, 1),
(14, 'fake', 'fake', 1, 1),
(3, 'mechanic', 'Mehanicar', 1, 0),
(8, 'montana', 'montana', 1, 1),
(7, 'omerta', 'omerta', 1, 1),
(9, 'panthers', 'panthers', 1, 1),
(4, 'police', 'LSPD', 1, 0),
(11, 'pollos', 'pollos', 1, 1),
(5, 'reporter', 'Reporter', 1, 1),
(10, 'sinaloa', 'sinaloa', 1, 1),
(6, 'taxi', 'Uber', 1, 0),
(1, 'unemployed', 'Nezaposlen', 0, 0),
(12, 'zemunski', 'zemunski', 1, 1);

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
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=273 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

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
(23, 'police', 0, 'recruit', 'Kadet', 400, '{}', '{}'),
(24, 'police', 1, 'officer', 'Saobracajac', 500, '{}', '{}'),
(26, 'police', 2, 'sergeant', 'Policajac', 600, '{}', '{}'),
(27, 'police', 5, 'chef', 'Komandant', 700, '{{\"tshirt_1\":96,\"tshirt_2\":0,\"torso_1\":32,\"arms\":4,\"pants_1\":28,\"shoes_1\":10,\"chain_1\":125,\"chain_2\":0,\"helmet_1\":46,\"helmet_2\":3}}', '{}'),
(28, 'mechanic', 0, 'recrue', 'Segrt', 450, '{}', '{}'),
(29, 'mechanic', 1, 'novice', 'Radnik', 700, '{}', '{}'),
(30, 'mechanic', 2, 'experimente', 'Iskusni Radnik', 1000, '{}', '{}'),
(31, 'mechanic', 3, 'chief', 'Podsef', 1500, '{}', '{}'),
(32, 'mechanic', 4, 'boss', 'Sef', 10000, '{}', '{}'),
(54, 'ambulance', 0, 'ambulance', 'Vozac', 400, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":9,\"torso_2\":3,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":0,\"helmet_2\":0,\"arms\":92,\"face\":19,\"decals_1\":60,\"torso_1\":13,\"hair_2\":0,\"skin\":34,\"pants_2\":5}', '{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
(55, 'ambulance', 1, 'doctor', 'Medicinski Tehnicar', 600, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":9,\"torso_2\":3,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":0,\"helmet_2\":0,\"arms\":92,\"face\":19,\"decals_1\":60,\"torso_1\":13,\"hair_2\":0,\"skin\":34,\"pants_2\":5}', '{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
(56, 'ambulance', 2, 'chief_doctor', 'Doktor', 800, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":9,\"torso_2\":3,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":0,\"helmet_2\":0,\"arms\":92,\"face\":19,\"decals_1\":60,\"torso_1\":13,\"hair_2\":0,\"skin\":34,\"pants_2\":5}', '{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
(57, 'ambulance', 3, 'boss', 'Kirurg', 1200, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":9,\"torso_2\":3,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":0,\"helmet_2\":0,\"arms\":92,\"face\":19,\"decals_1\":60,\"torso_1\":13,\"hair_2\":0,\"skin\":34,\"pants_2\":5}', '{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
(58, 'kosac', 0, 'employee', 'Radnik', 200, '{\"tshirt_1\":59,\"torso_1\":89,\"arms\":31,\"pants_1\":36,\"glasses_1\":19,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":2,\"glasses_2\":0,\"torso_2\":1,\"shoes\":35,\"hair_1\":0,\"skin\":0,\"sex\":0,\"glasses_1\":19,\"pants_2\":0,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":5}', '{\"tshirt_1\":36,\"torso_1\":0,\"arms\":68,\"pants_1\":30,\"glasses_1\":15,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":27,\"glasses_2\":0,\"torso_2\":11,\"shoes\":26,\"hair_1\":5,\"skin\":0,\"sex\":1,\"glasses_1\":15,\"pants_2\":2,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":19}'),
(59, 'deliverer', 0, 'employee', 'Radnik', 600, '{\"tshirt_1\":59,\"torso_1\":89,\"arms\":31,\"pants_1\":36,\"glasses_1\":19,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":2,\"glasses_2\":0,\"torso_2\":1,\"shoes\":35,\"hair_1\":0,\"skin\":0,\"sex\":0,\"glasses_1\":19,\"pants_2\":0,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":5}', '{\"tshirt_1\":36,\"torso_1\":0,\"arms\":68,\"pants_1\":30,\"glasses_1\":15,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":27,\"glasses_2\":0,\"torso_2\":11,\"shoes\":26,\"hair_1\":5,\"skin\":0,\"sex\":1,\"glasses_1\":15,\"pants_2\":2,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":19}'),
(60, 'vatrogasac', 0, 'employee', 'Radnik', 200, '{\"tshirt_1\":75,\"torso_1\":267,\"arms\":17,\"pants_1\":34,\"glasses_1\":0,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":4,\"hair_color_1\":0,\"face\":2,\"glasses_2\":0,\"torso_2\":4,\"shoes_1\":71,\"shoes_2\":25,\"hair_1\":0,\"skin\":0,\"sex\":0,\"glasses_1\":0,\"pants_2\":0,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":3,\"helmet_1\":126}', '{\"tshirt_1\":75,\"torso_1\":267,\"arms\":17,\"pants_1\":34,\"glasses_1\":0,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":4,\"hair_color_1\":0,\"face\":2,\"glasses_2\":0,\"torso_2\":4,\"shoes_1\":71,\"shoes_2\":25,\"hair_1\":0,\"skin\":0,\"sex\":0,\"glasses_1\":0,\"pants_2\":0,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":3,\"helmet_1\":126}'),
(62, 'police', 4, 'lieutenant', 'Inspektor', 750, '{}', '{}'),
(64, 'police', 3, 'intendent', 'Serif', 0, '{\"tshirt_1\":5,\"tshirt_2\":3,\"torso_1\":53,\"arms\":17,\"pants_1\":33,\"shoes_1\":62,\"decals_1\":0,\"decals_2\":0,\"helmet_1\":59,\"helmet_2\":9,\"glasses_1\":15,\"glasses_2\":7,\"watch_1\":6,\"mask_1\":56,\"mask_2\":1}', '{}'),
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
(114, 'police', 6, 'boss', 'Nacelnik', 900, '{{\"tshirt_1\":96,\"tshirt_2\":0,\"torso_1\":32,\"arms\":4,\"pants_1\":28,\"shoes_1\":10,\"chain_1\":125,\"chain_2\":0,\"helmet_1\":46,\"helmet_2\":3}}', '{}'),
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
(203, 'fastfood', 0, 'employee', 'Uber Eats', 200, '{\"tshirt_1\":59,\"torso_1\":67,\"arms\":1,\"pants_1\":22,\"glasses_1\":0,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":2,\"glasses_2\":0,\"torso_2\":3,\"shoes_1\":1,\"hair_1\":0,\"skin\":0,\"sex\":0,\"glasses_1\":19,\"pants_2\":5,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":17}', '{\"tshirt_1\":36,\"torso_1\":0,\"arms\":68,\"pants_1\":30,\"glasses_1\":15,\"decals_2\":0,\"hair_color_2\":0,\"helmet_2\":0,\"hair_color_1\":0,\"face\":27,\"glasses_2\":0,\"torso_2\":11,\"shoes\":26,\"hair_1\":5,\"skin\":0,\"sex\":1,\"glasses_1\":15,\"pants_2\":2,\"hair_2\":0,\"decals_1\":0,\"tshirt_2\":0,\"helmet_1\":19}'),
(240, 'omerta', 0, 'Pocetnik', 'Pocetnik', 1, '{}', '{}'),
(241, 'omerta', 1, 'Diler', 'Diler', 300, '{}', '{}'),
(242, 'omerta', 2, 'Podsef', 'Podsef', 300, '{}', '{}'),
(243, 'omerta', 3, 'boss', 'boss', 300, '{}', '{}'),
(248, 'montana', 0, 'Pocetnik', 'pocetnik', 0, '{}', '{}'),
(249, 'montana', 1, 'Diler', 'diler', 0, '{}', '{}'),
(250, 'montana', 2, 'Podsef', 'podsef', 0, '{}', '{}'),
(252, 'montana', 3, 'boss', 'boss', 0, '{}', '{}'),
(253, 'panthers', 0, 'Pocetnik', 'pocetnik', 300, '{}', '{}'),
(254, 'panthers', 1, 'Diler', 'diler', 300, '{}', '{}'),
(255, 'panthers', 2, 'Podsef', 'podsef', 300, '{}', '{}'),
(256, 'panthers', 3, 'boss', 'boss', 300, '{}', '{}'),
(257, 'sinaloa', 0, 'Pocetnik', 'pocetnik', 0, '{}', '{}'),
(258, 'sinaloa', 1, 'Diler', 'diler', 0, '{}', '{}'),
(259, 'sinaloa', 2, 'Podsef', 'podsef', 0, '{}', '{}'),
(260, 'sinaloa', 3, 'boss', 'boss', 0, '{}', '{}'),
(261, 'pollos', 0, 'Pocetnik', 'pocetnik', 300, '{}', '{}'),
(262, 'pollos', 1, 'Diler', 'diler', 300, '{}', '{}'),
(263, 'pollos', 2, 'Podsef', 'podsef', 300, '{}', '{}'),
(264, 'pollos', 3, 'boss', 'boss', 300, '{}', '{}'),
(265, 'zemunski', 0, 'Pocetnik', 'pocetnik', 0, '{}', '{}'),
(266, 'zemunski', 1, 'Diler', 'diler', 0, '{}', '{}'),
(267, 'zemunski', 2, 'Podsef', 'podsef', 0, '{}', '{}'),
(268, 'zemunski', 3, 'boss', 'boss', 0, '{}', '{}'),
(269, 'devilzeye', 0, 'Pocetnik', 'pocetnik', 300, '{}', '{}'),
(270, 'devilzeye', 1, 'Diler', 'Diler', 300, '{}', '{}'),
(271, 'devilzeye', 2, 'Podsef', 'podsef', 300, '{}', '{}'),
(272, 'devilzeye', 3, 'boss', 'boss', 300, '{}', '{}');

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
  `classified` int(11) NOT NULL DEFAULT 0,
  `identifier` varchar(255) DEFAULT NULL,
  `dob` varchar(255) DEFAULT NULL,
  `warden` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`offense`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

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
  PRIMARY KEY (`identifier`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

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
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=356 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `kuce`
--

INSERT INTO `kuce` (`ID`, `prop`, `door`, `price`, `prodaja`, `rentanje`, `rentCijena`) VALUES
(1, 'trevor', '{\"x\":-1112.25,\"y\":-1578.4000244140626,\"z\":7.69999980926513}', 22500, 0, 0, 20),
(2, 'trevor', '{\"x\":-1114.3399658203126,\"y\":-1579.469970703125,\"z\":7.69999980926513}', 22500, 0, 0, 20),
(3, 'trevor', '{\"x\":-1114.949951171875,\"y\":-1577.5699462890626,\"z\":3.55999994277954}', 22500, 0, 0, 20),
(4, 'trevor', '{\"x\":373.9276123046875,\"y\":427.87890625,\"z\":144.7342071533203}', 22500, 0, 0, 20),
(5, 'nice', '{\"x\":346.4424133300781,\"y\":440.6260070800781,\"z\":146.7830047607422}', 38000, 0, 0, 20),
(6, 'nice', '{\"x\":331.4053955078125,\"y\":465.68231201171877,\"z\":150.2642059326172}', 38000, 0, 0, 20),
(7, 'mansion', '{\"x\":316.0714111328125,\"y\":501.47869873046877,\"z\":152.22979736328126}', 65000, 0, 0, 20),
(8, 'mansion', '{\"x\":325.3428039550781,\"y\":537.4041748046875,\"z\":152.92059326171876}', 65000, 0, 0, 20),
(9, 'nice', '{\"x\":223.64830017089845,\"y\":513.9970703125,\"z\":139.8170928955078}', 38000, 0, 0, 20),
(10, 'nice', '{\"x\":119.22889709472656,\"y\":494.32330322265627,\"z\":146.3928985595703}', 38000, 0, 0, 20),
(11, 'nice', '{\"x\":80.12486267089844,\"y\":485.8677978515625,\"z\":147.25169372558595}', 38000, 0, 0, 20),
(12, 'nice', '{\"x\":57.8746109008789,\"y\":450.0857849121094,\"z\":146.0814971923828}', 38000, 0, 0, 20),
(13, 'nice', '{\"x\":42.98038864135742,\"y\":468.6543884277344,\"z\":147.14590454101563}', 38000, 0, 0, 20),
(14, 'mansion', '{\"x\":-7.60816717147827,\"y\":468.3959045410156,\"z\":144.92080688476563}', 65000, 0, 0, 20),
(15, 'nice', '{\"x\":-66.48236846923828,\"y\":490.8035888671875,\"z\":143.74229431152345}', 38000, 0, 0, 20),
(16, 'mansion', '{\"x\":-109.8572006225586,\"y\":502.61920166015627,\"z\":142.3531036376953}', 65000, 0, 0, 20),
(17, 'nice', '{\"x\":-174.7194061279297,\"y\":502.5979919433594,\"z\":136.47059631347657}', 38000, 0, 0, 20),
(18, 'nice', '{\"x\":84.86479949951172,\"y\":561.9719848632813,\"z\":181.8175048828125}', 38000, 0, 0, 20),
(19, 'lester', '{\"x\":119.08489990234375,\"y\":564.5529174804688,\"z\":183.00369262695313}', 25000, 0, 0, 20),
(20, 'nice', '{\"x\":215.64540100097657,\"y\":620.1937255859375,\"z\":186.66729736328126}', 38000, 0, 0, 20),
(21, 'nice', '{\"x\":231.95640563964845,\"y\":672.4473266601563,\"z\":188.99549865722657}', 38000, 0, 0, 20),
(22, 'nice', '{\"x\":-230.5478057861328,\"y\":488.45928955078127,\"z\":127.81749725341797}', 38000, 0, 0, 20),
(23, 'nice', '{\"x\":-311.9219970703125,\"y\":474.8205871582031,\"z\":110.87239837646485}', 38000, 0, 1, 40),
(24, 'nice', '{\"x\":-166.7200927734375,\"y\":424.6629943847656,\"z\":110.85579681396485}', 38000, 0, 0, 20),
(25, 'mansion', '{\"x\":-297.89208984375,\"y\":380.3153076171875,\"z\":111.14530181884766}', 65000, 0, 0, 20),
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
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `kuca` (`kuca`,`owner`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

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
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `owner` (`owner`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

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
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `item` (`item`) USING BTREE,
  KEY `owner` (`owner`) USING BTREE,
  KEY `kuca` (`kuca`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `licenses`
--

DROP TABLE IF EXISTS `licenses`;
CREATE TABLE IF NOT EXISTS `licenses` (
  `type` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL,
  PRIMARY KEY (`type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

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
  `Vozila` longtext NOT NULL,
  `Oruzja` longtext NOT NULL,
  `Boje` varchar(255) NOT NULL DEFAULT '{}',
  `Ulaz` varchar(250) NOT NULL DEFAULT '{}',
  `Izlaz` varchar(250) NOT NULL DEFAULT '{}',
  `Gradonacelnik` int(11) NOT NULL DEFAULT 0,
  `DeleteV2` varchar(255) NOT NULL DEFAULT '{}',
  `LokVozila2` varchar(250) NOT NULL DEFAULT '{}',
  `Kokain` varchar(255) NOT NULL DEFAULT '{}',
  `KamionK` varchar(255) NOT NULL DEFAULT '{}',
  `Skladiste` int(11) NOT NULL DEFAULT 0,
  `Posao` int(11) NOT NULL DEFAULT 0,
  `KPosao` varchar(255) NOT NULL DEFAULT '{}',
  `PosaoSpawn` varchar(255) NOT NULL DEFAULT '{}',
  `Heroin` varchar(255) NOT NULL DEFAULT '{}',
  `KamionH` varchar(255) NOT NULL DEFAULT '{}',
  `Skladiste2` int(11) NOT NULL DEFAULT 0,
  `Avion` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `mafije`
--

INSERT INTO `mafije` (`ID`, `Ime`, `Label`, `Rankovi`, `Oruzarnica`, `Lider`, `SpawnV`, `DeleteV`, `LokVozila`, `CrateDrop`, `Vozila`, `Oruzja`, `Boje`, `Ulaz`, `Izlaz`, `Gradonacelnik`, `DeleteV2`, `LokVozila2`, `Kokain`, `KamionK`, `Skladiste`, `Posao`, `KPosao`, `PosaoSpawn`, `Heroin`, `KamionH`, `Skladiste2`, `Avion`) VALUES
(28, 'omerta', 'omerta', '[{\"ID\":0,\"Ime\":\"Pocetnik\"},{\"ID\":1,\"Ime\":\"Diler\"},{\"ID\":2,\"Ime\":\"Podsef\"},{\"ID\":3,\"Ime\":\"boss\"}]', '[-811.65625,175.20733642578126,75.7453384399414]', '[-811.5560913085938,181.09063720703126,75.74079895019531]', '[-811.4532470703125,187.16062927246095,71.47862243652344]', '[-817.8375854492188,185.07177734375,71.32868194580078]', '[-822.4115600585938,181.62937927246095,70.76243591308594,126.18638610839844]', '{}', '[{\"Ime\":\"zastava101\",\"Label\":\"Zastava 101\"}]', '{}', '[{\"Ime\":\"Blip\",\"Boja\":1}]', '{}', '{}', 0, '{}', '{}', '[-1114.0413818359376,4926.70556640625,217.1011505126953]', '{}', 1, 0, '{}', '{}', '[-1106.9371337890626,4922.5107421875,216.10316467285157]', '{}', 1, 0),
(29, 'montana', 'montana', '[{\"ID\":0,\"Ime\":\"Pocetnik\"},{\"ID\":1,\"Ime\":\"Diler\"},{\"ID\":2,\"Ime\":\"Podsef\"},{\"ID\":3,\"Ime\":\"boss\"}]', '[-1541.2978515625,91.93569946289063,52.89733505249023]', '[-1541.0174560546876,92.28370666503906,56.95387649536133]', '[-1524.326904296875,82.01624298095703,55.58827209472656]', '[-1528.9996337890626,81.60293579101563,55.65853500366211]', '[-1519.75244140625,87.71495819091797,55.35099411010742,265.9933776855469]', '{}', '[{\"Ime\":\"zastava101\",\"Label\":\"Zastava 101\"}]', '{}', '[{\"Ime\":\"Blip\",\"Boja\":26},{\"B\":26,\"R\":26,\"Ime\":\"Vozilo\",\"G\":26}]', '{}', '{}', 0, '{}', '{}', '{}', '{}', 0, 0, '{}', '{}', '{}', '{}', 0, 0),
(30, 'panthers', 'panthers', '[{\"ID\":0,\"Ime\":\"Pocetnik\"},{\"ID\":1,\"Ime\":\"Diler\"},{\"ID\":2,\"Ime\":\"Podsef\"},{\"ID\":3,\"Ime\":\"boss\"}]', '[-574.8690185546875,291.2066650390625,78.17670440673828]', '[-561.3453979492188,281.8149108886719,84.67633819580078]', '[-565.8964233398438,302.029296875,82.13440704345703]', '[-553.1580200195313,308.3945007324219,82.21385955810547]', '[-551.0376586914063,303.62713623046877,82.15904235839844,273.2047119140625]', '{}', '[{\"Ime\":\"zastava101\",\"Label\":\"Zastava 101\"}]', '{}', '[{\"Ime\":\"Blip\",\"Boja\":58}]', '{}', '{}', 0, '{}', '{}', '{}', '{}', 0, 0, '{}', '{}', '{}', '{}', 0, 0),
(31, 'sinaloa', 'sinaloa', '[{\"Ime\":\"Pocetnik\",\"ID\":0},{\"Ime\":\"Diler\",\"ID\":1},{\"Ime\":\"Podsef\",\"ID\":2},{\"Ime\":\"boss\",\"ID\":3}]', '[1414.9927978515626,1163.337646484375,113.33426666259766]', '[1414.8638916015626,1160.1529541015626,113.67388916015625]', '[1412.3978271484376,1118.8829345703126,113.8379135131836]', '{}', '[1398.4110107421876,1119.092529296875,113.8377685546875,88.17010498046875]', '{}', '[{\"Ime\":\"zastava101\",\"Label\":\"zastava\"}]', '{}', '[{\"Ime\":\"Blip\",\"Boja\":64}]', '{}', '{}', 0, '{}', '{}', '{}', '{}', 0, 0, '{}', '{}', '{}', '{}', 0, 0),
(32, 'pollos', 'pollos', '[{\"Ime\":\"Pocetnik\",\"ID\":0},{\"Ime\":\"Diler\",\"ID\":1},{\"Ime\":\"Podsef\",\"ID\":2},{\"Ime\":\"boss\",\"ID\":3}]', '[9.5750093460083,528.8480834960938,169.6189727783203]', '[-1.46080720424652,535.55859375,174.34254455566407]', '[24.53618049621582,542.997314453125,175.0275115966797]', '[20.54754447937011,545.3576049804688,175.0275115966797]', '[13.37284183502197,549.2056884765625,175.1866912841797,102.77726745605469]', '{}', '[{\"Ime\":\"zastava101\",\"Label\":\"Zastava 101\"}]', '{}', '[{\"Ime\":\"Blip\",\"Boja\":8}]', '{}', '{}', 0, '{}', '{}', '{}', '{}', 0, 0, '{}', '{}', '{}', '{}', 0, 0),
(33, 'zemunski', 'zemunski', '[{\"Ime\":\"Pocetnik\",\"ID\":0},{\"Ime\":\"Diler\",\"ID\":1},{\"Ime\":\"Podsef\",\"ID\":2},{\"Ime\":\"boss\",\"ID\":3}]', '[-1792.0670166015626,441.86492919921877,127.50787353515625]', '[-1757.3079833984376,427.458251953125,126.68441009521485]', '[-1789.4769287109376,462.2101745605469,127.30819702148438]', '[-1791.305908203125,456.5953369140625,127.30819702148438]', '[-1797.825439453125,458.25054931640627,127.30819702148438,109.52713775634766]', '{}', '[{\"Ime\":\"zastava101\",\"Label\":\"Zastava 101\"}]', '{}', '[{\"Ime\":\"Blip\",\"Boja\":73}]', '{}', '{}', 0, '{}', '{}', '{}', '{}', 0, 0, '{}', '{}', '{}', '{}', 0, 0),
(34, 'devilzeye', 'devilzeye', '[{\"Ime\":\"Pocetnik\",\"ID\":0},{\"Ime\":\"Diler\",\"ID\":1},{\"Ime\":\"Podsef\",\"ID\":2},{\"Ime\":\"boss\",\"ID\":3}]', '[-1928.878662109375,2059.557373046875,139.83741760253907]', '[-1911.7056884765626,2074.21484375,139.38600158691407]', '[-1920.3162841796876,2043.9605712890626,139.73562622070313]', '[-1920.0379638671876,2048.2080078125,139.73562622070313]', '[-1913.44091796875,2041.1300048828126,139.7372283935547,177.92481994628907]', '{}', '[{\"Ime\":\"zastava101\",\"Label\":\"Zastava 101\"}]', '{}', '[{\"Ime\":\"Blip\",\"Boja\":43}]', '{}', '{}', 0, '{}', '{}', '{}', '{}', 0, 0, '{}', '{}', '{}', '{}', 0, 0);

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
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `tablica` (`tablica`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=175 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `meh_narudzbe`
--

INSERT INTO `meh_narudzbe` (`ID`, `tablica`, `narudzba`, `vrijeme`, `broj`) VALUES
(158, 'III 954', '[{\"modNum\":10,\"price\":26,\"label\":\"Lowrider [11] Classic Rod \",\"modType\":\"modFrontWheels\",\"wheelType\":2,\"tablica\":\"III 954\"},{\"modNum\":0,\"price\":28,\"label\":\"Auspuh [1] Titanium Tuner Exhaust \",\"modType\":\"modExhaust\",\"tablica\":\"III 954\"},{\"modNum\":12,\"price\":6,\"label\":\"Glavna [6] Matte Black \",\"modType\":\"color1\",\"tablica\":\"III 954\"},{\"modNum\":2,\"price\":6,\"label\":\"Tablica [3] Zuto na plavo \",\"modType\":\"plateIndex\",\"tablica\":\"III 954\"}]', '2022-11-26 19:33:50', 1092880),
(155, 'VGM 553', '[{\"modNum\":12,\"price\":6,\"label\":\"Glavna [6] Matte Black \",\"modType\":\"color1\",\"tablica\":\"VGM 553\"},{\"modNum\":true,\"price\":20,\"label\":\"Svijetla Xenon \",\"modType\":\"modXenon\",\"tablica\":\"VGM 553\"}]', '2022-11-26 19:16:06', 4918169),
(156, 'HLH 584', '[{\"modNum\":2,\"price\":900,\"label\":\"Stage tuning Stage 2 \",\"modType\":\"stage\",\"tablica\":\"HLH 584\"},{\"modNum\":3,\"price\":111,\"label\":\"Suspenzija Level 4 \",\"modType\":\"modSuspension\",\"tablica\":\"HLH 584\"}]', '2022-11-26 19:25:39', 1092880),
(157, 'III 954', '[{\"modNum\":true,\"price\":313,\"label\":\"Turbo Turbo \",\"modType\":\"modTurbo\",\"tablica\":\"III 954\"},{\"modNum\":4,\"price\":953,\"label\":\"Motor Level 5 \",\"modType\":\"modEngine\",\"tablica\":\"III 954\"},{\"modNum\":3,\"price\":430,\"label\":\"Mjenjac Level 4 \",\"modType\":\"modTransmission\",\"tablica\":\"III 954\"},{\"modNum\":1,\"price\":900,\"label\":\"Stage tuning Stage 1 \",\"modType\":\"stage\",\"tablica\":\"III 954\"}]', '2022-11-26 19:30:49', 1092880);

-- --------------------------------------------------------

--
-- Table structure for table `minute`
--

DROP TABLE IF EXISTS `minute`;
CREATE TABLE IF NOT EXISTS `minute` (
  `identifier` int(11) NOT NULL,
  `minute` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`identifier`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

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
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

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
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

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
-- Table structure for table `phone_app_chat`
--

DROP TABLE IF EXISTS `phone_app_chat`;
CREATE TABLE IF NOT EXISTS `phone_app_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(20) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `identifier` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

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
  PRIMARY KEY (`id`) USING BTREE,
  KEY `owner` (`owner`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

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
  PRIMARY KEY (`id`) USING BTREE,
  KEY `time` (`time`) USING BTREE,
  KEY `rec` (`receiver`) USING BTREE,
  KEY `tran` (`transmitter`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=1574 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Table structure for table `phone_users_contacts`
--

DROP TABLE IF EXISTS `phone_users_contacts`;
CREATE TABLE IF NOT EXISTS `phone_users_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` int(11) DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  `display` varchar(64) CHARACTER SET utf8mb4 NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `number` (`number`) USING BTREE,
  KEY `ident` (`identifier`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=79 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Table structure for table `poslovi`
--

DROP TABLE IF EXISTS `poslovi`;
CREATE TABLE IF NOT EXISTS `poslovi` (
  `pID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  `whitelisted` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `id` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`name`) USING BTREE,
  KEY `whitelisted` (`whitelisted`) USING BTREE,
  KEY `pID` (`pID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `poslovi`
--

INSERT INTO `poslovi` (`pID`, `name`, `label`, `whitelisted`, `id`) VALUES
(2, 'farmer', 'Farmer', 0, 1),
(3, 'kamion', 'Kamiondzija', 0, 1),
(4, 'kosac', 'Kosac trave', 0, 0),
(6, 'kran', 'Kranista', 0, 1),
(5, 'luka', 'Lucki radnik', 0, 1),
(7, 'ralica', 'Cistac snijega', 0, 1),
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
(1, NULL, '{\"x\":25.20756912231445,\"y\":-1391.8756103515626,\"z\":28.33451271057129}', '{\"x\":-1.5900136232376,\"y\":-1400.3079833984376,\"z\":28.27205467224121}', 50, 20, 45000),
(2, NULL, '{\"x\":-699.8239135742188,\"y\":-932.6240234375,\"z\":18.01389694213867}', '{\"x\":-703.8509521484375,\"y\":-941.4659423828125,\"z\":18.27253723144531}', 50, 0, 45000),
(3, NULL, '{\"x\":168.01113891601563,\"y\":-1715.1614990234376,\"z\":28.29169845581054}', '{\"x\":167.40232849121095,\"y\":-1709.40869140625,\"z\":28.29169845581054}', 50, 0, 45000);

-- --------------------------------------------------------

--
-- Table structure for table `prijatelji`
--

DROP TABLE IF EXISTS `prijatelji`;
CREATE TABLE IF NOT EXISTS `prijatelji` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `VlasnikID` int(11) NOT NULL,
  `PrijateljID` int(11) NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

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
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

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
  `gcijena` double NOT NULL DEFAULT 1,
  `kcijena` double NOT NULL DEFAULT 250,
  `gorivo` int(11) NOT NULL DEFAULT 500,
  `narudzba` int(11) NOT NULL DEFAULT 0,
  `dostava` varchar(255) NOT NULL DEFAULT '{}',
  `kapacitet` tinyint(1) NOT NULL DEFAULT 0,
  `bcijena` double NOT NULL DEFAULT 700,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `pumpe`
--

INSERT INTO `pumpe` (`ID`, `ime`, `koord`, `vlasnik`, `cijena`, `sef`, `gcijena`, `kcijena`, `gorivo`, `narudzba`, `dostava`, `kapacitet`, `bcijena`) VALUES
(5, 'Pumpa 1', '{\"x\":288.7102966308594,\"y\":-1266.9971923828126,\"z\":29.44075202941894}', NULL, 600000, 1055, 1.1, 26, 2450, 0, '{\"x\":284.2962341308594,\"y\":-1251.5218505859376,\"z\":29.25572204589843}', 0, 50),
(6, 'Pumpa 2', '{\"x\":46.5079116821289,\"y\":2789.208740234375,\"z\":57.87831497192383}', NULL, 600000, 0, 1.1, 26, 2500, 0, '{\"x\":65.29000854492188,\"y\":2782.740966796875,\"z\":57.8783073425293}', 0, 50),
(7, 'Pumpa 3', '{\"x\":265.904296875,\"y\":2598.3525390625,\"z\":44.83026885986328}', NULL, 600000, 30, 1.1, 26, 2500, 0, '{\"x\":243.4324493408203,\"y\":2599.6689453125,\"z\":45.12274551391601}', 0, 50),
(8, 'Pumpa 4', '{\"x\":1039.33837890625,\"y\":2664.4296875,\"z\":39.55110931396484}', NULL, 600000, 0, 1.1, 26, 2500, 0, '{\"x\":1057.305908203125,\"y\":2657.41064453125,\"z\":39.55492782592773}', 0, 50),
(9, 'Pumpa 5', '{\"x\":1204.728759765625,\"y\":2663.441162109375,\"z\":37.80981826782226}', NULL, 600000, 72, 1.1, 26, 2500, 0, '{\"x\":1208.5582275390626,\"y\":2642.334228515625,\"z\":37.83019256591797}', 0, 50),
(10, 'Pumpa 6', '{\"x\":2545.087646484375,\"y\":2592.07177734375,\"z\":37.95740509033203}', NULL, 600000, 0, 1.1, 26, 2500, 0, '{\"x\":2537.218017578125,\"y\":2587.263427734375,\"z\":37.94486999511719}', 0, 50),
(11, 'Pumpa 7', '{\"x\":2673.765625,\"y\":3267.038330078125,\"z\":55.24057006835937}', NULL, 600000, 440, 1.1, 26, 2500, 0, '{\"x\":2685.82470703125,\"y\":3259.474853515625,\"z\":55.24052047729492}', 0, 50),
(12, 'Pumpa 8', '{\"x\":2001.4554443359376,\"y\":3779.962890625,\"z\":32.18083190917969}', NULL, 600000, 144, 1.1, 26, 2500, 0, '{\"x\":1985.66357421875,\"y\":3757.26171875,\"z\":32.17351150512695}', 0, 50),
(13, 'Pumpa 9', '{\"x\":1693.9664306640626,\"y\":4924.24267578125,\"z\":42.07815170288086}', NULL, 600000, 98, 1.1, 26, 2500, 0, '{\"x\":1699.9659423828126,\"y\":4942.923828125,\"z\":42.1611213684082}', 0, 50),
(14, 'Pumpa 10', '{\"x\":1706.0556640625,\"y\":6425.56298828125,\"z\":32.76841735839844}', NULL, 600000, 114, 1.1, 26, 2500, 0, '{\"x\":1685.691650390625,\"y\":6435.3154296875,\"z\":32.35713958740234}', 0, 50),
(15, 'Pumpa 11', '{\"x\":179.8773956298828,\"y\":6602.54345703125,\"z\":31.86820411682129}', NULL, 600000, 454, 1.1, 26, 2500, 0, '{\"x\":201.42800903320313,\"y\":6622.1669921875,\"z\":31.57495498657226}', 0, 50),
(16, 'Pumpa 12', '{\"x\":-92.73368072509766,\"y\":6409.70263671875,\"z\":31.64035034179687}', NULL, 600000, 80, 1.1, 26, 2500, 0, '{\"x\":-79.52699279785156,\"y\":6431.9990234375,\"z\":31.49045944213867}', 0, 50),
(17, 'Pumpa 13', '{\"x\":-2544.21923828125,\"y\":2316.140380859375,\"z\":33.21610641479492}', NULL, 600000, 26, 1.1, 26, 2500, 0, '{\"x\":-2544.855224609375,\"y\":2323.4072265625,\"z\":33.0599250793457}', 0, 50),
(18, 'Pumpa 14', '{\"x\":-1801.026611328125,\"y\":804.757080078125,\"z\":138.4710693359375}', NULL, 600000, 40, 1.1, 26, 2500, 0, '{\"x\":-1813.795654296875,\"y\":799.1516723632813,\"z\":138.47694396972657}', 0, 50),
(19, 'Pumpa 15', '{\"x\":-1427.7933349609376,\"y\":-268.3453674316406,\"z\":46.2274169921875}', NULL, 600000, 146, 1.1, 26, 2500, 0, '{\"x\":-1408.90771484375,\"y\":-276.75555419921877,\"z\":46.37263870239258}', 0, 50),
(20, 'Pumpa 16', '{\"x\":-2073.2041015625,\"y\":-327.2723083496094,\"z\":13.31596565246582}', NULL, 600000, 0, 1.1, 26, 500, 0, '{\"x\":-2064.948974609375,\"y\":-305.96405029296877,\"z\":13.142915725708}', 0, 50),
(21, 'Pumpa 17', '{\"x\":-724.0491333007813,\"y\":-937.43115234375,\"z\":19.03470802307129}', NULL, 600000, 308, 1.1, 26, 2500, 0, '{\"x\":-711.2090454101563,\"y\":-927.6903686523438,\"z\":19.01409339904785}', 0, 50),
(22, 'Pumpa 18', '{\"x\":-531.4134521484375,\"y\":-1220.990234375,\"z\":18.45499420166015}', NULL, 600000, 32, 1.1, 26, 2500, 0, '{\"x\":-520.8833618164063,\"y\":-1201.466796875,\"z\":18.56760597229004}', 0, 50),
(23, 'Pumpa 19', '{\"x\":-71.19830322265625,\"y\":-1763.1817626953126,\"z\":29.3459243774414}', NULL, 600000, 378, 1.1, 26, 2500, 0, '{\"x\":-62.38230514526367,\"y\":-1745.2607421875,\"z\":29.33869361877441}', 0, 50),
(24, 'Pumpa 20', '{\"x\":818.1276245117188,\"y\":-1040.5389404296876,\"z\":26.75078582763672}', NULL, 600000, 0, 1.1, 26, 2500, 0, '{\"x\":817.4137573242188,\"y\":-1035.2459716796876,\"z\":26.3928050994873}', 0, 50),
(25, 'Pumpa 21', '{\"x\":1211.0872802734376,\"y\":-1389.131591796875,\"z\":35.37686920166015}', NULL, 600000, 66, 1.1, 26, 2500, 0, '{\"x\":1205.057861328125,\"y\":-1406.123291015625,\"z\":35.22417449951172}', 0, 50),
(26, 'Pumpa 22', '{\"x\":1182.912353515625,\"y\":-329.9923095703125,\"z\":69.17447662353516}', NULL, 600000, 0, 1.1, 26, 2500, 0, '{\"x\":1173.80419921875,\"y\":-317.5242614746094,\"z\":69.17607879638672}', 0, 50),
(27, 'Pumpa 23', '{\"x\":646.076904296875,\"y\":267.31439208984377,\"z\":103.25042724609375}', NULL, 600000, 1470, 1.1, 26, 2500, 0, '{\"x\":638.5718383789063,\"y\":274.66485595703127,\"z\":103.08860778808594}', 0, 50),
(28, 'Pumpa 24', '{\"x\":2559.566650390625,\"y\":373.7714538574219,\"z\":108.62117767333985}', NULL, 600000, 28, 1.1, 26, 2500, 0, '{\"x\":2565.124267578125,\"y\":357.2509765625,\"z\":108.46162414550781}', 0, 50),
(29, 'Pumpa 25', '{\"x\":167.09417724609376,\"y\":-1553.5196533203126,\"z\":29.26177215576172}', NULL, 600000, 56, 1.1, 26, 2500, 0, '{\"x\":173.6867218017578,\"y\":-1553.2872314453126,\"z\":29.21279525756836}', 0, 50),
(30, 'Pumpa 26', '{\"x\":-341.90545654296877,\"y\":-1482.9364013671876,\"z\":30.69084167480468}', NULL, 600000, 0, 1.1, 26, 2500, 0, '{\"x\":-336.7940673828125,\"y\":-1486.441162109375,\"z\":30.59874725341797}', 0, 50),
(31, 'Pumpa 27', '{\"x\":1776.7811279296876,\"y\":3327.733642578125,\"z\":41.4331169128418}', NULL, 600000, 78, 1.1, 26, 500, 0, '{\"x\":1776.112548828125,\"y\":3337.34912109375,\"z\":41.1572380065918}', 0, 50);

-- --------------------------------------------------------

--
-- Table structure for table `qalle_brottsregister`
--

DROP TABLE IF EXISTS `qalle_brottsregister`;
CREATE TABLE IF NOT EXISTS `qalle_brottsregister` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `dateofcrime` varchar(255) NOT NULL,
  `crime` varchar(255) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

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
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `rent`
--

INSERT INTO `rent` (`ID`, `ime`, `koord`, `vlasnik`, `sef`, `vozila`, `cijena`) VALUES
(10, 'Rent 1', '{\"x\":-1054.64697265625,\"y\":-2650.354736328125,\"z\":13.83067226409912}', NULL, 72, '[{\"label\":\"Zastava 101\",\"value\":\"zastava101\",\"cijena\":5}]', 100000),
(11, 'Rent 2', '{\"x\":302.8141784667969,\"y\":-1360.2646484375,\"z\":31.82571411132812}', NULL, 4290, '[{\"label\":\"Zastava 101\",\"value\":\"zastava101\",\"cijena\":5}]', 100000),
(12, 'Rent 3', '{\"x\":1875.635986328125,\"y\":2595.276123046875,\"z\":45.67189025878906}', NULL, 4194, '[{\"label\":\"zastava101\",\"value\":\"zastava101\",\"cijena\":5}]', 100000),
(13, 'Rent 4', '{\"x\":776.5717163085938,\"y\":-294.40673828125,\"z\":59.89569854736328}', NULL, 2151, '[{\"label\":\"Zastava 101\",\"value\":\"zastava101\",\"cijena\":5}]', 100000),
(15, 'Rent 5', '{\"x\":114.77751922607422,\"y\":6599.607421875,\"z\":31.99914932250976}', NULL, 1320, '[{\"value\":\"zastava101\",\"cijena\":5,\"label\":\"zastava101\"}]', 2147483647),
(16, 'Rent 6', '{\"x\":1483.6966552734376,\"y\":3752.110107421875,\"z\":33.77544021606445}', NULL, 354, '[{\"value\":\"zastava101\",\"cijena\":5,\"label\":\"Zastava\"}]', 2147483647),
(17, 'Rent 7', '{\"x\":1189.5391845703126,\"y\":-3104.508056640625,\"z\":5.74172687530517}', NULL, 651, '[{\"value\":\"zastava101\",\"cijena\":5,\"label\":\"Zastava\"}]', 2147483647),
(18, 'Rent 8', '{\"x\":162.6787872314453,\"y\":-312.68359375,\"z\":44.41375350952148}', NULL, 4332, '[{\"value\":\"zastava101\",\"cijena\":5,\"label\":\"Zastava\"}]', 2147483647),
(19, 'Rent 9', '{\"x\":-1406.2294921875,\"y\":88.32289123535156,\"z\":53.05549621582031}', NULL, 723, '[{\"value\":\"zastava101\",\"cijena\":5,\"label\":\"zastava\"}]', 2147483647),
(20, 'Rent 10', '{\"x\":2452.509521484375,\"y\":4996.6611328125,\"z\":46.00117111206055}', NULL, 897, '[{\"value\":\"zastava101\",\"cijena\":5,\"label\":\"zastava\"}]', 2147483647);

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
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

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
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

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
  PRIMARY KEY (`id`) USING BTREE,
  KEY `item` (`item`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `shops`
--

INSERT INTO `shops` (`id`, `store`, `item`, `price`) VALUES
(1, 'TwentyFourSeven', 'bread', 1),
(2, 'TwentyFourSeven', 'water', 1),
(8, 'TwentyFourSeven', 'bandage', 25),
(9, 'TwentyFourSeven', 'burek', 3),
(15, 'TwentyFourSeven', 'rakija', 6),
(17, 'TwentyFourSeven', 'pizza', 3),
(18, 'TwentyFourSeven', 'kola', 2),
(23, 'TwentyFourSeven', 'contract', 2),
(27, 'TwentyFourSeven', 'repairkit', 800),
(64, 'TwentyFourSeven', 'milk', 2),
(73, 'TwentyFourSeven', 'ukosnica', 1),
(76, 'TwentyFourSeven', 'petarde', 5),
(82, 'TwentyFourSeven', 'mobitel', 150),
(99, 'TwentyFourSeven', 'novine', 2),
(101, 'TwentyFourSeven', 'fishingrod', 50),
(102, 'TwentyFourSeven', 'fishbait', 3),
(103, 'Bar', 'beer', 4),
(104, 'Bar', 'wine', 6),
(105, 'Bar', 'vodka', 9),
(106, 'Bar', 'tequila', 9),
(107, 'Bar', 'whisky', 11),
(108, 'Bar', 'cigarett', 4),
(109, 'Bar', 'lighter', 1);

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
  PRIMARY KEY (`id`) USING BTREE,
  KEY `owstore` (`owner`,`store`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

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
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

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
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `item` (`item`,`plate`,`itemt`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Table structure for table `twitter_accounts`
--

DROP TABLE IF EXISTS `twitter_accounts`;
CREATE TABLE IF NOT EXISTS `twitter_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `password` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `avatar_url` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `twitter_likes`
--

DROP TABLE IF EXISTS `twitter_likes`;
CREATE TABLE IF NOT EXISTS `twitter_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) DEFAULT NULL,
  `tweetId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_twitter_likes_twitter_accounts` (`authorId`) USING BTREE,
  KEY `FK_twitter_likes_twitter_tweets` (`tweetId`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

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
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_twitter_tweets_twitter_accounts` (`authorId`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `ukradeni`
--

DROP TABLE IF EXISTS `ukradeni`;
CREATE TABLE IF NOT EXISTS `ukradeni` (
  `tablica` varchar(50) NOT NULL,
  `datum` varchar(50) NOT NULL,
  PRIMARY KEY (`tablica`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

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
  `job` int(11) DEFAULT 1,
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
  `jail` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `last_property` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `is_dead` tinyint(1) DEFAULT 0,
  `armour` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `house` longtext COLLATE utf8mb4_bin NOT NULL DEFAULT '{"owns":false,"furniture":[],"houseId":0}',
  `bought_furniture` longtext COLLATE utf8mb4_bin NOT NULL DEFAULT '{}',
  `last_house` int(11) DEFAULT 0,
  `mute` int(11) NOT NULL DEFAULT 0,
  `kpljacka` int(11) NOT NULL DEFAULT 0,
  `zadnji_login` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `kredit` int(11) NOT NULL DEFAULT 0,
  `rata` int(11) NOT NULL DEFAULT 0,
  `brplaca` int(11) NOT NULL DEFAULT 0,
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
  `atmpljacka` int(11) DEFAULT 0,
  PRIMARY KEY (`identifier`) USING BTREE,
  UNIQUE KEY `phone` (`phone_number`) USING BTREE,
  KEY `ident` (`identifier`) USING BTREE,
  KEY `ID` (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10466 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

--
-- Table structure for table `user_inventory`
--

DROP TABLE IF EXISTS `user_inventory`;
CREATE TABLE IF NOT EXISTS `user_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` int(11) NOT NULL,
  `item` varchar(50) NOT NULL,
  `count` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=82219 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;


--
-- Table structure for table `user_races`
--

DROP TABLE IF EXISTS `user_races`;
CREATE TABLE IF NOT EXISTS `user_races` (
  `name` varchar(50) NOT NULL,
  `time` double NOT NULL,
  `race` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `uteknark`
--

DROP TABLE IF EXISTS `uteknark`;
CREATE TABLE IF NOT EXISTS `uteknark` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `stage` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `soil` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `stage` (`stage`,`time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

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
  PRIMARY KEY (`model`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `vehicles`
--

INSERT INTO `vehicles` (`name`, `model`, `price`, `category`, `brod`) VALUES
('Opel Rekord Coupe', '2dopelr3', 18500, 'opel', 0),
('Opel Rekord', '4dopelr3', 17000, 'opel', 0),
('Porsche 718', '718', 123000, 'porsche', 0),
('Alfa Giulia Sprint', 'agta', 42000, 'alfa', 0),
('Alfa Romeo 75', 'alfa75', 36000, 'alfa', 0),
('Mercedes AMG Hammer', 'amgh', 100000000, 'donatorski', 0),
('Audi 100 Coupe S', 'audi100sc1', 64000, 'audi', 0),
('Audi Union', 'audif103', 48000, 'audi', 0),
('Audi Quattro', 'audquattros', 75000, 'audi', 0),
('Austin Mini Cooper', 'austminlhd', 22000, 'austin', 0),
('Ferrari California 250GT', 'cali57', 130000, 'ferrari', 0),
('Jeep Grand Cherokee', 'cherokee1', 50000, 'jeep', 0),
('Lamborghini Countach', 'cont88', 100000000, 'donatorski', 0),
('Dinghy', 'dinghy', 800000, 'gliser', 1),
('Ferrari Dino', 'dino', 145000, 'ferrari', 0),
('BMW E21', 'e21', 53000, 'bmw', 0),
('Zastava 1300', 'fiat1300', 12000, 'zastava', 0),
('Zastava 750', 'fiat600', 11000, 'zastava', 0),
('Ford GT40', 'gt401', 100000000, 'donatorski', 0),
('Lancia Delta HF Integrale', 'lanciad', 100000000, 'donatorski', 0),
('Land Rover Defender', 'landseries3', 53000, 'landrover', 0),
('BMW E24', 'm686eu', 63000, 'bmw', 0),
('Ford Mustang Mach1', 'mustangmach1', 100000000, 'donatorski', 0),
('Porsche 928', 'p928', 65000, 'porsche', 0),
('Peugeot 204', 'peugeot204', 18000, 'peugeot', 0),
('Porsche 911', 'porrs73', 115000, 'porsche', 0),
('NSU Prinz 1000TT', 'prinztt', 8500, 'nsu', 0),
('Renault 4', 'renault4', 7500, 'renault', 0),
('Jet Ski', 'seashark', 500000, 'jetski', 1),
('Simca 1100', 'simca1100', 8100, 'simca', 0),
('Skoda 100', 'skoda100', 6300, 'skoda', 0),
('Alfa Romeo Spider 115', 'spider115', 39000, 'alfa', 0),
('Squalo', 'squalo', 1500000, 'gliser', 1),
('Podmornica', 'submersible', 5000000, 'podmornica', 1),
('Podmornica 2', 'submersible2', 5000000, 'podmornica', 1),
('Tropic', 'tropic2', 1000000, 'gliser', 1),
('VW Type 3 Fastback', 'type3fast', 6000, 'vw', 0),
('VW Type 3 Sedan', 'type3notch', 6000, 'vw', 0),
('VW Type 3 Kocka', 'type3square', 6000, 'vw', 0),
('Aston Martin Vantage', 'v877', 100000000, 'donatorski', 0),
('Volvo 142', 'volvo142', 24000, 'volvo', 0),
('Volvo 144', 'volvo144', 25000, 'volvo', 0),
('Volvo 145', 'volvo145', 26000, 'volvo', 0),
('Mercedes W115', 'w115200d', 81000, 'mercedes', 0),
('Wartburg 353', 'wartburg353', 4500, 'wartburg', 0),
('Zastava 101', 'zastava101', 3000, 'zastava', 0);

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
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `vehicle_categories`
--

INSERT INTO `vehicle_categories` (`name`, `label`, `brod`, `slika`) VALUES
('alfa', 'Alfa Romeo', 0, 'alfa.png'),
('audi', 'Audi', 0, 'audi.png'),
('austin', 'Austin', 0, 'austin.png'),
('bmw', 'BMW', 0, 'bmw.png'),
('donatorski', 'Donatorski', 0, 'dolla.png'),
('ferrari', 'Ferrari', 0, 'ferrari.png'),
('gliser', 'Gliser', 1, 'gtav.png'),
('jeep', 'Jeep', 0, 'jeep.png'),
('jetski', 'Jet Ski', 1, 'gtav.png'),
('landrover', 'LandRover', 0, 'landrover.png'),
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
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_croatian_ci ROW_FORMAT=DYNAMIC;

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
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

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
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

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
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `warovi`
--

INSERT INTO `warovi` (`ID`, `Ime`, `Win`, `Lose`) VALUES
(3, 'omerta', 16, 2),
(4, 'montana', 10, 7);

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
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `weashops`
--

INSERT INTO `weashops` (`id`, `name`, `item`, `price`) VALUES
(1, 'GunShop', 'WEAPON_PISTOL', 1500),
(5, 'GunShop', 'WEAPON_MACHETE', 250),
(11, 'GunShop', 'WEAPON_STUNGUN', 450),
(41, 'GunShop', 'WEAPON_KNIFE', 100),
(42, 'GunShop', 'WEAPON_CROWBAR', 15),
(43, 'GunShop', 'WEAPON_DAGGER', 100),
(44, 'GunShop', 'WEAPON_KNUCKLE', 100),
(45, 'GunShop', 'WEAPON_SWITCHBLADE', 100),
(46, 'GunShop', 'WEAPON_PISTOL_MK2', 2000),
(47, 'GunShop', 'WEAPON_PISTOL50', 3000),
(48, 'GunShop', 'WEAPON_MICROSMG', 3500),
(49, 'GunShop', 'WEAPON_COMBATPISTOL', 2500);

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
  PRIMARY KEY (`id`) USING BTREE,
  KEY `owname` (`owner`,`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `weashops2`
--

INSERT INTO `weashops2` (`id`, `name`, `owner`, `sef`) VALUES
(1, 'GunShop1', NULL, 538),
(2, 'GunShop2', NULL, 1615),
(3, 'GunShop3', NULL, 25966),
(4, 'GunShop4', NULL, 13054),
(5, 'GunShop5', NULL, 10811),
(6, 'GunShop6', NULL, 17890),
(7, 'GunShop7', NULL, 0),
(8, 'GunShop8', NULL, 0),
(9, 'GunShop9', NULL, 25),
(10, 'GunShop10', NULL, 5792);

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
  PRIMARY KEY (`id`) USING BTREE,
  KEY `novine` (`novine`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Table structure for table `zemljista`
--

DROP TABLE IF EXISTS `zemljista`;
CREATE TABLE IF NOT EXISTS `zemljista` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Ime` varchar(255) NOT NULL,
  `Koord1` longtext NOT NULL,
  `Koord2` longtext NOT NULL,
  `Cijena` int(11) NOT NULL DEFAULT 0,
  `Vlasnik` int(11) DEFAULT NULL,
  `Kuca` varchar(255) DEFAULT NULL,
  `KKoord` longtext NOT NULL,
  `MKoord` longtext NOT NULL,
  `KucaID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

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
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `zone`
--

INSERT INTO `zone` (`ID`, `ime`, `koord`, `velicina`, `rotacija`, `boja`, `vlasnik`, `label`, `vrijeme`, `vrijednost`, `PedKoord`, `PedHead`) VALUES
(2, 'zona2', '{\"x\":2789.8134765625,\"y\":1587.1585693359376,\"z\":24.50067138671875}', 200, -176, 0, NULL, NULL, 0, 200, NULL, NULL),
(3, 'zona3', '{\"x\":8.01981258392334,\"y\":-2478.081787109375,\"z\":5.44206237792968}', 200, -123, 0, NULL, NULL, 0, 5000, NULL, NULL),
(4, 'zona4', '{\"x\":-1048.6021728515626,\"y\":-1143.892578125,\"z\":1.55892622470855}', 100, 121, 73, 'zemunski', 'zemunski', 0, 5000, NULL, NULL),
(5, 'zona5', '{\"x\":-956.7833862304688,\"y\":-1090.5233154296876,\"z\":1.65182423591613}', 100, 122, 73, 'zemunski', 'zemunski', 0, 5000, NULL, NULL),
(6, 'zona6', '{\"x\":-113.91008758544922,\"y\":923.5415649414063,\"z\":235.12802124023438}', 200, 39, 1, 'omerta', 'Omerta', 0, 5000, NULL, NULL),
(7, 'zona7', '{\"x\":-1613.794189453125,\"y\":3177.352294921875,\"z\":30.19296836853027}', 200, -158, 0, NULL, NULL, 0, 5000, NULL, NULL),
(8, 'zona8', '{\"x\":2517.48876953125,\"y\":-383.7721862792969,\"z\":93.14043426513672}', 200, -61, 26, 'montana', 'Montana Cartel', 0, 5000, NULL, NULL),
(9, 'zona9', '{\"x\":-1054.79931640625,\"y\":-1576.043212890625,\"z\":4.77379131317138}', 200, -147, 1, 'omerta', 'Omerta', 0, 5000, NULL, NULL),
(10, 'zona10', '{\"x\":2862.156005859375,\"y\":2823.3935546875,\"z\":53.36796569824219}', 400, -121, 64, 'sinaloa', 'sinaloa', 0, 5000, NULL, NULL),
(15, 'zona12', '{\"x\":-1119.9439697265626,\"y\":4925.0185546875,\"z\":218.40289306640626}', 100, 88, 1, 'omerta', 'omerta', 0, 30000, '{\"x\":-1124.54150390625,\"y\":4924.2109375,\"z\":218.89468383789063}', 278.11);

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
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `zpostavke`
--

INSERT INTO `zpostavke` (`id`, `idzone`, `mafije`, `vrijeme`, `sat`, `minuta`, `zauzimanje`) VALUES
(1, 13, '[]', 10, 0, 0, 10);

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
