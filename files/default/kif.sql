-- phpMyAdmin SQL Dump
-- version 3.3.0
-- http://www.phpmyadmin.net
--
-- ホスト: localhost
-- 生成時間: 2013 年 9 月 29 日 22:30
-- サーバのバージョン: 5.1.61
-- PHP のバージョン: 5.3.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- データベース: `kif`
--

-- --------------------------------------------------------

--
-- テーブルの構造 `Category`
--

CREATE TABLE IF NOT EXISTS `Category` (
  `number` int(2) NOT NULL DEFAULT '0',
  `content` varchar(25) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- テーブルの構造 `Kin`
--

CREATE TABLE IF NOT EXISTS `Kin` (
  `category` int(2) NOT NULL,
  `point` int(2) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `Category`
SELECT * FROM (SELECT 1, 'TEST') AS tmp
WHERE NOT EXISTS (
    SELECT content FROM Category WHERE content = 'TEST'
) LIMIT 1;
