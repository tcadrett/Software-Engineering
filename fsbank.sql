-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 12, 2021 at 02:37 AM
-- Server version: 10.1.38-MariaDB
-- PHP Version: 7.3.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fsbank`
--
CREATE DATABASE IF NOT EXISTS `fsbank` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `fsbank`;

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `AcctID` int(11) NOT NULL,
  `FName` varchar(30) NOT NULL DEFAULT '""',
  `LName` varchar(30) NOT NULL DEFAULT '""',
  `Email` varchar(50) NOT NULL DEFAULT '""',
  `Phone` varchar(11) NOT NULL DEFAULT '""',
  `AcctType` smallint(6) NOT NULL DEFAULT '0',
  `AcctStatus` smallint(6) NOT NULL DEFAULT '0',
  `Username` varchar(30) NOT NULL,
  `Pwd` varchar(30) NOT NULL,
  `CreationDate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`AcctID`, `FName`, `LName`, `Email`, `Phone`, `AcctType`, `AcctStatus`, `Username`, `Pwd`, `CreationDate`) VALUES
(1, 'Natalie', 'Jackson', 'aJackson@gmail.com', '5559997896', 1, 1, 'NJackson', 'nJ5559997896!', '2021-04-02'),
(3, 'Allison', 'Jackson', 'aJackson@gmail.com', '5559997896', 3, 0, 'AJackson', 'aJ5559997896!', '2021-04-02'),
(4, 'Jane', 'Doe', 'jDoe@gmail.com', '5557778888', 3, 1, 'JDoe', 'jD5557778888!', '0000-00-00');

-- --------------------------------------------------------

--
-- Table structure for table `checking`
--

CREATE TABLE `checking` (
  `CheckingID` int(11) NOT NULL,
  `AcctID` int(11) NOT NULL,
  `Balance` float NOT NULL DEFAULT '0',
  `Interest` float NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `checking`
--

INSERT INTO `checking` (`CheckingID`, `AcctID`, `Balance`, `Interest`) VALUES
(7, 1, 1000, 0),
(8, 1, 0, 0.1),
(9, 1, 0, 0.1),
(10, 1, 0, 0.1);

-- --------------------------------------------------------

--
-- Table structure for table `credit`
--

CREATE TABLE `credit` (
  `CreditID` int(11) NOT NULL,
  `AcctID` int(11) NOT NULL,
  `CreditLimit` double NOT NULL,
  `Balance` double NOT NULL,
  `CardNumber` varchar(17) NOT NULL,
  `DueDate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `credit`
--

INSERT INTO `credit` (`CreditID`, `AcctID`, `CreditLimit`, `Balance`, `CardNumber`, `DueDate`) VALUES
(1, 1, 5000, 28.16, '0180626679994887', '2021-04-30');

-- --------------------------------------------------------

--
-- Table structure for table `defaultvalues`
--

CREATE TABLE `defaultvalues` (
  `VarName` varchar(50) NOT NULL,
  `VarIntValue` int(11) NOT NULL,
  `VarFloatValue` float NOT NULL,
  `VarStrValue` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `loans`
--

CREATE TABLE `loans` (
  `LoanID` int(11) NOT NULL,
  `AcctID` int(11) NOT NULL,
  `Principal` double NOT NULL,
  `Balance` double NOT NULL,
  `APR` double NOT NULL,
  `DueDate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `loans`
--

INSERT INTO `loans` (`LoanID`, `AcctID`, `Principal`, `Balance`, `APR`, `DueDate`) VALUES
(1, 3, 300, 280, 1.45, '2021-04-24');

-- --------------------------------------------------------

--
-- Table structure for table `savings`
--

CREATE TABLE `savings` (
  `SavingsID` int(11) NOT NULL,
  `AcctID` int(11) NOT NULL,
  `Balance` double NOT NULL DEFAULT '0',
  `Interest` double NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `savings`
--

INSERT INTO `savings` (`SavingsID`, `AcctID`, `Balance`, `Interest`) VALUES
(1, 3, 2860.36, 0.02),
(2, 1, 0, 0.3),
(3, 1, 0, 0.3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`AcctID`);

--
-- Indexes for table `checking`
--
ALTER TABLE `checking`
  ADD PRIMARY KEY (`CheckingID`),
  ADD KEY `AcctID` (`AcctID`);

--
-- Indexes for table `credit`
--
ALTER TABLE `credit`
  ADD PRIMARY KEY (`CreditID`),
  ADD KEY `AcctID` (`AcctID`);

--
-- Indexes for table `defaultvalues`
--
ALTER TABLE `defaultvalues`
  ADD PRIMARY KEY (`VarName`);

--
-- Indexes for table `loans`
--
ALTER TABLE `loans`
  ADD PRIMARY KEY (`LoanID`),
  ADD KEY `AcctID` (`AcctID`);

--
-- Indexes for table `savings`
--
ALTER TABLE `savings`
  ADD PRIMARY KEY (`SavingsID`),
  ADD KEY `AcctID` (`AcctID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `AcctID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `checking`
--
ALTER TABLE `checking`
  MODIFY `CheckingID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `credit`
--
ALTER TABLE `credit`
  MODIFY `CreditID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `loans`
--
ALTER TABLE `loans`
  MODIFY `LoanID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `savings`
--
ALTER TABLE `savings`
  MODIFY `SavingsID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `checking`
--
ALTER TABLE `checking`
  ADD CONSTRAINT `checking_ibfk_1` FOREIGN KEY (`AcctID`) REFERENCES `accounts` (`AcctID`) ON UPDATE CASCADE;

--
-- Constraints for table `credit`
--
ALTER TABLE `credit`
  ADD CONSTRAINT `credit_ibfk_1` FOREIGN KEY (`AcctID`) REFERENCES `accounts` (`AcctID`) ON UPDATE CASCADE;

--
-- Constraints for table `loans`
--
ALTER TABLE `loans`
  ADD CONSTRAINT `loans_ibfk_1` FOREIGN KEY (`AcctID`) REFERENCES `accounts` (`AcctID`) ON UPDATE CASCADE;

--
-- Constraints for table `savings`
--
ALTER TABLE `savings`
  ADD CONSTRAINT `savings_ibfk_1` FOREIGN KEY (`AcctID`) REFERENCES `accounts` (`AcctID`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
