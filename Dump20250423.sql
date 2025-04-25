CREATE DATABASE  IF NOT EXISTS `site` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `site`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: site
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tbl_alunos`
--

DROP TABLE IF EXISTS `tbl_alunos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_alunos` (
  `id_aluno` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL COMMENT 'Link para a conta de usuário do aluno',
  `matricula` varchar(50) NOT NULL COMMENT 'Número de matrícula único do aluno',
  `id_turma_atual` int DEFAULT NULL COMMENT 'Turma em que o aluno está matriculado atualmente',
  PRIMARY KEY (`id_aluno`),
  UNIQUE KEY `id_usuario` (`id_usuario`),
  UNIQUE KEY `matricula` (`matricula`),
  KEY `id_turma_atual` (`id_turma_atual`),
  CONSTRAINT `tbl_alunos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tbl_alunos_ibfk_2` FOREIGN KEY (`id_turma_atual`) REFERENCES `tbl_turmas` (`id_turma`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_alunos`
--

LOCK TABLES `tbl_alunos` WRITE;
/*!40000 ALTER TABLE `tbl_alunos` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_alunos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_cursos`
--

DROP TABLE IF EXISTS `tbl_cursos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_cursos` (
  `id_curso` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(150) NOT NULL COMMENT 'Nome do curso (ex: Ciência da Computação, ADS etc)',
  PRIMARY KEY (`id_curso`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_cursos`
--

LOCK TABLES `tbl_cursos` WRITE;
/*!40000 ALTER TABLE `tbl_cursos` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_cursos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_enderecos`
--

DROP TABLE IF EXISTS `tbl_enderecos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_enderecos` (
  `id_endereco` int NOT NULL AUTO_INCREMENT,
  `logradouro` varchar(255) NOT NULL,
  `numero` varchar(20) DEFAULT NULL,
  `complemento` varchar(100) DEFAULT NULL,
  `bairro` varchar(100) NOT NULL,
  `cidade` varchar(100) NOT NULL,
  `estado` varchar(2) NOT NULL,
  `cep` varchar(9) NOT NULL COMMENT 'CEP no formato XXXXX-XXX pra facilitar',
  PRIMARY KEY (`id_endereco`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_enderecos`
--

LOCK TABLES `tbl_enderecos` WRITE;
/*!40000 ALTER TABLE `tbl_enderecos` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_enderecos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_entregas`
--

DROP TABLE IF EXISTS `tbl_entregas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_entregas` (
  `id_entrega` int NOT NULL AUTO_INCREMENT,
  `id_aluno` int NOT NULL COMMENT 'Aluno que realizou a entrega',
  `id_tipo_residuo` int NOT NULL COMMENT 'Tipo de resíduo entregue',
  `quantidade_kg` decimal(10,3) NOT NULL COMMENT 'Quantidade em quilogramas (ex: 1.250)',
  `data_hora_entrega` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data e hora exata da entrega',
  `id_turma_entrega` int NOT NULL COMMENT 'Turma do aluno no momento da entrega',
  `id_curso_entrega` int NOT NULL COMMENT 'Curso do aluno no momento da entrega',
  `id_semestre_entrega` int NOT NULL COMMENT 'Semestre do aluno no momento da entrega',
  `id_turno_entrega` int NOT NULL COMMENT 'Turno do aluno no momento da entrega',
  `id_unidade_entrega` int NOT NULL COMMENT 'Unidade do aluno no momento da entrega',
  PRIMARY KEY (`id_entrega`),
  KEY `id_aluno` (`id_aluno`),
  KEY `id_tipo_residuo` (`id_tipo_residuo`),
  KEY `id_turma_entrega` (`id_turma_entrega`),
  KEY `id_curso_entrega` (`id_curso_entrega`),
  KEY `id_semestre_entrega` (`id_semestre_entrega`),
  KEY `id_turno_entrega` (`id_turno_entrega`),
  KEY `id_unidade_entrega` (`id_unidade_entrega`),
  CONSTRAINT `tbl_entregas_ibfk_1` FOREIGN KEY (`id_aluno`) REFERENCES `tbl_alunos` (`id_aluno`),
  CONSTRAINT `tbl_entregas_ibfk_2` FOREIGN KEY (`id_tipo_residuo`) REFERENCES `tbl_tipos_residuos` (`id_tipo_residuo`),
  CONSTRAINT `tbl_entregas_ibfk_3` FOREIGN KEY (`id_turma_entrega`) REFERENCES `tbl_turmas` (`id_turma`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `tbl_entregas_ibfk_4` FOREIGN KEY (`id_curso_entrega`) REFERENCES `tbl_cursos` (`id_curso`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `tbl_entregas_ibfk_5` FOREIGN KEY (`id_semestre_entrega`) REFERENCES `tbl_semestres` (`id_semestre`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `tbl_entregas_ibfk_6` FOREIGN KEY (`id_turno_entrega`) REFERENCES `tbl_turnos` (`id_turno`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `tbl_entregas_ibfk_7` FOREIGN KEY (`id_unidade_entrega`) REFERENCES `tbl_unidades` (`id_unidade`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Registros das entregas de resíduos feitas pelos alunos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_entregas`
--

LOCK TABLES `tbl_entregas` WRITE;
/*!40000 ALTER TABLE `tbl_entregas` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_entregas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_semestres`
--

DROP TABLE IF EXISTS `tbl_semestres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_semestres` (
  `id_semestre` int NOT NULL AUTO_INCREMENT,
  `identificador` varchar(50) NOT NULL COMMENT 'Identificador do semestre (2025.1, 2025.2 ou 1° semestre, 2° semestre etc)',
  PRIMARY KEY (`id_semestre`),
  UNIQUE KEY `identificador` (`identificador`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_semestres`
--

LOCK TABLES `tbl_semestres` WRITE;
/*!40000 ALTER TABLE `tbl_semestres` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_semestres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_tipos_residuos`
--

DROP TABLE IF EXISTS `tbl_tipos_residuos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_tipos_residuos` (
  `id_tipo_residuo` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL COMMENT 'Nome do resíduo (Alumínio, Vidro, Pano, PET) vai variar muito, é bom a gente conversar pra ',
  `descricao` varchar(255) DEFAULT NULL COMMENT 'Descrição sobre o residuo',
  PRIMARY KEY (`id_tipo_residuo`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tipos de resíduos que vamos aceitar nesse projeto';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_tipos_residuos`
--

LOCK TABLES `tbl_tipos_residuos` WRITE;
/*!40000 ALTER TABLE `tbl_tipos_residuos` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_tipos_residuos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_turmas`
--

DROP TABLE IF EXISTS `tbl_turmas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_turmas` (
  `id_turma` int NOT NULL AUTO_INCREMENT,
  `identificador` varchar(100) NOT NULL COMMENT 'Código ou nome único da turma (ex: ADS2025N1A) como ja temos na nossa turma',
  `id_curso` int NOT NULL,
  `id_semestre` int NOT NULL,
  `id_turno` int NOT NULL,
  `id_unidade` int NOT NULL,
  PRIMARY KEY (`id_turma`),
  UNIQUE KEY `uk_turma_composicao` (`id_curso`,`id_semestre`,`id_turno`,`id_unidade`,`identificador`),
  KEY `id_semestre` (`id_semestre`),
  KEY `id_turno` (`id_turno`),
  KEY `id_unidade` (`id_unidade`),
  CONSTRAINT `tbl_turmas_ibfk_1` FOREIGN KEY (`id_curso`) REFERENCES `tbl_cursos` (`id_curso`),
  CONSTRAINT `tbl_turmas_ibfk_2` FOREIGN KEY (`id_semestre`) REFERENCES `tbl_semestres` (`id_semestre`),
  CONSTRAINT `tbl_turmas_ibfk_3` FOREIGN KEY (`id_turno`) REFERENCES `tbl_turnos` (`id_turno`),
  CONSTRAINT `tbl_turmas_ibfk_4` FOREIGN KEY (`id_unidade`) REFERENCES `tbl_unidades` (`id_unidade`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Representa uma turma específica da instituição';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_turmas`
--

LOCK TABLES `tbl_turmas` WRITE;
/*!40000 ALTER TABLE `tbl_turmas` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_turmas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_turnos`
--

DROP TABLE IF EXISTS `tbl_turnos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_turnos` (
  `id_turno` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL COMMENT 'Qual turno do aluno (Manhã, tarde ou noite)',
  PRIMARY KEY (`id_turno`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_turnos`
--

LOCK TABLES `tbl_turnos` WRITE;
/*!40000 ALTER TABLE `tbl_turnos` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_turnos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_unidades`
--

DROP TABLE IF EXISTS `tbl_unidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_unidades` (
  `id_unidade` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(150) NOT NULL COMMENT 'Nome da unidade/campus (ex: Unama Alcindo Cacela)',
  `endereco_completo` varchar(255) DEFAULT NULL COMMENT 'Endereço físico da unidade se for importante, se não deixa sem mesmo',
  PRIMARY KEY (`id_unidade`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_unidades`
--

LOCK TABLES `tbl_unidades` WRITE;
/*!40000 ALTER TABLE `tbl_unidades` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_unidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_usuarios`
--

DROP TABLE IF EXISTS `tbl_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nome_completo` varchar(200) NOT NULL,
  `email` varchar(255) NOT NULL,
  `senha_hash` varchar(255) NOT NULL COMMENT 'Hash da senha (NÃO pode guardar senha em texto puro!)  A gente pode usar o bcrypt ou Argon2 pra gerar o hash antes de armazenar no banco',
  `tipo_usuario` enum('aluno','funcionario','admin') NOT NULL DEFAULT 'aluno' COMMENT 'Vai definir o papel do usuário no sistema',
  `id_endereco` int DEFAULT NULL,
  `data_cadastro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `ativo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `email` (`email`),
  KEY `id_endereco` (`id_endereco`),
  CONSTRAINT `tbl_usuarios_ibfk_1` FOREIGN KEY (`id_endereco`) REFERENCES `tbl_enderecos` (`id_endereco`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Usuários do sistema (alunos, funcionários, admins)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_usuarios`
--

LOCK TABLES `tbl_usuarios` WRITE;
/*!40000 ALTER TABLE `tbl_usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'site'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-23 20:36:14
