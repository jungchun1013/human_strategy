-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- 主機： sql308.byetcluster.com
-- 產生時間： 2024 年 12 月 22 日 22:42
-- 伺服器版本： 10.6.19-MariaDB
-- PHP 版本： 7.2.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `if0_37694833_human_strategy_exp_db`
--

-- --------------------------------------------------------

--
-- 資料表結構 `Results`
--

CREATE TABLE `Results` (
  `id` varchar(255) NOT NULL,
  `PHPSESSID` varchar(255) NOT NULL,
  `trial` varchar(255) NOT NULL,
  `attempt_num` int(11) NOT NULL,
  `tool` varchar(255) NOT NULL,
  `pos_x` float NOT NULL,
  `pos_y` float NOT NULL,
  `time` int(11) NOT NULL,
  `success_trial` tinyint(1) NOT NULL,
  `trial_order` bigint(64) NOT NULL,
  `success_place` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `Results`
--

INSERT INTO `Results` (`id`, `PHPSESSID`, `trial`, `attempt_num`, `tool`, `pos_x`, `pos_y`, `time`, `success_trial`, `trial_order`, `success_place`) VALUES
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Basic_1', 1, 'obj2', 445.6, 101.4, 24289, 1, 1734878180180, 0),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Basic_1', 2, 'obj2', 189.6, 233.4, 33672, 1, 1734878180180, 1),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Basic_2', 1, 'obj3', 404.6, 232.4, 12034, 1, 1734878204507, 1),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Comp_GapCatapult', 1, 'obj2', 303.6, 502.4, 14769, 0, 1734878622707, 0),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Comp_GapCatapult', 2, 'obj1', 469.6, 575.4, 34394, 0, 1734878622707, 0),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Comp_GapCatapult', 3, 'obj2', 318.6, 575.4, 52202, 0, 1734878622707, 0),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Comp_SoCloseLaunch', 1, 'obj1', 260.6, 290.4, 34511, 1, 1734878684011, 0),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Comp_SoCloseLaunch', 2, 'obj3', 256.6, 263.4, 47927, 1, 1734878684011, 1),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Comp_UnboxSlope', 1, 'obj2', 476.6, 419.4, 11947, 1, 1734878561227, 0),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Comp_UnboxSlope', 2, 'obj2', 313.6, 414.4, 26391, 1, 1734878561227, 1),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Mech_Catapult_0', 1, 'obj2', 435.6, 562.4, 4172, 1, 1734878516673, 1),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Mech_Catapult_1', 1, 'obj3', 437.6, 555.4, 6390, 1, 1734878505359, 0),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Mech_Catapult_1', 2, 'obj3', 433.6, 562.4, 13861, 1, 1734878505359, 1),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Mech_Catapult_2', 1, 'obj2', 357.6, 556.4, 34874, 1, 1734878319777, 0),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Mech_Catapult_2', 2, 'obj2', 340.6, 561.4, 50635, 1, 1734878319777, 1),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Mech_Catapult_3', 1, 'obj2', 506.6, 562.4, 24589, 1, 1734878483639, 0),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Mech_Catapult_3', 2, 'obj2', 534.6, 562.4, 37976, 1, 1734878483639, 0),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Mech_Catapult_3', 3, 'obj2', 259.6, 562.4, 46394, 1, 1734878483639, 1),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Mech_Catapult_4', 1, 'obj2', 469.6, 259.4, 19179, 0, 1734878262060, 0),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Mech_Catapult_4', 2, 'obj3', 197.6, 153.4, 39424, 0, 1734878262060, 0),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Mech_Catapult_4', 3, 'obj1', 441.6, 201.4, 42640, 0, 1734878262060, 0),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Mech_Gap_0', 1, 'obj1', 348.6, 147.4, 12542, 1, 1734878400400, 1),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Mech_Gap_1', 1, 'obj3', 318.6, 314.4, 8052, 1, 1734878415644, 1),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Mech_Gap_2', 1, 'obj3', 255.6, 106.4, 19704, 1, 1734878347754, 1),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Mech_Gap_3', 1, 'obj2', 230.6, 53.4, 12386, 1, 1734878380124, 0),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Mech_Gap_3', 2, 'obj1', 265.6, 39.4, 22016, 1, 1734878380124, 1),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Mech_Gap_4', 1, 'obj1', 325.6, 197.4, 4739, 1, 1734878429558, 1),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Playground', 1, 'obj1', 260.6, 177, 9113, 0, 1734878126027, 0),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Playground', 2, 'obj3', 485.6, 298, 19165, 0, 1734878126027, 0),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Playground', 3, 'obj2', 517.6, 71, 31103, 0, 1734878126027, 0),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Playground', 4, 'obj3', 301.6, 157, 46079, 0, 1734878126027, 0),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Playground', 5, 'obj1', 555.6, 417, 53970, 0, 1734878126027, 0),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Playground', 6, 'obj2', 202.6, 141, 63509, 0, 1734878126027, 0),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Playground', 7, 'obj3', 524.6, 443, 76459, 0, 1734878126027, 0),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Playground', 8, 'obj3', 367.6, 84, 90739, 0, 1734878126027, 0),
('5b96dd68d193e30001b3cb69', 'ebbfc7e20312fe3e9efa285293c1ad4f', 'Playground', 9, 'obj1', 343.6, 101, 101585, 0, 1734878126027, 0),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Basic_1', 1, 'obj2', 189, 288, 4762, 1, 1734878032106, 1),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Basic_2', 1, 'obj3', 403, 234, 7251, 1, 1734878016255, 1),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Comp_GapCatapult', 1, 'obj1', 493, 570, 8116, 0, 1734878268977, 0),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Comp_GapCatapult', 2, 'obj1', 475, 574, 13362, 0, 1734878268977, 0),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Comp_GapCatapult', 3, 'obj2', 348, 450, 19703, 0, 1734878268977, 0),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Comp_SoCloseLaunch', 1, 'obj3', 260, 269, 18564, 1, 1734878299969, 1),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Comp_UnboxSlope', 1, 'obj1', 399, 325, 7343, 0, 1734878334412, 0),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Comp_UnboxSlope', 2, 'obj3', 253, 411, 15226, 0, 1734878334412, 0),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Comp_UnboxSlope', 3, 'obj2', 409, 389, 28250, 0, 1734878334412, 0),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Mech_Catapult_0', 1, 'obj2', 420, 455, 2114, 1, 1734878152510, 1),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Mech_Catapult_1', 1, 'obj3', 398, 448, 4421, 0, 1734878144989, 0),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Mech_Catapult_1', 2, 'obj3', 363, 429, 10712, 0, 1734878144989, 0),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Mech_Catapult_1', 3, 'obj2', 378, 508, 18882, 0, 1734878144989, 0),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Mech_Catapult_2', 1, 'obj2', 351, 555, 2741, 1, 1734878176682, 0),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Mech_Catapult_2', 2, 'obj2', 315, 527, 8839, 1, 1734878176682, 1),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Mech_Catapult_3', 1, 'obj2', 264, 559, 2878, 1, 1734878161424, 1),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Mech_Catapult_4', 1, 'obj2', 271, 558, 2154, 0, 1734878229939, 0),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Mech_Catapult_4', 2, 'obj2', 274, 517, 7112, 0, 1734878229939, 0),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Mech_Catapult_4', 3, 'obj2', 243, 224, 27421, 0, 1734878229939, 0),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Mech_Gap_0', 1, 'obj2', 348, 168, 4700, 1, 1734878118504, 0),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Mech_Gap_0', 2, 'obj2', 351, 166, 11210, 1, 1734878118504, 1),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Mech_Gap_1', 1, 'obj1', 318, 452, 5262, 1, 1734878193622, 0),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Mech_Gap_1', 2, 'obj1', 336, 453, 10695, 1, 1734878193622, 1),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Mech_Gap_2', 1, 'obj1', 234, 133, 8397, 1, 1734878100686, 0),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Mech_Gap_2', 2, 'obj1', 235, 302, 25459, 1, 1734878100686, 0),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Mech_Gap_2', 3, 'obj3', 250, 291, 32403, 1, 1734878100686, 1),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Mech_Gap_3', 1, 'obj1', 262, 49, 2737, 1, 1734878241946, 1),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Mech_Gap_4', 1, 'obj1', 373, 203, 5608, 0, 1734878060913, 0),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Mech_Gap_4', 2, 'obj3', 325, 205, 11604, 0, 1734878060913, 0),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Mech_Gap_4', 3, 'obj3', 328, 221, 16887, 0, 1734878060913, 0),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Playground', 1, 'obj1', 357, 477, 3121, 0, 1734877997174, 0),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Playground', 2, 'obj1', 531, 554, 14046, 0, 1734877997174, 0),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Playground', 3, 'obj1', 536, 179, 19216, 0, 1734877997174, 0),
('5ca3cafa2707e10001a04746', '91ad62cf94b1fbfb87bcf8786483bcb8', 'Playground', 4, 'obj1', 227, 184, 28427, 0, 1734877997174, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Basic_1', 1, 'obj1', 173.5, 185.5, 21575, 1, 1734878225938, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Basic_1', 2, 'obj2', 171.5, 188.5, 40159, 1, 1734878225938, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Basic_1', 3, 'obj3', 206.5, 204.5, 46737, 1, 1734878225938, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Basic_1', 4, 'obj1', 174.5, 186.5, 58305, 1, 1734878225938, 1),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Basic_2', 1, 'obj2', 401.5, 237.5, 19708, 1, 1734878262117, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Basic_2', 2, 'obj3', 401.5, 234.5, 27692, 1, 1734878262117, 1),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Comp_GapCatapult', 1, 'obj2', 352.5, 135.5, 11588, 0, 1734878770380, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Comp_GapCatapult', 2, 'obj3', 151.5, 392.5, 27232, 0, 1734878770380, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Comp_GapCatapult', 3, 'obj2', 139.5, 486.5, 39044, 0, 1734878770380, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Comp_SoCloseLaunch', 1, 'obj3', 256.5, 383.5, 21598, 1, 1734878661188, 1),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Comp_UnboxSlope', 1, 'obj1', 409.5, 328.5, 6324, 0, 1734878725570, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Comp_UnboxSlope', 2, 'obj2', 408.5, 336.5, 24828, 0, 1734878725570, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Comp_UnboxSlope', 3, 'obj3', 331.5, 404.5, 55554, 0, 1734878725570, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Mech_Catapult_0', 1, 'obj2', 377.5, 157.5, 7678, 0, 1734878538388, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Mech_Catapult_0', 2, 'obj3', 385.5, 110.5, 16148, 0, 1734878538388, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Mech_Catapult_0', 3, 'obj2', 456.5, 140.5, 21818, 0, 1734878538388, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Mech_Catapult_1', 1, 'obj2', 185.5, 224.5, 5644, 0, 1734878357774, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Mech_Catapult_1', 2, 'obj2', 455.5, 158.5, 22699, 0, 1734878357774, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Mech_Catapult_1', 3, 'obj1', 147.5, 239.5, 34954, 0, 1734878357774, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Mech_Catapult_2', 1, 'obj2', 334.5, 147.5, 6671, 0, 1734878623909, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Mech_Catapult_2', 2, 'obj2', 72.5, 167.5, 17012, 0, 1734878623909, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Mech_Catapult_2', 3, 'obj2', 319.5, 217.5, 26036, 0, 1734878623909, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Mech_Catapult_3', 1, 'obj2', 223.5, 306.5, 4616, 0, 1734878573320, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Mech_Catapult_3', 2, 'obj2', 327.5, 328.5, 21559, 0, 1734878573320, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Mech_Catapult_3', 3, 'obj2', 532.5, 341.5, 28612, 0, 1734878573320, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Mech_Catapult_4', 1, 'obj2', 260.5, 45.5, 23303, 0, 1734878505191, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Mech_Catapult_4', 2, 'obj1', 268.5, 170.5, 35049, 0, 1734878505191, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Mech_Catapult_4', 3, 'obj2', 271.5, 186.5, 39101, 0, 1734878505191, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Mech_Gap_0', 1, 'obj2', 47.5, 459.5, 19317, 1, 1734878391748, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Mech_Gap_0', 2, 'obj1', 351.5, 181.5, 27973, 1, 1734878391748, 1),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Mech_Gap_1', 1, 'obj1', 289.5, 406.5, 16870, 0, 1734878317656, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Mech_Gap_1', 2, 'obj1', 318.5, 371.5, 35948, 0, 1734878317656, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Mech_Gap_1', 3, 'obj3', 323.5, 420.5, 41836, 0, 1734878317656, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Mech_Gap_2', 1, 'obj1', 341.5, 236.5, 6097, 1, 1734878592567, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Mech_Gap_2', 2, 'obj3', 251.5, 195.5, 12288, 1, 1734878592567, 1),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Mech_Gap_3', 1, 'obj1', 260.5, 55.5, 3056, 1, 1734878459291, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Mech_Gap_3', 2, 'obj1', 250.5, 51.5, 33135, 1, 1734878459291, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Mech_Gap_3', 3, 'obj1', 271.5, 54.5, 44623, 1, 1734878459291, 1),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Mech_Gap_4', 1, 'obj1', 328.5, 219.5, 6141, 1, 1734878406276, 1),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Playground', 1, 'obj1', 463.5, 103.5, 3244, 0, 1734878138361, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Playground', 2, 'obj2', 398.5, 75.5, 15610, 0, 1734878138361, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Playground', 3, 'obj3', 399.5, 137.5, 28693, 0, 1734878138361, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Playground', 4, 'obj3', 523.5, 517.5, 33194, 0, 1734878138361, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Playground', 5, 'obj1', 158.5, 486.5, 38974, 0, 1734878138361, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Playground', 6, 'obj3', 517.5, 139.5, 47054, 0, 1734878138361, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Playground', 7, 'obj1', 394.5, 154.5, 58513, 0, 1734878138361, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Playground', 8, 'obj1', 495.5, 114.5, 62354, 0, 1734878138361, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Playground', 9, 'obj1', 452.5, 109.5, 71597, 0, 1734878138361, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Playground', 10, 'obj3', 517.5, 525.5, 81430, 0, 1734878138361, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Playground', 11, 'obj3', 451.5, 80.5, 88284, 0, 1734878138361, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Playground', 12, 'obj2', 455.5, 63.5, 94302, 0, 1734878138361, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Playground', 13, 'obj2', 504.5, 77.5, 97968, 0, 1734878138361, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Playground', 14, 'obj2', 398.5, 69.5, 104439, 0, 1734878138361, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Playground', 15, 'obj2', 448.5, 134.5, 108873, 0, 1734878138361, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Playground', 16, 'obj2', 468.5, 123.5, 113255, 0, 1734878138361, 0),
('5fd814d756099c14ab3d5c29', 'c92e536515c39c28531f2deff7e302c7', 'Playground', 17, 'obj2', 483.5, 84.5, 118568, 0, 1734878138361, 0),
('5ffcc820426b8c19e80f397a', '9849e47f953b04ab53d15175d513a66f', 'Basic_1', 1, 'obj1', 174.6, 288.4, 9587, 1, 1734878134529, 1),
('5ffcc820426b8c19e80f397a', '9849e47f953b04ab53d15175d513a66f', 'Basic_2', 1, 'obj3', 402.6, 233.4, 15674, 1, 1734878164665, 1),
('5ffcc820426b8c19e80f397a', '9849e47f953b04ab53d15175d513a66f', 'Comp_GapCatapult', 1, 'obj2', 329.6, 357.4, 13820, 0, 1734878461716, 0),
('5ffcc820426b8c19e80f397a', '9849e47f953b04ab53d15175d513a66f', 'Comp_GapCatapult', 2, 'obj1', 481.6, 569.4, 33890, 0, 1734878461716, 0),
('5ffcc820426b8c19e80f397a', '9849e47f953b04ab53d15175d513a66f', 'Comp_GapCatapult', 3, 'obj2', 486.6, 572.4, 63269, 0, 1734878461716, 0),
('5ffcc820426b8c19e80f397a', '9849e47f953b04ab53d15175d513a66f', 'Comp_SoCloseLaunch', 1, 'obj3', 258.6, 264.4, 21441, 1, 1734878566360, 1),
('5ffcc820426b8c19e80f397a', '9849e47f953b04ab53d15175d513a66f', 'Comp_UnboxSlope', 1, 'obj1', 301.6, 413.4, 50400, 1, 1734878527148, 1),
('5ffcc820426b8c19e80f397a', '9849e47f953b04ab53d15175d513a66f', 'Mech_Catapult_0', 1, 'obj2', 422.6, 539.4, 8336, 1, 1734878307314, 1),
('5ffcc820426b8c19e80f397a', '9849e47f953b04ab53d15175d513a66f', 'Mech_Catapult_1', 1, 'obj3', 413.6, 543.4, 6327, 1, 1734878190090, 1),
('5ffcc820426b8c19e80f397a', '9849e47f953b04ab53d15175d513a66f', 'Mech_Catapult_2', 1, 'obj2', 326.6, 556.4, 3814, 1, 1734878322456, 1),
('5ffcc820426b8c19e80f397a', '9849e47f953b04ab53d15175d513a66f', 'Mech_Catapult_3', 1, 'obj2', 266.6, 558.4, 7907, 1, 1734878269077, 1),
('5ffcc820426b8c19e80f397a', '9849e47f953b04ab53d15175d513a66f', 'Mech_Catapult_4', 1, 'obj2', 254.6, 547.4, 7691, 1, 1734878376661, 1),
('5ffcc820426b8c19e80f397a', '9849e47f953b04ab53d15175d513a66f', 'Mech_Gap_0', 1, 'obj1', 349.6, 145.4, 10377, 1, 1734878250851, 1),
('5ffcc820426b8c19e80f397a', '9849e47f953b04ab53d15175d513a66f', 'Mech_Gap_1', 1, 'obj3', 320.6, 317.4, 29026, 1, 1734878229963, 1),
('5ffcc820426b8c19e80f397a', '9849e47f953b04ab53d15175d513a66f', 'Mech_Gap_2', 1, 'obj3', 254.6, 106.4, 8360, 1, 1734878289231, 1),
('5ffcc820426b8c19e80f397a', '9849e47f953b04ab53d15175d513a66f', 'Mech_Gap_3', 1, 'obj1', 263.6, 38.4, 6401, 1, 1734878359823, 1),
('5ffcc820426b8c19e80f397a', '9849e47f953b04ab53d15175d513a66f', 'Mech_Gap_4', 1, 'obj1', 326.6, 198.4, 4721, 1, 1734878340390, 1),
('5ffcc820426b8c19e80f397a', '9849e47f953b04ab53d15175d513a66f', 'Playground', 1, 'obj3', 399.6, 185.4, 5000, 0, 1734878085101, 0),
('5ffcc820426b8c19e80f397a', '9849e47f953b04ab53d15175d513a66f', 'Playground', 2, 'obj3', 349.6, 103.4, 17608, 0, 1734878085101, 0),
('5ffcc820426b8c19e80f397a', '9849e47f953b04ab53d15175d513a66f', 'Playground', 3, 'obj3', 69.6, 529.4, 28873, 0, 1734878085101, 0),
('5ffcc820426b8c19e80f397a', '9849e47f953b04ab53d15175d513a66f', 'Playground', 4, 'obj1', 343.6, 98.4, 37439, 0, 1734878085101, 0),
('5ffcc820426b8c19e80f397a', '9849e47f953b04ab53d15175d513a66f', 'Playground', 5, 'obj1', 556.6, 557.4, 43619, 0, 1734878085101, 0),
('5ffcc820426b8c19e80f397a', '9849e47f953b04ab53d15175d513a66f', 'Playground', 6, 'obj3', 543.6, 549.4, 49695, 0, 1734878085101, 0),
('5ffcc820426b8c19e80f397a', '9849e47f953b04ab53d15175d513a66f', 'Playground', 7, 'obj3', 534.6, 325.4, 55462, 0, 1734878085101, 0),
('5ffcc820426b8c19e80f397a', '9849e47f953b04ab53d15175d513a66f', 'Playground', 8, 'obj3', 554.6, 196.4, 60892, 0, 1734878085101, 0),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Basic_1', 1, 'obj1', 195.08, 219.92, 3720, 1, 1734878264300, 1),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Basic_2', 1, 'obj3', 401.08, 232.92, 6709, 1, 1734878250943, 1),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Comp_GapCatapult', 1, 'obj2', 312.08, 572.92, 5752, 1, 1734878683780, 0),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Comp_GapCatapult', 2, 'obj1', 477.08, 570.92, 12127, 1, 1734878683780, 1),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Comp_SoCloseLaunch', 1, 'obj2', 207.08, 261.92, 9191, 1, 1734878665617, 0),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Comp_SoCloseLaunch', 2, 'obj1', 268.08, 282.92, 19730, 1, 1734878665617, 0),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Comp_SoCloseLaunch', 3, 'obj3', 253.08, 267.92, 36033, 1, 1734878665617, 1),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Comp_UnboxSlope', 1, 'obj1', 407.08, 326.92, 8281, 0, 1734878608762, 0),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Comp_UnboxSlope', 2, 'obj1', 384.08, 324.92, 29003, 0, 1734878608762, 0),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Comp_UnboxSlope', 3, 'obj2', 298.08, 573.92, 64509, 0, 1734878608762, 0),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Mech_Catapult_0', 1, 'obj2', 401.08, 562.92, 3156, 1, 1734878454962, 1),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Mech_Catapult_1', 1, 'obj3', 419.08, 561.92, 2639, 1, 1734878501927, 1),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Mech_Catapult_2', 1, 'obj2', 359.08, 556.92, 4831, 1, 1734878446207, 0),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Mech_Catapult_2', 2, 'obj2', 330.08, 562.92, 9003, 1, 1734878446207, 1),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Mech_Catapult_3', 1, 'obj2', 235.08, 558.92, 4029, 0, 1734878328347, 0),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Mech_Catapult_3', 2, 'obj2', 224.08, 464.92, 15616, 0, 1734878328347, 0),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Mech_Catapult_3', 3, 'obj2', 235.08, 559.92, 25421, 0, 1734878328347, 0),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Mech_Catapult_4', 1, 'obj2', 235.08, 529.92, 4568, 1, 1734878279835, 1),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Mech_Gap_0', 1, 'obj2', 58.08, 538.92, 16460, 1, 1734878431064, 0),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Mech_Gap_0', 2, 'obj1', 82.08, 519.92, 21255, 1, 1734878431064, 0),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Mech_Gap_0', 3, 'obj1', 328.08, 290.92, 28337, 1, 1734878431064, 1),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Mech_Gap_1', 1, 'obj1', 358.08, 361.92, 10019, 0, 1734878494130, 0),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Mech_Gap_1', 2, 'obj1', 327.08, 325.92, 19243, 0, 1734878494130, 0),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Mech_Gap_1', 3, 'obj3', 311.08, 484.92, 32136, 0, 1734878494130, 0),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Mech_Gap_2', 1, 'obj3', 267.08, 190.92, 8207, 1, 1734878532759, 1),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Mech_Gap_3', 1, 'obj1', 264.08, 65.92, 13578, 0, 1734878395501, 0),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Mech_Gap_3', 2, 'obj3', 263.08, 73.92, 28201, 0, 1734878395501, 0),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Mech_Gap_3', 3, 'obj1', 264.08, 65.92, 59105, 0, 1734878395501, 0),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Mech_Gap_4', 1, 'obj3', 329.08, 222.92, 3603, 1, 1734878517834, 0),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Mech_Gap_4', 2, 'obj1', 333.08, 226.92, 7779, 1, 1734878517834, 1),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Playground', 1, 'obj1', 545.08, 322.92, 5638, 0, 1734878229411, 0),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Playground', 2, 'obj3', 518.08, 558.92, 15532, 0, 1734878229411, 0),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Playground', 3, 'obj1', 556.08, 332.92, 32764, 0, 1734878229411, 0),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Playground', 4, 'obj2', 537.08, 312.92, 37817, 0, 1734878229411, 0),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Playground', 5, 'obj3', 527.08, 548.92, 43403, 0, 1734878229411, 0),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Playground', 6, 'obj1', 522.08, 535.92, 49201, 0, 1734878229411, 0),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Playground', 7, 'obj1', 156.08, 481.92, 55812, 0, 1734878229411, 0),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Playground', 8, 'obj1', 555.08, 330.92, 63806, 0, 1734878229411, 0),
('609cd75c7570c1dc4f9e9c43', '375d98ea9d321e356f704b1ab447ebae', 'Playground', 9, 'obj1', 482.08, 275.92, 69183, 0, 1734878229411, 0);

--
-- 已傾印資料表的索引
--

--
-- 資料表索引 `Results`
--
ALTER TABLE `Results`
  ADD PRIMARY KEY (`id`,`trial`,`attempt_num`),
  ADD KEY `trial` (`trial`);

--
-- 已傾印資料表的限制式
--

--
-- 資料表的限制式 `Results`
--
ALTER TABLE `Results`
  ADD CONSTRAINT `results_ibfk_1` FOREIGN KEY (`id`) REFERENCES `Users` (`name`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
