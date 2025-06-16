-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 12, 2025 at 01:47 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tasknotate`
--

-- --------------------------------------------------------

--
-- Table structure for table `assigned_users`
--

CREATE TABLE `assigned_users` (
  `id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `assigned_users`
--

INSERT INTO `assigned_users` (`id`, `task_id`, `user_id`) VALUES
(260, 145, 62),
(261, 152, 60),
(262, 153, 62),
(263, 154, 60);

-- --------------------------------------------------------

--
-- Table structure for table `attachments`
--

CREATE TABLE `attachments` (
  `id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `file_url` varchar(255) NOT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attachments`
--

INSERT INTO `attachments` (`id`, `task_id`, `filename`, `file_url`, `uploaded_at`) VALUES
(161, 150, 'images.jpg.jpg', 'upload/files/company/174435389534500_.jpg', '2025-04-11 06:44:55');

-- --------------------------------------------------------

--
-- Table structure for table `checktask`
--

CREATE TABLE `checktask` (
  `checktask_id` int(11) NOT NULL,
  `checktask_userid` int(11) NOT NULL,
  `checktask_taskid` int(11) NOT NULL,
  `checktask_status` enum('Pending','Acknowledged','In Progress','Completed','Not Acknowledged') NOT NULL DEFAULT 'Pending',
  `checktask_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `checktask`
--

INSERT INTO `checktask` (`checktask_id`, `checktask_userid`, `checktask_taskid`, `checktask_status`, `checktask_date`) VALUES
(14, 62, 145, 'In Progress', '2025-04-10 18:26:27'),
(15, 60, 150, 'Pending', '2025-04-11 08:41:22');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `comment` text NOT NULL,
  `created_on` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `company`
--

CREATE TABLE `company` (
  `company_ID` int(11) NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `company_image` varchar(255) NOT NULL,
  `company_description` varchar(255) NOT NULL,
  `company_job` varchar(255) NOT NULL,
  `company_managerID` int(11) NOT NULL,
  `company_nickID` varchar(255) NOT NULL,
  `company_workes` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `company`
--

INSERT INTO `company` (`company_ID`, `company_name`, `company_image`, `company_description`, `company_job`, `company_managerID`, `company_nickID`, `company_workes`) VALUES
(27, 'instagramm', '2392Screenshot_20250323_062102_Facebook.jpg', 'hello world', 'Technology', 61, 'djjdidjs@i3833', '1-10'),
(28, 'Google', '8973Google__G__logo.svg.png', 'Search', 'Education', 60, 'google', '51-200'),
(31, 'DeerTech', '4862logo-deer-tech-vector-black-260nw-1478566049.jpg', 'نحن نساعد , نطور , نبتكر ', 'التكنولوجيا', 62, '@TeerTech', '1-10');

-- --------------------------------------------------------

--
-- Table structure for table `employee_company`
--

CREATE TABLE `employee_company` (
  `employee_company_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `managerapprove` tinyint(2) NOT NULL DEFAULT 0,
  `daterequest` timestamp NOT NULL DEFAULT current_timestamp(),
  `datejoined` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee_company`
--

INSERT INTO `employee_company` (`employee_company_id`, `company_id`, `user_id`, `managerapprove`, `daterequest`, `datejoined`) VALUES
(51, 28, 62, 1, '2025-04-10 18:23:03', '2025-04-10 21:23:03'),
(52, 31, 60, 1, '2025-04-11 08:40:51', '2025-04-11 11:40:51');

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE `notification` (
  `notification_id` int(11) NOT NULL,
  `notification_title` varchar(255) NOT NULL,
  `notification_body` varchar(255) NOT NULL,
  `notification_userid` int(11) NOT NULL,
  `notification_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `notification_view` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `progressbar`
--

CREATE TABLE `progressbar` (
  `progressbar_id` int(11) NOT NULL,
  `progressbar_companyid` int(11) NOT NULL,
  `progressbar_taskscompleted` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `progressbar`
--

INSERT INTO `progressbar` (`progressbar_id`, `progressbar_companyid`, `progressbar_taskscompleted`) VALUES
(2, 27, 0),
(3, 31, 2),
(4, 28, 2);

-- --------------------------------------------------------

--
-- Table structure for table `subtasks`
--

CREATE TABLE `subtasks` (
  `id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subtasks`
--

INSERT INTO `subtasks` (`id`, `task_id`, `title`, `description`) VALUES
(236, 150, 'Hello ofds', 'fsdfdsfs'),
(237, 152, 'lkjlasjlsdfd', 'dlskfjdslkfjlds'),
(238, 153, 'vvggu', '');

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_on` varchar(255) NOT NULL,
  `due_date` varchar(255) DEFAULT NULL,
  `priority` enum('Not set','Low','Medium','High') NOT NULL,
  `status` varchar(50) NOT NULL,
  `last_updated` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tasks`
--

INSERT INTO `tasks` (`id`, `company_id`, `title`, `description`, `created_on`, `due_date`, `priority`, `status`, `last_updated`) VALUES
(145, 28, 'Welcome to tasknotate company', '', '2025-04-02', '2025-04-30', 'Medium', 'Completed', '2025-04-11T13:24:26.461611'),
(150, 31, 'Tesging', 'Hello ', '2025-04-11', '2025-04-30', 'Medium', 'In Progress', '2025-04-11T09:46:22.522262'),
(151, 31, 'tesing ', 'hello world', '2025-04-11', '2025-04-30', 'High', 'Completed', '2025-04-11'),
(152, 31, 'hello world', 'fhjdkjfhdkhjfds', '2025-04-11', '2025-04-30', 'High', 'Completed', '2025-04-11'),
(153, 28, 'nmm', '', '2025-04-12', '2025-04-30', 'Medium', 'Completed', '2025-04-12'),
(154, 31, 'hello world', '', '2025-04-12', '', 'Not set', 'Pending', '2025-04-12');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `users_id` int(11) NOT NULL,
  `users_name` varchar(255) NOT NULL,
  `users_email` varchar(255) NOT NULL,
  `users_phone` int(11) NOT NULL,
  `users_image` varchar(255) NOT NULL,
  `users_verifycode` int(11) NOT NULL,
  `users_password` varchar(255) NOT NULL,
  `users_approve` tinyint(1) DEFAULT 0,
  `users_role` tinyint(1) NOT NULL DEFAULT 0,
  `users_googlesigned` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`users_id`, `users_name`, `users_email`, `users_phone`, `users_image`, `users_verifycode`, `users_password`, `users_approve`, `users_role`, `users_googlesigned`) VALUES
(56, 'google', 'moghassan70@gmail.com', 94689971, '', 0, '', 1, 0, 1),
(57, 'hggdd', 'alawaelstore6@gmail.com', 997456688, '', 0, '', 1, 0, 1),
(58, 'huugg', 'rashafacebook112@gmail.com', 675880877, '', 0, '', 1, 0, 1),
(59, 'uuyyttfg', 'mg2phantom@gmail.com', 997213456, '', 0, '', 1, 0, 1),
(60, 'Mohammed', 'rooltion@gmail.com', 997468997, '174436737811706_.jpg', 12345, '', 1, 0, 1),
(61, 'gxxon', 'gxxon21@gmail.com', 997468521, '', 0, '', 1, 0, 1),
(62, 'Mohammed', 'rootltion@gmail.com', 997468995, '', 60925, '9d9875bcf6c387efc74cc53287584bc0a3020266', 1, 0, 0),
(63, 'osso', 'hello@gmail.com', 99999999, '', 68267, '8cb2237d0679ca88db6464eac60da96345513964', 0, 0, 0),
(64, 'mohammedalkasem', 'alkasem@gmail.com', 997468994, '', 50309, '7c222fb2927d828af22f592134e8932480637c0d', 0, 0, 0),
(65, 'MohammedAbdullkareem', 'MohammedAbdullkareem@gmail.com', 2147483647, '', 24896, '9d9875bcf6c387efc74cc53287584bc0a3020266', 0, 0, 0),
(66, 'mohammed', 'moahmmed1234@gmail.com', 977468912, '', 62542, '9d9875bcf6c387efc74cc53287584bc0a3020266', 0, 0, 0),
(67, 'mohammed', 'moahmmed1235@gmail.com', 2147483647, '', 54744, '9d9875bcf6c387efc74cc53287584bc0a3020266', 0, 0, 0),
(68, 'mohammed', 'kajfkasdjf@gmail.com', 997456774, '', 92871, '9d9875bcf6c387efc74cc53287584bc0a3020266', 0, 0, 0),
(69, 'mohammed', 'moahmmed12351@gmail.com', 2147483647, '', 25722, '9d9875bcf6c387efc74cc53287584bc0a3020266', 0, 0, 0),
(70, 'mohammed', 'moahmmed123512@gmail.com', 2147483647, '', 58241, '9d9875bcf6c387efc74cc53287584bc0a3020266', 0, 0, 0),
(71, 'MOhammed', 'Jasem@gmail.com', 997467543, '', 80494, '9d9875bcf6c387efc74cc53287584bc0a3020266', 0, 0, 0),
(72, 'mohammed', 'Helloworld@gmail.com', 997484789, '', 98260, '9d9875bcf6c387efc74cc53287584bc0a3020266', 0, 0, 0),
(73, 'mohammed', 'flskdhjlfikdsj@gmail.com', 97845887, '', 55370, '9d9875bcf6c387efc74cc53287584bc0a3020266', 0, 0, 0),
(74, 'hellofsdfsd', 'Mohammed123@gmail.com', 2147483647, '', 25897, '9d9875bcf6c387efc74cc53287584bc0a3020266', 0, 0, 0),
(75, 'mohammed', 'moahmmed1213512@gmail.com', 2147483647, '', 32735, '9d9875bcf6c387efc74cc53287584bc0a3020266', 0, 0, 0),
(76, 'fklsjfkdsf', 'mohamme322@gmail.com', 2147483647, '', 80807, '9d9875bcf6c387efc74cc53287584bc0a3020266', 0, 0, 0),
(77, 'jflkjfklsd', 'fldskjflkdsj@gmail.com', 2147483647, '', 81212, '9d9875bcf6c387efc74cc53287584bc0a3020266', 0, 0, 0),
(78, 'mohammed', 'mohamme12@gmail.com', 2147483647, '', 80001, '9d9875bcf6c387efc74cc53287584bc0a3020266', 1, 0, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assigned_users`
--
ALTER TABLE `assigned_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assigned_users_ibfk_1` (`task_id`),
  ADD KEY `assigned_users_ibfk_2` (`user_id`);

--
-- Indexes for table `attachments`
--
ALTER TABLE `attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attachments_ibfk_1` (`task_id`);

--
-- Indexes for table `checktask`
--
ALTER TABLE `checktask`
  ADD PRIMARY KEY (`checktask_id`),
  ADD KEY `checktask_ibfk_1` (`checktask_userid`),
  ADD KEY `checktask_taskid` (`checktask_taskid`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comments_ibfk_1` (`user_id`),
  ADD KEY `comments_ibfk_2` (`task_id`);

--
-- Indexes for table `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`company_ID`),
  ADD KEY `company_managerID` (`company_managerID`);

--
-- Indexes for table `employee_company`
--
ALTER TABLE `employee_company`
  ADD PRIMARY KEY (`employee_company_id`),
  ADD KEY `company_id` (`company_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `notification_userid` (`notification_userid`);

--
-- Indexes for table `progressbar`
--
ALTER TABLE `progressbar`
  ADD PRIMARY KEY (`progressbar_id`),
  ADD KEY `progressbar_companyid` (`progressbar_companyid`);

--
-- Indexes for table `subtasks`
--
ALTER TABLE `subtasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subtasks_ibfk_1` (`task_id`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tasks_ibfk_1` (`company_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`users_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assigned_users`
--
ALTER TABLE `assigned_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=264;

--
-- AUTO_INCREMENT for table `attachments`
--
ALTER TABLE `attachments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=162;

--
-- AUTO_INCREMENT for table `checktask`
--
ALTER TABLE `checktask`
  MODIFY `checktask_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `company`
--
ALTER TABLE `company`
  MODIFY `company_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `employee_company`
--
ALTER TABLE `employee_company`
  MODIFY `employee_company_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `notification`
--
ALTER TABLE `notification`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `progressbar`
--
ALTER TABLE `progressbar`
  MODIFY `progressbar_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `subtasks`
--
ALTER TABLE `subtasks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=239;

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=155;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `users_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assigned_users`
--
ALTER TABLE `assigned_users`
  ADD CONSTRAINT `assigned_users_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `assigned_users_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`users_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `attachments`
--
ALTER TABLE `attachments`
  ADD CONSTRAINT `attachments_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `checktask`
--
ALTER TABLE `checktask`
  ADD CONSTRAINT `checktask_ibfk_1` FOREIGN KEY (`checktask_userid`) REFERENCES `users` (`users_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `checktask_ibfk_2` FOREIGN KEY (`checktask_taskid`) REFERENCES `tasks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`users_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `company`
--
ALTER TABLE `company`
  ADD CONSTRAINT `company_ibfk_1` FOREIGN KEY (`company_managerID`) REFERENCES `users` (`users_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `employee_company`
--
ALTER TABLE `employee_company`
  ADD CONSTRAINT `employee_company_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `company` (`company_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `employee_company_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`users_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `notification`
--
ALTER TABLE `notification`
  ADD CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`notification_userid`) REFERENCES `users` (`users_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `progressbar`
--
ALTER TABLE `progressbar`
  ADD CONSTRAINT `progressbar_ibfk_1` FOREIGN KEY (`progressbar_companyid`) REFERENCES `company` (`company_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `subtasks`
--
ALTER TABLE `subtasks`
  ADD CONSTRAINT `subtasks_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tasks`
--
ALTER TABLE `tasks`
  ADD CONSTRAINT `tasks_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `company` (`company_ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
