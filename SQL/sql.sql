-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 24, 2025 at 11:22 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `collegehunt`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `email`, `password`, `name`) VALUES
(1, 'ADMIN@123.com', 'ADMIN123', 'Main Admin');

-- --------------------------------------------------------

--
-- Table structure for table `ap`
--

CREATE TABLE `ap` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `state` varchar(100) NOT NULL,
  `image_url` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ap`
--

INSERT INTO `ap` (`id`, `name`, `address`, `state`, `image_url`) VALUES
(1, 'Indian Institute of Technology Tirupati', 'Tirupati, Andhra Pradesh', 'Andhra Pradesh', 'http://localhost/collegehunt/uploads/68381820e818f_image21.png'),
(2, 'Vignan Institute of Information Technology', 'Visakhapatnam, Andhra Pradesh', 'Andhra Pradesh', 'http://localhost/collegehunt/uploads/68392d61bd471_image23.png');

-- --------------------------------------------------------

--
-- Table structure for table `ba_opportunities`
--

CREATE TABLE `ba_opportunities` (
  `id` int(11) NOT NULL,
  `opportunity` varchar(255) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ba_opportunities`
--

INSERT INTO `ba_opportunities` (`id`, `opportunity`, `description`) VALUES
(1, 'Civil Services', 'Prepare for UPSC, IAS, IPS, or State PSC exams. BA in Political Science or History is advantageous.'),
(2, 'Content Writing', 'Work as a content creator, copywriter, or editor in media, advertising, or digital marketing.'),
(3, 'Teaching', 'Pursue B.Ed. after BA to become a school teacher or qualify for teaching posts through NET/SET.'),
(4, 'Public Relations', 'Work in PR agencies or corporate communication after specializing in Mass Communication or Journalism.'),
(5, 'NGO and Social Work', 'Join NGOs or social organizations focusing on development, human rights, or education.'),
(6, 'Event Management', 'Plan, organize, and execute events such as corporate seminars, weddings, and cultural functions.'),
(7, 'Marketing & Sales', 'Entry-level roles in sales, client servicing, and marketing with BA in Economics or Sociology.'),
(8, 'Law', 'Pursue LLB after BA to enter the legal profession. BA in Political Science or Sociology is helpful.'),
(9, 'Government Jobs', 'Prepare for SSC, Banking, Railways, or other central and state-level government exams.'),
(10, 'Translation & Interpretation', 'Use language proficiency for jobs in translation, interpretation, or content localization.');

-- --------------------------------------------------------

--
-- Table structure for table `bba_opportunities`
--

