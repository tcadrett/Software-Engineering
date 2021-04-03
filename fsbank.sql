-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 22, 2021 at 06:03 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fsbank`
--

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
  `AcctType` smallint(6) NOT NULL DEFAULT 0,
  `AcctStatus` smallint(6) NOT NULL DEFAULT 0,
  `Username` varchar(30) NOT NULL,
  `Pwd` varchar(30) NOT NULL,
  `CreationDate` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `checking`
--

CREATE TABLE `checking` (
  `CheckingID` int(11) NOT NULL,
  `AcctID` int(11) NOT NULL,
  `Balance` float NOT NULL DEFAULT 0,
  `Interest` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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

-- --------------------------------------------------------

--
-- Table structure for table `savings`
--

CREATE TABLE `savings` (
  `SavingsID` int(11) NOT NULL,
  `AcctID` int(11) NOT NULL,
  `Balance` double NOT NULL DEFAULT 0,
  `Interest` double NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  MODIFY `AcctID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `checking`
--
ALTER TABLE `checking`
  MODIFY `CheckingID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `credit`
--
ALTER TABLE `credit`
  MODIFY `CreditID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `loans`
--
ALTER TABLE `loans`
  MODIFY `LoanID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `savings`
--
ALTER TABLE `savings`
  MODIFY `SavingsID` int(11) NOT NULL AUTO_INCREMENT;

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
