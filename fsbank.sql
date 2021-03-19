-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 17, 2021 at 02:10 AM
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
-- Table structure for table `accountreq`
--

CREATE TABLE `accountreq` (
  `ReqID` int(7) NOT NULL,
  `FName` varchar(30) NOT NULL,
  `LName` varchar(30) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Phone` varchar(11) NOT NULL,
  `accountType` int(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `accountreq`
--

INSERT INTO `accountreq` (`ReqID`, `FName`, `LName`, `Email`, `Phone`, `accountType`) VALUES
(4, 'Jack', 'Joe', 'jJoe@gmail.com', '7779995555', 1),
(320, 'Jason', 'Dean', 'jDean', '', 0),
(321, 'Jack', 'Johnson', 'jJohnson@hotmail.com', '4449997359', 0),
(322, 'Alice', 'Jackson', 'aJackson@yahoo.com', '8946557736', 2),
(323, 'Admin', 'Administrator', 'admin@FSBank.com', '8006447116', 3);

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `AcctID` int(7) NOT NULL,
  `FName` varchar(30) NOT NULL,
  `LName` varchar(30) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Phone` varchar(11) NOT NULL,
  `accountType` int(7) NOT NULL,
  `Username` varchar(30) NOT NULL,
  `Password` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`AcctID`, `FName`, `LName`, `Email`, `Phone`, `accountType`, `Username`, `Password`) VALUES
(1, 'Admin', 'Administrator', '', '', 3, 'admin', 'admin'),
(3, 'Jack', 'Joe', 'jJoe@gmail.com', '7779995555', 1, 'JJoe', 'jJ7779995555!'),
(4, 'Jack', 'Joe', 'jJoe@gmail.com', '7779995555', 1, 'JJoe', 'jJ7779995555!'),
(6, 'Alice', 'Jackson', 'aJackson@yahoo.com', '8946557736', 0, 'AJackson', 'aJ8946557736!'),
(7, 'Alice', 'Jackson', 'aJackson@yahoo.com', '8946557736', 1, 'AJackson', 'aJ8946557736!');

-- --------------------------------------------------------

--
-- Table structure for table `checking`
--

CREATE TABLE `checking` (
  `CheckingID` int(7) NOT NULL,
  `CurrentBalance` int(7) NOT NULL,
  `CheckingAccountNumber` int(12) NOT NULL,
  `AcctID` int(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `clerk`
--

CREATE TABLE `clerk` (
  `ClerkID` int(7) NOT NULL,
  `FName` varchar(30) NOT NULL,
  `LName` varchar(30) NOT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Gender` varchar(10) NOT NULL DEFAULT 'N/A',
  `HireDate` date NOT NULL DEFAULT current_timestamp(),
  `Password` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `clerk`
--

INSERT INTO `clerk` (`ClerkID`, `FName`, `LName`, `Email`, `Gender`, `HireDate`, `Password`) VALUES
(1, 'Test1', 'Test2', '0', '', '0000-00-00', 'Test4'),
(2, 'Alice', 'Jackson', 'aJackson@yahoo.com', 'N/A', '2021-03-14', 'aJ8946557736!'),
(3, 'Alice', 'Jackson', 'aJackson@yahoo.com', 'N/A', '2021-03-14', 'aJ8946557736!'),
(4, 'Alice', 'Jackson', 'aJackson@yahoo.com', 'N/A', '2021-03-14', 'aJ8946557736!'),
(5, 'Alice', 'Jackson', 'aJackson@yahoo.com', 'N/A', '2021-03-14', 'aJ8946557736!'),
(6, 'Alice', 'Jackson', 'aJackson@yahoo.com', 'N/A', '2021-03-14', 'aJ8946557736!'),
(7, 'Alice', 'Jackson', 'aJackson@yahoo.com', 'N/A', '2021-03-14', 'aJ8946557736!'),
(8, 'Alice', 'Jackson', 'aJackson@yahoo.com', 'N/A', '2021-03-14', 'aJ8946557736!'),
(9, 'Alice', 'Jackson', 'aJackson@yahoo.com', 'N/A', '2021-03-15', 'aJ8946557736!');

-- --------------------------------------------------------

--
-- Table structure for table `credit card`
--

CREATE TABLE `credit card` (
  `AcctID` int(7) NOT NULL,
  `APR` decimal(2,1) NOT NULL,
  `CreditLimit` decimal(7,2) NOT NULL,
  `PayOffAmount` decimal(7,2) NOT NULL,
  `CreditCardNumber` int(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `loan`
--

CREATE TABLE `loan` (
  `LoanID` int(7) NOT NULL,
  `PrincipleBalance` decimal(5,2) NOT NULL,
  `APR` decimal(2,1) NOT NULL,
  `SchedulePayment` text NOT NULL,
  `CurrentPayoff` decimal(5,2) NOT NULL,
  `PaymentDueDate` date NOT NULL,
  `AcctID` int(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `saving`
--

CREATE TABLE `saving` (
  `SavingID` int(7) NOT NULL,
  `CurrentBalance` int(12) NOT NULL,
  `SavingAccountNumber` int(12) NOT NULL,
  `AcctID` int(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accountreq`
--
ALTER TABLE `accountreq`
  ADD PRIMARY KEY (`ReqID`),
  ADD KEY `accountType` (`accountType`);

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
-- Indexes for table `clerk`
--
ALTER TABLE `clerk`
  ADD PRIMARY KEY (`ClerkID`);

--
-- Indexes for table `credit card`
--
ALTER TABLE `credit card`
  ADD PRIMARY KEY (`AcctID`);

--
-- Indexes for table `loan`
--
ALTER TABLE `loan`
  ADD PRIMARY KEY (`LoanID`),
  ADD KEY `AcctID` (`AcctID`);

--
-- Indexes for table `saving`
--
ALTER TABLE `saving`
  ADD PRIMARY KEY (`SavingID`),
  ADD UNIQUE KEY `AcctID` (`AcctID`),
  ADD KEY `AcctID_2` (`AcctID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accountreq`
--
ALTER TABLE `accountreq`
  MODIFY `ReqID` int(7) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=324;

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `AcctID` int(7) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `checking`
--
ALTER TABLE `checking`
  MODIFY `CheckingID` int(7) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `clerk`
--
ALTER TABLE `clerk`
  MODIFY `ClerkID` int(7) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `credit card`
--
ALTER TABLE `credit card`
  MODIFY `AcctID` int(7) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `loan`
--
ALTER TABLE `loan`
  MODIFY `LoanID` int(7) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `saving`
--
ALTER TABLE `saving`
  MODIFY `SavingID` int(7) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `checking`
--
ALTER TABLE `checking`
  ADD CONSTRAINT `checking_ibfk_1` FOREIGN KEY (`AcctID`) REFERENCES `accounts` (`AcctID`);

--
-- Constraints for table `credit card`
--
ALTER TABLE `credit card`
  ADD CONSTRAINT `credit card_ibfk_1` FOREIGN KEY (`AcctID`) REFERENCES `accounts` (`AcctID`);

--
-- Constraints for table `loan`
--
ALTER TABLE `loan`
  ADD CONSTRAINT `loan_ibfk_1` FOREIGN KEY (`AcctID`) REFERENCES `accounts` (`AcctID`);

--
-- Constraints for table `saving`
--
ALTER TABLE `saving`
  ADD CONSTRAINT `saving_ibfk_1` FOREIGN KEY (`AcctID`) REFERENCES `accounts` (`AcctID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