CREATE TABLE `bba_opportunities` (
  `id` int(11) NOT NULL,
  `opportunity` varchar(255) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bba_opportunities`
--

INSERT INTO `bba_opportunities` (`id`, `opportunity`, `description`) VALUES
(1, 'Marketing Executive', 'Plan and execute marketing campaigns for businesses.'),
(2, 'Human Resource Manager', 'Handle recruitment, training, and employee welfare.'),
(3, 'Financial Analyst', 'Analyze financial data and assist business decisions.'),
(4, 'Operations Manager', 'Oversee daily operations in various departments.'),
(5, 'Business Development Executive', 'Identify growth opportunities and partnerships.'),
(6, 'Sales Manager', 'Lead sales teams and drive revenue targets.'),
(7, 'Entrepreneur', 'Start and manage your own business venture.'),
(8, 'Retail Manager', 'Supervise retail store operations and customer experience.'),
(9, 'Project Coordinator', 'Assist in managing and delivering company projects.'),
(10, 'Digital Marketing Specialist', 'Manage online marketing and SEO strategies.');

-- --------------------------------------------------------

--
-- Table structure for table `bca_opportunities`
--

CREATE TABLE `bca_opportunities` (
  `id` varchar(10) NOT NULL,
  `opportunity` varchar(255) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bca_opportunities`
--

INSERT INTO `bca_opportunities` (`id`, `opportunity`, `description`) VALUES
('1', 'Web Developer', 'Design and develop websites and web applications.'),
('10', 'Cloud Support Engineer', 'Provide cloud-based infrastructure support and solutions.'),
('2', 'Software Tester', 'Ensure software quality by identifying bugs and issues.'),
('3', 'Technical Support Specialist', 'Provide tech support and troubleshooting solutions.'),
('4', 'System Administrator', 'Manage and maintain computer systems and networks.'),
('5', 'UI/UX Designer', 'Design user interfaces and user experiences for applications.'),
('6', 'Mobile App Developer', 'Build mobile applications for Android and iOS.'),
('7', 'IT Analyst', 'Analyze and improve IT systems for business efficiency.'),
('8', 'Digital Marketer', 'Promote products through digital marketing channels.'),
('9', 'Database Administrator', 'Organize and manage large data sets efficiently.');

-- --------------------------------------------------------

--
-- Table structure for table `bcom_opportunities`
--

CREATE TABLE `bcom_opportunities` (
  `id` int(11) NOT NULL,
  `opportunity` varchar(100) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bcom_opportunities`
--

INSERT INTO `bcom_opportunities` (`id`, `opportunity`, `description`) VALUES
(1, 'Accountant', 'Manage financial records, audits, and ensure compliance.'),
(2, 'Financial Analyst', 'Analyze financial data to assist decision making.'),
(3, 'Tax Consultant', 'Assist individuals or firms with tax planning and filing.'),
(4, 'Banking Officer', 'Work in various roles in public and private sector banks.'),
(5, 'Business Analyst', 'Evaluate business processes and suggest improvements.'),
(6, 'Insurance Advisor', 'Provide clients with insurance and investment plans.'),
(7, 'Stock Broker', 'Buy and sell stocks and provide trading advice.'),
(8, 'Auditor', 'Conduct internal or external audits of financial records.'),
(9, 'HR Executive', 'Manage recruitment, employee records, and payroll.'),
(10, 'Entrepreneur', 'Start your own business and manage operations.');

-- --------------------------------------------------------

--
-- Table structure for table `bdes_opportunities`
--

CREATE TABLE `bdes_opportunities` (
  `id` int(11) NOT NULL,
  `opportunity` varchar(255) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bdes_opportunities`
--

INSERT INTO `bdes_opportunities` (`id`, `opportunity`, `description`) VALUES
(1, 'Graphic Designer', 'Create visual content for branding, marketing, and web.'),
(2, 'UI/UX Designer', 'Design user interfaces and experiences for websites and apps.'),
(3, 'Fashion Designer', 'Design clothing, accessories, and fashion collections.'),
(4, 'Product Designer', 'Develop the look and functionality of physical products.'),
(5, 'Interior Designer', 'Plan and design interior spaces that are functional and beautiful.'),
(6, 'Animation Artist', 'Create animations for games, films, and digital content.'),
(7, 'Game Designer', 'Design gameplay mechanics and visuals for interactive games.'),
(8, 'Design Consultant', 'Offer creative design solutions to businesses.'),
(9, 'Packaging Designer', 'Design product packaging that attracts customers.'),
(10, 'Art Director', 'Lead creative teams and define visual direction for projects.');

-- --------------------------------------------------------

--
-- Table structure for table `bed_opportunities`
--

CREATE TABLE `bed_opportunities` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bed_opportunities`
--

INSERT INTO `bed_opportunities` (`id`, `title`, `description`) VALUES
(1, 'School Teacher', 'Teach primary or secondary level students in schools.'),
(2, 'Educational Counselor', 'Guide students in academic and career choices.'),
(3, 'Curriculum Developer', 'Design course materials and learning objectives.'),
(4, 'School Administrator', 'Oversee the management of schools and educational institutions.'),
(5, 'Online Tutor', 'Provide virtual education support to students globally.'),
(6, 'Special Education Teacher', 'Support students with learning disabilities and special needs.'),
(7, 'Education Content Writer', 'Create textbooks and e-learning content.'),
(8, 'Teacher Trainer', 'Train aspiring and in-service teachers.'),
(9, 'Government Teaching Jobs', 'Work as a government teacher after clearing eligibility exams.'),
(10, 'Principal or Headmaster', 'Lead schools with academic and administrative responsibilities.');

-- --------------------------------------------------------

--
-- Table structure for table `bpharm_opportunities`
--

CREATE TABLE `bpharm_opportunities` (
  `id` int(11) NOT NULL,
  `course` varchar(50) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bpharm_opportunities`
--

INSERT INTO `bpharm_opportunities` (`id`, `course`, `title`, `description`) VALUES
(1, 'BPharm', 'Pharmacist', 'Dispenses prescribed medications and provides information on the proper use of pharmaceutical products.'),
(2, 'BPharm', 'Drug Safety Associate', 'Monitors and ensures the safety of pharmaceutical products by tracking adverse reactions and ensuring compliance.'),
(3, 'BPharm', 'Medical Representative', 'Promotes and sells pharmaceutical products to healthcare professionals, ensuring they are informed about the latest treatments.'),
(4, 'BPharm', 'Clinical Research Associate', 'Monitors clinical trials to ensure they are conducted in compliance with regulations and ethical standards.'),
(5, 'BPharm', 'Quality Control Analyst', 'Ensures the quality and safety of pharmaceutical products by conducting tests and analysis of raw materials and finished products.'),
(6, 'BPharm', 'Regulatory Affairs Officer', 'Manages the approval process for new pharmaceutical products and ensures compliance with national and international regulations.'),
(7, 'BPharm', 'Production Manager (Pharmaceuticals)', 'Oversees the manufacturing of pharmaceutical products, ensuring production schedules are met and quality standards are maintained.'),
(8, 'BPharm', 'Hospital Pharmacist', 'Works in hospitals to dispense medications, provide patient counseling, and collaborate with healthcare teams on treatment plans.'),
(9, 'BPharm', 'Pharmaceutical Marketing Manager', 'Develops and implements marketing strategies for pharmaceutical products, working to expand market reach and sales.'),
(10, 'BPharm', 'Research Scientist', 'Conducts research to discover new pharmaceutical products, focusing on drug development and improvement.');

-- --------------------------------------------------------

--
-- Table structure for table `bsc_opportunities`
--

CREATE TABLE `bsc_opportunities` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bsc_opportunities`
--

INSERT INTO `bsc_opportunities` (`id`, `title`, `description`) VALUES
(1, 'Data Analyst', 'Use data tools to extract insights and support business decisions.'),
(2, 'Research Assistant', 'Assist in academic or industrial research and lab work.'),
(3, 'Biotech Lab Technician', 'Work in biotech labs handling specimens, equipment, and reporting.'),
(4, 'Medical Coding Specialist', 'Use healthcare knowledge to translate diagnoses into codes.'),
(5, 'Environmental Consultant', 'Support ecological assessments and provide scientific advice.'),
(6, 'Science Writer', 'Translate complex scientific information into public content.'),
(7, 'Clinical Data Manager', 'Manage and organize data from clinical trials.'),
(8, 'Pharmaceutical Sales Rep', 'Market medical products using biology/chemistry knowledge.'),
(9, 'Nutritionist Assistant', 'Support diet planning using biology and food science.'),
(10, 'Forensic Science Technician', 'Assist crime investigations using biology and chemistry.');

-- --------------------------------------------------------

--
-- Table structure for table `btech_opportunities`
--

CREATE TABLE `btech_opportunities` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `btech_opportunities`
--

INSERT INTO `btech_opportunities` (`id`, `title`, `description`) VALUES
(1, 'AI/ML Engineer', 'Design machine learning models and AI systems for real-world problems.'),
(2, 'Cloud Engineer', 'Manage and deploy scalable cloud infrastructure solutions.'),
(3, 'Cybersecurity Specialist', 'Protect systems and networks from digital attacks.'),
(4, 'Data Analyst', 'Analyze data to help companies make informed business decisions.'),
(5, 'DevOps Engineer', 'Automate and streamline software development and deployment pipelines.'),
(6, 'Embedded Systems Engineer', 'Work on hardware-software integration in real-time systems.'),
(7, 'Full Stack Developer', 'Build complete web or mobile applications from front-end to back-end.'),
(8, 'Network Engineer', 'Design and manage secure and efficient computer networks.'),
(9, 'Software Developer', 'Develop and maintain software applications for various platforms.'),
(10, 'Technical Consultant', 'Provide technical expertise to clients and help implement solutions.');

-- --------------------------------------------------------

--
-- Table structure for table `colleges`
--

CREATE TABLE `colleges` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `description1` text DEFAULT NULL,
  `description2` text DEFAULT NULL,
  `description3` text DEFAULT NULL,
  `image1` varchar(255) DEFAULT NULL,
  `image2` varchar(255) DEFAULT NULL,
  `image3` varchar(255) DEFAULT NULL,
  `image4` varchar(255) DEFAULT NULL,
  `image5` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `colleges`
--

INSERT INTO `colleges` (`id`, `name`, `location`, `description1`, `description2`, `description3`, `image1`, `image2`, `image3`, `image4`, `image5`) VALUES
(1, 'College', 'Shag', 'Rhsfhbs', 'Arhfherghsafh', 'Aether', '1751858580_college1.jpg', '1751858580_college2.jpg', '1751858580_college3.jpg', '1751858580_college4.jpg', '1751858580_college5.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `colleges1`
--

CREATE TABLE `colleges1` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `state` varchar(100) NOT NULL,
  `image_url` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `colleges1`
--

INSERT INTO `colleges1` (`id`, `name`, `address`, `state`, `image_url`) VALUES
(1, 'Indian Institute of Technology Hyderabad', 'Kandi, Sangareddy, Telangana', 'Telangana', 'http://localhost/collegehunt/uploads/683942281763f6.26561808_image11.png'),
(2, 'International Institute of Information Technology Hyderabad', 'Gachibowli, Telangana', 'Telangana', 'http://localhost/collegehunt/uploads/img_683960eec1b1b7.43510677_image13.png'),
(3, 'Indian Institute of Technology Madras', 'Sardar Patel Road, Adyar, Chennai, Tamil Nadu', 'Tamil Nadu', 'uploads/683923914ec63_image40.png'),
(4, 'National Institute of Technology Tiruchirappalli', 'Tanjore Main Road, NH 67, Tiruchirappalli, Tamil Nadu', 'Tamil Nadu', 'uploads/683924015d25a_image41.png'),
(5, 'National Institute of Technology Karnataka', 'Surathkal, Karnataka', 'Karnataka', 'uploads/683824ebdec0d_image30.png'),
(6, 'Visvesvaraya Technological University', 'Belagavi, Karnataka', 'Karnataka', 'uploads/683825358442d_image31.png'),
(7, 'Indian Institute of Technology Tirupati', 'Tirupati, Andhra Pradesh', 'Andhra Pradesh', 'http://localhost/collegehunt/uploads/68381820e818f_image21.png'),
(8, 'Vignan Institute of Information Technology', 'Visakhapatnam, Andhra Pradesh', 'Andhra Pradesh', 'http://localhost/collegehunt/uploads/68392d61bd471_image23.png');

-- --------------------------------------------------------

--
-- Table structure for table `college_reviews`
--

CREATE TABLE `college_reviews` (
  `id` int(11) NOT NULL,
  `college_code` varchar(50) NOT NULL,
  `author` varchar(100) NOT NULL,
  `rating` int(11) NOT NULL CHECK (`rating` between 1 and 5),
  `comment` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `college_reviews`
--

INSERT INTO `college_reviews` (`id`, `college_code`, `author`, `rating`, `comment`, `created_at`) VALUES
(1, 'nitt', 'Anjali S.', 5, 'The faculty at this college truly sets it apart. Professors are knowledgeable and approachable.', '2025-07-23 05:57:30'),
(2, 'nitt', 'Rahul M.', 4, 'Placement support is great with mock interviews and top recruiters visiting.', '2025-07-23 05:57:30'),
(3, 'nitt', 'Divya K.', 5, 'The tech culture is amazing! Hackathons and peer groups are very motivating.', '2025-07-23 05:57:30'),
(4, 'nitt', 'Siddharth R.', 4, 'Labs are well-maintained with the latest equipment and long hours.', '2025-07-23 05:57:30'),
(5, 'nitt', 'Meghana T.', 5, 'Academic support includes mentoring, doubt clearing, and peer study groups.', '2025-07-23 05:57:30'),
(6, 'nitt', 'Karthik J.', 3, 'Curriculum is good but workload is a bit heavy during exams.', '2025-07-23 05:57:30'),
(7, 'iiith', 'Priya N.', 5, 'Cutting-edge research environment with top-notch labs and mentors.', '2025-07-23 05:57:30'),
(8, 'iiith', 'Ramesh D.', 4, 'Students are very smart and tech-savvy. Amazing peer learning experience.', '2025-07-23 05:57:30'),
(9, 'iiith', 'Shruti P.', 5, 'Infrastructure is impressive and startup culture is thriving.', '2025-07-23 05:57:30'),
(10, 'iitm', 'Vinay R.', 5, 'IITM provides outstanding academic exposure and entrepreneurial support.', '2025-07-23 05:57:30'),
(11, 'iitm', 'Sneha G.', 4, 'Campus life is balanced and vibrant with excellent hostel facilities.', '2025-07-23 05:57:30'),
(12, 'vignan', 'Tarun B.', 4, 'Good support for competitive exams and decent campus placements.', '2025-07-23 05:57:30'),
(13, 'vignan', 'Lakshmi P.', 5, 'Faculty is encouraging and helps with career guidance.', '2025-07-23 05:57:30');

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `duration` varchar(20) DEFAULT NULL,
  `eligibility` varchar(150) DEFAULT NULL,
  `fees` varchar(50) DEFAULT NULL,
  `screen` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`id`, `name`, `full_name`, `duration`, `eligibility`, `fees`, `screen`) VALUES
(1, 'B.Tech', 'Bachelor of Technology', '4 Years', '10+2 with PCM', '₹1,00,000/year', 'BTechCareer'),
(2, 'B.Sc', 'Bachelor of Science', '3 Years', '10+2 Science Stream', '₹60,000/year', 'BScCareer'),
(3, 'BCA', 'Bachelor of Computer Applications', '3 Years', '10+2 with Math/Computer', '₹70,000/year', 'BCACareer'),
(4, 'B.Com', 'Bachelor of Commerce', '3 Years', '10+2 in any stream', '₹50,000/year', 'BComCareer'),
(5, 'BBA', 'Bachelor of Business Administration', '3 Years', '10+2 in any stream', '₹65,000/year', 'BBACareer'),
(6, 'BA', 'Bachelor of Arts', '3 Years', '10+2 in any stream', '₹40,000/year', 'BACareer'),
(7, 'MBBS', 'Bachelor of Medicine and Bachelor of Surgery', '5.5 Years', '10+2 with PCB + NEET', '₹6–10 Lakhs/year', 'MBBSCareer'),
(8, 'B.Ed', 'Bachelor of Education', '2 Years', 'Graduation in any stream', '₹35,000/year', 'BEDCareer'),
(9, 'B.Des', 'Bachelor of Design', '4 Years', '10+2 in any stream + entrance', '₹1,50,000/year', 'BDesCareer'),
(10, 'B.Pharm', 'Bachelor of Pharmacy', '4 Years', '10+2 with PCB/PCM', '₹85,000/year', 'BPharmCareer');

-- --------------------------------------------------------

--
-- Table structure for table `courses1`
--

CREATE TABLE `courses1` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courses1`
--

INSERT INTO `courses1` (`id`, `name`) VALUES
(1, 'Bcom'),
(2, 'Bsc'),
(3, 'Bca');

-- --------------------------------------------------------

--
-- Table structure for table `iiit_hyderabad`
--

CREATE TABLE `iiit_hyderabad` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image_logo` varchar(255) NOT NULL,
  `image1` varchar(255) NOT NULL,
  `image2` varchar(255) NOT NULL,
  `image3` varchar(255) NOT NULL,
  `description1` text NOT NULL,
  `description2` text NOT NULL,
  `description3` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `iiit_hyderabad`
--

INSERT INTO `iiit_hyderabad` (`id`, `name`, `image_logo`, `image1`, `image2`, `image3`, `description1`, `description2`, `description3`) VALUES
(1, 'International Institute of Information Technology Hyderabad', 'img_683960eec1b1b7.43510677_image13.png', 'img_683965052f87b8.72435386_iit1.png', 'img_68396505362a12.75581458_iit2.png', 'img_6839650536b203.15259677_iit3.png', 'International Institute of Information Technology Hyderabad (IIITH) is a deemed university established as a non-profit public-private partnership. It was the first IIIT in India under this model. Founded in 1998 by the Government of Andhra Pradesh and NASSCOM, it was initially known as the Indian Institute of Information Technology Hyderabad and later became a deemed university in 2001. Ajay Prakash Sawhney conceptualized the institute, and Rajeev Sangal was its first director. The Silver Jubilee was celebrated in 2023 with events recognizing key contributors including former CM N. Chandrababu Naidu.', 'IIITH offers undergraduate admissions through five modes:\n• JEE Main – the national entrance exam.\n• UGEE – IIITH’s own entrance test and interview.\n• Olympiad – for international Olympiad participants.\n• DASA – for NRIs and foreign nationals.\n• LEEE – lateral entry for dual-degree programs.\n\nPostgraduate admissions are via PGEE or MSIT-specific exams held annually.', 'IIIT Hyderabad offers multiple admission channels for undergraduate and postgraduate programs. These include national-level exams and institute-specific processes. Undergraduate Admissions: • UGEE / SPEC / Olympiad / DASA / JEE (Main) Postgraduate Admissions: • PGEE (for MS, MTech, PhD) • GATE (some MTech programs) • Interviews and written tests for research programs Selection involves coding assessments, written tests, and/or interviews depending on the channel. 📍 Address: Indian Institute of Technology Hyderabad (IITH), Kandi, Sangareddy, Telangana – 502285, India 📞 Phone: +91 40 2301 6033 ✉️ Email: office.acad@iith.ac.in\r\n');

-- --------------------------------------------------------

--
-- Table structure for table `iit_hyderabad`
--

CREATE TABLE `iit_hyderabad` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image_logo` varchar(255) NOT NULL,
  `image1` varchar(255) NOT NULL,
  `description1` text NOT NULL,
  `image2` varchar(255) NOT NULL,
  `description2` text NOT NULL,
  `image3` varchar(255) NOT NULL,
  `description3` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `iit_hyderabad`
--

INSERT INTO `iit_hyderabad` (`id`, `name`, `image_logo`, `image1`, `description1`, `image2`, `description2`, `image3`, `description3`) VALUES
(1, 'Indian Institute of Technology Hyderabad', '683822b714573_image11.png', 'img_68395e0496b133.70850277_it.png', 'Indian Institute of Technology Hyderabad (IITH), established in 2008, is one of the premier engineering institutions in India. Located in Kandi, Telangana, the institute has rapidly grown into a hub of academic excellence, research innovation, and entrepreneurial spirit. The campus is spread over 576 acres and offers a serene environment for learning and exploration.', 'img_68395e04972ef4.95609126_it01.png', 'IITH emphasizes interdisciplinary learning, strong research culture, and innovation. It is known for its state-of-the-art laboratories in fields like Artificial Intelligence, Nanotechnology, 5G Communication, and Biomedical Engineering. The faculty includes experts from IITs and top global universities. IITH has over 100 active MoUs with foreign institutions, promoting global exposure and collaborative research.', 'img_68395e04979ad6.06629137_it02.png', 'Admissions to undergraduate programs at IITH are through the JEE Advanced exam. For M.Tech and PhD programs, candidates must qualify through GATE and written interviews respectively. IITH supports students with generous scholarships, on-campus hostels, and vibrant student clubs. Its strong placement record and startup ecosystem make it a top choice among engineering aspirants in India.');

-- --------------------------------------------------------

--
-- Table structure for table `iit_madras`
--

CREATE TABLE `iit_madras` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image_logo` varchar(255) NOT NULL,
  `image1` varchar(255) NOT NULL,
  `description1` text NOT NULL,
  `image2` varchar(255) NOT NULL,
  `description2` text NOT NULL,
  `image3` varchar(255) NOT NULL,
  `description3` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `iit_madras`
--

INSERT INTO `iit_madras` (`id`, `name`, `image_logo`, `image1`, `description1`, `image2`, `description2`, `image3`, `description3`) VALUES
(1, 'Indian Institute of Technology Madras', '683923914ec63_image40.png', 'im1.png', 'The Indian Institute of Technology Madras (IIT Madras or IITM) is a public technical university located in Chennai, Tamil Nadu, India. It is one of the eight public Institutes of Eminence in India. Recognized as an Institute of National Importance.\n\nIIT Madras was founded in 1959 with technical, academic, and financial assistance from the government of West Germany. It was the third Indian Institute of Technology established by the Government of India.\n\nSince the inception of the National Institutional Ranking Framework by the Ministry of Education in 2016, IIT Madras has consistently ranked as the best engineering institute in India.', 'im2.png', 'Academics at IIT Madras\n\nIIT Madras offers undergraduate, postgraduate, and research degrees across 18 disciplines in Engineering, Science, Humanities, and Management.\n\nThe institute hosts around 600 faculty members engaged in teaching, research, and consultancy. The academic framework includes 18 departments and nearly 100 laboratories.\n\nAll instruction is conducted in English. Evaluation is continuous. Research is assessed through peer-reviewed thesis evaluation. Academic policies are set by the Senate.', 'ni3.png', '📍 Address:\r\nIndian Institute of Technology Madras\r\nSardar Patel Road, Adyar\r\nChennai – 600036, Tamil Nadu, India\r\n\r\nofficial_link = \'https://www.iitm.ac.in\'\r\n\r\n📞 Undergrad Admissions:\r\n+91 44 2257 8220\r\n✉️ ugadmissions@iitm.ac.in\r\n\r\n📞 PG Admissions (MTech/MA):\r\n+91 44 2257 8200 (GATE/JAM office)\r\n✉️ mtechadm@iitm.ac.in\r\n\r\n📞 General / Registrar’s Office:\r\n+91 44 2257 8100\r\n✉️ registrar@iitm.ac.in\r\n\r\n🕒 Admission Office Hours: Mon–Fri, 10:00 AM–1:00 PM & 2:00 PM–5:30 PM');

-- --------------------------------------------------------

--
-- Table structure for table `iit_tirupati`
--

CREATE TABLE `iit_tirupati` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image_logo` varchar(255) DEFAULT NULL,
  `image1` varchar(255) DEFAULT NULL,
  `image2` varchar(255) DEFAULT NULL,
  `image3` varchar(255) DEFAULT NULL,
  `description1` text DEFAULT NULL,
  `description2` text DEFAULT NULL,
  `description3` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `iit_tirupati`
--

INSERT INTO `iit_tirupati` (`id`, `name`, `image_logo`, `image1`, `image2`, `image3`, `description1`, `description2`, `description3`) VALUES
(1, 'Indian Institute of Technology Tirupati', '68393b033dbcd_image21.png', '68393b67ec442_it1.png', '68393b67ed732_it2.png', '6839409f07f9f_it02.png', 'Indian Institute of Technology Tirupati (IIT Tirupati) is a premier technical institute established in 2015 under the mentorship of IIT Madras. Located in the serene temple town of Tirupati, Andhra Pradesh, it offers students a peaceful, focused academic environment. As one of the fast-growing new IITs, it is known for discipline, innovation, and a strong academic culture.', 'The campus features state-of-the-art classrooms, 24/7 Wi-Fi, computer and research labs, a central library, and well-maintained hostels. Hostel rooms are generally well-ventilated and furnished, with hygienic food options in the mess (veg and non-veg). The campus encourages holistic development with access to gym, sports grounds, and student clubs like coding, dance, music, robotics, and literature.', 'IIT Tirupati admits students to its undergraduate programs through JEE Advanced and to postgraduate programs through national-level exams like GATE, JAM, and CAT.\r\n\r\nUndergraduate Admissions:\r\n• JEE Advanced (for BTech)\r\n\r\nPostgraduate Admissions:\r\n• GATE (for MTech)\r\n• JAM (for MSc)\r\n• CAT (for MBA)\r\n\r\nDoctoral programs require GATE/NET qualifications and interviews conducted by the institute.\r\n\r\n📍 Address: Indian Institute of Technology Tirupati (IIT Tirupati)\r\nYerpedu-Venkatagiri Road, Yerpedu Post, Tirupati District – 517619, Andhra Pradesh, India\r\n\r\n📞 Phone: +91 877 250 0331\r\n✉️ Email: office_academics@iittp.ac.in\r\n\r\nFor more details, please contact the admissions office via phone or email.');

-- --------------------------------------------------------

--
-- Table structure for table `ka`
--

CREATE TABLE `ka` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `state` varchar(100) DEFAULT 'Karnataka',
  `image_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ka`
--

INSERT INTO `ka` (`id`, `name`, `address`, `state`, `image_url`) VALUES
(1, 'National Institute of Technology Karnataka', 'Surathkal, Karnataka', 'Karnataka', 'http://localhost/collegehunt/uploads/683824ebdec0d_image30.png'),
(2, 'Visvesvaraya Technological University', 'Belagavi, Karnataka', 'Karnataka', 'http://localhost/collegehunt/uploads/683825358442d_image31.png');

-- --------------------------------------------------------

--
-- Table structure for table `locations1`
--

CREATE TABLE `locations1` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `locations1`
--

INSERT INTO `locations1` (`id`, `name`) VALUES
(1, 'Ap'),
(2, 'Tn');

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`id`, `email`, `password`) VALUES
(1, 'user@example.com', '123'),
(2, 'a@gmail.com', '007'),
(3, 'ali@gmail.com', '1'),
(4, 'ali123@gmail.com', 'ali'),
(5, 'hey@g.c', 'hey');

-- --------------------------------------------------------

--
-- Table structure for table `ma`
--

CREATE TABLE `ma` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `state` varchar(50) NOT NULL,
  `image_url` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ma`
--

INSERT INTO `ma` (`id`, `name`, `address`, `state`, `image_url`) VALUES
(1, 'Institute of Chemical Technology (ICT)', 'Maharashtra', 'ma', 'http://172.23.52.145/collegehunt/uploads/68392512334a7_image27.png'),
(2, 'Datta Meghe Institute of Higher Education', 'Maharashtra', 'ma', 'http://172.23.52.145/collegehunt/uploads/683925508a962_image28.png');

-- --------------------------------------------------------

--
-- Table structure for table `mbbs_opportunities`
--

CREATE TABLE `mbbs_opportunities` (
  `id` int(11) NOT NULL,
  `opportunity` varchar(255) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mbbs_opportunities`
--

INSERT INTO `mbbs_opportunities` (`id`, `opportunity`, `description`) VALUES
(1, 'General Physician', 'Provide primary healthcare services and treat common illnesses.'),
(2, 'Surgeon', 'Perform surgical procedures in hospitals and clinics.'),
(3, 'Pediatrician', 'Specialize in the medical care of infants and children.'),
(4, 'Gynecologist', 'Provide healthcare services related to women\'s reproductive systems.'),
(5, 'Dermatologist', 'Diagnose and treat skin-related issues and diseases.'),
(6, 'Psychiatrist', 'Treat mental health disorders through therapy and medication.'),
(7, 'Medical Researcher', 'Conduct research in medical labs to improve treatments.'),
(8, 'Hospital Administrator', 'Manage hospital operations and ensure efficient care.'),
(9, 'Forensic Medical Examiner', 'Assist in legal investigations through medical examination.'),
(10, 'Medical Professor', 'Teach and train future doctors in medical colleges.');

-- --------------------------------------------------------

--
-- Table structure for table `nitk_college`
--

CREATE TABLE `nitk_college` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image_logo` varchar(255) NOT NULL,
  `image1` varchar(255) NOT NULL,
  `image2` varchar(255) NOT NULL,
  `image3` varchar(255) NOT NULL,
  `description1` text NOT NULL,
  `description2` text NOT NULL,
  `description3` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nitk_college`
--

INSERT INTO `nitk_college` (`id`, `name`, `image_logo`, `image1`, `image2`, `image3`, `description1`, `description2`, `description3`) VALUES
(1, 'National Institute of Technology Karnataka', '683824ebdec0d_image30.png', '683930bfeb93e_vu2.png', 'img_68395e04972ef4.95609126_it01.png', '6839409f07f9f_it02.png', 'National Institute of Technology Karnataka (NITK), formerly known as Karnataka Regional Engineering College (KREC), is a public technical university located in Surathkal, Mangaluru.\nEstablished in 1960, NITK is one of the 31 National Institutes of Technology in India and is recognized as an Institute of National Importance by the Government of India.\nThe campus is situated near the Arabian Sea and is well-connected by National Highway 66, which provides easy access to the university.', 'Karnataka Regional Engineering College (KREC), founded in 1960 at Surathkal, Mangaluru, marked the beginning of higher technical education in the region. The establishment of the college was led by U. Srinivas Mallya and V. S. Kudva, and the area now named Srinivasnagar honors their efforts.\nIn 1980, KREC became affiliated with Mangalore University, and the duration of undergraduate courses was reduced from five years to four. In 2002, the college was elevated to the status of a National Institute of Technology, thereby becoming NIT Karnataka (NITK).\nThis recognition allowed the institution to become a Deemed University, further cementing its role as a leader in technical education in India.', 'The campus of NIT Karnataka (NITK) spans 295.35 acres and is located along National Highway 66, near the Arabian Sea in Surathkal, Mangaluru.\nThis picturesque campus features a private beach with a lighthouse, enhancing the serene environment for students.\nThe campus includes over 200 residences such as independent houses and flats.\nEssential services are available within the campus, including a Cooperative Society, branches of both State Bank of India and Canara Bank with ATM facilities, and a Central Library with a floor area of 2,758 m².\n📍 Address: National Institute of Technology Karnataka (NITK), NH 66, Srinivasnagar, Surathkal, Mangalore – 575025, Karnataka, India\n📞 Phone: +91 824 2474000\n✉️ Email: registrar@nitk.edu.in\n\nFor more details, please contact the admissions office via phone or email.');

-- --------------------------------------------------------

--
-- Table structure for table `nitt`
--

CREATE TABLE `nitt` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image_logo` varchar(255) NOT NULL,
  `image1` varchar(255) NOT NULL,
  `image2` varchar(255) NOT NULL,
  `image3` varchar(255) NOT NULL,
  `description1` text NOT NULL,
  `description2` text NOT NULL,
  `description3` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nitt`
--

INSERT INTO `nitt` (`id`, `name`, `image_logo`, `image1`, `image2`, `image3`, `description1`, `description2`, `description3`) VALUES
(1, 'National Institute of Technology Tiruchirappalli', 'image41.png', 'ni1.png', 'ni2.png', 'ni3.png', 'The National Institute of Technology Tiruchirappalli (NIT Trichy) is a national research deemed university near Tiruchirappalli, Tamil Nadu, India. It was established in 1964 as the Regional Engineering College Tiruchirappalli by the governments of India and Tamil Nadu under the affiliation of the University of Madras. In 2003, it was granted deemed university status with the approval of the UGC, AICTE, and the Government of India. NIT Trichy is recognized as an Institute of National Importance under the NITSER Act, 2007.', 'The institute is funded by the Ministry of Education (MoE), Government of India, and focuses on engineering, management, science, technology, and architecture. It offers 10 bachelor\'s, 42 master\'s, and 17 doctoral programs through its 17 academic departments and awards more than 2,000 degrees annually. Ranked as the top NIT in India for nine consecutive years (2016 to 2024) by NIRF.', 'NIT Trichy admits students to its undergraduate, postgraduate, and doctoral programs based on national-level entrance exams.\n\nUndergraduate Admissions:\n• JEE Main (for BTech programs)\n\nPostgraduate Admissions:\n• GATE (for MTech, MS)\n• JAM (for MSc)\n• CAT (for MBA through DoMS)\n\nDoctoral programs require GATE/NET qualifications and follow institute-conducted interviews.\n\n📍 Address: National Institute of Technology, Tiruchirappalli (NIT Trichy)\nTanjore Main Road, National Highway 83, Tiruchirappalli – 620015, Tamil Nadu, India\n\n📞 Phone: +91 431 250 3000\n✉️ Email: ugsection@nitt.edu | pgsection@nitt.edu\n\nFor more details, please contact the admissions office via phone or email.');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `author` varchar(100) NOT NULL,
  `rating` int(11) DEFAULT NULL CHECK (`rating` between 1 and 5),
  `comment` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`id`, `author`, `rating`, `comment`, `created_at`) VALUES
