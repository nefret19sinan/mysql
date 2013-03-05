-- phpMyAdmin SQL Dump
-- version 3.4.10.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 05, 2013 at 05:51 PM
-- Server version: 5.5.20
-- PHP Version: 5.3.10

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `game`
--
CREATE DATABASE `game` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `game`;

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `NewAccount`(
in UName varchar(45),
in UPass varchar(45),
in UMail varchar(45),
in UBornDate DateTime,
in UGender varchar(45),
out returnAccount varchar(45)
)
BEGIN
declare myID int default 0;
declare genderID int default 0;

set myID=(Select UserID from tbuser where UserName=UName or UserMail=UMail);
if(myID!=0) then
set returnAccount="Bu Kullanıcı Adı veya Mail adresi kullanılmakta";
else
set genderID=(Select GID from tbGender where GenderName=UGender);
insert into tbuser(UserName,UserPass,UserMail,UserBornDate,UserGender)
values(UName,UPass,UMail,UBornDate,genderID) ;
set returnAccount="Kayıt Başarıyla Gerçekleştirildi";
end if;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `getusers`
--
CREATE TABLE IF NOT EXISTS `getusers` (
`Kullanıcı Adı` varchar(45)
,`Şifre` varchar(45)
,`Mail Adresi` varchar(45)
,`Doğum Tarihi` date
,`Kayıt Tarihi` timestamp
,`Cinsiyet` varchar(45)
);
-- --------------------------------------------------------

--
-- Table structure for table `tbgender`
--

CREATE TABLE IF NOT EXISTS `tbgender` (
  `GID` int(11) NOT NULL AUTO_INCREMENT,
  `GenderName` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`GID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Cinsiyet' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `tbgender`
--

INSERT INTO `tbgender` (`GID`, `GenderName`) VALUES
(1, 'Male'),
(2, 'Female');

-- --------------------------------------------------------

--
-- Table structure for table `tbingame`
--

CREATE TABLE IF NOT EXISTS `tbingame` (
  `UserID` int(11) NOT NULL,
  `GameNick` varchar(45) DEFAULT NULL,
  `GameGender` int(11) DEFAULT NULL,
  `GameIntelligence` int(11) DEFAULT NULL,
  `GamePower` int(11) DEFAULT NULL,
  `GameCash` int(11) DEFAULT NULL,
  PRIMARY KEY (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Oyunun genel hatları';

-- --------------------------------------------------------

--
-- Table structure for table `tbjobs`
--

CREATE TABLE IF NOT EXISTS `tbjobs` (
  `JobID` int(11) NOT NULL AUTO_INCREMENT,
  `JobName` varchar(45) NOT NULL,
  PRIMARY KEY (`JobID`,`JobName`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Meslekler' AUTO_INCREMENT=5 ;

--
-- Dumping data for table `tbjobs`
--

INSERT INTO `tbjobs` (`JobID`, `JobName`) VALUES
(1, 'Student'),
(2, 'Teacher'),
(3, 'Doctor'),
(4, 'Engineer');

-- --------------------------------------------------------

--
-- Table structure for table `tblogin`
--

CREATE TABLE IF NOT EXISTS `tblogin` (
  `LID` int(11) NOT NULL AUTO_INCREMENT,
  `UID` varchar(45) DEFAULT NULL,
  `LTime` timestamp NULL DEFAULT NULL,
  `LIP` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`LID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Giriş Bilgileri' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tbtypes`
--

CREATE TABLE IF NOT EXISTS `tbtypes` (
  `TypeID` int(11) NOT NULL AUTO_INCREMENT,
  `TypeName` varchar(45) NOT NULL,
  PRIMARY KEY (`TypeID`,`TypeName`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Yetkiler' AUTO_INCREMENT=1000 ;

--
-- Dumping data for table `tbtypes`
--

INSERT INTO `tbtypes` (`TypeID`, `TypeName`) VALUES
(0, 'InActive'),
(1, 'User'),
(2, 'VIP'),
(777, 'Administrator'),
(999, 'Ban!!!!!!');

-- --------------------------------------------------------

--
-- Table structure for table `tbuser`
--

CREATE TABLE IF NOT EXISTS `tbuser` (
  `UserID` int(11) NOT NULL AUTO_INCREMENT,
  `UserType` int(11) DEFAULT '0',
  `UserName` varchar(45) NOT NULL DEFAULT '',
  `UserPass` varchar(45) DEFAULT NULL,
  `UserMail` varchar(45) DEFAULT NULL,
  `UserRegisterTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UserBornDate` date DEFAULT NULL,
  `UserGender` int(11) DEFAULT '0',
  PRIMARY KEY (`UserID`,`UserName`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Kullanıcılar' AUTO_INCREMENT=9 ;

--
-- Dumping data for table `tbuser`
--

INSERT INTO `tbuser` (`UserID`, `UserType`, `UserName`, `UserPass`, `UserMail`, `UserRegisterTime`, `UserBornDate`, `UserGender`) VALUES
(6, 0, 'deneme', 'deneme', 'deneme', '2013-03-05 17:19:38', '2013-03-05', 2),
(7, 0, 'erkek', 'erkek', 'erkek', '2013-03-05 17:23:52', '2013-03-05', 1),
(8, 0, 'Bayan', 'Bayan', 'Bayan', '2013-03-05 17:24:17', '2013-03-05', 2);

-- --------------------------------------------------------

--
-- Structure for view `getusers`
--
DROP TABLE IF EXISTS `getusers`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `getusers` AS select `tbuser`.`UserName` AS `Kullanıcı Adı`,`tbuser`.`UserPass` AS `Şifre`,`tbuser`.`UserMail` AS `Mail Adresi`,`tbuser`.`UserBornDate` AS `Doğum Tarihi`,`tbuser`.`UserRegisterTime` AS `Kayıt Tarihi`,`tbgender`.`GenderName` AS `Cinsiyet` from (`tbuser` join `tbgender` on((`tbuser`.`UserGender` = `tbgender`.`GID`)));

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
