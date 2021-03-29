-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 24, 2021 at 08:32 PM
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

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `AcctID` int(11) NOT NULL,
  `firstname` varchar(30) NOT NULL,
  `lastname` varchar(30) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(30) NOT NULL,
  `address` varchar(50) NOT NULL,
  `city` varchar(20) NOT NULL,
  `state` varchar(6) NOT NULL,
  `Phone` varchar(11) NOT NULL,
  `security` varchar(30) NOT NULL,
  `answer` varchar(32) NOT NULL,
  `accounttype` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`AcctID`, `firstname`, `lastname`, `email`, `password`, `address`, `city`, `state`, `Phone`, `security`, `answer`, `accounttype`) VALUES
(2, 'ollio', 'doe', 'odoe@we.kj', 'Penamang1', 'sdafgaqfgedsgf', 'WESTBOROW', '', '5087681234', 'hat is up or down', 'down', 'staff'),
(123456789, 'guada', 'lupe', 'glu@h.n', 'Ollio90', '1', 'WESTBOROW', 'AL', '1', '1', '1', 'staff');

-- --------------------------------------------------------

--
-- Table structure for table `checking`
--

CREATE TABLE `checking` (
  `CheckingID` int(11) NOT NULL,
  `AcctID` int(11) NOT NULL,
  `Balance` float NOT NULL,
  `Interest` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `credit`
--

CREATE TABLE `credit` (
  `CreditID` int(11) NOT NULL,
  `AcctID` int(11) NOT NULL,
  `CreditLimit` double NOT NULL,
  `Balance` double NOT NULL,
  `CardNumber` varchar(11) NOT NULL,
  `DueDate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `savings`
--

CREATE TABLE `savings` (
  `SavingID` int(11) NOT NULL,
  `AcctID` int(11) NOT NULL,
  `Balance` double NOT NULL,
  `Interest` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  ADD PRIMARY KEY (`SavingID`),
  ADD KEY `AcctID` (`AcctID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `AcctID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `SavingID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `checking`
--
ALTER TABLE `checking`
  ADD CONSTRAINT `checking_ibfk_1` FOREIGN KEY (`AcctID`) REFERENCES `accounts` (`AcctID`);

--
-- Constraints for table `credit`
--
ALTER TABLE `credit`
  ADD CONSTRAINT `credit_ibfk_1` FOREIGN KEY (`AcctID`) REFERENCES `accounts` (`AcctID`);

--
-- Constraints for table `loans`
--
ALTER TABLE `loans`
  ADD CONSTRAINT `loans_ibfk_1` FOREIGN KEY (`AcctID`) REFERENCES `accounts` (`AcctID`);

--
-- Constraints for table `savings`
--
ALTER TABLE `savings`
  ADD CONSTRAINT `savings_ibfk_1` FOREIGN KEY (`AcctID`) REFERENCES `accounts` (`AcctID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