(1, 'Anjali', 5, 'Excellent faculty and infrastructure.', '2025-07-23 04:12:32'),
(2, 'Ravi', 4, 'Good placements and research facilities.', '2025-07-23 04:12:32'),
(3, 'Priya', 3, 'Campus is big, but hostel food could be better.', '2025-07-23 04:12:32'),
(4, 'Karthik', 2, 'Too much pressure during exams.', '2025-07-23 04:12:32'),
(5, 'Meena', 1, 'Needs improvement in administration.', '2025-07-23 04:12:32'),
(6, 'Harsha', 5, 'Amazing exposure to projects and hackathons.', '2025-07-23 04:12:32'),
(7, 'Divya', 4, 'Clubs are very active and helpful for personal growth.', '2025-07-23 04:12:32'),
(8, 'Suresh', 5, 'I loved the cultural events and tech fests!', '2025-07-23 04:12:32'),
(9, 'Sneha', 4, 'Internship opportunities are quite strong.', '2025-07-23 04:12:32'),
(10, 'Manoj', 5, 'Clean campus and responsive faculty members.', '2025-07-23 04:12:32');

-- --------------------------------------------------------

--
-- Table structure for table `telangana_colleges`
--

CREATE TABLE `telangana_colleges` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `image_url` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `telangana_colleges`
--

