-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 24, 2025 at 04:49 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 7.3.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `simkos`
--

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `id_booking` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_kamar` int(11) NOT NULL,
  `tanggal_masuk` date NOT NULL,
  `hitungan_sewa` int(11) NOT NULL,
  `durasi_sewa` int(11) NOT NULL,
  `tanggal_keluar` date NOT NULL,
  `jumlah_kamar` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`id_booking`, `id_user`, `id_kamar`, `tanggal_masuk`, `hitungan_sewa`, `durasi_sewa`, `tanggal_keluar`, `jumlah_kamar`) VALUES
(1, 25, 1, '2025-01-09', 4, 1, '2026-01-09', 1),
(2, 32, 3, '2003-12-12', 3, 1, '2004-01-12', 1),
(3, 25, 1, '2004-09-09', 4, 1, '2005-09-09', 1),
(4, 25, 1, '1970-01-01', 3, 8, '1970-09-01', 1),
(5, 25, 1, '1970-01-01', 3, 3, '1970-04-01', 1),
(6, 25, 1, '2004-09-09', 4, 1, '2005-09-09', 1),
(7, 25, 1, '2002-01-01', 3, 12, '2003-01-01', 1),
(8, 25, 1, '2025-05-24', 4, 1, '2026-05-24', 1);

--
-- Triggers `booking`
--
DELIMITER $$
CREATE TRIGGER `update_kamar` AFTER INSERT ON `booking` FOR EACH ROW BEGIN
	UPDATE kamar SET jumlah_kamar=jumlah_kamar-NEW.jumlah_kamar
    WHERE id_kamar=NEW.id_kamar;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `kamar`
--

CREATE TABLE `kamar` (
  `id_kamar` int(11) NOT NULL,
  `id_kost` int(11) NOT NULL,
  `jumlah_kamar` int(11) NOT NULL,
  `panjang_kamar` int(11) NOT NULL,
  `lebar_kamar` int(11) NOT NULL,
  `tipe_kamar` varchar(255) NOT NULL,
  `biaya_fasilitas` int(11) NOT NULL,
  `fasilitas_kamar` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `kamar`
--

INSERT INTO `kamar` (`id_kamar`, `id_kost`, `jumlah_kamar`, `panjang_kamar`, `lebar_kamar`, `tipe_kamar`, `biaya_fasilitas`, `fasilitas_kamar`) VALUES
(1, 4, 5, 4, 4, 'kamar mandi dalam', 100000, 'Tempat Tidur, TV, Kulkas'),
(2, 4, 0, 3, 3, 'kamar mandi luar', 50000, 'Tempat Tidur, Lemari, Kipas Angin'),
(3, 4, 3, 5, 3, 'kamar mandi luar', 231, 'Lemari, TV'),
(4, 10, 0, 0, 0, 'kamar mandi dalam', 0, ''),
(5, 11, 0, 0, 0, 'kamar mandi dalam', 0, ''),
(6, 8, 5, 10, 10, 'kamar mandi dalam', 50000, 'AC, Tempat Tidur, Kulkas');

--
-- Triggers `kamar`
--
DELIMITER $$
CREATE TRIGGER `after_update` AFTER UPDATE ON `kamar` FOR EACH ROW BEGIN
	UPDATE kost SET jumlah_kamar=jumlah_kamar-1
	WHERE id_kost=NEW.id_kost;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `hapus_kamar` AFTER DELETE ON `kamar` FOR EACH ROW UPDATE kost SET kost.jumlah_kamar = kost.jumlah_kamar-old.jumlah_kamar
WHERE kost.id_kost=old.id_kost
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `total_kamar` AFTER INSERT ON `kamar` FOR EACH ROW BEGIN
	UPDATE kost SET jumlah_kamar=jumlah_kamar+NEW.jumlah_kamar
	WHERE id_kost=NEW.id_kost;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `kost`
--

CREATE TABLE `kost` (
  `id_kost` int(11) NOT NULL,
  `nama_kost` varchar(255) NOT NULL,
  `tipe_kost` varchar(255) NOT NULL,
  `jenis_kost` varchar(255) NOT NULL,
  `jumlah_kamar` int(11) NOT NULL,
  `tanggal_tagih` date NOT NULL,
  `nama_pemilik` text NOT NULL,
  `nama_bank` text NOT NULL,
  `no_rekening` int(11) NOT NULL,
  `foto_bangunan_utama` varchar(255) NOT NULL,
  `foto_kamar` varchar(255) NOT NULL,
  `foto_kamar_mandi` varchar(255) NOT NULL,
  `foto_interior` varchar(255) NOT NULL,
  `provinsi` varchar(25) NOT NULL,
  `kota` varchar(25) NOT NULL,
  `kecamatan` varchar(25) NOT NULL,
  `kelurahan` varchar(25) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `harga_sewa` int(11) NOT NULL,
  `kontak` varchar(255) NOT NULL,
  `deskripsi` text NOT NULL,
  `id_pemilik` int(11) NOT NULL,
  `fasilitas_kost` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `kost`
--

INSERT INTO `kost` (`id_kost`, `nama_kost`, `tipe_kost`, `jenis_kost`, `jumlah_kamar`, `tanggal_tagih`, `nama_pemilik`, `nama_bank`, `no_rekening`, `foto_bangunan_utama`, `foto_kamar`, `foto_kamar_mandi`, `foto_interior`, `provinsi`, `kota`, `kecamatan`, `kelurahan`, `alamat`, `harga_sewa`, `kontak`, `deskripsi`, `id_pemilik`, `fasilitas_kost`) VALUES
(4, 'Kost Rangga', 'Tahun', 'Putra', 8, '2020-03-13', 'Kost Rangga', 'Mandiri', 812345678, 'foto bangunan utama kost.webp', 'foto bangunan utama kost.webp', 'kamar mandi.jpg', 'foto kamar kost.jpg', 'Lampung', 'Balam', 'Sukarame', 'ugu', 'Jl Sukarame', 4500000, '0825353525', 'Kost Muslim anak uin, memiliki fasilitas terbaik , Dekat kampus ', 22, 'Parkir Mobil, WIFI/Internet, Security, Ruang Tamu'),
(8, 'Kost Putri', 'Tahun', 'Putri', 5, '2025-06-27', 'Bapak sudirman said', 'BCA', 2147483647, 'Gambar WhatsApp 2025-05-23 pukul 21.51.14_001a807c.jpg', 'Gambar WhatsApp 2025-05-23 pukul 21.51.14_597124b3.jpg', 'foto kamar mandi.jpeg', 'Gambar WhatsApp 2025-05-23 pukul 21.51.14_4a2429c8.jpg', 'Lampung', 'Balam', 'kedaton', 'kedaton', 'Jl Pandawa', 10000000, '0898989898', 'Kost nyaman mantap minimalis', 26, ''),
(9, 'Kost Kausar', 'Bulan', 'Putra', 0, '2025-05-22', 'Kausar', 'Mandiri', 923334124, 'foto bangunannn.jpg', 'foto bangunannn.jpg', 'foto kamar mandi.jpg', 'foto kamarjajaj.webp', 'Lampung', 'Balam', 'Sukarame', 'Sukarame', 'Jl. Sukarame', 350000, '0823423242', 'Kost nyaman', 31, '');

-- --------------------------------------------------------

--
-- Table structure for table `rating`
--

CREATE TABLE `rating` (
  `id_rating` int(11) NOT NULL,
  `Id_kost` int(11) NOT NULL,
  `Id_user` int(11) NOT NULL,
  `score` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles_user`