INSERT INTO `telangana_colleges` (`id`, `name`, `address`, `state`, `image_url`) VALUES
(1, 'Indian Institute of Technology Hyderabad', 'Kandi, Sangareddy, Telangana', 'Telangana', 'http://localhost/collegehunt/uploads/683942281763f6.26561808_image11.png'),
(2, 'International Institute of Information Technology Hyderabad', 'Gachibowli, Telangana', 'Telangana', 'http://localhost/collegehunt/uploads/img_683960eec1b1b7.43510677_image13.png');

-- --------------------------------------------------------

--
-- Table structure for table `tn_colleges`
--

CREATE TABLE `tn_colleges` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `state` varchar(100) DEFAULT 'Tamil Nadu',
  `image_url` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tn_colleges`
--

INSERT INTO `tn_colleges` (`id`, `name`, `address`, `state`, `image_url`) VALUES
(1, 'Indian Institute of Technology Madras', 'Sardar Patel Road, Adyar, Chennai, Tamil Nadu', 'Tamil Nadu', 'http://localhost/collegehunt/uploads/683923914ec63_image40.png'),
(2, 'National Institute of Technology Tiruchirappalli', 'Tanjore Main Road, NH 67, Tiruchirappalli, Tamil Nadu', 'Tamil Nadu', 'http://localhost/collegehunt/uploads/683924015d25a_image41.png');

-- --------------------------------------------------------

--
-- Table structure for table `ts_colleges`
--

CREATE TABLE `ts_colleges` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `image_url` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ts_colleges`
--

INSERT INTO `ts_colleges` (`id`, `name`, `address`, `state`, `image_url`) VALUES
(1, 'Indian Institute of Technology Hyderabad', 'Kandi, Sangareddy, Telangana', 'Telangana', 'http://localhost/collegehunt/uploads/683942281763f6.26561808_image11.png'),
(2, 'International Institute of Information Technology Hyderabad', 'Gachibowli, Telangana', 'Telangana', 'http://localhost/collegehunt/uploads/img_683960eec1b1b7.43510677_image13.png');

-- --------------------------------------------------------

--
-- Table structure for table `vignan`
--

CREATE TABLE `vignan` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `imageLogo` varchar(255) DEFAULT NULL,
  `image1` varchar(255) DEFAULT NULL,
  `image2` varchar(255) DEFAULT NULL,
  `image3` varchar(255) DEFAULT NULL,
  `description1` text DEFAULT NULL,
  `description2` text DEFAULT NULL,
  `description3` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vignan`
--

INSERT INTO `vignan` (`id`, `name`, `imageLogo`, `image1`, `image2`, `image3`, `description1`, `description2`, `description3`) VALUES
(1, 'Vignan Institute of Information Technology', 'http://localhost/collegehunt/uploads/68392d61bd471_image23.png', 'vu1.png', 'vu2.png', 'vu3.png', 'Vignan Institute of Information Technology, located in Visakhapatnam, Andhra Pradesh, is a reputed engineering college offering quality education and modern infrastructure. The institution focuses on nurturing technical skills and leadership qualities in students. It maintains a strong academic culture and personalized mentorship.', 'The campus includes smart classrooms, department-specific labs, high-speed Wi-Fi, hostels with Wi-Fi, a well-stocked library, and both indoor/outdoor sports facilities. Students engage in technical fests, coding contests, hackathons, robotics, and cultural clubs. The annual college fest is a big highlight with celebrity events and competitions.', 'Vignan’s Foundation for Science, Technology & Research (VFSTR) conducts its own entrance exam and also accepts other national-level scores for admissions.\n\nUndergraduate Admissions:\n• VSAT (Vignan’s Scholastic Aptitude Test)\n• Also accepts JEE Main / EAMCET (for BTech programs)\n\nPostgraduate Admissions:\n• GATE / PGECET (for MTech)\n• ICET (for MBA and MCA)\n\nThe university also provides lateral entry programs and scholarships based on merit and entrance performance.\n\n📍 Address: Vignan’s Foundation for Science, Technology & Research (Deemed to be University)\nVadlamudi, Guntur – 522213, Andhra Pradesh, India\n\n📞 Phone: +91 863 234 4777 / 78\n✉️ Email: admissions@vignan.ac.in\n\nFor more details, please contact the admissions office via phone or email.');

-- --------------------------------------------------------

--
-- Table structure for table `vtu_college`
--

CREATE TABLE `vtu_college` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image_logo` varchar(255) NOT NULL,
  `image1` varchar(255) NOT NULL,
  `description1` text NOT NULL,
  `image2` varchar(255) NOT NULL,
  `description2` text NOT NULL,
  `image3` varchar(255) NOT NULL,
  `description3` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vtu_college`
--

INSERT INTO `vtu_college` (`id`, `name`, `image_logo`, `image1`, `description1`, `image2`, `description2`, `image3`, `description3`) VALUES
(1, 'Visvesvaraya Technological University', '683825358442d_image31.png', '683930bfeb1f2_vu1.png', 'Visvesvaraya Technological University (VTU), established in 1998 by the Government of Karnataka, is one of the largest technical universities in India. The university is named after Sir M. Visvesvaraya, a prominent Indian civil engineer and statesman. VTU was created to address the growing demand for skilled technical professionals by providing a comprehensive education in engineering, technology, and allied sciences. With its headquarters in Belagavi, VTU was designed to unify various engineering colleges under one umbrella, harmonizing syllabi, administrative procedures, and traditions. VTU has since become a significant player in Indian technical education landscape, offering a wide range of undergraduate, postgraduate, and doctoral programs.', '683930bfec1f1_vu3.png', 'Visvesvaraya Technological University (VTU) is situated in Belagavi, Karnataka, with its main administrative center, \"Jnana Sangama\" (meaning \"The Confluence of Knowledge\"). This campus provides state-of-the-art infrastructure, including well-equipped laboratories, research facilities, and classrooms designed to foster academic and technical learning. In addition, VTU is establishing the Visvesvaraya Institute of Advanced Technology (VIAT) near Bangalore, aimed at advancing research and technology initiatives.', '683930bfeb93e_vu2.png', 'Visvesvaraya Technological University (VTU) governs the admission process for over 200 affiliated engineering colleges across Karnataka.\n\nUndergraduate Admissions:\n• Karnataka Common Entrance Test (KCET)\n• COMEDK (for private institutions under VTU)\n• Management quota (for select private colleges)\n\nPostgraduate Admissions:\n• GATE / Karnataka PGCET (for MTech, MBA, MCA)\n\nEligibility and admission cutoffs vary by affiliated college and course. Students should consult specific institution websites for precise details.\n\n📍 Address: Visvesvaraya Technological University (VTU)  \nJnana Sangama, Belagavi – 590018, Karnataka, India\n\n📞 Phone: +91 831 249 8100  \n✉️ Email: registrar@vtu.ac.in\n\nFor more details, please contact the admissions office via phone or email.');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `ap`
--
ALTER TABLE `ap`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ba_opportunities`
--
ALTER TABLE `ba_opportunities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bba_opportunities`
--
ALTER TABLE `bba_opportunities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bca_opportunities`
--
ALTER TABLE `bca_opportunities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bcom_opportunities`
--
ALTER TABLE `bcom_opportunities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bdes_opportunities`
--
ALTER TABLE `bdes_opportunities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bed_opportunities`
--
ALTER TABLE `bed_opportunities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bpharm_opportunities`
--
ALTER TABLE `bpharm_opportunities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bsc_opportunities`
--
ALTER TABLE `bsc_opportunities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `btech_opportunities`
--
ALTER TABLE `btech_opportunities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `colleges`
--
ALTER TABLE `colleges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `colleges1`
--
ALTER TABLE `colleges1`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `college_reviews`
--
ALTER TABLE `college_reviews`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `courses1`
--
ALTER TABLE `courses1`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `iiit_hyderabad`
--
ALTER TABLE `iiit_hyderabad`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `iit_hyderabad`
--
ALTER TABLE `iit_hyderabad`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `iit_madras`
--
ALTER TABLE `iit_madras`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `iit_tirupati`
--
ALTER TABLE `iit_tirupati`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ka`
--
ALTER TABLE `ka`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `locations1`
--
ALTER TABLE `locations1`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `ma`
--
ALTER TABLE `ma`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mbbs_opportunities`
--
ALTER TABLE `mbbs_opportunities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `nitk_college`
--
ALTER TABLE `nitk_college`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `nitt`
--
ALTER TABLE `nitt`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `telangana_colleges`
--
ALTER TABLE `telangana_colleges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tn_colleges`
--
ALTER TABLE `tn_colleges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ts_colleges`
--
ALTER TABLE `ts_colleges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vignan`
--
ALTER TABLE `vignan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vtu_college`
--
ALTER TABLE `vtu_college`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ap`
--
ALTER TABLE `ap`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `ba_opportunities`
--
ALTER TABLE `ba_opportunities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `bba_opportunities`
--
ALTER TABLE `bba_opportunities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `bcom_opportunities`
--
ALTER TABLE `bcom_opportunities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `bdes_opportunities`
--
ALTER TABLE `bdes_opportunities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `bed_opportunities`
--
ALTER TABLE `bed_opportunities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `bpharm_opportunities`
--
ALTER TABLE `bpharm_opportunities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `bsc_opportunities`
--
ALTER TABLE `bsc_opportunities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `btech_opportunities`
--
ALTER TABLE `btech_opportunities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `colleges`
--
ALTER TABLE `colleges`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `colleges1`
--
ALTER TABLE `colleges1`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `college_reviews`
--
ALTER TABLE `college_reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `courses1`
--
ALTER TABLE `courses1`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `iiit_hyderabad`
--
ALTER TABLE `iiit_hyderabad`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `iit_hyderabad`
--
ALTER TABLE `iit_hyderabad`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `iit_madras`
--
ALTER TABLE `iit_madras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `iit_tirupati`
--
ALTER TABLE `iit_tirupati`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ka`
--
ALTER TABLE `ka`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `locations1`
--
ALTER TABLE `locations1`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `login`
--
ALTER TABLE `login`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `ma`
--
ALTER TABLE `ma`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `mbbs_opportunities`
--
ALTER TABLE `mbbs_opportunities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `nitk_college`
--
ALTER TABLE `nitk_college`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `nitt`
--
ALTER TABLE `nitt`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `tn_colleges`
--
ALTER TABLE `tn_colleges`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `vignan`
--
ALTER TABLE `vignan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `vtu_college`
--
ALTER TABLE `vtu_college`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