--

CREATE TABLE `roles_user` (
  `id_roles` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `roles_user`
--

INSERT INTO `roles_user` (`id_roles`, `nama`) VALUES
(1, 'penghuni kost'),
(2, 'pemilik kost'),
(3, 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `tagihan`
--

CREATE TABLE `tagihan` (
  `no_tagihan` int(11) NOT NULL,
  `no_booking` int(11) NOT NULL,
  `total_tagihan` int(11) NOT NULL,
  `stats` int(11) NOT NULL,
  `tanggal_tagihan` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `bukti_bayar` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tagihan`
--

INSERT INTO `tagihan` (`no_tagihan`, `no_booking`, `total_tagihan`, `stats`, `tanggal_tagihan`, `bukti_bayar`) VALUES
(1, 1, 5700000, 1, '2025-04-29 18:11:12', 'Screenshot 2025-04-28 010507.jpg'),
(2, 2, 375231, 1, '2025-04-27 19:02:58', 'TUGSA UTS.jpg'),
(3, 3, 5700000, 3, '2025-05-04 13:48:18', ''),
(4, 4, 3800000, 3, '2025-05-04 13:49:45', ''),
(5, 5, 1425000, 3, '2025-05-04 13:51:34', ''),
(6, 6, 5700000, 3, '2025-05-04 14:31:32', ''),
(7, 7, 5700000, 2, '2025-05-04 15:52:05', 'Screenshot 2025-05-03 204514.jpg'),
(8, 8, 5700000, 1, '2025-05-24 02:02:01', 'Kost hub.png');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `nama_lengkap` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `no_hp` varchar(255) NOT NULL,
  `pekerjaan` varchar(255) NOT NULL,
  `jenis_kelamin` varchar(25) NOT NULL,
  `foto_ktp` varchar(255) NOT NULL,
  `foto_profil` text NOT NULL,
  `roles` int(11) NOT NULL,
  `id_kost_saya` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `nama_lengkap`, `email`, `username`, `password`, `no_hp`, `pekerjaan`, `jenis_kelamin`, `foto_ktp`, `foto_profil`, `roles`, `id_kost_saya`) VALUES
(22, 'Rangga Trio', 'rangga@gmail.com', 'Rangga', '1234', '082147483647', 'Rangga Kost', '            laki-laki', '', 'fotoprofil.webp', 2, 0),
(25, 'user', 'user.com', 'user', 'user', '0812345678', 'Mahasiswa', '          laki-laki', 'Gambar_WhatsApp_2025-05-05_pukul_01.04.04_351819f5-removebg-preview.png', 'ada.PNG', 1, 0),
(26, 'Putri', 'Putri@mail.com', 'Putri', '1234', '08123456789', 'ibu kost', '       Perempuan', 'ele.jpg', 'fotoputri.webp', 2, 0),
(30, 'admin', '', 'admin', 'admin', '0', '', '', '', '', 3, 0),
(31, 'Kausar', 'kausar@mail.com', 'Kausar', '1234', '0812345678', 'wiraswasta', '   laki-laki', 'www.drawesome.uy-vac46s66tb.png', 'profilkausr.png', 2, 0),
(33, 'ardea', 'arda@gmail.com', 'ardea', '1234', '081234567', 'gaul', 'laki-laki', '112.png', 'fotoprofil.webp', 2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `wishlist`
--

CREATE TABLE `wishlist` (
  `id_wishlist` int(11) NOT NULL,
  `id_kost` int(11) NOT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `wishlist`
--

INSERT INTO `wishlist` (`id_wishlist`, `id_kost`, `id_user`) VALUES
(2, 4, 25);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`id_booking`),
  ADD KEY `id_user` (`id_user`,`id_kamar`),
  ADD KEY `id_kamar` (`id_kamar`);

--
-- Indexes for table `kamar`
--
ALTER TABLE `kamar`
  ADD PRIMARY KEY (`id_kamar`),
  ADD KEY `id_kost` (`id_kost`);

--
-- Indexes for table `kost`
--
ALTER TABLE `kost`
  ADD PRIMARY KEY (`id_kost`),
  ADD KEY `id_pemilik` (`id_pemilik`);

--
-- Indexes for table `rating`
--
ALTER TABLE `rating`
  ADD PRIMARY KEY (`id_rating`),
  ADD KEY `Id_kost` (`Id_kost`),
  ADD KEY `Id_user` (`Id_user`);

--
-- Indexes for table `roles_user`
--
ALTER TABLE `roles_user`
  ADD PRIMARY KEY (`id_roles`);

--
-- Indexes for table `tagihan`
--
ALTER TABLE `tagihan`
  ADD PRIMARY KEY (`no_tagihan`),
  ADD KEY `no_booking` (`no_booking`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_kost_saya` (`id_kost_saya`),
  ADD KEY `roles` (`roles`);

--
-- Indexes for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD PRIMARY KEY (`id_wishlist`),
  ADD KEY `id_kost` (`id_kost`),
  ADD KEY `id_user` (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `id_booking` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `kamar`
--
ALTER TABLE `kamar`
  MODIFY `id_kamar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `kost`
--
ALTER TABLE `kost`
  MODIFY `id_kost` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `rating`
--
ALTER TABLE `rating`
  MODIFY `id_rating` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles_user`
--
ALTER TABLE `roles_user`
  MODIFY `id_roles` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tagihan`
--
ALTER TABLE `tagihan`
  MODIFY `no_tagihan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `wishlist`
--
ALTER TABLE `wishlist`
  MODIFY `id_wishlist` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `booking_ibfk_3` FOREIGN KEY (`id_kamar`) REFERENCES `kamar` (`id_kamar`);

--
-- Constraints for table `kamar`
--
ALTER TABLE `kamar`
  ADD CONSTRAINT `kamar_ibfk_1` FOREIGN KEY (`id_kost`) REFERENCES `kost` (`id_kost`);

--
-- Constraints for table `kost`
--
ALTER TABLE `kost`
  ADD CONSTRAINT `kost_ibfk_1` FOREIGN KEY (`id_pemilik`) REFERENCES `user` (`id`);

--
-- Constraints for table `rating`
--
ALTER TABLE `rating`
  ADD CONSTRAINT `rating_ibfk_1` FOREIGN KEY (`Id_kost`) REFERENCES `kost` (`id_kost`),
  ADD CONSTRAINT `rating_ibfk_2` FOREIGN KEY (`Id_user`) REFERENCES `user` (`id`);

--
-- Constraints for table `tagihan`
--
ALTER TABLE `tagihan`
  ADD CONSTRAINT `tagihan_ibfk_1` FOREIGN KEY (`no_booking`) REFERENCES `booking` (`id_booking`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`roles`) REFERENCES `roles_user` (`id_roles`);

--
-- Constraints for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD CONSTRAINT `wishlist_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `wishlist_ibfk_2` FOREIGN KEY (`id_kost`) REFERENCES `kost` (`id_kost`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
